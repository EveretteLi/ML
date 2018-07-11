function [out] = hypo_regular_g(x)
out = 487.8460 * exp( -( dist(0, x) )^2 * 0.8325 )...
+ 451.9270 * exp( -( dist(2.5, x) )^2 * 0.8325 )...
+ 362.3026 * exp( -( dist(5,x) )^2 * 0.8325 )...
+ 212.8432 * exp( -( dist(7.5, x) )^2 * 0.8325 )...
+ -3.7839;
end