clc
clear

func_num=1;
D = 20;
popmax = 100;
popmin = -100;
pop_size = 30;
iter_max=1000;
runs = 30;
fhd=str2func('cec13_func');
for i = 1:28
    func_num = i;
    for j = 1:runs
        i,j,
%         [TotalBest,T]=CBH_3(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest,T]=CBH_2(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
        [TotalBest,T]= BH(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest,T]= CBH_4(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest,T]= CBH_5(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest,T]= EnhanceBH(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest,T]= PSO(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest,T]= WOA(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
        fbest(i,j)=TotalBest;
        
        for t = (iter_max/20):(iter_max/20):iter_max
            a = t/(iter_max/20);
            FV(j,a) =  T(t);
        end
    end
    for g = 1:20
        fv_mean(i,g) = mean(FV(:,g));
    end
    f_mean(i)=mean(fbest(i,:));
end