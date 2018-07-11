function [r_list, counter] = get_r_list(epsilon, num_years, r_earth)
r_list = r_earth;
counter = 1;
temp_r = 1;
while temp_r > epsilon && counter <= num_years
    temp_r = exp(-0.69314718056 * counter) * r_earth;
    r_list = [r_list, temp_r];
    counter = counter + 1;
end
end