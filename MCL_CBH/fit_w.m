function [ diff_fit ] = fit_w( Xpos, Ypos, RXpos, RYpos, Seed ,SeedNo)
%FIT_W �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%�²�ĵ���ê�ڵ�ľ����ȥ��ʵ����ê�ڵ�֮��ľ���
% sum_guess = 0;
% sum_real = 0;   
% %���������λ����ê�ڵ�֮��ľ����
% for i=1:SeedNo
%     sum_guess = sum_guess + sqrt((Xpos - Seed(1,i))^2 + (Ypos - Seed(2,i))^2);
% end
% 
% %��������ʵλ����ê�ڵ�ֱ�ӵľ����
% for i=1:SeedNo
%     sum_real = sum_real + sqrt((RXpos - Seed(1,i))^2 + (RYpos - Seed(2,i))^2);
% end
diff_fit = 0;
for i = 1:SeedNo
    diff_fit = diff_fit + abs(sqrt((Xpos - Seed(1,i))^2 + (Ypos - Seed(2,i))^2) - sqrt((RXpos - Seed(1,i))^2 + (RYpos - Seed(2,i))^2));
end

