function [ colorImage ] = imColor(imagenumber)
%   Reads in the 3 channels of the specified image.
%   Computes the correlation-coefficients between the different channels,
%   aligns them and returns the resulting colorimage.   
%
%   INPUT
%   imagename.... String which contains the number of the image
%
%   OUTPUT
%   colorImage... The resulting colorimage with correctly aligned channels


% read in all the images in the folder 'Images' which contain the 'imagenumber', channel-order: b, g, r
imfiles = dir(['Images/' imagenumber '*.jpg']);
imcount = length(imfiles);

for i=1:imcount   
     imagearray{i}=imread([imfiles(i).name]);    
end

% for better code-readability
r = imagearray{3};
g = imagearray{2};
b = imagearray{1};

% initialise correlations and shifts with 0 for channels b and r
corr_b = 0;
corr_r = 0;
xshift_r = 0;
yshift_r = 0;
xshift_b = 0;
yshift_b = 0;


% g channel is fixed and r and b channels get shifted from -15 to 15 in x
% and y direction. for every shifted-position the correlation coefficient
% with g is computed. the x and y shift-values with the highest correlation
% coefficient are stored 
for i = -15:15
   
    for j= -15:15
       
        if corr2(g,circshift(b, [i j])) > corr_b
           
            corr_b=corr2(g,circshift(b, [i j]));
            xshift_b = i;
            yshift_b = j;
            
        end
        
        if corr2(g,circshift(r, [i j])) > corr_r
           
            corr_r=corr2(g,circshift(r, [i j]));
            xshift_r = i;
            yshift_r = j;
            
        end        
        
    end    
    
end

% puts together the color image from the 3 channels, the x- and
% y-shiftvalues with the highest correlations are applied to the channels r and b
colorImage=cat(3,circshift(r,[xshift_r yshift_r]),g,circshift(b,[xshift_b yshift_b]));

% shows the image with unshifted and correctly aligned channels next to each other
imshow([cat(3,r,g,b) colorImage]);

end

