function [bestMin,bestArchive] = BA(fhd,dim,ps,Max_iteration,lb,ub,func_num)

%% BA��������
 
t = 1; 
maxT = Max_iteration; %����������
sizep = ps; %��Ⱥ��С
xmin = lb;
xmax = ub; %λ�������ķ�Χ
 
A = 0.6.*ones(sizep,1);    % ��� (������߼�С)
r = zeros(sizep,1);      % ������ (���������))
r0 = 0.7;
Af = 0.9;
Rf = 0.9;
Qmin = 0;         % ��СƵ��
Qmax = 1;         % ���Ƶ��
 
%% ��ʼ��
 
% Lb = xmin*ones(1,dim);
% Ub = xmax*ones(1,dim);
pop = lb+(ub-lb).*rand(sizep,dim); %��Ⱥ��ʼ��
popv = zeros(sizep,dim);   % �ٶ�
Q = zeros(sizep,1);   % Ƶ��
 
pfitness = zeros(sizep,1);
for i = 1:sizep
    pfitness(i) = feval(fhd,pop(i,:)',func_num); %����
end
[bestMin, bestID]=min(pfitness);
bestS = pop(bestID, :);
bestArchive = zeros(maxT,1);
%% �����������
 
while t <= maxT
    for i = 1:sizep
        Q(i)=Qmin+(Qmax-Qmin)*rand();
        popv(i,:)=popv(i,:)+(pop(i,:)-bestS)*Q(i);
        Stemp = pop(i,:)+popv(i,:);
        % ������
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
