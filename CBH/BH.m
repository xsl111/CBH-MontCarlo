function [bh, T] = BH( fhd,D,pop_size,iter_max,popmin,popmax,func_num )
%BH 此处显示有关此函数的摘要
%   此处显示详细说明
c = 2.0;
for i = 1:pop_size
    pop(i,:) = popmin+(popmax-popmin)*rand(1,D);    %初始种群
end
fitness = feval(fhd,pop',func_num);
[bh,bh_index] = min(fitness);
bh_position = pop(bh_index,:);
R = bh/sum(fitness);
% R_sum = 0;
% for i = 1:pop_size
%     R_sum = 1/fitness(i)+R_sum;
% end
% R = (1/bh)/R_sum*Rmax;

for g=1:iter_max
%     R_sum = 0;
% R =  1+Rmax*g/iter_max;
c = 2.0 - (g / iter_max);
    for i=1:pop_size
        pop(i,:) = pop(i,:) + c * rand*(bh_position - pop(i,:));
%         Dis = 0;
        
        for d = 1:D
            pop(i,d) = max(popmin,min(popmax,pop(i,d)));
%             Dis = Dis + (bh_position(d) - pop(i,d))^2;
        end
         fitness(i) = feval(fhd,pop(i,:)',func_num);
%         R_sum = 1/fitness(i)+R_sum;
        if fitness(i) < bh
            bh_index = i;
            bh_position = pop(bh_index,:);
            bh = fitness(i);
            R = bh/sum(fitness);
        end
        distance(i) = Dist(bh_position,pop(i,:),D);
        if distance(i) < R && i ~= bh_index
            pop(i,:) = popmin+(popmax-popmin)*rand(1,D);
        end
       
    end
%     R = (1/bh)/R_sum*Rmax;
   
    T(g) = bh;
end
end

