function bh = BlackHole_Cover( D,pop_size,iter_max,popmin,popmax,Node_num,coordinate,Radius )
%BLACKHOLE_COVER 此处显示有关此函数的摘要
%   此处显示详细说明
for i = 1:pop_size
    pop(i,:) = popmin+(popmax-popmin)*rand(1,D);
    fitness(i) = Cover_function(pop(i,:),Node_num,coordinate,Radius);
end
% fitness = feval(fhd,pop',func_num);
[bh,bh_index] = max(fitness);
bh_position = pop(bh_index,:);
 R = bh/sum(fitness);
for g=1:iter_max
%     R_sum = 0;
% R =  1+Rmax*g/iter_max;
    for i=1:pop_size
        pop(i,:) = pop(i,:) + rand*(bh_position - pop(i,:));
%         Dis = 0;
        
%         for d = 1:D
            pop(i,:) = max(popmin,min(popmax,pop(i,:)));
%             Dis = Dis + (bh_position(d) - pop(i,d))^2;
%         end
        distance(i) = Dist(bh_position,pop(i,:),D);
        if distance(i) < R && i ~= bh_index
            pop(i,:) = popmin+(popmax-popmin)*rand(1,D);
        end
        fitness(i) = Cover_function(pop(i,:),Node_num,coordinate,Radius);
%         R_sum = 1/fitness(i)+R_sum;
        if fitness(i) > bh
            bh_index = i;
            bh_position = pop(bh_index,:);
            bh = fitness(i);
        end
    end
%     R = (1/bh)/R_sum*Rmax;
 R = bh/sum(fitness);
   
    T(g) = bh;
end

end

