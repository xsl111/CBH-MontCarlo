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
for i = 1:1
    func_num = 28;
    for j = 1:runs
        i,j,
%         [TotalBest,T]=CBH_3(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest,T]=CBH_2(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
        [TotalBest_BH,T_BH]= BH(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest_BH_3,T_BH_3]= BH_3(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest,T]= CBH_4(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest_CBH_5,T_CBH_5]= CBH_5(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest_CBH_6,T_CBH_6]= CBH_6(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest_Copy_of_CBH_7,T_Copy_of_CBH_7]=Copy_of_CBH_7(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
%         [TotalBest,T]= EnhanceBH(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
        [TotalBest_PSO,T_PSO]= PSO(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
        [TotalBest_WOA,T_WOA]= WOA(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
        [TotalBest_CBH_7,T_CBH_7] = CBH_7( fhd, D, pop_size, iter_max, popmin, popmax, func_num );
        
%         fbest(i,j)=TotalBest_BH;
%         fbest_CBH_5(i,j)=TotalBest_CBH_5;
%         fbest_PSO(i,j)=TotalBest_PSO;
%         fbest_WOA(i,j)=TotalBest_WOA;
%         
%         FV_BH(j,:) =  T_BH;
%         FV_PSO(j,:) =  T_PSO;
%         FV_BH_3(j,:) =  T_BH_3;
%         FV_CBH_6(j,:) =  T_CBH_6;
%
        for t = (iter_max/100):(iter_max/100):iter_max
            a = t/(iter_max/100);
            FV_PSO(j,a) =  T_PSO(t);
        end
        for ii = 1:100
            FV_Mean_PSO(ii) = mean(FV_PSO(:,ii));
        end
        
        for t = (iter_max/100):(iter_max/100):iter_max
            a = t/(iter_max/100);
            FV_WOA(j,a) =  T_WOA(t);
        end
        for ii = 1:100
            FV_Mean_WOA(ii) = mean(FV_WOA(:,ii));
        end
        
        for t = (iter_max/100):(iter_max/100):iter_max
            a = t/(iter_max/100);
            FV_BH(j,a) =  T_BH(t);
        end
        for ii = 1:100
            FV_Mean_BH(ii) = mean(FV_BH(:,ii));
        end
%           FV_WOA(j,:) =  T_WOA;
       
%         for t = (iter_max*30/100):(iter_max*30/100):iter_max*30
%             a = t/(iter_max*30/100); 
%             FV_CBH_6(j,a) =  T_CBH_6(t);
%         end
%         for ii = 1:100
%             FV_Mean_CBH_6(ii) = mean(FV_CBH_6(:,ii));
%         end
        
        
        for t = (7500/100):(7500/100):7500
            a = t/(7500/100);
            FV_CBH_7(j,a) =  T_CBH_7(t);
        end
        for ii = 1:100
            FV_Mean_CBH_7(ii) = mean(FV_CBH_7(:,ii));
        end
        
        
%         for t = (iter_max/100):(iter_max/100):iter_max
%             a = t/(iter_max/100);
%             FV_Copy_of_CBH_7(j,a) =  T_Copy_of_CBH_7(t);
%         end
%         for ii = 1:100
%             FV_Mean_Copy_of_CBH_7(ii) = mean(FV_Copy_of_CBH_7(:,ii));
%         end
        
    end
%     for g = 1:20
%         fv_mean_PSO(i,g) = mean(FV(:,g));
%     end
%     f_mean=mean(fbest(i,:));
%    figure(T_BH);%     hold on;
%     f_mean_bh=sum(FV_BH,1)./runs;
%     f_mean_pso=sum(FV_PSO,1)./runs;
%     f_mean_BH_3=sum(FV_BH_3,1)./runs;
%     f_mean_CBH_6=sum(FV_CBH_6,1)./(runs * 30);
%     f_mean_WOA=sum(FV_WOA,1)./runs;
    figure(func_num);
%     hold on;
    plot(FV_Mean_PSO,'r');
    hold on;
    plot(FV_Mean_WOA,'b');
    plot(FV_Mean_BH,'m');
%     plot(FV_Mean_CBH_6,'g');
    plot(FV_Mean_CBH_7,'k');
%     plot(FV_Mean_Copy_of_CBH_7,'c');

%     hold on;

%     plot(FV_Mean_BH,'m');
%     plot(f_mean_BH_3,'b');
%     plot(FV_Mean_CBH_6,'y');
%     plot(f_mean_WOA,'c');
%     legend('BH','BH_3','CBH_6');  
%     legend('PSO','WOA','BH','CBH_6');
    legend('PSO', 'WOA', 'BH', 'CBH_7');    
%     legend('PSO', 'WOA', 'BH','CBH_6', 'CBH_7','Copy_of_CBH_7');    
    saveas(func_num,strcat('E:\result\picture_of_result_10\new_image\',num2str(func_num),'.png'),'png');
end