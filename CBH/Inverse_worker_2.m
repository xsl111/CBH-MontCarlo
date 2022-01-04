function [ bh_fitness,T ] = Inverse_worker_2( pop, pop_size, mu, sicma,  bh, bh_R, bh_fitness, fhd, D, iter_max, popmin, popmax, func_num )
%WORKER_2 此处显示有关此函数的摘要
%   此处显示详细说明
% [bh_sub_fit, T_sub] = worker_2(pop, bh, bh_R, fhd, D, sub_iter_max/2, popmin, popamx,func_num); 
%四个粒子
c = 2.0;
Np=pop_size;
% bh = pop;
count = 0;
bh_last = bh;
% mu = zeros(1,D);
% sicma = 10*ones(1,D);

% for i=1:4
%     pop(i,:) = popmin + (popmax-popmin) * rand(1,D);
% %     pop(1,:)=popmax*icdf('Normal',rand(1,D),mu,sicma);
% end

for g=1:iter_max
    for i=1:4
%         fitness(i) = feval(fhd, pop(i,:),func_num);
        c = 2.0 - (g / (iter_max));
        bh_R = bh_R *(1 - g / (iter_max * 2));
        star(1,:)=popmax*icdf('Normal',rand(1,D),mu,sicma);
        fitness_star=feval(fhd,star(1,:)',func_num);
        if(fitness_star < bh_fitness)
            bh_fitness=fitness_star;
            bh=star(1,:);
            bh_R = bh_R *(1 - g / (iter_max * pop_size * 2));
        end
        
        pop(i,:) = pop(i,:) +  c * rand * (bh - pop(i,:));%更新粒子位置
        
        for d=1:D
            pop(1,d)=max(popmin,min(popmax,pop(i,d)));
        end
        
        distance=Dist(bh,pop(i,:),D);
        if( all(bh_last == bh))%检查是否陷入了局部最优
            count = count + 1;
        end
        if(count == 100)%如果陷入了局部最优，产生一个新的粒子
            pop(i,:)=popmin+(popmax-popmin)*rand(1,D);%这里不能用icdf函数产生新粒子，不然产生的粒子仍然有可能使算法陷入局优
            count = 0;
        elseif (all(bh == pop(i,:)) || distance < bh_R)
            pop(i,:)=popmin+(popmax-popmin)*rand(1,D);
        end
        
        fitness_new = feval(fhd,pop(i,:)',func_num);
        %     if(fitness_new < bh_fitness)
        %         bh_fitness=fitness_new;
        %         bh=pop(1,:);
        %         bh_R=fitness_new/0.01724;
        %     end
        
        [winner,loser] = compete(fitness_new,bh_fitness,pop(i,:),bh);
        for j=1:D
            temp=mu(j)+(1/Np)*(winner(j)-loser(j));
            sicma(j)=sqrt(sicma(j)^2 + (mu(j)^2 -temp^2) + (1/Np)*(winner(j)^2 - loser(j)^2));
            mu(j)=temp;
        end
        
        if(fitness_new < bh_fitness)
            bh=pop(i,:);
            bh_fitness=fitness_new;
        end
        
        %     end %end of for i=1:pop_size
%         T_sub(g)=bh_fitness;
    end
    T(g) = bh_fitness;
    
end
end



%%比较函数
function [winner,loser] = compete(finess,bh,newpop,bh_position)
if finess < bh
    winner=newpop;
    loser=bh_position;
elseif bh <finess
    winner=bh_position;
    loser=newpop;
else
    winner=bh_position;
    loser=newpop;
end    
end