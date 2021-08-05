function [a, b, c, d] = cal_abcd( fea, gnd )
% fea should be a vector
% a: term & class
% b: term & ~class
% c: ~term & class
% d: ~term & ~class
% implemented by referencing t-Test fs approach based on tf for tc
% PRL, 2014, 45, pp.1-10

class_list = unique(gnd);
class_num = length(class_list);
a = zeros( class_num, 1 );
b = zeros( class_num, 1 );
c = zeros( class_num, 1 );
d = zeros( class_num, 1 );
for i=1:class_num
    a(i, 1) = sum( fea ~= 0 & gnd == i );
    b(i, 1) = sum( fea ~= 0 & gnd ~= i );
    c(i, 1) = sum( fea == 0 & gnd == i );
    d(i, 1) = sum( fea == 0 & gnd ~= i );
end
end