function [ dist, r ] = computeDistances( count, k, x, mu )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

r=zeros(count-1,k);
index=0;
dist=inf(1,count-1);

% assign all xn to nearest mu
for i=1:count-1 %for all xn
    
    for j=1:k %for all mu
        
        if sum((x(i,:)'-mu(:,j)).^2)<dist(i)
           dist(i)=sum((x(i,:)'-mu(:,j)).^2);
           index=j;           
        end
        
    end
    
    r(i,index)=1;
    
end


end

