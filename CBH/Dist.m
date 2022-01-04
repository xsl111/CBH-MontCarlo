function distance = Dist( a,b,Dimension )
%DISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明
D = 0;
for d = 1:Dimension
    D = (a(d)-b(d))^2 + D;
end
distance = sqrt(D);
end
