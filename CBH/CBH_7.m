function [ bh_fitness,T ] = CBH_7( fhd, D, pop_size, iter_max, popmin, popmax, func_num )
c = 2.0;
Np = pop_size;
sub_iter_max = 300;
mu = zeros(1,D);
sicma = 10*ones(1,D);
for i=1:4
    pop(i,:) = popmin + (popmax-popmin) .* rand(1,D);
%     pop(1,:)=popmax*icdf('Normal',rand(1,D),mu,sicma);
end
fitness = feval(fhd,pop',func_num);
[bh_fitness,bh_index] = min(fitness);
bh = pop(bh_index,:);
bh_R = 0.0174;
bh_R_sub = bh_R;
%ÿ�����ӵ���5000��
for i=1:4
    [bh_sub_fit, T_sub, bh_R_sub, bh_sub] = worker(bh, pop(i,:), pop_size, mu, sicma, bh_R_sub, fhd, D, sub_iter_max, popmin+(i-1)*50, popmin+i*50,func_num);
    bh_fit(i,:) = bh_sub_fit;%ÿ����������õ���Ӧ��
    T_sub_1(i,:) = T_sub;%��������ÿһ����õ���Ӧ��
    bh_m(i,:) = bh_sub;%ÿ�������ҵ������λ��
%     bh_R_sub = bh_R;
end
bh_R = bh_R_sub;%����bh_R�ڶ��뾶
[bh_fitness_1,bh_index] = min(bh_fit);
bh = bh_m(bh_index,:);%���ºڶ�λ��
T_1 = min(T_sub_1,[],1);%�ڴ˴�����T_sub,ȡT_subÿһ�е����ֵ


%ÿ�����ӵ���2500��
popmin = -100;
popmax = 100;
% for i=1:4
%     [bh_sub_fit, T_sub, bh_sub] = worker(pop(i,:), bh, bh_R, fhd, D, sub_iter_max/2, popmin, popamx,func_num); 
%     bh_fit(i,:) = bh_sub_fit;%ÿ����������õ���Ӧ��
%     T_sub_2(i,:) = T_sub;%��������ÿһ����õ���Ӧ��
%     bh_m(i,:) = bh_sub;%ÿ�������ҵ������λ��
% end

%��һ�����⣬��ԭ�Ȳ������ĸ����ӣ���������������ĸ��µ�����
sub_iter_max = 7200;
[bh_sub_fit, T_sub] = worker_2( pop, pop_size, mu, sicma, bh, bh_R, bh_fitness_1, fhd, D, sub_iter_max, popmin, popmax,func_num); 
% [bh_fitness,bh_index] = min(T_sub);
%bh = pop(bh_index,:);%���ºڶ�λ��
%bh_R = bh_R_sub;%����bh_R�ڶ��뾶
bh_fitness = min(bh_fitness_1,bh_sub_fit);
% T_2 = min(T_sub_2,[],2);      
T = [T_1 T_sub];

end

