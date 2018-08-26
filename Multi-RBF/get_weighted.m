%% get the weighted Gaussian functions 
% returns [weighted_guassian, b2] 
% net: the NN model 
% x: the domain
function [weighted_guassian, b2] = get_weighted(net, x)
weighted_guassian = net.LW{2,1}' .* radbas(netprod(dist(net.IW{1,1}, x), net.b{1}));
b2 = net.b{2};
end
