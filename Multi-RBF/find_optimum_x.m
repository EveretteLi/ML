% given range of x, find x for local optimums covered by this range
% input: range, a list the x values
%        start_from_1, boolean value. If true, the list will start from
%        the x that lead to the first 1 in this given range. 
% output: op_input, a list of x at local optimum(1 or -1)
function [op_input] = find_optimum_x(range, start_from_1)
op_input = [];
opn = get_ind_from_x(range);
opx = get_op_from_ind(opn);
temp = sin(opx.^-1);

count = 1;
if start_from_1
    while count <= length(temp)
        if temp(count) == 1
            op_input = [op_input, opx(count)];
        end
        count = count + 1;
    end
else
    op_input = opx;
end
end