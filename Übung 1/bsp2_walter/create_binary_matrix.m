function [ binaryLogical ] = create_binary_matrix(DistanceMinIndex, row_size,column_size,k)
    h= zeros (row_size*column_size,k);
    for i=1:row_size*column_size
       h(i,DistanceMinIndex(i)) = 1; 
    end
    binaryLogical = logical(h);
end