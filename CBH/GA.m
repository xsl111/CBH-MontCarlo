function [ fitnessGBest,Total ] = GA( fhd,dim,popsize,iterMax,lb,ub,func_num )
%GA 此处显示有关此函数的摘要
%   此处显示详细说明
%% 初始化参数
% chromlength = ub;   %二进制编码长度
pc = 0.9;           %交叉概率
pm = 0.01;          %变异概率


%% 随机产生一个染色体种群
for i = 1:popsize
    pop(i,:) = lb + (ub - lb) .* rand(1,dim);  %初始种群位置，并保证不越界
end
%计算适应度值
fitness = feval(fhd,pop',func_num);

[fitnessGBest,GBestindex] = min(fitness);
gbest = pop(GBestindex,:);

%% 迭代更新
for iter = 1:iterMax

    %选择操作
    %构造轮盘，进行轮盘赌
    sumfitness = sum(fitness);
    s_fitness = fitness / sumfitness;
    s_fitness = cumsum(s_fitness);
    ms = sort(rand(popsize,1));
    newindex = 1;
    fitnessindex =1;
    while newindex <= popsize
        if(ms(newindex) < s_fitness(fitnessindex))
            newpop1(newindex,:) = pop(fitnessindex,:);
            newindex = newindex + 1;
        else
            fitnessindex = fitnessindex + 1;
        end
    end
    pop = newpop1;
    
    %交叉操作
    for i = 1:2:popsize-1
        if(rand < pc)
            cpoint = round(rand * dim);
            newpop2(i,:) = [pop(i,1:cpoint),pop(i+1,cpoint+1:dim)];
            newpop2(i+1,:) = [pop(i+1,1:cpoint),pop(i,cpoint+1:dim)];
        else
            newpop2(i,:)=pop(i,:);
            newpop2(i+1,:)=pop(i+1,:);
        end
    end
    pop = newpop2;
    
    %变异操作
    for i = 1:popsize
        newpop3(i,:) = pop(i,:);
        if(rand < pm)
            mpoint = round(rand * dim);
            if mpoint <= 0
                mpoint = 1;
            end
            newpop3(i,mpoint) = lb + (ub - lb) * rand;
        end
    end
    pop = newpop3;
    
%     pop_next = b2d(pop);
    fitnessNext = feval(fhd,pop',func_num);
    
    %比较适应度值进行最优的选择
    for i = 1:popsize
        if fitnessNext(i) < fitnessGBest
            fitnessGBest = fitnessNext(i);
            gbest = pop(i,:);
        end
    end
    Total(iter) = fitnessGBest;
end

