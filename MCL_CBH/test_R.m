% clear;
% close all;
% rand('state',sum(1000*clock));
% D = 2;
% % Xmin = 0;
% % Xmax = 100;
% pop_size = 30;
% iter_max = 100;
% runs = 20;
% BorderLength = 100;%����Ϊ0 ~ 100������������
% SeedNo = 30;%ê�ڵ���Ŀ
% NodeNo = 200;%�ڵ�����Ŀ
% UNNodeNo = NodeNo - SeedNo;%λ�ý����Ŀ 
% R = 40;%ͨ�Ű뾶
% Vmax = 15;%����˶��ٶ�
% Node = BorderLength .* rand(2,NodeNo);%�����ʼ�����λ��
% Seed = Node(1:2,1:SeedNo);%30��ê�ڵ㿪ʼʱ��λ��
% UNNode = Node(1:2,SeedNo+1:200);%��ͨ��㿪ʼʱ��λ��
% for i=1:2
%     for j=1:NodeNo
%         newNode(i,j) = (rand - 0.5) * 2 * Vmax + Node(i,j);%�����ӵ�λ�ý�������Ŷ�
% %         r = rand(1,1) * Vmax;
% %         thita = rand(1,1) * 2 * pi;
% %         newNode(i,j) = Node(i,j) + r * cos(thita);
%         while (newNode(i,j) > BorderLength || newNode(i,j) < 0)%�ѽڵ�λ���޶���0~100
% %             newNode(i,j) = BorderLength .* rand;
%             newNode(i,j) = (rand - 0.5) * 2 * Vmax + Node(i,j);
%         end
%     end
% end
% Sxy = [[1:NodeNo];newNode];%�ѽڵ�λ��ӳ�䵽���
% newSeed = [Sxy(2,1:SeedNo);Sxy(3,1:SeedNo)];%ê�ڵ��Ŷ��������
% newUNNode = [Sxy(2,SeedNo+1:NodeNo);Sxy(3,SeedNo+1:NodeNo)];%��ͨ�ڵ��Ŷ��������
% %�������δ֪�ڵ㵽����ê�ڵ�ľ���֮��,������ͨ�����ê�ڵ�ľ���֮��ѡȡ����de����
% for i=1:UNNodeNo
%     sumDist(i) = 0;
%     for j=1:SeedNo
%         Dist(i,j) = sqrt((newUNNode(1,i) - newSeed(1,j))^2 + (newUNNode(2,i) - newSeed(2,j))^2);
%         sumDist(i) = sumDist(i) + Dist(i,j);
%     end
%     avgDist = sumDist(i) / SeedNo;
%     if avgDist <= R
%         hop(i) = 1;
%     elseif avgDist <= 2 * R
%         hop(i) = 2;
%     else
%         if avgDist <= 2 * R
%             hop(i) = round(avgDist / R);
%         else
%             hop(i) = 5;
%         end
%     end
% end
% 
% [Dist,Dist_Pos] = sort(Dist,2);%Dist��170*30
% 
% %ȷ��ÿ����ͨ�����ê�ڵ�֮�������,���������������������Ϊ0
% for i=1:UNNodeNo
%     for j=1:SeedNo
%         if rem(Dist(i,j) / R, 1) == 0 && Dist(i,j) / R <= hop(i)
%             Hop(i,j) = Dist(i,j) / R;
%             pos(i,j) = Dist_Pos(i,j);%seedλ�õı��
%         elseif rem(Dist(i,j) / R, 1) ~= 0 && Dist(i,j) / R < hop(i)
%             Hop(i,j) = floor(Dist(i,j) / R) + 1;
%             pos(i,j) = Dist_Pos(i,j);
%         else
%             Hop(i,j) = 0;
%         end
%     end
% end
% 
% %�������170��δ֪����λ��,Ϊÿ����ͨ�����20�����ܵ�λ��
% Vamx = Vmax * 3;
% 
% 
% 
%     count = 0;
%     pos1 = [];
%     pos2 = [];
%     %newNode(i,j) = (rand - 0.5) * 2 * Vmax + Node(i,j);
%     while(count < 20)
%         Xpos =  (rand - 0.5) * 2 * Vmax + UNNode(1,i);
%         while( Xpos > BorderLength || Xpos < 0)
%             Xpos =  (rand - 0.5) * 2 * Vmax + UNNode(1,i);
%         end
%         Ypos = (rand - 0.5) * 2 * Vmax + UNNode(2,i);
%         while (Ypos > BorderLength || Ypos < 0)
%             Ypos = (rand - 0.5) * 2 * Vmax + UNNode(2,i);
%         end
%         num = 0;
%         for j=1:SeedNo
% %             distance = sqrt((possible(1,i) - newSeed(1,j))^2 + (possible(2,i) - newSeed(2,j))^2);
%             if Hop(i,j) ~= 0 
%                 num = num + 1;%�ҵ�����������ê�ڵ���Ŀ
%             end
%         end
%         flag = 1;
%         for j=1:num 
%             distance = sqrt((Xpos - newSeed(1,Dist_Pos(i,j)))^2 + (Ypos - newSeed(2,Dist_Pos(i,j)))^2);
%             if round(distance / R) > Hop(i,j)
%                 flag = 0;
%             end
%         end
%         if flag == 1
%             pos1 = [pos1 Xpos];
%             pos2 = [pos2 Ypos];
%             count = count + 1;
%         end
%     end
%     %�ҵ�20��λ�ú���һ��ƽ��ֵ
%     X = mean(pos1)
%     Y = mean(pos2)
%   
%     newUNNode(1,i)
%     newUNNode(2,i)
    
   

Xmin = 16.0158 - 10;
Xmax = 16.0158 + 10;
Ymin = 94.9452 - 10;
Ymax = 94.9452 + 10;
Xmax = min(100,max(0,Xmax));
Xmin = min(100,max(0,Xmin));
Ymax = min(100,max(0,Ymax));
Ymax = min(100,max(0,Ymax));
for t=1:30
    pop(t,1)=Xmin + (Xmax-Xmin) * rand;
    pop(t,2)=Ymin + (Ymax-Ymin) * rand;
    fitness(t) = fit_w(pop(t,1),pop(t,2),11.6940,98.2499,newSeed,SeedNo);
end
R = min(fitness) / sum(fitness)

