function [ mu ] = computeMeans( dimension, count, k, x, r )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


s=zeros(1,dimension);
c=0;

% compute new values for mu
for i=1:k %for all mu
    
    for j=1:count-1
    
        if r(j,i)==1
            s=s+x(j,:);
            c=c+1;
        end
        
    end
    
    mu(:,i)=s./c;
    
    s=zeros(1,dimension);
    c=0;
    
end

% disp(mu);



end

