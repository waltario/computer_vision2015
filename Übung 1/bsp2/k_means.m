function [ coloured_img ] = k_means( imagename, dimension, k, threshold )
%UNTITLED Summary of this function goes here
%   imagename... filename of the image
%   dimension... 3 or 5, either with or without x,y-values of points
%   k...         number of means

%read in the specified image
image=imread(['Images/' imagename]);
image=im2double(image);

%initialise mu with random numbers
mu=rand(dimension,k);
disp(mu);

count=1;

%initialise xn. generates a matrix which contains for every pixel its r,g,b
%values and if the dimension is 5 also the x,y koordinates
if dimension==5
    x=zeros(size(image,1)*size(image,2),5);
else
    x=zeros(size(image,1)*size(image,2),3);
end
    


for j=1:size(image,1);    
    
    for i=1:size(image,2);
        
        x(count,1)=image(j,i,1);
        x(count,2)=image(j,i,2);
        x(count,3)=image(j,i,3);
        
        if dimension==5
            x(count,5)=i/size(image,2);
            x(count,4)=j/size(image,1);
        end
        count=count+1;
        
    end
end

%compute distance and matrix r
[dist, r]=computeDistances(count, k, x, mu);

%compute new mean values
mu=computeMeans(dimension, count, k, x, r);

%compute distances to new mu-values
[dist2,r]=computeDistances(count,k,x,mu);

j_old=sum(dist);
j_new=sum(dist2);

% disp(j_old);
% disp(j_new);
% disp(j_old/j_new);

while(j_old/j_new)>threshold
   
%     disp('oldnew');
%     disp(j_old/j_new);
    
    j_old=j_new;
    mu=computeMeans(dimension, count,k,x,r);
    
%     disp(mu);       
    
    [dist,r]=computeDistances(count,k,x,mu);
    j_new=sum(dist);    
    
end

% disp(j_old/j_new);
disp(mu);

coloured_img=zeros(size(image,1),size(image,2));
c=1;
%colorize image with mean-values
%TODO
for i=1:size(image,1);
    
    for j= 1:size(image,2);
        
        vec=mu(:,r(c,:)==1);               
        coloured_img(i,j,1)=vec(1);
        coloured_img(i,j,2)=vec(2);
        coloured_img(i,j,3)=vec(3);
        c=c+1;
        
    end    
    
end

coloured_img=im2uint8(coloured_img);

imshow(coloured_img);

end

