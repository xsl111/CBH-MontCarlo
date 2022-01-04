function [bh_fitness, T, bh_R, bh ] = worker( bh, pop, pop_size, xmu, xsicma, ymu, ysicma, bh_R, D, iter_max, Xmin, Xmax,Ymin, Ymax,RX, RY, newSeed, SeedNo, BorderLength)
Xmax = min(BorderLength,max(0,Xmax));
Xmin = min(BorderLength,max(0,Xmin));
Ymax = min(BorderLength,max(0,Ymax));
Ymax = min(BorderLength,max(0,Ymax));
Np=pop_size * 10;
count = 0;
bh_last = bh;
bh_fitness=fit_w(bh(1,1),bh(1,2),RX,RY,newSeed,SeedNo);
for g=1:iter_max 
    c = 2.0 - (g / (iter_max));
    bh_R = bh_R *(1 - g / (iter_max * 2));
    star(1,1)=Xmin + (Xmax - Xmin)/2*abs(icdf('Normal',rand,xmu,xsicma));
    star(1,2)=Ymin + (Ymax - Ymin)/2*abs(icdf('Normal',rand,ymu,ysicma));
    fitness_star=fit_w(star(1,1),star(1,2),RX,RY,newSeed,SeedNo);
    if(fitness_star < bh_fitness)
        bh_fitness=fitness_star;
        bh=star;
        bh_R = bh_R *(1 - g / (iter_max * pop_size * 2));
    end
    
    pop = pop +  c * rand * (bh - pop);%更新黑洞位置
    
    pop(1,1)=max(Xmin,min(Xmax,pop(1,1)));
    pop(1,2)=max(Ymin,min(Ymax,pop(1,2)));
    
    distance=Dist(bh,pop,D);
    if( all(bh_last == bh))%检查是否陷入了局部最优
        count = count + 1;
    end
    if(count == 10)%如果陷入了局部最优，产生一个新的粒子
        pop(1,1)=Xmin+(Xmax-Xmin)*rand;
        pop(1,2)=Ymin+(Ymax-Ymin)*rand;
        count = 0;
    elseif (all(bh == pop) || distance < bh_R)
        pop(1,1)=Xmin + (Xmax-Xmin) .* rand;
        pop(1,2)=Ymin + (Ymax-Ymin) .* rand;
    end
    
    fitness_new = fit_w(pop(1,1),pop(1,2),RX,RY,newSeed,SeedNo);

    [winner,loser] = compete(fitness_new,bh_fitness,pop,bh);
    
    xtemp=xmu+(1/Np)*(winner(1,1)-loser(1,1));
    xsicma=sqrt(xsicma^2 + (xmu^2 -xtemp^2) + (1/Np)*(winner(1,1)^2 - loser(1,1)^2));
    xmu=xtemp;
    
    ytemp=ymu+(1/Np)*(winner(1,2)-loser(1,2));
    ysicma=sqrt(ysicma^2 + (ymu^2 -ytemp^2) + (1/Np)*(winner(1,2)^2 - loser(1,2)^2));
    ymu=ytemp;
    
    if(fitness_new < bh_fitness)
        bh=pop;
        bh_fitness=fitness_new;
    end
    
    %     end %end of for i=1:pop_size
    T(g)=bh_fitness;
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
