function [a, x_a] = show_radbas(net, x)
x_a = x;
a = radbas(netprod(dist(net.IW{1,1}, x_a), net.b{1}));
end