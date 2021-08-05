function [ig] = cal_ig(a, b, c, d)
N = a(1, 1) + b(1, 1) + c(1, 1) + d(1, 1);
% t1 = -nanmean( ( (a+c)/N ) .* log2( (a+c)/N ) );
% t2 = ( (a(1, 1)+b(1, 1)) / N ) * nanmean( (a./(a+b)).*log2(a./(a+b)) );
% t3 = ( (c(1, 1)+d(1, 1)) / N ) * nanmean( (c./(c+d)).*log2(c./(c+d)) );
% ig = t1 + t2 + t3;

t1 = ( (a+c)/N ) .* log2( (a+c)/N );
t2 = ( a./(a+b) ) .* log2( a./(a+b) );
t3 = ( c./(c+d) ) .* log2( c./(c+d) );
t1(isnan(t1)) = 0; t1(isinf(t1)) = 0;
t2(isnan(t2)) = 0; t2(isinf(t2)) = 0;
t3(isnan(t3)) = 0; t3(isinf(t3)) = 0;
ig = -mean(t1) + ( (a(1, 1)+b(1, 1)) / N ) * mean(t2) + ( (c(1, 1)+d(1, 1)) / N ) * mean(t3);

end