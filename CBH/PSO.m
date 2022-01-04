function [fitnessgbest,T] = PSO( fhd,Dimension,Particle_Number,Max_Gen,Popmin,Popmax,varargin )
%PSO 此处显示有关此函数的摘要
%   此处显示详细说明
%本函数的参数是CPSO论文中给出的
rand('state',sum(100*clock));

% c = 2.0;
w = -0.2;
c1 = -0.07;
c2 = 3.74;
r1 = 1;
r2 = 1;
D = Dimension;
sizepop = Particle_Number;
maxgen = Max_Gen;
popmax = Popmax;
popmin = Popmin;
Vmax = Popmax/10;
Vmin = Popmin/10;
for i = 1:sizepop
    % 随机产生一个种群
    pop(i,:) = popmin+(popmax-popmin)*rand(1,D);    %初始种群
    V(i,:) = Vmin+(Vmax-Vmin)*rand(1,D);  %初始化速度
    % 计算适应度
end
fitness = feval(fhd,pop',varargin{:});


%% V. 个体极值和群体极值

[bestfitness,bestindex] = min(fitness);
GP = bestindex;
pbest = pop;    %个体最佳
gbest = pop(bestindex,:);   %全局最佳
fitnesspbest = fitness;%个体最佳适应度值

fitnessgbest = bestfitness;%全局最佳适应度值





for G = 1:maxgen
%     w = 0.9-0.5*G/maxgen;
    for i = 1:sizepop
%         V(i,:) = w*V(i,:)+c*rand*(pbest(i,:) -pop(i,:))+c*rand*(gbest-pop(i,:));
        V(i,:) = w*V(i,:)+c1*rand*(pbest(i,:) -pop(i,:))+c2*rand*(gbest-pop(i,:));
        for d = 1:D
            V(i,d) = max(Vmin,min(Vmax,V(i,d)));
        end
        
        % 种群更新
%         pop(i,:) = pop(i,:)+V(i,:);
        pop(i,:) = r1*pop(i,:)+r2*V(i,:);

        
        %确保粒子位置不超出边界
        for d = 1:D
            pop(i,d) = max(popmin,min(popmax,pop(i,d)));
        end
        
        
    end
    fitness = feval(fhd,pop',varargin{:});
    for i = 1:sizepop
        if fitness(i)<fitnesspbest(i)
            fitnesspbest(i) = fitness(i);
            pbest(i,:) = pop(i,:);
        end
        
        if fitness(i)<fitnessgbest
            fitnessgbest = fitness(i);
            gbest = pop(i,:);
        end
    end
    
    
    T(G) = fitnessgbest;
end

% figure(varargin{:});
% 
% plot(T(1:50:1000),'r-o','LineWidth',1,'Marker','o','MarkerFaceColor','red');
% hold on;
% legend('PSO');
end

