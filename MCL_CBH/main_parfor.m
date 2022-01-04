clc
clear
%parallel program
func_num=1;
D = 20;
popmax = 100;
popmin = -100;
pop_size = 30;
iter_max=1000;
runs = 48;
FV_CBH = rand(48,100);
fhd=str2func('cec13_func');
for i = 1:28
    func_num = i;
    parfor j = 1:runs
        i,j,
        FV_CBH_sub = rand(1,100);
        
        [TotalBest_CBH,T_CBH]= CBH(fhd,D,pop_size,popmin,popmax,func_num);
        
        for t = (7500/100):(7500/100):7500
            a = t/(7500/100);
            FV_CBH_sub(a) =  T_CBH(t);
        end 
      
        FV_CBH(j,:) = FV_CBH_sub;

    end
    
    for g = 1:100
        fv_CBH_mean(i,g) = mean(FV_CBH(:,g));

    end
end