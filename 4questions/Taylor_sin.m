function [out] = Taylor_sin(x)
out = x - (x.^3./factorial(3))+(x.^5./factorial(5))-(x.^7./factorial(7));
end
