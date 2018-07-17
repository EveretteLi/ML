% find 5 points in each period of sin function
function [output, input] = five_points_each_period(x)
output = [];
input = [];
% pick 5 ys
% these ys should be fixed for all period
y_5 = linspace(1, -1, 5);
for i = y_5
   for j = x
       if sin(j) == i
           output = [output, i];
           input = [input, j];
       end
   end
end
end