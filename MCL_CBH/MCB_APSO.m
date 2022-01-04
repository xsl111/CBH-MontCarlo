% function [fitnessgbest,T] = APSO( fhd,func_num,Dimension,Particle_Number,Max_Gen,VRmin,VRmax,Popmin,Popmax)
function gbest = MCB_APSO( Dimension,Particle_Number,Max_Gen,Xpos,Ypos,RXpos,RYpos,newSeed,SeedNo,BorderLength)

%APSO �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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
    % �������һ����Ⱥ
    %     pop(i,:) = popmin+(popmax-popmin)*rand(1,D);    %��ʼ��Ⱥ
    pop(i,1) = Xmin+(Xmax-Xmin)*rand;    %��ʼ��Ⱥ
    pop(i,2) = Ymin+(Ymax-Ymin)*rand;    %��ʼ��Ⱥ
    V(i,:) = Vmin+(Vmax-Vmin)*rand(1,D);  %��ʼ���ٶ�
    fitness(i) = fit_w(pop(i,1), pop(i,2), RXpos, RYpos, newSeed, SeedNo);
end
% fitness = feval(fhd,pop',func_num);

%% V. ���弫ֵ��Ⱥ�弫ֵ
[bestfitness,bestindex] = min(fitness);
pbest = pop;    %�������
gbest = pop(bestindex,:);   %ȫ�����
fitnesspbest = fitness;%���������Ӧ��ֵ

fitnessgbest = bestfitness;   %ȫ�������Ӧ��ֵ
g = bestindex;


%% VI. ����Ѱ��
for i = 1:maxgen
    for j = 1:sizepop
        % �ٶȸ���
        V(j,:) = w*V(j,:) + c1*rand*(pbest(j,:) - pop(j,:)) + c2*rand*(gbest - pop(j,:));
        
        
        %ȷ���ٶȲ������߽�
        for d = 1:D
            V(j,d) = max(Vmin,min(Vmax,V(j,d)));
        end
        
        % ��Ⱥ����
        pop(j,:) = pop(j,:) + V(j,:);
        
        %ȷ������λ�ò������߽�
%          for d = 1:D
%            pop(j,d) = max(popmin,min(popmax,pop(j,d)));
%          end
        pop(j,1) = max(Xmin,min(Xmax,pop(j,1)));
        pop(j,2) = max(Ymin,min(Ymax,pop(j,2)));
        
        % ��Ӧ��ֵ����
%         fitness(j) = feval(fhd,pop(j,:)',func_num);
        fitness(j) = fit_w(pop(j,1), pop(j,2), RXpos, RYpos, newSeed, SeedNo);
        %pbest��gbest����
        if fitness(j) < fitnesspbest(j)
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
            if fitness(j) < fitnessgbest
                gbest = pop(j,:);
                fitnessgbest = fitness(j);
                g = j;
            end
            
        end
        Rd = randperm(D,1);%��1-D�����ѡȡһ����
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
    
    
%%   ״̬�ж�
    
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
%%    ����״̬��������
    
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

