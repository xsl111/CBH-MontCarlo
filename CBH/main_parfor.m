clc;
clear;
%parallel program
func_num=1;
D = 20;
popmax = 100;
popmin = -100;
pop_size = 30;
iter_max=1000;
runs = 48;
% FV_CBH_7 = rand(48,100);
FV_BA = rand(48,100);
FV_CLPSO = rand(48,100);
FV_DE = rand(48,100);
FV_GA = rand(48,100);
FV_SCA = rand(48,100);
FV_PSO = rand(48,100);
FV_BH = rand(48,100);   
FV_WOA = rand(48,100);
FV_GWO = rand(48,100);  
FV_Copy_of_CBH_7 = rand(48,100);
fhd=str2func('cec13_func');
for i = 1:28
    func_num = i;
    parfor j = 1:runs
        i,j,
% %         FV_CBH_7_sub = rand(1,100);
        FV_BA_sub = rand(1,100);        
        FV_CLPSO_sub = rand(1,100);
        FV_DE_sub = rand(1,100);
        FV_GA_sub = rand(1,100);
        FV_SCA_sub = rand(1,100);
        FV_PSO_sub = rand(1,100);
        FV_BH_2_sub = rand(1,100);
        FV_WOA_sub = rand(1,100);
        FV_GWO_sub = rand(1,100);
        FV_Copy_of_CBH_7_sub = rand(1,100);
%         [TotalBest_CBH_7,T_CBH_7] = CBH_7( fhd, D, pop_size, iter_max, popmin, popmax, func_num );
        [TotalBest_PSO,T_PSO]= PSO(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
        [TotalBest_BH_2,T_BH_2]= BH_2(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
        [TotalBest_WOA,T_WOA]= WOA(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
        [TotalBest_Copy_of_CBH_7,T_Copy_of_CBH_7]= Copy_of_CBH_7(fhd,D,pop_size,iter_max,popmin,popmax,func_num);
        [TotalBest_BA,T_BA]= BA(fhd, D,pop_size,iter_max,popmin,popmax, func_num);
        [TotalBest_CLPSO,T_CLPSO]= CLPSO(fhd, D,pop_size,iter_max,popmin,popmax, func_num);
        [TotalBest_DE,T_DE]= DE(fhd, D,pop_size,iter_max,popmin,popmax, func_num);
        [TotalBest_GA,T_GA]= GA(fhd, D,pop_size,iter_max,popmin,popmax, func_num);
        [TotalBest_SCA,T_SCA]= SCA(fhd, D,pop_size,iter_max,popmin,popmax, func_num);
        [TotalBest_GWO,T_GWO]= GWO(fhd, D,pop_size,iter_max,popmin,popmax, func_num);


        
% %         for t = (7500/100):(7500/100):7500
% %             a = t/(7500/100);
% %             FV_CBH_7_sub(a) =  T_CBH_7(t);
% %         end   
% % 
% %         
        for t = (iter_max/100):(iter_max/100):iter_max
            a = t/(iter_max/100);
            FV_PSO_sub(a) =  T_PSO(t);
        end  
        
        for t = (iter_max/100):(iter_max/100):iter_max
            a = t/(iter_max/100);
            FV_BH_2_sub(a) =  T_BH_2(t);
        end
                
        for t = (iter_max/100):(iter_max/100):iter_max
            a = t/(iter_max/100);
            FV_WOA_sub(a) =  T_WOA(t);
        end     
        
        for t = (iter_max/100):(iter_max/100):iter_max
            a = t/(iter_max/100);
            FV_BA_sub(a) =  T_BA(t);
        end  
        
        for t = (iter_max/100):(iter_max/100):iter_max
            a = t/(iter_max/100);
            FV_CLPSO_sub(a) =  T_CLPSO(t);
        end
        
        
        for t = (iter_max/100):(iter_max/100):iter_max
            a = t/(iter_max/100);
            FV_DE_sub(a) =  T_DE(t);
        end
        for t = (iter_max/100):(iter_max/100):iter_max
            a = t/(iter_max/100);
            FV_GA_sub(a) =  T_GA(t);
        end
        
        for t = (iter_max/100):(iter_max/100):iter_max
            a = t/(iter_max/100);
            FV_SCA_sub(a) =  T_SCA(t);
        end

        
        for t = (7500/100):(7500/100):7500
            a = t/(7500/100);
            FV_Copy_of_CBH_7_sub(a) =  T_Copy_of_CBH_7(t);
        end  
        
        for t = (iter_max/100):(iter_max/100):iter_max
            a = t/(iter_max/100);
            FV_GWO_sub(a) =  T_GWO(t);
        end
%         FV_CBH_7(j,:) = FV_CBH_7_sub;
        FV_PSO(j,:) = FV_PSO_sub;
        FV_BH_2(j,:) = FV_BH_2_sub;
        FV_WOA(j,:) = FV_WOA_sub;
        FV_BA(j,:) = FV_BA_sub;
        FV_CLPSO(j,:) = FV_CLPSO_sub;
        FV_DE(j,:) = FV_DE_sub;
        FV_GA(j,:) = FV_GA_sub;
        FV_SCA(j,:) = FV_SCA_sub;
        FV_Copy_of_CBH_7(j,:) = FV_Copy_of_CBH_7_sub;
        FV_GWO(j,:) = FV_GWO_sub;

    end
    
    for g = 1:100
% %         fv_CBH_7_mean(i,g) = mean(FV_CBH_7(:,g));
        fv_Copy_of_CBH_7_mean(i,g) = mean(FV_Copy_of_CBH_7(:,g));
        fv_PSO_mean(i,g) = mean(FV_PSO(:,g));
        fv_BH_2_mean(i,g) = mean(FV_BH_2(:,g));
        fv_WOA_mean(i,g) = mean(FV_WOA(:,g));
        fv_BA_mean(i,g) = mean(FV_BA(:,g));
        fv_CLPSO_mean(i,g) = mean(FV_CLPSO(:,g));
        fv_DE_mean(i,g) = mean(FV_DE(:,g));
        fv_GA_mean(i,g) = mean(FV_GA(:,g));
        fv_SCA_mean(i,g) = mean(FV_SCA(:,g));
        fv_GWO_mean(i,g) = mean(FV_GWO(:,g));

    end
end