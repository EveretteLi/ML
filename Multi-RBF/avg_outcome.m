function [avg] = avg_outcome(net, x)
out = net(x);
[num_func, d] = size(out);
avg = [];
for i = 1:d
    temp = 0;
    for j = 1:num_func
        temp = temp + out(j, i);
    end
    avg = [avg, temp/length(num_func)];
end
end