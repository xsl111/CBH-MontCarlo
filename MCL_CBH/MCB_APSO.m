% function [fitnessgbest,T] = APSO( fhd,func_num,Dimension,Particle_Number,Max_Gen,VRmin,VRmax,Popmin,Popmax)
function gbest = MCB_APSO( Dimension,Particle_Number,Max_Gen,Xpos,Ypos,RXpos,RYpos,newSeed,SeedNo,BorderLength)

%APSO 此处显示有关此函数的摘要
%   此处显示详细说明
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
c1 = 2.0;
c2 = 2.0;
w = 0.9;
D = Dimension;
sizepop = Particle_Number;
maxgen = Max_Gen;%
% Vmax = VRmax;
% Vmin = VRmin;
% popmax = Popmax;
% popmin = Popmin;
Status = 'S1';


for i = 1:sizepop
    % 随机产生一个种群
    %     pop(i,:) = popmin+(popmax-popmin)*rand(1,D);    %初始种群
    pop(i,1) = Xmin+(Xmax-Xmin)*rand;    %初始种群
    pop(i,2) = Ymin+(Ymax-Ymin)*rand;    %初始种群
    V(i,:) = Vmin+(Vmax-Vmin)*rand(1,D);  %初始化速度
    fitness(i) = fit_w(pop(i,1), pop(i,2), RXpos, RYpos, newSeed, SeedNo);
end
% fitness = feval(fhd,pop',func_num);

%% V. 个体极值和群体极值
[bestfitness,bestindex] = min(fitness);
pbest = pop;    %个体最佳
gbest = pop(bestindex,:);   %全局最佳
fitnesspbest = fitness;%个体最佳适应度值

fitnessgbest = bestfitness;   %全局最佳适应度值
g = bestindex;


%% VI. 迭代寻优
for i = 1:maxgen
    for j = 1:sizepop
        % 速度更新
        V(j,:) = w*V(j,:) + c1*rand*(pbest(j,:) - pop(j,:)) + c2*rand*(gbest - pop(j,:));
        
        
        %确保速度不超出边界
        for d = 1:D
            V(j,d) = max(Vmin,min(Vmax,V(j,d)));
        end
        
        % 种群更新
        pop(j,:) = pop(j,:) + V(j,:);
        
        %确保粒子位置不超出边界
%          for d = 1:D
%            pop(j,d) = max(popmin,min(popmax,pop(j,d)));
%          end
        pop(j,1) = max(Xmin,min(Xmax,pop(j,1)));
        pop(j,2) = max(Ymin,min(Ymax,pop(j,2)));
        
        % 适应度值更新
%         fitness(j) = feval(fhd,pop(j,:)',func_num);
        fitness(j) = fit_w(pop(j,1), pop(j,2), RXpos, RYpos, newSeed, SeedNo);
        %pbest和gbest更新
        if fitness(j) < fitnesspbest(j)
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
            if fitness(j) < fitnessgbest
                gbest = pop(j,:);
                fitnessgbest = fitness(j);
                g = j;
            end
            
        end
        Rd = randperm(D,1);%从1-D中随机选取一个数
        variance = 1.0-0.9*i/maxgen;
%         Z = popmin+(popmax-popmin)*gaussmf(gbest(Rd),[variance 0]);
        Jump = gbest(Rd)-17+rand*34;
%         Jump = gbest(Rd)+Z;
%         Jump = max(popmin,min(popmax,Jump));
        if Rd == 1
            Jump = max(Xmin,min(Xmax,Jump));
        elseif Rd == 2
            Jump = max(Ymin,min(Ymax,Jump));
        end
        Ju = gbest;
        Ju(Rd) = Jump;
        
%         Jumpfitness = feval(fhd,Ju',func_num);
        Jumpfitness = fit_w(Ju(1), Ju(2), RXpos, RYpos, newSeed, SeedNo);
        if Jumpfitness < fitnessgbest
%             Status = 'S4';
            pop(g,:) = Ju;
            pbest(g,:) = Ju;
            gbest = Ju;
            fitnesspbest(g) = Jumpfitness;
            fitnessgbest = Jumpfitness;
        end
    end
    
%     yy(i) = fitnessgbest;
    
    
%%   状态判断
    
    S(i) = MeanD(pop,g,D);
    w = 1/(1+1.5*exp(-2.6*S(i)));   
    if S(i)<0.2
        Status = 'S3';
    end
    if 0.2<=S(i)&&S(i)<0.23
        if strcmp(Status,'S1')||strcmp(Status,'S2')
            Status = 'S2';
        else
            Status = 'S3';
        end
    end
    if 0.23<=S(i)&&S(i)<0.3
        if strcmp(Status,'S2')||strcmp(Status,'S3')
            Status = 'S3';
        else
            Status = 'S2';
        end
    end
    
    if 0.3<=S(i)&&S(i)<0.4
        Status = 'S2';
    end
    if 0.4<=S(i)&&S(i)<0.5
        if strcmp(Status,'S1')||strcmp(Status,'S4')
            Status = 'S1';
        else
            Status = 'S2';
        end
    end
    if 0.5<=S(i)&&S(i)<0.6
        if strcmp(Status,'S2')||strcmp(Status,'S1')
            Status = 'S2';
        else
            Status = 'S1';
        end
    end
    
    if 0.6<=S(i)&&S(i)<0.7
        Status = 'S1';
    end
    if 0.7<=S(i)&&S(i)<0.77
        if strcmp(Status,'S3')||strcmp(Status,'S4')
            Status = 'S4';
        else
            Status = 'S1';
        end
    end
    if 0.77<=S(i)&&S(i)<0.8
        if strcmp(Status,'S4')||strcmp(Status,'S1')
            Status = 'S1';
        else
            Status = 'S4';
        end
    end
    if S(i)>=0.8
        Status ='S4';
    end
%%    根据状态调整参数
    
    if strcmp(Status,'S1')
        c1 = c1+(0.05+rand*0.05);
        c2 = c2-(0.05+rand*0.05);
    end
    
    
    if strcmp(Status,'S2')
        c1 = c1+(0.025+rand*0.025);
        c2 = c2-(0.025+rand*0.025);
    end
    
    
    if strcmp(Status,'S3')
        c1 = c1+(0.025+rand*0.025);
        c2 = c2+(0.025+rand*0.025);
    end
    
    
    if strcmp(Status,'S4')
        c1 = c1-(0.05+rand*0.05);
        c2 = c2+(0.05+rand*0.05);
    end
    if c1+c2 < 3
        c1 = c1*3/(c1+c2);
        c2 = 3-c1;
    end
    if c1+c2 > 4
        c1 = c1*4/(c1+c2);
        c2 = 4-c1;
    end
    c1 =  max(1.5,min(2.5,c1));
    c2 =  max(1.5,min(2.5,c2));

    T(i) = fitnessgbest;
end

end

