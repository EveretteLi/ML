% given a set of x, find the index values that lead to a local optimum
% in sin(1/x)
% input: x, a list of x values
% output: n, a list of indexexes
function [n] = get_ind_from_x(x)
n = [];
if length(x) > 1
    temp = abs((2 - pi*x) ./ (2*pi*x));
    
    integer = floor(temp(1));
    n = [n, integer];
    for j = temp
    if integer ~= floor(j)
        integer = floor(j);
        n = [n, integer];
    end
    end
else
    n = floor((2 - pi*x) ./ (2*pi*x));
end
end