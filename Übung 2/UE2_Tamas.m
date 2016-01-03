
% draft script for UE2
% VU CV, TU Wien, WS2015


addpath 'ass4_data/'
addpath 'ass5_data/'
addpath(genpath('vlfeat-0.9.20-bin/'))




vl_setup


% A. SIFT Interest Point Detection

% load images
campus1 = imread('campus1.jpg');
campus2 = imread('campus2.jpg');
campus3 = imread('campus3.jpg');
campus4 = imread('campus4.jpg');
campus5 = imread('campus5.jpg');

% convert to gray scale
campus1g = rgb2gray(campus1);
campus2g = rgb2gray(campus2);
campus3g = rgb2gray(campus3);
campus4g = rgb2gray(campus4);
campus5g = rgb2gray(campus5);
% clear ...


officeview1 = imread('officeview1.jpg');
officeview2 = imread('officeview2.jpg');
officeview3 = imread('officeview3.jpg');
officeview4 = imread('officeview4.jpg');
officeview5 = imread('officeview5.jpg');

% convert to gray scale
officeview1g = rgb2gray(officeview1);
officeview2g = rgb2gray(officeview2);
officeview3g = rgb2gray(officeview3);
officeview4g = rgb2gray(officeview4);
officeview5g = rgb2gray(officeview5);
% clear...



% applying SIFT
% cast to single necessary
campus1_sift = vl_sift(single(campus1g));
campus2_sift = vl_sift(single(campus2g));
campus3_sift = vl_sift(single(campus3g));
campus4_sift = vl_sift(single(campus4g));
campus5_sift = vl_sift(single(campus5g));

officeview1_sift = vl_sift(single(officeview1g));
officeview2_sift = vl_sift(single(officeview2g));
officeview3_sift = vl_sift(single(officeview3g));
officeview4_sift = vl_sift(single(officeview4g));
officeview5_sift = vl_sift(single(officeview5g));




campus1_sift(2,:) = -campus1_sift(2,:);
campus2_sift(2,:) = -campus2_sift(2,:);
campus3_sift(2,:) = -campus3_sift(2,:);
campus4_sift(2,:) = -campus4_sift(2,:);
campus5_sift(2,:) = -campus5_sift(2,:);





% plot with features (circles, lines in circles: radii)

frh = vl_plotframe(campus2_sift);

figure
 imshow(campus2g)
figure
vl_plotframe(campus3_sift)
figure
vl_plotframe(campus4_sift)
figure
vl_plotframe(campus5_sift)




% B. Interest Point Matching and Image Registration

% matching the SIFT descriptors of 2 images
match_c1_c2 = vl_ubcmatch(campus1_sift, campus2_sift);
match_c1_c3 = vl_ubcmatch(campus1_sift, campus3_sift);
match_c1_c4 = vl_ubcmatch(campus1_sift, campus4_sift);


match_o1_o2 = vl_ubcmatch(officeview1_sift, officeview2_sift);
match_o1_o3 = vl_ubcmatch(officeview1_sift, officeview3_sift);
match_o1_o4 = vl_ubcmatch(officeview1_sift, officeview4_sift);
match_o1_o5 = vl_ubcmatch(officeview1_sift, officeview5_sift);

% showing the matching interest points
%match_plot(campus1g,campus2g,campus1_sift(1:2,match_c1_c2(1,:)),campus2_sift(1:2,match_c1_c2(2,:)))
%match_plot(campus1g,campus3g,campus1_sift(1:2,match_c1_c3(1,:)),campus3_sift(1:2,match_c1_c3(2,:)))


%match_plot(officeview1g,officeview2g,officeview1_sift(1:2,match_o1_o2(1,:)),officeview2_sift(1:2,match_o1_o2(2,:)));
%match_plot(officeview1g,officeview3g,officeview1_sift(1:2,match_o1_o3(1,:)),officeview3_sift(1:2,match_o1_o3(2,:)))
match_plot(officeview1g,officeview4g,officeview1_sift(1:2,match_o1_o4(1,:)),officeview4_sift(1:2,match_o1_o4(2,:)))
%match_plot(officeview1g,officeview5g,officeview1_sift(1:2,match_o1_o5(1,:)),officeview5_sift(1:2,match_o1_o5(2,:)))




% RANSAC

% cp2tform












