function bh_position = CBH( D, pop_size, X, Y, RX, RY, newSeed, SeedNo,BorderLength)
%CBH_7 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%%��ʼ������
iter_max = 30;
Xmin = X - 10;
Xmax = X + 10;
Ymin = Y - 10;
Ymax = Y + 10;
Xmax = min(BorderLength,max(0,Xmax));
Xmin = min(BorderLength,max(0,Xmin));
Ymax = min(BorderLength,max(0,Ymax));
Ymax = min(BorderLength,max(0,Ymax));
xmu = zeros(1,1);
xsicma = 10*ones(1,1);
ymu = zeros(1,1);
ysicma = 10*ones(1,1);
for i=1:4
%     pop(i,:) = popmin + (popmax-popmin) .* rand(1,D);
    pop(i,1)=Xmin + (Xmax-Xmin) * rand;
    pop(i,2)=Ymin + (Ymax-Ymin) * rand;
    fitness(i) = fit_w(pop(i,1),pop(i,2),RX,RY,newSeed,SeedNo);
end
[bh_fitness_1,bh_index] = min(fitness);
bh = pop(bh_index,:);
% bh_R = 0.01724;
bh_R = 0.0046;
bh_R_sub = bh_R;
%ÿ�����ӵ���5000��
for i=1:4
    [bh_sub_fit, T_sub, bh_R_sub, bh_sub] = worker(bh, pop(i,:), pop_size, xmu, xsicma, ymu, ysicma, bh_R_sub, D, iter_max, Xmin+(i-1)*5, Xmin+i*5,Ymin+(i-1)*5, Ymin+i*5,RX, RY, newSeed, SeedNo, BorderLength);
    bh_fit(i,:) = bh_sub_fit;%ÿ����������õ���Ӧ��
    T_sub_1(i,:) = T_sub;%��������ÿһ����õ���Ӧ��
    bh_m(i,:) = bh_sub;%ÿ�������ҵ������λ��
end
bh_R = bh_R_sub;%����bh_R�ڶ��뾶
[bh_fitness_1,bh_index] = min(bh_fit);
bh = bh_m(bh_index,:);%���ºڶ�λ��

iter_max = 720;
[bh_position] = worker_2( pop, pop_size, xmu, xsicma, ymu, ysicma, bh, bh_R,bh_fitness_1, D, iter_max, Xmin, Xmax, Ymin, Ymax, RX, RY, newSeed, SeedNo, BorderLength); 

end

