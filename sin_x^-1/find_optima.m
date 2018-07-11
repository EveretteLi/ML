% take in a range of x, find optima value among them
function [op_input] = find_optima(range, start_from_1)
op_input = [];
opn = get_int_from_x(range);
opx = get_op_from_int(opn);
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