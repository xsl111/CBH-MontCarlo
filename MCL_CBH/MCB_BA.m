function bestS = MCB_BA(dim, ps, Max_iteration,Xpos, Ypos, RXpos, RYpos, newSeed, SeedNo, BorderLength)
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
%% BA参数设置
 
t = 1; 
maxT = Max_iteration; %最大迭代次数
sizep = ps; %种群大小
% xmin = lb;
% xmax = ub; %位置向量的范围
 
A = 0.6.*ones(sizep,1);    % 响度 (不变或者减小)
r = zeros(sizep,1);      % 脉冲率 (不变或增加))
r0 = 0.7;
Af = 0.9;
Rf = 0.9;
Qmin = 0;         % 最小频率
Qmax = 1;         % 最大频率
 
%% 初始化
 
% Lb = xmin*ones(1,dim);
% Ub = xmax*ones(1,dim);
% pop = lb+(ub-lb).*rand(sizep,dim); %种群初始化
for i=1:sizep
    pop(i,1) = Xmin + (Xmax - Xmin) .* rand;
    pop(i,2) = Ymin + (Ymax - Ymin) .* rand;
end
popv = zeros(sizep,dim);   % 速度
Q = zeros(sizep,1);   % 频率
 
pfitness = zeros(sizep,1);
for i = 1:sizep
%     pfitness(i) = feval(fhd,pop(i,:)',func_num); %评价
    pfitness(i) = fit_w(pop(i,1), pop(i,2), RXpos, RYpos, newSeed, SeedNo);
end
[bestMin, bestID]=min(pfitness);
bestS = pop(bestID, :);
bestArchive = zeros(maxT,1);
%% 具体迭代过程
 
while t <= maxT
    for i = 1:sizep
        Q(i)=Qmin+(Qmax-Qmin)*rand();
        popv(i,:)=popv(i,:)+(pop(i,:)-bestS)*Q(i);
        Stemp = pop(i,:)+popv(i,:);
        % 脉冲率
         if rand>r(i)
             Stemp=bestS-1+2*rand(1,dim);
         end
%          fitTemp = feval(fhd,Stemp',func_num);
         fitTemp = fit_w(Stemp(1), Stemp(2), RXpos, RYpos, newSeed, SeedNo);
         if (fitTemp<=pfitness(i))&&(rand()<A(i))
            pop(i,:) = Stemp;
            pfitness(i) = fitTemp;
            A(i) = Af*A(i);
            r(i) = r0*(1-exp(-Rf*t));
         end
         if fitTemp <= bestMin
            bestMin = fitTemp;
         	bestS = Stemp;
         end
    end
    bestArchive(t) = bestMin;
%     fprintf('GEN: %d  min: %.4f\n', t, bestMin);
    t = t +1;
end
 
 
end
