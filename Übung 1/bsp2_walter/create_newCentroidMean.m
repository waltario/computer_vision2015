function [ rgb_new ] = create_newCentroidMean(image_reshaped,hLogical,dimension,k)
    rgb_new = zeros(k,dimension);
    if dimension == 3
        for m = 1:k
            rgb_new(m,:) = [mean(image_reshaped(hLogical(:,m),1)), mean(image_reshaped(hLogical(:,m),2)),mean(image_reshaped(hLogical(:,m),3))];
        end
    else
        for m = 1:k
            rgb_new(m,:) = [mean(image_reshaped(hLogical(:,m),1)), mean(image_reshaped(hLogical(:,m),2)),mean(image_reshaped(hLogical(:,m),3)),mean(image_reshaped(hLogical(:,m),4)),mean(image_reshaped(hLogical(:,m),5))];
        end
    end
end