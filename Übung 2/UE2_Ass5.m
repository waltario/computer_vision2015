% VU Computer Vision, TU Wien, WS 2015
% Assignment 5 (SIFT for scene recognition)


addpath(genpath('vlfeat-0.9.20-bin/'))

warning('off','all')

vl_setup

trainingfolder = 'ass5_data/train/';
testfolder = 'ass5_data/test/';
ownfolder = 'ass5_data/ownimages/';

% slow -> avoid re-training on the same data
train_on = 1;
test_on = 1;
own_on = 1;





if(train_on)

    % number of clusters/words
    num_clusters = 50;

    % look for centroids ('visual words') using kmeans
    c = BuildVocabulary(trainingfolder, num_clusters);

    % count occurrences of visual words in each image
    [training, group] = BuildKNN(trainingfolder, c);

end




if(test_on)

    % classification of test set images 
    conf_matrix_test = ClassifyImages(testfolder, c, training, group);

    disp('Confusion matrix on supplied test images: ');
    disp(conf_matrix_test);

end




if(own_on)
    
    % classification of own images 
    conf_matrix_own = ClassifyImages(ownfolder, c, training, group);

    disp('Confusion matrix on own test images: ');
    disp(conf_matrix_own);

end
