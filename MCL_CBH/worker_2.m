function [ bh ] = worker_2( pop, pop_size, xmu, xsicma, ymu, ysicma,  bh, bh_R, bh_fitness, D, iter_max,  Xmin, Xmax,Ymin, Ymax,RX, RY, newSeed, SeedNo, BorderLength )
Xmax = min(BorderLength,max(0,Xmax));
Xmin = min(BorderLength,max(0,Xmin));
Ymax = min(BorderLength,max(0,Ymax));
Ymax = min(BorderLength,max(0,Ymax));
Np=pop_size * 10;
count = 0;
bh_last = bh;

for g=1:iter_max
    for i=1:4
        c = 2.0 - (g / (iter_max));
        bh_R = bh_R *(1 - g / (iter_max * 2));
%         star(1,1)=Xmax*abs(icdf('Normal',rand,xmu,xsicma));
%         star(1,2)=Ymax*abs(icdf('Normal',rand,ymu,ysicma));
        star(1,1)=Xmin + (Xmax - Xmin)/2*abs(icdf('Normal',rand,xmu,xsicma));
        star(1,2)=Ymin + (Ymax - Ymin)/2*abs(icdf('Normal',rand,ymu,ysicma));
        fitness_star=fit_w(star(1,1),star(1,2),RX,RY,newSeed,SeedNo);
        if(fitness_star < bh_fitness)
            bh_fitness=fitness_star;
            bh=star;
            bh_R = bh_R *(1 - g / (iter_max * pop_size * 2));
        end
        
        pop(i,:) = pop(i,:) +  c * rand * (bh - pop(i,:));%更新粒子位置
        
        pop(i,1)=max(Xmin,min(Xmax,pop(i,1)));
        pop(i,2)=max(Ymin,min(Ymax,pop(i,2)));
        
        distance=Dist(bh,pop(i,:),D);
        if( all(bh_last == bh))%检查是否陷入了局部最优
            count = count + 1;
        else
            bh_last = bh;
            count = 0;
        end
        if(count == 20)%如果陷入了局部最优，产生一个新的粒子
            z = round(rand * 20);
            if z == 0
                z = z + 1;
            end
            bh_new = bh;
            if(z == 1)
                bh_new(z) = min(Xmax,max(Xmin,normrnd(bh_new(z),3)));%高斯扰动
            elseif(z == 2)
                bh_new(z) = min(Xmax,max(Xmin,normrnd(bh_new(z),3)));%高斯扰动
            end
            
            fitness_g = fit_w(bh_new(1,1),bh_new(1,2),RX,RY,newSeed,SeedNo);
            if fitness_g < bh_fitness
                bh_fitness = fitness_g;
                bh = bh_new;
            end
            count = 0;
        elseif (all(bh == pop(i,:)) || distance < bh_R)
            pop(i,1)=Xmin+(Xmax-Xmin)*rand;
            pop(i,2)=Ymin+(Ymax-Ymin)*rand;
        end
        
        fitness_new = fit_w(pop(i,1),pop(i,2),RX,RY,newSeed,SeedNo);
        
        [winner,loser] = compete(fitness_new,bh_fitness,pop(i,:),bh);
        xtemp=xmu+(1/Np)*(winner(1,1)-loser(1,1));
        xsicma=sqrt(xsicma^2 + (xmu^2 -xtemp^2) + (1/Np)*(winner(1,1)^2 - loser(1,1)^2));
        xmu=xtemp;

        ytemp=ymu+(1/Np)*(winner(1,2)-loser(1,2));
        ysicma=sqrt(ysicma^2 + (ymu^2 -ytemp^2) + (1/Np)*(winner(1,2)^2 - loser(1,2)^2));
        ymu=ytemp;
        
        if(fitness_new < bh_fitness)
            bh=pop(i,:);
            bh_fitness=fitness_new;
        end
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