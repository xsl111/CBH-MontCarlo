function [ pop,fitness ] = Rank( pop,fitness)
%RANK �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

for i = 1:size(pop,1)
    for j = i+1:size(pop,1)
        if fitness(j) < fitness(i)
            tempf = fitness(i);
            tempp = pop(i,:);
            
            fitness(i) = fitness(j);
            fitness(j) = tempf;
            pop(i,:) = pop(j,:);
            pop(j,:) = tempp;
        end
    end
end
end

