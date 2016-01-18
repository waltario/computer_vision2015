function cent = BuildVocabulary(folder, num_clusters)
%BuildVocabulary extracts SIFT features on a dense regular grid from the training images, 
%determines clusters, and saves their centroids
%   folder: where the images come from
%   num_clusters: user-defined number of clusters
%   cent: cluster centers (#rows: 128, #columns: num_clusters)


subfolders = {'bedroom/', 'forest/', 'kitchen/', 'livingroom/', 'mountain/', 'office/', 'store/', 'street/'};
file_extension = 'jpg';

% sigma could be image-dependent
sigma = 3;

featarr = [];

for subfolderindex = 1:size(subfolders,2)
    subfolder = subfolders{subfolderindex}
    file_list = dir([folder subfolder '*.' file_extension]);
    for currentfileindex = 1:size(file_list,1)
        currentimg = imread([folder subfolder file_list(currentfileindex).name]);
        
        % some preliminary smoothing is typically necessary
        % currentimg must be in double precision
        % already gray-scale
        currentimg = double(currentimg);
        currentimg = vl_imsmooth(currentimg, sigma); 
        
        
        % detect dense SIFT features (vl_dsift instead of vl_sift)
        % only on a grid of about 100 randomly chosen points
        % currentimg must here be in single precision
        currentimg = single(currentimg);
        
        % frames: each column is a 2D point
        % descriptors: each column is a 128D SIFT descriptor
        [frames, descriptors] = vl_dsift(currentimg, 'Step', [5 5], 'Fast');
        
        % only keep 100 feature points
        indextokeep = randsample(size(descriptors,2),100);
        frames = frames(:,indextokeep);
        descriptors = descriptors(:,indextokeep);
        featarr = [featarr descriptors];
    end
end


% k-means
% A: assignments of the data to the centers (unused)
[cent, A] = vl_kmeans(single(featarr), num_clusters);


end

