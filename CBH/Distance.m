function distance = Distance( a,b,Dimension,h )
%DISTANCE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
D = 0;
a(3) = h;
for d = 1:Dimension
    D = (a(d)-b(d))^2 + D;
end
distance = sqrt(D);
end

