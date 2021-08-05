function [avg_mi, max_mi] = cal_mi(a, b, c, d)
N = a(1, 1) + b(1, 1) + c(1, 1) + d(1, 1);
class_dist = (a+c) / N;
t = log2( ( a * N ) ./ ( ( a + c ).*( a + b ) ) );
t(isnan(t)) = 0;
t(isinf(t)) = 0;
avg_mi = class_dist' * t;
max_mi = max(t, [], 1);
end