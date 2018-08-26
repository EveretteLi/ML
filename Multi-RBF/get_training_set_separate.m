%% get a merged version of training set and the 2 subsets that makes it
% return: [x2, y1, x2, y2, x, y]
% from: domain from
% to: domain to
% intercal: the sapce that 2 sets merge together
% set_size: training set size
function [x1, y1, x2, y2, x, y] = get_training_set_separate(from, to, interval, set_size)

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
one = ones(1, length(x1));
y1 = one;
% y2 = sin(x2)-0.1
y2 = one.*0.03;
x = [];
y = [];

% merge into oe 
g_counter = 0;
a_counter = 0;
b_counter = 0;
threshold = false;
while g_counter < (length(list_1)+length(list_2))
    if interval < 0
        disp("interval value invalide");
        return;
    end
    
    % a threshould determine which function to put
    if mod(g_counter, interval) == 0
        threshold = ~threshold;
    end
    if threshold
        x = [x, x1(a_counter+1)];
        y = [y, y1(a_counter+1)];
        a_counter = a_counter +1;
    else
        x = [x, x2(b_counter+1)];
        y = [y, y2(b_counter+1)];
        b_counter = b_counter +1;
    end     
    g_counter = g_counter + 1;
end
end