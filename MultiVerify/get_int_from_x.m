% give a set of x, give the integer values that will lead to a optima
% in sin(1/x)
function [n] = get_int_from_x(x)
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