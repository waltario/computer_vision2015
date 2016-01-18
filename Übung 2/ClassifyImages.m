function [ conf_matrix ] = ClassifyImages(folder,C,training,group)
%ClassifyImages finds the nearest visual word histogram
%   folder: where the images come from
%   C: centroids (visual words), one in each column
%   training:  each row is the histogram for one training image
%   group: training image classes (column vector)

subfolders = {'bedroom/', 'forest/', 'kitchen/', 'livingroom/', 'mountain/', 'office/', 'store/', 'street/'};
file_extension = 'jpg';


num_subfolders = size(subfolders,2);
num_clusters = size(C,2);
histarray = [];
actualgroup = [];
detectedgroup = [];

% smoothing
sigma = 3;


for subfolderindex = 1:num_subfolders
    subfolder = subfolders{subfolderindex}
    file_list = dir([folder subfolder '*.' file_extension]);
    
    
    for currentfileindex = 1:size(file_list,1)
        % ground truth
        actualgroup = [actualgroup ; subfolderindex];
        
        currentimg = imread([folder subfolder file_list(currentfileindex).name]);
        
        % some preliminary smoothing is typically necessary
        % currentimg must be in double precision
        % already gray-scale
        currentimg = double(currentimg);
        currentimg = vl_imsmooth(currentimg, sigma);
        
        % detect dense SIFT features (vl_dsift instead of vl_sift)
        % this time, step is 1 or 2, and all the information will be used
        % currentimg must here be in single precision
        currentimg = single(currentimg);
        
        % frames: each column is a 2D point
        % descriptors: each column is a 128D SIFT descriptor
        [frames, descriptors] = vl_dsift(currentimg, 'Step', [2 2], 'Fast');
        
        
        % nearcentindices: column vector, closest visual word indices for
        % descriptors
        nearcentindices = knnsearch(C', descriptors');
        
        
        % defining bins (centered on integers) for the histogram
        % nearcentindices are integers
        histedges = 1:(num_clusters);
        histwords = histc(nearcentindices,histedges);
        histwords = histwords/sum(histwords);
        
        histarray = [histarray ; histwords'];
        
        
    end
end



% k-nearest-neighbor 
detectedgroup = knnclassify(histarray, training, group, 3);


disp(['Accuracy: ' num2str(sum(actualgroup==detectedgroup)/size(actualgroup,1))])


% confusion matrix
conf_matrix = zeros(num_subfolders);
for i = 1:num_subfolders
    gti = detectedgroup(actualgroup==i);
    dethist_gti = histc(gti,1:num_subfolders)/size(gti,1);
    conf_matrix(i,:) = dethist_gti';
end


end

