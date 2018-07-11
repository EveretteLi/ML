function [r_list_array] = r_list_cutter(r_list, num)
r_list_array = {num};
seg_num = fix(length(r_list)/num);
cell_num = 1;
for i = 1:seg_num:length(r_list)
    if i + seg_num < length(r_list)
        r_list_array{cell_num} = r_list(i:i+seg_num);
        cell_num = cell_num + 1;
    else 
        r_list_array{cell_num} = r_list(i:length(r_list));
    end
end
end