function [fitnessBH, Total] = BH_3( fhd,Dimension,Particle_Number,Max_Gen,Xmin,Xmax,func_num )
%BH �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
c = 2.0;
%% �������һ����Ⱥ
for i = 1:Particle_Number
    X(i,:) = Xmin + (Xmax - Xmin) .* rand(1,Dimension);  %��ʼ��Ⱥλ�ã�����֤��Խ��
end
%������Ӧ��
fitness = feval(fhd,X',func_num);

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
        X(i,:) = max(Xmin,min(Xmax,X(i,:)));
    end
    %����ÿ�ε������º�ÿ�����ӵ���Ӧ��ֵ
    fitness = feval(fhd,X',func_num);
    
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
            X(i,:) = Xmin + (Xmax - Xmin) .* rand(1,Dimension);
%             X(i,:) = BH + normrnd((3 * R)/Dimension, R/Dimension, 1, Dimension);
        end
    end
    
    
    Total(g) = fitnessBH;     %��ÿ�ε������º��ȫ�����Ŵ洢��Total������
end
end

