clc
clear
load coordinate;
func_num=1;
Node_num = 50;
D = Node_num * 2;
Radius = 5;
popmax = 50;
popmin = 1;
pop_size = 30;
iter_max=10;
runs = 30;


for j = 1:runs
    j
    Cover_rate(1) = PSO_Cover(D,pop_size,iter_max,popmin,popmax,Node_num,coordinate,Radius);
    Cover_rate(2) = WOA_Cover(D,pop_size,iter_max,popmin,popmax,Node_num,coordinate,Radius);
    Cover_rate(3) = BlackHole_Cover(D,pop_size,iter_max,popmin,popmax,Node_num,coordinate,Radius);
    Cover_rate(4) = EnhanceBlackHole_Cover(D,pop_size,iter_max,popmin,popmax,Node_num,coordinate,Radius);
    A_cover(j) = Cover_rate(1);
    B_cover(j) = Cover_rate(2);
    C_cover(j) = Cover_rate(3);
    D_cover(j) = Cover_rate(4);
  
end

