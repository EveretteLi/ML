function [out] = Taylor_parabola(init_hight, g, t)
% let's say "a" is a value very close to input, 
% this will help us to make better estimation.
a = t-0.0001; 
g = -g; % gravity is downword.
out = ((g * t.^2) ./ 2  + init_hight) +...
    ((g * t)./ factorial(1)).*(t-a) +...
    (g/factorial(2)).*((t-a).^2);
end