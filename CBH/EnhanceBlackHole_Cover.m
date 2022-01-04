function  result = EnhanceBlackHole_Cover( D,pop_size,iter_max,popmin,popmax,Node_num,coordinate,Radius )
%ENHANCEBLACKHOLE_COVER 此处显示有关此函数的摘要
%   此处显示详细说明
H_num = 3;%黑洞数量
for i = 1:pop_size
    pop(i,:) = popmin+(popmax-popmin)*rand(1,D);    %初始种群
    fitness(i) = Cover_function(pop(i,:),Node_num,coordinate,Radius);
end
[pop,fitness] = Rank_Cover(pop,fitness);

for h = 1:H_num
    Bh_p(h,:) = pop(h,:);
    Bh_f(h) = fitness(h);
    Radio(h) = Bh_f(h)/sum(fitness);
end
for g=1:iter_max
    
    w = 2.0-1.6*g/iter_max;
    mu_d = randperm(D,3);
    Bh_mu = Bh_p(1,:);
    for d = 1:3
        Bh_mu(mu_d(d)) = Bh_p(1,mu_d(d))*1.2-rand*0.8;
    end
    Bh_mu = max(popmin,min(popmax,Bh_mu));
    Fit = Cover_function(Bh_mu,Node_num,coordinate,Radius);
    if Fit > Bh_f(1)
        Bh_p(1,:) = Bh_mu;
        Bh_f(1) = Fit;
    end
    for i=1:pop_size
        
      
        for h = 1:H_num
            distance(h,i) = Dist(Bh_p(h,:),pop(i,:),D);
        end
        
        %         pop(i,:) = pop(i,:) + rand*(bh_position - pop(i,:));
        pop(i,:) = pop(i,:)+w*(rand*0.9*(Bh_p(1,:)-pop(i,:))+rand*0.6*(Bh_p(2,:)-pop(i,:))...
            +rand*0.3*(Bh_p(3,:)-pop(i,:)));
        
        pop(i,:) = max(popmin,min(popmax,pop(i,:)));
        
        for h = 1:H_num
            if distance(h,i) < Radio(h)
                %             if distance(h,i)<R
                pop(i,:) = popmin+(popmax-popmin)*rand(1,D);
            end
        end
        fitness(i) = Cover_function(pop(i,:),Node_num,coordinate,Radius);
    end
    [pop,fitness] = Rank_Cover(pop,fitness);
%     R_sum = 0;
%     for i = 1:pop_size
% %         R_sum = 1/fitness(i)+R_sum;
%     end
    for h = 1:H_num
        if fitness(h) > Bh_f(h)
            Bh_f(h) = fitness(h);
            Bh_p(h,:) = pop(h,:);
        end
        Radio(h) = Bh_f(h)/sum(fitness);
    end
    T(g) = Bh_f(1);
end
result = Bh_f(1);

end

