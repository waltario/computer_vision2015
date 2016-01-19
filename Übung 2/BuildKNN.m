function [ histarray, group ] = BuildKNN( folder, C )
%BuildKNN counts the occurrences of each visual word in each training image,
%and stores these frequencies in normalized histograms
%   folder: where the images come from
%   C: centroids (visual words), one in each column
%   histarray: each row is the histogram for one image
%   group: image classes (column vector)


subfolders = {'bedroom/', 'forest/', 'kitchen/', 'livingroom/', 'mountain/', 'office/', 'store/', 'street/'};
file_extension = 'jpg';


num_clusters = size(C,2);
histarray = [];
group = [];

% smoothing
smoothing_on = 0;
sigma = 1;


for subfolderindex = 1:size(subfolders,2)
    subfolder = subfolders{subfolderindex}
    file_list = dir([folder subfolder '*.' file_extension]);
    
    
    for currentfileindex = 1:size(file_list,1)
        
        group = [group ; subfolderindex];
        
        currentimg = imread([folder subfolder file_list(currentfileindex).name]);
        
        if(size(currentimg,3)==3)
           currentimg = rgb2gray(currentimg); 
        end
        
        
        if(smoothing_on)
            % some preliminary smoothing is typically necessary
            % currentimg must be in double precision
            % already gray-scale
            currentimg = double(currentimg);
            currentimg = vl_imsmooth(currentimg, sigma);
        end
        
        
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
        histedges = 1:num_clusters;
        histwords = histc(nearcentindices,histedges);
        histwords = histwords/sum(histwords);
        
        histarray = [histarray ; histwords'];
        
    end
end
end

