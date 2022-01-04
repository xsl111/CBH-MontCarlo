function fitnessgbest = PSO_Cover( Dimension,Particle_Number,Max_Gen,Popmin,Popmax,Node_num,coordinate,Radius )
%PSO �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

rand('state',sum(100*clock));

c = 2.0;
D = Dimension;
sizepop = Particle_Number;
maxgen = Max_Gen;
popmax = Popmax;
popmin = Popmin;
Vmax = Popmax/10;
Vmin = Popmin/10;
for i = 1:sizepop
    % �������һ����Ⱥ
    pop(i,:) = popmin+(popmax-popmin)*rand(1,D);    %��ʼ��Ⱥ
    V(i,:) = Vmin+(Vmax-Vmin)*rand(1,D);  %��ʼ���ٶ�
    % ������Ӧ��
    fitness(i) = Cover_function(pop(i,:),Node_num,coordinate,Radius);
end

%% V. ���弫ֵ��Ⱥ�弫ֵ

[bestfitness,bestindex] = max(fitness);
GP = bestindex;
pbest = pop;    %�������
gbest = pop(bestindex,:);   %ȫ�����
fitnesspbest = fitness;%���������Ӧ��ֵ

fitnessgbest = bestfitness;%ȫ�������Ӧ��ֵ





for G = 1:maxgen
    w = 0.9-0.5*G/maxgen;
    for i = 1:sizepop
        V(i,:) = w*V(i,:)+c*rand*(pbest(i,:) -pop(i,:))+c*rand*(gbest-pop(i,:));
        for d = 1:D
            V(i,d) = max(Vmin,min(Vmax,V(i,d)));
        end
        
        % ��Ⱥ����
        pop(i,:) = pop(i,:)+V(i,:);
        
        %ȷ������λ�ò������߽�
        for d = 1:D
            pop(i,d) = max(popmin,min(popmax,pop(i,d)));
        end
        fitness(i) = Cover_function(pop(i,:),Node_num,coordinate,Radius);
        
        if fitness(i) > fitnesspbest(i)
            fitnesspbest(i) = fitness(i);
            pbest(i,:) = pop(i,:);
            if fitness(i) > fitnessgbest
                fitnessgbest = fitness(i);
                gbest = pop(i,:);
            end
        end
        
    end
    
end


end

