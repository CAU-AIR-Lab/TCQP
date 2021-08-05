function [avg_chi, max_chi] = cal_chi(a, b, c, d)
N = a(1, 1) + b(1, 1) + c(1, 1) + d(1, 1);
class_dist = (a+c) / N;
t = ( N * (a.*d - b.*c).^2 ) ./ ( (a+c).*(b+d).*(a+b).*(c+d) );
t(isnan(t)) = 0;
t(isinf(t)) = 0;
avg_chi = class_dist' * t;
max_chi = max(t, [], 1);
end