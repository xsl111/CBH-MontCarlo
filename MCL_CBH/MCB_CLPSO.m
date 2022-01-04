function gBest= MCB_CLPSO(Dimension,Particle_Number,Max_Gen,Xpos,Ypos,RXpos,RYpos,newSeed,SeedNo, BorderLength)

%Comprehensive Learning Particle Swarm Optimization �ۺ�ѧϰ����Ⱥ�Ż��㷨
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
%% ��ʼ������
c = 2.0;            %PSO��cһ��ȡ2.0
w = 0.9;            %PSO��wһ��ȡ0.9
wMax = 0.9;
wMin = 0.2;
% Vmin = -10;
% Vmax = 10;
%% �������һ����Ⱥ
for i = 1:Particle_Number
%     X(i,:) = Xmin + (Xmax - Xmin) .* rand(1,Dimension);  %��ʼ��Ⱥλ�ã�����֤��Խ��
%     V(i,:) = Vmin + (Vmax - Vmin) .* rand(1,Dimension);  %��ʼ��Ⱥ�ٶȣ�����֤��Խ��
    X(i,1)  = Xmin + (Xmax - Xmin) .* rand();    %��ʼ��Ⱥ
    X(i,2) = Ymin + (Ymax - Ymin) .* rand();
    V(i,:) = Vmin+(Vmax-Vmin).*rand(1,Dimension);  %��ʼ���ٶ�
    fitness(i) = fit_w(X(i,1), X(i,2), RXpos, RYpos, newSeed, SeedNo);
end
%������Ӧ��
% fitness = feval(fhd,X',func_num);

%% ���弫ֵ����Ⱥ��ֵ
[bestFitness,bestIndex] = min(fitness);     %��Ⱥ����ֵ���Ͷ�Ӧ���±�
pBest = X;                  %�������
gBest = X(bestIndex,:);     %ȫ�����
fitnessPBest = fitness;     %���������Ӧ��ֵ
fitnessGBest = bestFitness; %ȫ�������Ӧ��ֵend

%% ��������
for g =  1:Max_Gen
    w = wMax - (wMax - wMin) * (g/Max_Gen);   %��������������������Ӷ���С
    for i = 1:Particle_Number
        for d = 1:Dimension         %ÿһ��ά���ٶȸ��¸�����������������ڸ�ά�ȵ�����
            Pc = 0.05 + 0.45 * (exp(10 * (i - 1) / (Particle_Number - 1)) - 1) / (exp(10) - 1); %һ���Ƿ���ݱ�����Ӹ����Լ��ٶȵ���ֵ
        if (rand < Pc)
            f1 = fix(rand * Particle_Number);     %���ѡȡ��������
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
        %�������ÿ�����ӵ���һ�����ٶ�
        V(i,d) = w * V(i,d) + c * rand * (pBest(fd,d) - X(i,d));
        %���ٶȽ��п��ƣ���ֹԽ��
        V(i,d) = max(Vmin,min(Vmax,V(i,d)));
        %�������ÿ�����ӵ���һ��λ��
        X(i,d) = X(i,d) + V(i,d);
%         X(i,d) = max(Xmin,min(Xmax,X(i,d)));
        %��λ�ý��п��ƣ���ֹԽ��
        if d == 1
            X(i,d) = max(Xmin,min(Xmax,X(i,d)));
        elseif d == 2
            X(i,d) = max(Ymin,min(Ymax,X(i,d)));
        end
        end
        fitness(i) = fit_w(X(i,1), X(i,2), RXpos, RYpos, newSeed, SeedNo);
    end
    %����ÿ�ε������º�ÿ�����ӵ���Ӧ��ֵ
%     fitness = feval(fhd,X',func_num);
    
    %ÿ�ε����������Ⱥ�����Ӧ��ֵ��ȫ�������Ӧ��ֵ�Լ���������λ�ú�ȫ������λ��
    for i = 1:Particle_Number
        %����ÿ�ε�����ĸ��������Ӧ��ֵ��ÿ����������λ��
        if fitness(i) < fitnessPBest(i)
            fitnessPBest(i) = fitness(i);
            pBest(i,:) = X(i,:);
        end
        %����ÿ�ε������ȫ��������Ӧ��ֵ��ȫ�����λ��
        if fitness(i) < fitnessGBest
            fitnessGBest = fitness(i);
            gBest = X(i,:);
        end
    end
    
    Total(g) = fitnessGBest;     %��ÿ�ε������º��ȫ�����Ŵ洢��Total������
    
end       
end
