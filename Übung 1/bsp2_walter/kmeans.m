function [ outputImage ] = kmeans(input_image, dimension, k, threshold )

%### INIT image, centroids, rearange_image ###

%normalize input image
image = im2double(input_image);
[row_size,column_size,column_dim] = size(image);

%create first random centroids matrix
centroids = create_centroids(image,dimension,k);

%rearange image matrix for calculation purposes
image_reshaped = rearange_image(image,dimension);

%### INIT END ###

%TODO START FOR
%for z = 1:10

    %apply dist function rgb centers to rgb pic values in columns DONE
    distanceImagetoRGB = pdist2(image_reshaped,centroids);
    %find min value
    [MinDistanceValue,DistanceMinIndex] = min(distanceImagetoRGB,[],2);
   
    %get new binary matrix n x k
    hLogical = create_binary_matrix(DistanceMinIndex, row_size,column_size,k);
  
    %calculate J 
    distortionMeasureJ_old= distanceImagetoRGB(hLogical);       %combine euclid distance points to centroid
    distortionMeasureJ_old = sum(distortionMeasureJ_old(:))     %sum up all point to J
   
    %calculate new mean values for rgb k values
    centroids = create_newCentroidMean(image_reshaped,hLogical,dimension,k);
 
    distanceImagetoRGB = pdist2(image_reshaped,centroids);
    [MinDistanceValue,DistanceMinIndex] = min(distanceImagetoRGB,[],2);

    %get new binary matrix n x k
    hLogical = create_binary_matrix(DistanceMinIndex, row_size,column_size,k);
  
    distortionMeasureJ_new= distanceImagetoRGB(hLogical);       %combine euclid distance points to centroid
    distortionMeasureJ_new = sum(distortionMeasureJ_new(:));     % sum up all point to J
    
    distortionMeasureJ_old/distortionMeasureJ_new;
    
    while(distortionMeasureJ_old/distortionMeasureJ_new)>threshold
    %for z = 1:10
        distortionMeasureJ_old/distortionMeasureJ_new;
        distortionMeasureJ_old=distortionMeasureJ_new;
        
         %calculate new mean values for rgb k values
         centroids = create_newCentroidMean(image_reshaped,hLogical,dimension,k);
    
         distanceImagetoRGB = pdist2(image_reshaped,centroids);
        [MinDistanceValue,DistanceMinIndex] = min(distanceImagetoRGB,[],2);

        %get new binary matrix n x k
        hLogical = create_binary_matrix(DistanceMinIndex, row_size,column_size,k);
  
        distortionMeasureJ_new= distanceImagetoRGB(hLogical);       % combine euclid distance points to centroid
        distortionMeasureJ_new = sum(distortionMeasureJ_new(:));     % sum up all point to J   
    
    end
    
%create new image with mean values (centroids) as colors
image_colored = image_reshaped;

%assign colors to pixel position where mean value has min distance, = 1
for m = 1:k
    image_colored(hLogical(:,m),1) = centroids(m,1);
    image_colored(hLogical(:,m),2) = centroids(m,2);
    image_colored(hLogical(:,m),3) = centroids(m,3);
end

%create / reshape to original image n x m dimension
outputImage =zeros(row_size,column_size,column_dim);
for m = 1:3
    outputImage(:,:,m) = vec2mat(image_colored(:,m),column_size); 
end

%print original image and new colored image
%figure();
%subplot(1,2,1); imshow(image);
%subplot(1,2,2); imshow(image6);

    

