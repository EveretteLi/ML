function [height] =  find_parabola(init_hight, init_velocity, g, time_range)
g = -g; % gravity is downword
height = (0.5*(g*time_range.^2))+(init_velocity .* time_range)+init_hight;
end