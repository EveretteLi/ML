% generates a x value at a sin(1/x) optima
function [opx] = get_op_from_int(integer)
opx = 2 ./ ((2*pi*integer)+pi);
end