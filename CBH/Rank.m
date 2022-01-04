function [ pop,fitness ] = Rank( pop,fitness)
%RANK 此处显示有关此函数的摘要
%   此处显示详细说明

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

