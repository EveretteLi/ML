function [group_array] = find_sublist_test(index_list, dif)
group_array = {};
% if the index list is empty -> return empty list
if size(index_list) == 0
    return
% if index list has size 1 -> return it
elseif size(index_list) == 1
    group_array{end+1} = index_list;
    return
end

% make groups by dif
subgroup = index_list(1);
disp("il size: " + size(index_list));
for i = 2:length(index_list)
    % if i - (i-1) > dif -> break in subgroups
    if index_list(i) - index_list(i-1) > dif
        group_array{end+1} = subgroup;
        disp("group_array: " + group_array{end});
        subgroup = index_list(i);
        continue;
    end
     %i - (i-1) <= dif -> append subgroup
    subgroup = [subgroup, index_list(i)];
    disp("subgroup: " + subgroup);
    % end of index list
    if i == length(index_list)
        group_array{end+1} = subgroup;
    end
end
end