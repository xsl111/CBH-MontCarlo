function [bh_fitness, T] = CBH_6(fhd,D,pop_size,iter_max,popmin,popmax,func_num  )
%CBH_3 此处显示有关此函数的摘要
%   此处显示详细说明
%rand('state',sum(100*clock));
c = 2.0;
Np=pop_size;
mu=zeros(1,D);
sicma=10*ones(1,D);
% pop(1,:)=popmax*icdf('Normal',rand(1,D),mu,sicma);
pop(1,:) = popmin + (popmax-popmin) .* rand(1,D);
bh = pop(1,:);
bh_fitness=feval(fhd,pop(1,:)',func_num);
% bh_R=bh_fitness/(3.2831e+05);%把分母换成常数
bh_R = 0.01724;
count = 0;
bh_last = bh;
for g=1:iter_max * pop_size
    c = 2.0 - (g / (iter_max * pop_size));
    %     for i=1:pop_size
    bh_R = bh_R *(1 - g / (iter_max * pop_size * 2));
    star(1,:)=popmax*icdf('Normal',rand(1,D),mu,sicma);
    fitness_star=feval(fhd,star(1,:)',func_num);
    if(fitness_star < bh_fitness)
        bh_fitness=fitness_star;
        %pop(i,:)=star(i,:);%这里其实不用将pop(i,:)给替换掉，因为下面还需要用pop(i,:)进行更新位置
        %bh_index=i;
        bh_last = bh;
        bh=star(1,:);
        bh_R = bh_R *(1 - g / (iter_max * pop_size * 2));
%         bh_R=bh/0.01724;
    end
    
    pop(1,:) = pop(1,:) +  c * rand * (bh - pop(1,:));%更新黑洞位置
    
    for d=1:D
        pop(1,d)=max(popmin,min(popmax,pop(1,d)));
    end
    
    distance=Dist(bh,pop(1,:),D);
    %新加入的内容
    if( all(bh_last == bh))
        count = count + 1;
    end
    if(count == 100)
        pop(1,:)=popmin+(popmax-popmin)*rand(1,D);
        count = 0;
    elseif (all(bh == pop) || distance < bh_R)
        pop(1,:)=popmin+(popmax-popmin)*rand(1,D);
    end
    
    fitness_new = feval(fhd,pop(1,:)',func_num);
%     if(fitness_new < bh_fitness)
%         bh_fitness=fitness_new;
%         bh=pop(1,:);
%         bh_R=fitness_new/0.01724;
%     end

    [winner,loser] = compete(fitness_new,bh_fitness,pop(1,:),bh);
    for j=1:D
        temp=mu(j)+(1/Np)*(winner(j)-loser(j));
        sicma(j)=sqrt(sicma(j)^2 + (mu(j)^2 -temp^2) + (1/Np)*(winner(j)^2 - loser(j)^2));
        mu(j)=temp;
    end
    
    if(fitness_new < bh_fitness)
        bh_last = bh;
        bh=pop(1,:);
        bh_fitness=fitness_new;
    end
    
    %     end %end of for i=1:pop_size
    T(g)=bh_fitness;
end
                 
end

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