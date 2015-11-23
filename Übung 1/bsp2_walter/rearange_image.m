function [ image_reshaped ] = rearange_image(image, dimension)
%function rearrange rgb values of image into columns DONE
%save in image_reshaped c1: r, c2:g, c3:b

    [row_size,column_size,column_dim] = size(image);

    r_values = horzcat(image(1,:,1));
    g_values = horzcat(image(1,:,2));
    b_values = horzcat(image(1,:,3)); 
    
    for i=2:row_size
        r_values = horzcat(r_values,image(i,:,1));
        g_values = horzcat(g_values,image(i,:,2));
        b_values = horzcat(b_values,image(i,:,3));
    end
    
    image_reshaped(:,1) = r_values';
    image_reshaped(:,2) = g_values';
    image_reshaped(:,3) = b_values';

    if (dimension == 5)
        
        x_norm_temp = (1:column_size)/column_size;
        x_norm = horzcat(x_norm_temp);
        y_step = (1)/row_size;
        y_norm_temp = zeros(1,column_size);
        y_norm_temp = y_norm_temp + y_step; 
        y_norm = horzcat(y_norm_temp);
        
        for i=2:row_size
            x_norm = horzcat(x_norm,x_norm_temp);
            y_norm_temp = y_norm_temp + y_step; 
            y_norm = horzcat(y_norm,y_norm_temp);
        end       
        image_reshaped(:,5) = x_norm';
        image_reshaped(:,4) = y_norm'; 
    end

end