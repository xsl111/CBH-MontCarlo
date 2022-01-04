function [ bh_fitness,T ] = Inverse_CBH_7( fhd, D, pop_size, iter_max, popmin, popmax, func_num )
%CBH_7 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%%��ʼ������
c = 2.0;
Np = pop_size;
% sub_iter_max = 1500;
mu = zeros(1,D);
sicma = 10*ones(1,D);
for i=1:4
    pop(i,:) = popmin + (popmax-popmin) .* rand(1,D);
%     pop(1,:)=popmax*icdf('Normal',rand(1,D),mu,sicma);
end
fitness = feval(fhd,pop',func_num);
[bh_fitness_1,bh_index] = min(fitness);
bh = pop(bh_index,:);
bh_R = 0.01724;
bh_R_sub = bh_R;
%ÿ�����ӵ���5000��
for i=1:4
    [bh_sub_fit, T_sub, bh_R_sub, bh_sub] = Copy_of_worker(i, pop(i,:), pop_size, mu, sicma, bh_R_sub, fhd, D, sub_iter_max, popmin+(i-1)*50, popmin+i*50,func_num);
    bh_fit(i,:) = bh_sub_fit;%ÿ����������õ���Ӧ��
    T_sub_1(i,:) = T_sub;%��������ÿһ����õ���Ӧ��
    bh_m(i,:) = bh_sub;%ÿ�������ҵ������λ��
end
bh_R = bh_R_sub;%����bh_R�ڶ��뾶
[bh_fitness_1,bh_index] = min(bh_fit);
bh = bh_m(bh_index,:);%���ºڶ�λ��
T_1 = min(T_sub_1,[],1);%�ڴ˴�����T_sub,ȡT_subÿһ�е����ֵ


popmin = -100;
popmax = 100;

%��һ�����⣬��ԭ�Ȳ������ĸ����ӣ���������������ĸ��µ�����
sub_iter_max = 7500;
[bh_sub_fit, T_sub] = Copy_of_worker_2( pop, pop_size, mu, sicma, bh, bh_R, bh_fitness_1, fhd, D, sub_iter_max, popmin, popmax,func_num); 
% [bh_fitness,bh_index] = min(T_sub);
%bh = pop(bh_index,:);%���ºڶ�λ��
%bh_R = bh_R_sub;%����bh_R�ڶ��뾶
bh_fitness = min(bh_fitness_1,bh_sub_fit);
% T_2 = min(T_sub_2,[],2);      
T = T_sub;

end

