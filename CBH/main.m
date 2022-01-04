clc
clear

func_num=1;
D = 20;
popmax = 100;
popmin = -100;
pop_size = 30;
iter_max=1000;
runs = 1;
fhd=str2func('cec13_func');
for i = 1:1
    func_num = i;
    for j = 1:runs
        i,j,
%         [TotalBest,T]=CBH_3(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest,T]=CBH_2(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
        [TotalBest_BH,T_BH]= BH(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
        [TotalBest_BH_3,T_BH_3]= BH_3(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest,T]= CBH_4(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest,T]= CBH_5(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest,T]= EnhanceBH(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest_PSO,T_PSO]= PSO(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest_WOA,T_WOA]= WOA(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
        
        fbest(i,j)=TotalBest_BH;
%         fbest_CBH_5(i,j)=TotalBest_CBH_5;
%         fbest_PSO(i,j)=TotalBest_PSO;
%         fbest_WOA(i,j)=TotalBest_WOA;
%         
        for t = (iter_max/20):(iter_max/20):iter_max
            a = t/(iter_max/20);
            FV(j,a) =  T_BH(t);
        end   
    end
    for g = 1:20
        fv_mean(i,g) = mean(FV(:,g));
    end
    f_mean=mean(fbest(i,:));
    figure(func_num);
    hold on;
    plot(f_mean,'m');
    legend('BH');
    saveas(func_num,strcat('C:\Users\LENOVO\Desktop\',num2str(func_num),'.fig'),'fig');

end