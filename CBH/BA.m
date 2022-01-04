function [bestMin,bestArchive] = BA(fhd,dim,ps,Max_iteration,lb,ub,func_num)

%% BA参数设置
 
t = 1; 
maxT = Max_iteration; %最大迭代次数
sizep = ps; %种群大小
xmin = lb;
xmax = ub; %位置向量的范围
 
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
pop = lb+(ub-lb).*rand(sizep,dim); %种群初始化
popv = zeros(sizep,dim);   % 速度
Q = zeros(sizep,1);   % 频率
 
pfitness = zeros(sizep,1);
for i = 1:sizep
    pfitness(i) = feval(fhd,pop(i,:)',func_num); %评价
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
         fitTemp = feval(fhd,Stemp',func_num);
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
