function distance = Dist( a,b,Dimension )
%DISTANCE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
D = 0;
for d = 1:Dimension
    D = (a(d)-b(d))^2 + D;
end
distance = sqrt(D);
end
