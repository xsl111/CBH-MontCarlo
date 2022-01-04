function gBest= MCB_CLPSO(Dimension,Particle_Number,Max_Gen,Xpos,Ypos,RXpos,RYpos,newSeed,SeedNo, BorderLength)

%Comprehensive Learning Particle Swarm Optimization 综合学习粒子群优化算法
Xmin = Xpos - 10;
Xmax = Xpos + 10;
Ymin = Ypos - 10;
Ymax = Ypos + 10;
Xmax = min(BorderLength,max(0,Xmax));
Xmin = min(BorderLength,max(0,Xmin));
Ymax = min(BorderLength,max(0,Ymax));
Ymax = min(BorderLength,max(0,Ymax));
Vmax = (Xmax - Xmin) / 20;
Vmin = -Vmax;
%% 初始化参数
c = 2.0;            %PSO中c一般取2.0
w = 0.9;            %PSO中w一般取0.9
wMax = 0.9;
wMin = 0.2;
% Vmin = -10;
% Vmax = 10;
%% 随机产生一个种群
for i = 1:Particle_Number
%     X(i,:) = Xmin + (Xmax - Xmin) .* rand(1,Dimension);  %初始种群位置，并保证不越界
%     V(i,:) = Vmin + (Vmax - Vmin) .* rand(1,Dimension);  %初始种群速度，并保证不越界
    X(i,1)  = Xmin + (Xmax - Xmin) .* rand();    %初始种群
    X(i,2) = Ymin + (Ymax - Ymin) .* rand();
    V(i,:) = Vmin+(Vmax-Vmin).*rand(1,Dimension);  %初始化速度
    fitness(i) = fit_w(X(i,1), X(i,2), RXpos, RYpos, newSeed, SeedNo);
end
%计算适应度
% fitness = feval(fhd,X',func_num);

%% 个体极值和种群极值
[bestFitness,bestIndex] = min(fitness);     %种群最优值，和对应的下标
pBest = X;                  %个体最佳
gBest = X(bestIndex,:);     %全局最佳
fitnessPBest = fitness;     %个体最佳适应度值
fitnessGBest = bestFitness; %全局最佳适应度值end

%% 迭代更新
for g =  1:Max_Gen
    w = wMax - (wMax - wMin) * (g/Max_Gen);   %惯性因子随迭代次数增加而减小
    for i = 1:Particle_Number
        for d = 1:Dimension         %每一个维度速度更新根据随机的两个粒子在该维度的最优
            Pc = 0.05 + 0.45 * (exp(10 * (i - 1) / (Particle_Number - 1)) - 1) / (exp(10) - 1); %一个是否根据别的粒子更新自己速度的阈值
        if (rand < Pc)
            f1 = fix(rand * Particle_Number);     %随机选取两个粒子
            f2 = fix(rand * Particle_Number);
            if f1 == 0
                f1 = Particle_Number;
            end
            if f2 == 0
                f2 = Particle_Number;
            end
            if fitness(f1) < fitness(f2)
                fd = f1;
            else
                fd = f2;
            end
        else
            fd = i;
        end
        %计算更新每个粒子的下一代的速度
        V(i,d) = w * V(i,d) + c * rand * (pBest(fd,d) - X(i,d));
        %对速度进行控制，防止越界
        V(i,d) = max(Vmin,min(Vmax,V(i,d)));
        %计算更新每个粒子的下一代位置
        X(i,d) = X(i,d) + V(i,d);
%         X(i,d) = max(Xmin,min(Xmax,X(i,d)));
        %对位置进行控制，防止越界
        if d == 1
            X(i,d) = max(Xmin,min(Xmax,X(i,d)));
        elseif d == 2
            X(i,d) = max(Ymin,min(Ymax,X(i,d)));
        end
        end
        fitness(i) = fit_w(X(i,1), X(i,2), RXpos, RYpos, newSeed, SeedNo);
    end
    %计算每次迭代更新后每个粒子的适应度值
%     fitness = feval(fhd,X',func_num);
    
    %每次迭代后更新种群最佳适应度值和全局最佳适应度值以及个体最优位置和全局最优位置
    for i = 1:Particle_Number
        %更新每次迭代后的个体最佳适应度值和每个个体的最佳位置
        if fitness(i) < fitnessPBest(i)
            fitnessPBest(i) = fitness(i);
            pBest(i,:) = X(i,:);
        end
        %更新每次迭代后的全局最优适应度值和全局最佳位置
        if fitness(i) < fitnessGBest
            fitnessGBest = fitness(i);
            gBest = X(i,:);
        end
    end
    
    Total(g) = fitnessGBest;     %将每次迭代更新后的全局最优存储到Total数组中
    
end       
end
