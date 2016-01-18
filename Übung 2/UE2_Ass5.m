% VU Computer Vision, TU Wien, WS 2015
% Assignment 5 (SIFT for scene recognition)


addpath(genpath('vlfeat-0.9.20-bin/'))
vl_setup

trainingfolder = 'ass5_data/train/';
testfolder = 'ass5_data/test/';

% number of clusters/words
num_clusters = 50;

% look for centroids ('visual words') using kmeans
c = BuildVocabulary(trainingfolder, num_clusters);

% count occurrences of visual words in each image
[training, group] = BuildKNN(trainingfolder, c);

% classification of test set images 
conf_matrix = ClassifyImages(testfolder, c, training, group);

