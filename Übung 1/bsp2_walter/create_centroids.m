function [ centroids ] = create_centroids(input_image, dimension, k)
%create first random centroids matrix 
%dimension = 5 -> 5D vector (R,G,B,X,Y)
%dimension = 3 -> 3D vector (R,G,B)
%k = amount of centroid vectors

centroids = double(zeros(k,dimension));
[row_size,column_size,dim] = size(input_image);

%select k random x and y values interval 1 - row_size / column_size
% x-coord = column, y-coord = rows
columns = randperm(column_size,k);
rows = randperm(row_size,k);

if(dimension == 3)
    %save vector [R value, G value, B value,
    for o = 1:k
        centroids(o,:) = [input_image(rows(o),columns(o),1),input_image(rows(o),columns(o),2),input_image(rows(o),columns(o),3)];
    end   
elseif (dimension == 5)
   %save vector [R value, G value, B value, X , Y ] into vectorRGBXY
    for o = 1:k
         centroids(o,:) = [input_image(rows(o),columns(o),1),input_image(rows(o),columns(o),2),input_image(rows(o),columns(o),3),double(rows(o)/row_size),double(columns(o)/column_size)];
    end      
end