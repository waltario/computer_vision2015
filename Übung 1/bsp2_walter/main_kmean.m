%test kmean function with different inputs

%test1 - simple.png , dimension = 5
% kmeans(input_image, dimension, k, threshold )
test1_input_image=imread('images/simple.png');
test1_image = kmeans(test1_input_image,5,5,1.01);

%test2 - future.jpg , dimension = 5
test2_input_image=imread('images/future.jpg');
test2_image = kmeans(test2_input_image,5,3,1.01);

%test3 - mm.jpg , dimension = 5
test3_input_image=imread('images/mm.jpg');
test3_image = kmeans(test3_input_image,5,3,1.01);

%test4 - simple.png , dimension = 3
test4_input_image=imread('images/simple.png');
test4_image = kmeans(test1_input_image,3,3,1.01);

%test5 - future.jpg , dimension = 3
test5_input_image=imread('images/future.jpg');
test5_image = kmeans(test2_input_image,3,3,1.01);

%test6 - mm.jpg , dimension = 3
test6_input_image=imread('images/mm.jpg');
test6_image = kmeans(test3_input_image,3,3,1.01);


%print original image and new colored image
figure();
subplot(1,2,1); imshow(test1_input_image);
subplot(1,2,2); imshow(test1_image);

figure();
subplot(1,2,1); imshow(test2_input_image);
subplot(1,2,2); imshow(test2_image);

figure();
subplot(1,2,1); imshow(test3_input_image);
subplot(1,2,2); imshow(test3_image);

figure();
subplot(1,2,1); imshow(test4_input_image);
subplot(1,2,2); imshow(test4_image);

figure();
subplot(1,2,1); imshow(test5_input_image);
subplot(1,2,2); imshow(test5_image);

figure();
subplot(1,2,1); imshow(test6_input_image);
subplot(1,2,2); imshow(test6_image);
