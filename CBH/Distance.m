function distance = Distance( a,b,Dimension,h )
%DISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明
D = 0;
a(3) = h;
for d = 1:Dimension
    D = (a(d)-b(d))^2 + D;
end
distance = sqrt(D);
end

