%% main function.
% a: the amount of sp to be resuced every step
% x, y: training set
% eg: error goal
% sp: spread
% mn: max number of neurans
% dp: display gap
function [final_prediction] = rec_rbf(a, x, y, eg, sp, mn, dp)
% determine a constant rate - alpha
alpha = a;
arg_array = {x, y, eg, sp, mn, dp};

final_prediction = recursive_rbf(arg_array, alpha);
end

%% recursive step of approximation.
% decrease the size of training set while decreasding sp
function temp_prediction = recursive_rbf(arg_array, alpha)
disp("Recursion start: ");
disp("with alpha: " + alpha);
disp("spread: " + arg_array{4});
% eg: the error goal that sould be aplied to every elements
% error goal is how close the prediction to the target -> norm(apro - tgt)
eg = arg_array{3};
% make prediction using current sp
temp_model = newrb(arg_array{1}, arg_array{2}, arg_array{3}, arg_array{4}, arg_array{5}...
    , arg_array{6});
% if eg is reached -> done
temp_prediction = temp_model(arg_array{1});
disp("performance: " +  perform(temp_model, temp_prediction, arg_array{2})...
     + " // " + "GOAL: " + arg_array{3});
 disp("MEET ? " + (perform(temp_model, temp_prediction, arg_array{2}) <= arg_array{3}));
if perform(temp_model, temp_prediction, arg_array{2}) <= arg_array{3}
    disp("ERROR GOAL MEET");
    return
end

% devide training set by performance
% get actual error vector
err_vec = abs(temp_prediction - arg_array{2});

%disp("err_vec: " + err_vec');

% index list of bad predictions
index_list = [];
counter = 1;
for i = err_vec
    % not in error goal -> record its index
    if i > eg
        index_list = [index_list, counter];
    end
    counter = counter + 1;
end

disp("sub-taining set size: " + length(index_list));

% divide training set according to index list
% sublist of index list
% if the diference between 2 elements is less than some number dif(let dif = 3)
% those 2 will be considered in a same group.
% group array: an cell array of sublist 
dif = 3;
group_array = find_sublists(index_list, dif);
disp("group array size: " + length(group_array));

% decrease sp in rate alpha
sp = arg_array{4};
sp = sp - alpha*sp;
arg_array{4} = sp;
% a cell array carrys fixed predictions
fix_prediction = {};
x = arg_array{1};
y = arg_array{2};
for subgroup = 1:length(group_array)    
    arg_array{1} = x(group_array{subgroup}(1):group_array{subgroup}(end));
    arg_array{2} = y(group_array{subgroup}(1):group_array{subgroup}(end));
    sub_fix_pred = recursive_rbf(arg_array, alpha);
    fix_prediction{end+1} = sub_fix_pred;
end
% replace the bad perdictions on temp_prediction list with new trained
% outcomes
for i = 1 : length(group_array)
    temp_prediction(group_array{i}(1) : group_array{i}(end)) = fix_prediction{i};
end
disp("Recursion end: ");
return;
end
%% find sublists from index list
% determining the subgroups for the next learning step
function [group_array] = find_sublists(index_list, dif)
group_array = {};
% if the index list is empty -> return empty list
if isempty(index_list)
    return
% if index list has size 1 -> return it
elseif length(index_list) == 1
    group_array{end+1} = index_list;
    return
end
% make groups by dif
subgroup = index_list(1);
for i = 2:length(index_list)
    % if i - (i-1) > dif -> break in subgroups
    if index_list(i) - index_list(i-1) > dif
        group_array{end+1} = subgroup;
        subgroup = index_list(i);
        continue;
    end
     %i - (i-1) <= dif -> append subgroup
    subgroup = [subgroup, index_list(i)];
    % end of index list
    if i == length(index_list)
        group_array{end+1} = subgroup;
    end
end
end






















