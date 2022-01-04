% function [fitnessgbest,T] = PSO( fhd,Dimension,Particle_Number,Max_Gen,Popmin,Popmax,varargin )
%PSO 此处显示有关此函数的摘要
%   此处显示详细说明
function gbest = MCB_PSO( Dimension,Particle_Number,Max_Gen,Xpos,Ypos,RXpos,RYpos,newSeed,SeedNo,BorderLength )
rand('state',sum(100*clock));

c = 2.0;
% w = -0.2;
w = 0.9;
c1 = -0.07;
c2 = 3.74;
r1 = 1;
r2 = 1;
D = Dimension;
sizepop = Particle_Number;
maxgen = Max_Gen;
% popmax = Popmax;
% popmin = Popmin;
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
for i = 1:sizepop
    % 随机产生一个种群
    X(i,1)  = Xmin + (Xmax - Xmin) .* rand();    %初始种群
    X(i,2) = Ymin + (Ymax - Ymin) .* rand();
    V(i,:) = Vmin+(Vmax-Vmin).*rand(1,D);  %初始化速度
    % 计算适应度
    fitness(i) = fit_w(X(i,1), X(i,2), RXpos, RYpos, newSeed, SeedNo);
end
% fitness = feval(fhd,pop',varargin{:});


%% V. 个体极值和群体极值

[bestfitness,bestindex] = min(fitness);
GP = bestindex;
pbest = X;    %个体最佳
gbest = X(bestindex,:);   %全局最佳
fitnesspbest = fitness;%个体最佳适应度值

fitnessgbest = bestfitness;%全局最佳适应度值

for G = 1:maxgen
    %     w = 0.9-0.5*G/maxgen;
    w = fix(10-5*G/maxgen)/10;
    for i = 1:sizepop
%         V(i,:) = w*V(i,:)+c*rand*(pbest(i,:) -X(i,:))+c*rand*(gbest-X(i,:));
        V(i,:) = w*V(i,:)+c1*rand*(pbest(i,:) -X(i,:))+c2*rand*(gbest-X(i,:));
        V(i,:) = max(Vmin,min(Vmax,V(i,:)));
        X(i,:) = X(i,:)+V(i,:);
        X(i,1) = max(Xmin,min(Xmax,X(i,1)));
        X(i,2) = max(Ymin,min(Ymax,X(i,2)));
        fitness(i) = fit_w(X(i,1), X(i,2), RXpos, RYpos, newSeed, SeedNo);
        % 种群更新
        %         pop(i,:) = pop(i,:)+V(i,:);
        %         pop(i,:) = r1*pop(i,:)+r2*V(i,:);
        
        
        %确保粒子位置不超出边界
        %         for d = 1:D
        %             pop(i,d) = max(popmin,min(popmax,pop(i,d)));
        %         end
        if fitness(i)<fitnesspbest(i)
            fitnesspbest(i) = fitness(i);
            pbest(i,:) = X(i,:);
            if fitness(i)<fitnessgbest
                fitnessgbest = fitness(i);
                gbest = X(i,:);
            end
        end
        
    end
    
    
end

% figure(varargin{:});
% 
% plot(T(1:50:1000),'r-o','LineWidth',1,'Marker','o','MarkerFaceColor','red');
% hold on;
% legend('PSO');
end

