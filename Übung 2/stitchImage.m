function [ stitchedImage ] = stitchImage(imagename)
%reads in the specified imagesequence and stitches the images together
%   imagename.... name of the imagesequence which shall be stitched together
%   stitchedImage... the final image stitched together from the images in the sequence


%read in all the images in the imagefolder containing the specified imagename
imfiles = dir(['ass4_data/' imagename '*.jpg']);
imcount = length(imfiles);

%initialise cell arrays to make things faster
imagearray=cell(imcount,1);
imgray=cell(imcount,1);
features=cell(imcount,1);
descriptors=cell(imcount,1);


% A and B1

%read in images and determine sift features and descriptors
%use code in comments to plot features on images
for i=1:imcount
     imagearray{i}=im2single(imread([imfiles(i).name]));
     imgray{i}=rgb2gray(imagearray{i});
     figure;
     imshow(imgray{i},[]); %plot features on image ... for report
     [features{i}, descriptors{i}]=vl_sift(imgray{i});
 
     featureImage=vl_plotframe(features{i});
     set(featureImage,'color','y','linewidth',2); %plot features on image ... for report   
end
  

% B2 bzw. C1

matches=cell(imcount-1,1);
scores=cell(imcount-1,1);

% for every 2 consecutive images: match their descriptors and plot the matching points
for i=1:imcount-1
    [matches{i}, scores{i}]=vl_ubcmatch(descriptors{i},descriptors{i+1});
    match_plot(im2double(imagearray{i}),im2double(imagearray{i+1}),features{i}(1:2,matches{i}(1,:))',features{i+1}(1:2,matches{i}(2,:))');

    %for easier usage... matrices with the matched points of image 1 and image 2
    matchedfeatures1=features{i}(1:2,matches{i}(1,:));
    matchedfeatures2=features{i+1}(1:2,matches{i}(2,:));
    
    
    % B3    
    
    %determine number of matched points
    [rows, columns]=size(matches{i}); 
    
    inl=0;
    
    for j=1:1000    
        
        %generate 4 random numbers between 1 and number of matched points
        rand=randsample(columns,4);
        
        inliers=0;
        
        %estimate homography taking the 4 random pairs of matched points
        try
            tform=cp2tform(matchedfeatures1(:,rand)',matchedfeatures2(:,rand)','projective');
        catch
            
        end
            
        %transform all the (other) points of the first image
        [X,Y]=tformfwd(tform,matchedfeatures1');
        
                  
        % euclidean distance between transformed point and corresponding point from second image with threshold 25
        dist = sum(([X, Y]'-matchedfeatures2).^2) < 25;
            
        %determine number of inliers and their indizes
        inliernumbers=find(dist);        
        inliers=size(inliernumbers,2);      
        
        
        %if the number of inliers is higher than from the transformations before, remember these inliers
        if inliers>inl           
            inl=inliers; %remember the number of inliers to compare it with the next one
            inlnr=inliernumbers; %remember the positions of the inliers           
        end        
            
    end   
    
    
    %B4
    
    %determine final homography (the one with the most inliers) with only inliers (the best matches)
    try
        tformfinal=cp2tform(matchedfeatures1(:,inlnr)',matchedfeatures2(:,inlnr)','projective');
    catch
    
    end
    
    % plot of matching points with only inliers
    match_plot(im2double(imagearray{i}),im2double(imagearray{i+1}),matchedfeatures1(:,inlnr)',matchedfeatures2(:,inlnr)');
    
           
    % store the best transformation for every 2 consecutive images (e.g. if we stitch 5 images, we have 4 transformations
    imtransforms{i}=tformfinal;    
    
end


%B5

%XData, YData... range. 
%XYScale... if the images are scaled differently the ratio of the 2 images.
transformedimg=imtransform(imagearray{1}, imtransforms{1}, 'XData', [1 size(imagearray{2},2)], 'YData', [1 size(imagearray{2},1)], 'XYScale', 1, 'FillValues', NaN);
transfimg=transformedimg; %copy for absolute differences calculation
%fill the NaN values in the transformed image with the values from the second image
transformedimg(isnan(transformedimg))=imagearray{2}(isnan(transformedimg));
figure;
imshow(transformedimg);

%absolute differences
transfimg(isnan(transfimg))=0;
diffimg=imabsdiff(transfimg,imagearray{2});
figure;
imshow(diffimg);


%TODO C2 usw hier einfügen
%nützliche Dinge: 
%imagearray{i}... das i-te farbbild der eingelesenen bildsequenz
%imtransforms{i}... die transformationen zwischen den bildern.... z.b imtransforms{1} die transf. zwischen 1. u. 2. bild
%im cellarray mit den transformationen sind auch die in der angabe erwähnten tdata.T und tdata.Tinv enthalten
%zugriff z.b über: imtransforms{1}.tdata.T




end

