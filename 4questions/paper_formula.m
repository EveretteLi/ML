function [out] = paper_formula(g, v, p, x)
out = g*(x-1).^2 + v*(x-1) + p;
end