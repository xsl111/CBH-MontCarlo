function Status = MeanD(x,g,D)
%MEANDISTANCE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% rows = size(x,1);
for i = 1:size(x,1)
    distan = 0;
    for j = 1:size(x,1)
        if i==j
            continue;
        end
        for d = 1:D
            distan = distan + (x(j,d)-x(i,d))^2;
%             distance = sqrt((x(j,1)-x(i,1))^2+(x(j,2)-x(i,2))^2)+distance;
        end
    end
    distance = sqrt(distan);
    MeanDis(i) = distance/(size(x,1)-1);  
end;
% Status = MeanDis;

MaxDis = MeanDis(1);
MinDis = MeanDis(1);
for i = 1:size(x,1)
    if MeanDis(i)>MaxDis
        MaxDis = MeanDis(i);
    end
    if MeanDis(i)<MinDis
        MinDis = MeanDis(i);
    end
end
Status = (MeanDis(g)-MinDis)/(MaxDis-MinDis);


end


