% VU Computer Vision
% TU Wien, WS 2015
% Group 12


% Exercise Session 1
% Task 3
% Implementing a LoG-based blob detector

%-----------------------------------------------------------------------%



% 1.


% display all filtered images?
manyfigures = 1;

% process half-sized image instead?
halfsize = 1;



addpath images;

%image_path = '00125v_R.jpg';
%image_path = '00125v_G.jpg';
%image_path = '00125v_B.jpg';

%image_path = '00149v_R.jpg';
%image_path = '00149v_G.jpg';
%image_path = '00149v_B.jpg';

%image_path = '00153v_R.jpg';
%image_path = '00153v_G.jpg';
%image_path = '00153v_B.jpg';

%image_path = '00351v_R.jpg';
%image_path = '00351v_G.jpg';
%image_path = '00351v_B.jpg';

%image_path = '00398v_R.jpg';
%image_path = '00398v_G.jpg';
%image_path = '00398v_B.jpg';

%image_path = '01112v_R.jpg';
%image_path = '01112v_G.jpg';
%image_path = '01112v_B.jpg';


%image_path='simple.png';
%image_path='mm.jpg';
%image_path='future.jpg';
image_path='butterfly.jpg';


image = imread(image_path);
image = image(:,:,1);


if manyfigures
    figure
    imshow(image)
    title('Original image')
end


if halfsize
   image = image(1:2:end, 1:2:end); 
   if manyfigures
       figure
       imshow(image)
       title('Half-sized image')
   end
end

[height, width] = size(image);
max_image = max(max(image));


% scaling parameters
% more than 15 levels does not make sense for scale_ratio > 1.2...
if(strcmp(image_path,'images/butterfly.jpg'))
    % initial scale
    sigma_init = 1.5;
    % factor k between filter widths
    scale_ratio = 1.25;
    % number of scales examined
    nb_levels = 8;
else
    % initial scale
    sigma_init = 1.5;
    % factor k between filter widths
    scale_ratio = 1.2;
    % number of scales examined
    nb_levels = 15;
end



% padded to avoid border problems
% filter size smaller than padding: should be checked manually
hpad = 2;
wpad = 2;
levelpad = 1;
filtered_stack = zeros(height+2*hpad,width+2*wpad,nb_levels+2*levelpad);




% filtering

for level = 1:nb_levels
    
    sigma = sigma_init*(scale_ratio^(level-1));
    
    % filter size
    logheight = 2*max(floor(3*sigma),1)+1;
    logwidth = 2*max(floor(3*sigma),1)+1;
    
    disp(['Current scaling level: ' num2str(level)]) 
    
    % creating current filter
    log_kernel = fspecial('log', [logheight logwidth], sigma);
    
    % convolution of image with current filter
    % imfilter options:
    % values outside of boundary as value of nearest actual pixel 
    % output size same as input (plus padding), independently of filter size (default)
    % lowermost and uppermost levels not modified here
    filtered_stack((hpad+1):(height+hpad),(wpad+1):(width+wpad),level+levelpad) = (sigma^2)*abs(imfilter(image, log_kernel, 'replicate', 'same'));
    % filtered_stack((hpad+1):(height+hpad),(wpad+1):(width+wpad),level+levelpad) = abs(imfilter(image, log_kernel, 'replicate', 'same'));
        
    max_intensity = max(max(filtered_stack(:,:,level+levelpad)));
    % max_intensity = 255;
    
    if manyfigures
        figure
        imshow((double(max_image)/double(max_intensity))*filtered_stack(:,:,level+levelpad));
        title(['Filtered image at scale ' num2str(sigma)])
    end
end





%-----------------------------------------------------------------------%


% 2

% threshold for being considered as a candidate center
if(strcmp(image_path,'images/butterfly.jpg'))
    threshold_ratio = 0.25;
else
    threshold_ratio = 0.45;
end

max_stack = filtered_stack;

% how many blob centers have been found at each scale
nb_centers = [];

% column vector of circle radii
max_rad = [];

for level = 1:nb_levels
    
    sigma = sigma_init*(scale_ratio^(level-1));
    
    % radius of circles to be drawn
    rad_scale = ceil(3*sigma);
    
    % global intensity criterion for centers 
    % new threshold value for each image
    max_intensity = max(max(filtered_stack(:,:,level+levelpad)));
    threshold = threshold_ratio * max_intensity;
    max_stack(:,:,level+levelpad) = (filtered_stack(:,:,level+levelpad)>threshold);
    
    % keeping only local maxima
    % eliminating flat regions
    % (otherwise if >= : too many, if > : too few centers)
    wramp = ones(height,1)*(0.0001:0.0001:width*0.0001);
    hramp = (0.0000005:0.0000005:height*0.0000005)'*ones(1,width);
    filtered_stack((hpad+1):(hpad+height), (wpad+1):(wpad+width), level) = filtered_stack((hpad+1):(hpad+height), (wpad+1):(wpad+width), level) + wramp + hramp;
    for xdir=(-hpad):hpad
        for ydir=(-wpad):wpad
            for zdir=(-levelpad):levelpad
                if(abs(xdir)>0.1 || abs(ydir)>0.1 || abs(zdir)>0.1)
                    max_stack((hpad+1):(height+hpad),(wpad+1):(width+wpad),level+levelpad) = max_stack((hpad+1):(height+hpad),(wpad+1):(width+wpad),level+levelpad).*(filtered_stack((hpad+1):(height+hpad),(wpad+1):(width+wpad),level+levelpad) > filtered_stack((hpad+1+xdir):(height+hpad+xdir),(wpad+1+ydir):(width+wpad+ydir),(level+levelpad+zdir)));
                end
            end
        end
    end
    
    if manyfigures
        figure
        imshow(255*max_stack(:,:,level+levelpad))
        title(['Centers at scale ' num2str(sigma)])
    end
    
    
    new_nb_centers = sum(sum(max_stack(:,:,level+levelpad)));
    nb_centers = [nb_centers; new_nb_centers];
    disp(['Number of centers at scale ' num2str(sigma) sprintf(': \n\t\t') num2str(new_nb_centers)])
    
    max_rad = [max_rad; rad_scale*ones(nb_centers(level,1),1)];
    
end


% computing center coordinates
% all scales combined

hcoord = (1:height)'*ones(1,width);
wcoord = ones(height,1)*(1:width);

max_coord_h = [];
max_coord_w = [];


for level = 1:nb_levels
    
    h_max = reshape((hcoord.*max_stack((hpad+1):(hpad+height), (wpad+1):(wpad+width), level))',[height*width 1]);
    new_max_coord_h = h_max(h_max>0);
    max_coord_h = [max_coord_h; new_max_coord_h];
    
    w_max = reshape((wcoord.*max_stack((hpad+1):(hpad+height), (wpad+1):(wpad+width), level))',[height*width 1]);
    new_max_coord_w = w_max(w_max>0);
    max_coord_w = [max_coord_w; new_max_coord_w];
    
    
end

figure
show_all_circles(image, max_coord_w, max_coord_h, max_rad)