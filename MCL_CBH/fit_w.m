function [ diff_fit ] = fit_w( Xpos, Ypos, RXpos, RYpos, Seed ,SeedNo)
%FIT_W 此处显示有关此函数的摘要
%   此处显示详细说明
%猜测的点与锚节点的距离减去真实点与锚节点之间的距离
% sum_guess = 0;
% sum_real = 0;   
% %计算结点估测位置与锚节点之间的距离和
% for i=1:SeedNo
%     sum_guess = sum_guess + sqrt((Xpos - Seed(1,i))^2 + (Ypos - Seed(2,i))^2);
% end
% 
% %计算结点真实位置与锚节点直接的距离和
% for i=1:SeedNo
%     sum_real = sum_real + sqrt((RXpos - Seed(1,i))^2 + (RYpos - Seed(2,i))^2);
% end
diff_fit = 0;
for i = 1:SeedNo
    diff_fit = diff_fit + abs(sqrt((Xpos - Seed(1,i))^2 + (Ypos - Seed(2,i))^2) - sqrt((RXpos - Seed(1,i))^2 + (RYpos - Seed(2,i))^2));
end

