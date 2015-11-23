%test kmean function with different inputs

%### dimension = 5 ,fixed k = 10 
k=10;
%test1 - simple.png 
% kmeans(input_image, dimension, k, threshold )
test1_input_image=imread('images/simple.png');
test1_image = kmeans(test1_input_image,5,k,1.01);

%test2 - future.jpg 
test2_input_image=imread('images/future.jpg');
test2_image = kmeans(test2_input_image,5,k,1.01);

%test3 - mm.jpg
test3_input_image=imread('images/mm.jpg');
test3_image = kmeans(test3_input_image,5,k,1.01);

%### dimension = 3 ,fixed k = 10 

%test4 - simple.png 
test4_image = kmeans(test1_input_image,3,k,1.01);

%test5 - future.jpg , dimension = 3
test5_image = kmeans(test2_input_image,3,k,1.01);

%test6 - mm.jpg , dimension = 3
test6_image = kmeans(test3_input_image,3,k,1.01);

%### Show Output 1

%print original image and new colored image for d=3/5 and k = fixed 10
figure('Name','original [links]  d = 5, k = 10 [rechts]','NumberTitle','off');
subplot(3,2,1); imshow(test1_input_image);
subplot(3,2,2); imshow(test1_image);   

subplot(3,2,3); imshow(test2_input_image);
subplot(3,2,4); imshow(test2_image);

subplot(3,2,5); imshow(test3_input_image);
subplot(3,2,6); imshow(test3_image);

figure('Name','original [links]  d = 3, k = 10 [rechts]','NumberTitle','off');
subplot(3,2,1); imshow(test1_input_image);
subplot(3,2,2); imshow(test4_image);

subplot(3,2,3); imshow(test2_input_image);
subplot(3,2,4); imshow(test5_image);

subplot(3,2,5); imshow(test3_input_image);
subplot(3,2,6); imshow(test6_image);

%### image mm.jpg different dimesion and k

%test3 - mm.jpg
test3_input_image=imread('images/mm.jpg');

%test7 dimension d = 3, k = 3
% kmeans(input_image, dimension, k, threshold )
test7_image = kmeans(test3_input_image,3,3,1.01);
%test8 dimension d = 3, k = 5
test8_image = kmeans(test3_input_image,3,5,1.01);
%tes9 dimension d = 3, k = 10
test9_image = kmeans(test3_input_image,3,10,1.01);
%test10 dimension d = 3, k = 15
test10_image = kmeans(test3_input_image,3,15,1.01);
%test11 dimension d = 3, k = 20
test11_image = kmeans(test3_input_image,3,20,1.01);
%test12 dimension d = 3, k = 30
test12_image = kmeans(test3_input_image,3,30,1.01);
%test12_a dimension d = 3, k = 50
test12_aimage = kmeans(test3_input_image,3,50,1.01);

%test13 dimension d = 5, k = 3
% kmeans(input_image, dimension, k, threshold )
test13_image = kmeans(test3_input_image,5,3,1.01);
%test14 dimension d = 5, k = 5
test14_image = kmeans(test3_input_image,5,5,1.01);
%test15 dimension d = 5, k = 10
test15_image = kmeans(test3_input_image,5,10,1.01);
%test16 dimension d = 5, k = 15
test16_image = kmeans(test3_input_image,5,15,1.01);
%test17 dimension d = 5, k = 20
test17_image = kmeans(test3_input_image,5,20,1.01);
%test18 dimension d = 5, k = 30
test18_image = kmeans(test3_input_image,5,30,1.01);
%test19 dimension d = 5, k = 50
test19_image = kmeans(test3_input_image,5,50,1.01);

%### Show Output 2

%print orignial image mm.jpg first, and additional 7 images with d = 3,
% k = 3,5,10,15,20,30,50
figure('Name','original + d = 3, k = 3 to to 10','NumberTitle','off');
subplot(1,4,1); imshow(test3_input_image);
subplot(1,4,2); imshow(test7_image);   
subplot(1,4,3); imshow(test8_image); 
subplot(1,4,4); imshow(test9_image); 
figure('Name','d = 3, k = 15 to to 50','NumberTitle','off');
subplot(1,4,1); imshow(test10_image);
subplot(1,4,2); imshow(test11_image);   
subplot(1,4,3); imshow(test12_image); 
subplot(1,4,4); imshow(test12_aimage);

%print orignial image mm.jpg first, and additional 7 images with d = 5,
% k = 3,5,10,15,20,30,50
figure('Name','original + d = 5, k = 3 to to 10','NumberTitle','off');
subplot(1,4,1); imshow(test3_input_image);
subplot(1,4,2); imshow(test13_image);   
subplot(1,4,3); imshow(test14_image); 
subplot(1,4,4); imshow(test15_image); 
figure('Name',' d = 5, k = 15 to to 50','NumberTitle','off');
subplot(1,4,1); imshow(test16_image);
subplot(1,4,2); imshow(test17_image);   
subplot(1,4,3); imshow(test18_image); 
subplot(1,4,4); imshow(test19_image);
%}
