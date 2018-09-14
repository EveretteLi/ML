function [x, y] = make_training_set(interval, from, to, set_size)

list_1 = linspace(from, to, set_size);
list_2 = [];

space = list_1(2) - list_1(1);
disp("gap: " + space/2);

for i = list_1
    list_2 = [list_2, i+space/2];
end

x1 = list_1;
x2 = list_2;
% y1 = sin(x1)
y1 = x1;
% y2 = sin(x2)-0.001;
y2 = x2;
x = [];
y = [];

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