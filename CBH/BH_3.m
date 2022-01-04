function [fitnessBH, Total] = BH_3( fhd,Dimension,Particle_Number,Max_Gen,Xmin,Xmax,func_num )
%BH 此处显示有关此函数的摘要
%   此处显示详细说明
c = 2.0;
%% 随机产生一个种群
for i = 1:Particle_Number
    X(i,:) = Xmin + (Xmax - Xmin) .* rand(1,Dimension);  %初始种群位置，并保证不越界
end
%计算适应度
fitness = feval(fhd,X',func_num);

%% 个体极值和种群极值
[bestFitness,bestIndex] = min(fitness);     %种群最优值，和对应的下标
BH = X(bestIndex,:);     %全局最佳
BH_index = bestIndex;
fitnessBH = bestFitness; %全局最佳适应度值
R = fitnessBH / sum(fitness);

%% 进化迭代更新
%迭代Max_Gen次
for g = 1:Max_Gen
    %对每个种群个体计算下一次的位置和速度
    c = 2.0 - (g / Max_Gen);
    for i = 1:Particle_Number
        %计算更新每个粒子的下一代位置
        X(i,:) = X(i,:) + c * rand * (BH - X(i,:));
        %对位置进行控制，防止越界
        X(i,:) = max(Xmin,min(Xmax,X(i,:)));
    end
    %计算每次迭代更新后每个粒子的适应度值
    fitness = feval(fhd,X',func_num);
    
    %每次迭代后更新种群最佳适应度值和全局最佳适应度值以及个体最优位置和全局最优位置
    for i = 1:Particle_Number
        %更新每次迭代后的全局最优适应度值和全局最佳位置
        if fitness(i) < fitnessBH
            fitnessBH = fitness(i);
            BH = X(i,:);
            BH_index = i;
            R = fitnessBH / sum(fitness);
        end
    end
    for i = 1:Particle_Number
        distance = Dist(BH, X(i,:), Dimension);
        if distance < R && i ~= BH_index
            X(i,:) = Xmin + (Xmax - Xmin) .* rand(1,Dimension);
%             X(i,:) = BH + normrnd((3 * R)/Dimension, R/Dimension, 1, Dimension);
        end
    end
    
    
    Total(g) = fitnessBH;     %将每次迭代更新后的全局最优存储到Total数组中
end
end

