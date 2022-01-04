function BH = MCB_BH_2( Dimension, Particle_Number, Max_Gen, Xpos, Ypos, RXpos, RYpos, newSeed, SeedNo,BorderLength )
% MCB_BH_2(D,pop_size,iter_max,X,Y,newUNNode(1,i),newUNNode(2,i),newSeed,SeedNo);
%BH �˴���ʾ�йش˺�����ժҪ
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
c = 2.0;
%% �������һ����Ⱥ
for i = 1:Particle_Number
%     X(i,:) = Xmin + (Xmax - Xmin) .* rand(1,Dimension);  %��ʼ��Ⱥλ�ã�����֤��Խ��
    X(i,1)  = Xmin + (Xmax - Xmin) .* rand();    %��ʼ��Ⱥ
    X(i,2) = Ymin + (Ymax - Ymin) .* rand();
    fitness(i) = fit_w(X(i,1), X(i,2), RXpos, RYpos, newSeed, SeedNo);
end
%������Ӧ��
% fitness = feval(fhd,X',func_num);


%% ���弫ֵ����Ⱥ��ֵ
[bestFitness,bestIndex] = min(fitness);     %��Ⱥ����ֵ���Ͷ�Ӧ���±�
BH = X(bestIndex,:);     %ȫ�����
BH_index = bestIndex;
fitnessBH = bestFitness; %ȫ�������Ӧ��ֵ
R = fitnessBH / sum(fitness);

%% ������������
%����Max_Gen��
for g = 1:Max_Gen
    %��ÿ����Ⱥ���������һ�ε�λ�ú��ٶ�
    c = 2.0 - (g / Max_Gen);
    for i = 1:Particle_Number
        %�������ÿ�����ӵ���һ��λ��
        X(i,:) = X(i,:) + c * rand * (BH - X(i,:));
        %��λ�ý��п��ƣ���ֹԽ��
        %         X(i,:) = max(Xmin,min(Xmax,X(i,:)));
        X(i,1) = max(Xmin,min(Xmax,X(i,1)));
        X(i,2) = max(Ymin,min(Ymax,X(i,2)));
        fitness(i) = fit_w(X(i,1), X(i,2), RXpos, RYpos, newSeed, SeedNo);
    end
    %����ÿ�ε������º�ÿ�����ӵ���Ӧ��ֵ
%     fitness = feval(fhd,X',func_num);
    
    %ÿ�ε����������Ⱥ�����Ӧ��ֵ��ȫ�������Ӧ��ֵ�Լ���������λ�ú�ȫ������λ��
    for i = 1:Particle_Number
        %����ÿ�ε������ȫ��������Ӧ��ֵ��ȫ�����λ��
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
            %             X(i,:) = Xmin + (Xmax - Xmin) .* rand(1,Dimension);
            X(i,1) = Xmin + (Xmax - Xmin) .* rand;
            X(i,2) = Ymin + (Ymax - Ymin) .* rand;
            %             X(i,:) = BH + normrnd((3 * R)/Dimension, R/Dimension, 1, Dimension);
        end
    end
    
    
    Total(g) = fitnessBH;     %��ÿ�ε������º��ȫ�����Ŵ洢��Total������
end
end

