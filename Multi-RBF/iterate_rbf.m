%% main function.
% 
function [net_model] = iterate_rbf(a, x, y, eg, sp, mn, dp)
% determine a constant rate - alpha
alpha = a;
arg_list = [x, y, eg, sp, mn, dp];

final_model = recursive_rbf(arg_list, alpha);

end
%% recursive step of approximation.
% decrease the size of training set while decreasding sp
function temp_model = recursive_rbf(arg_list, alpha)
% epsilon: a very small value for equality check
epsilon = 0.0000000001;
% make prediction using current sp
temp_model = newrb(arg_list);
% if eg is reached -> done
perd = temp_model(arg_list(1))
if perform(net, perd, y) <= arg_list(3)
    return
end

% else decrease sp in rate alpha
sp = sp - alpha/sp;
% devide training set by performance
% get actual error vector
err_vec = perd - arg_list(2);
% index list of bad predictions
index_list = [];
counter = 1;
for i = err_vec
    % unequals -> record its index
    if i > epsilon
        index_list = [index_list, counter];
    end
    counter = counter + 1;
end

% divide training set according to index list
% sublist of index list
% if the diference between 2 elements is less than some number dif(let dif = 3)
% those 2 will be considered in a same group.
% group list: a list of sublist 
dif = 3;
group_list = find_sublists(index_list, dif);







end
%% find sublists from index list
% determining the subgroups for the next learning step
function [group_list] = find_sublists(index_list, dif)
% if the index list is empty -> return







end

