function [ bh, T] = CBH_4( fhd,D,pop_size,iter_max,popmin,popmax,func_num  )
%CBH_3 此处显示有关此函数的摘要
%   此处显示详细说明
%rand('state',sum(100*clock));
Np=pop_size;
mu=zeros(1,D);
sicma=10*ones(1,D);
for j = 1:pop_size
    pop(j,:)=popmin+(popmax-popmin)*rand(1,D);%产生新的种群
end
fitness=feval(fhd,pop',func_num);
[bh,bh_index]=min(fitness);
bh_position=pop(bh_index,:);
bh_R=bh/sum(fitness);

for g=1:iter_max
    for i=1:pop_size
        star(1,:)=popmax*icdf('Normal',rand(1,D),mu,sicma);
        fitness_star=feval(fhd,star(1,:)',func_num);
        if(fitness_star < bh)
            bh=fitness_star;
%             pop(i,:)=star(i,:);%这里其实不用将pop(i,:)给替换掉，因为下面还需要用pop(i,:)进行更新位置
%             bh_index=i;
            bh_position=star(1,:);
            bh_R=bh/sum(fitness);
        end
        pop(i,:) = pop(i,:) + rand*(bh_position - pop(i,:));
        
        for d=1:D
            pop(i,d)=max(popmin,min(popmax,pop(i,d)));
        end
        distance(i)=Dist(bh_position,pop(i,:)',D);
        if(distance(i) < bh_R && i~=bh_index)
            pop(i,:)=popmin+(popmax-popmin)*rand(1,D);
        end
        finess=feval(fhd,pop(i,:)',func_num);
        [winner,loser] = compete(finess,bh,pop(i,:),bh_position);
        for j=1:d
            temp=mu(j)+(1/Np)*(winner(j)-loser(j));
            sicma(j)=sqrt(sicma(j)^2 + (mu(j)^2 -temp^2) + (1/Np)*(winner(j)^2 - loser(j)^2));
            mu(j)=temp;
        end
        if(finess < bh)
            bh_index=i;
            bh_position=pop(i,:);
            bh=finess;
        end
    T(g)=bh;
    end
end
                 
end

function [winner,loser] = compete(finess,bh,npop,bh_position)
if finess < bh
    winner=npop;
    loser=bh_position;
else
    winner=bh_position;
    loser=npop;
end
end

    

