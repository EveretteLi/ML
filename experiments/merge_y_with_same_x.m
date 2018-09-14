function [x, y] = merge_y_with_same_x(y_from, x_onto, y_onto, interval)
    x = [];
    y = [];
    
    list_1 = x_onto;
    list_2 = [];
    
    space = list_1(2) - list_1(1);
    disp("gap: " + space/2);
    
    for i = list_1
        list_2 = [list_2, i+space/2];
    end
    
    x1 = list_1;
    x2 = list_2;
    y1 = y_onto;
    y2 = y_from + 1;
    
    counter = 0;
    threshold = false;
    while counter < length(list_1)
        if interval < 0
           disp("interval value invalide");
          return;
        end
    
        % a threshould determine which function to put
        if mod(counter, interval) == 0
            threshold = ~threshold;
        end
        if threshold
            x = [x, x1(counter+1)];
            y = [y, y1(counter+1)];
        else
            x = [x, x2(counter+1)];
            y = [y, y2(counter+1)];
        end     
        counter = counter + 1;
    end
end