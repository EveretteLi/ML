% generates x values on sin(1/x) local optimums
% input: index, a list of indexes lead to 1/-1 on sin(1/x)
% output: opx, the x values for local optimums
function [opx] = get_op_from_ind(index)
opx = 2 ./ ((2*pi*index)+pi);
end