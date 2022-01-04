function [ bh_fitness,T ] = Inverse_CBH_7( fhd, D, pop_size, iter_max, popmin, popmax, func_num )
%CBH_7 此处显示有关此函数的摘要
%   此处显示详细说明
%%初始化参数
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
%每个粒子迭代5000次
for i=1:4
    [bh_sub_fit, T_sub, bh_R_sub, bh_sub] = Copy_of_worker(i, pop(i,:), pop_size, mu, sicma, bh_R_sub, fhd, D, sub_iter_max, popmin+(i-1)*50, popmin+i*50,func_num);
    bh_fit(i,:) = bh_sub_fit;%每个子区间最好的适应度
    T_sub_1(i,:) = T_sub;%子区间内每一代最好的适应度
    bh_m(i,:) = bh_sub;%每个粒子找到的最好位置
end
bh_R = bh_R_sub;%更新bh_R黑洞半径
[bh_fitness_1,bh_index] = min(bh_fit);
bh = bh_m(bh_index,:);%更新黑洞位置
T_1 = min(T_sub_1,[],1);%在此处更新T_sub,取T_sub每一列的最好值


popmin = -100;
popmax = 100;

%有一个问题，用原先产生的四个粒子，还是再随机产生四个新的粒子
sub_iter_max = 7500;
[bh_sub_fit, T_sub] = Copy_of_worker_2( pop, pop_size, mu, sicma, bh, bh_R, bh_fitness_1, fhd, D, sub_iter_max, popmin, popmax,func_num); 
% [bh_fitness,bh_index] = min(T_sub);
%bh = pop(bh_index,:);%更新黑洞位置
%bh_R = bh_R_sub;%更新bh_R黑洞半径
bh_fitness = min(bh_fitness_1,bh_sub_fit);
% T_2 = min(T_sub_2,[],2);      
T = T_sub;

end

