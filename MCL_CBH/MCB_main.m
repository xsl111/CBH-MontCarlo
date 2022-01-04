clear;
close all;
rand('state',sum(1000*clock));
D = 2;
% Xmin = 0;
% Xmax = 100;
pop_size = 30;
iter_max = 100;
runs = 20;
BorderLength = 200;%����Ϊ0 ~ 100������������
SeedNo = 35;%ê�ڵ���Ŀ
NodeNo = 200;%�ڵ�����Ŀ
UNNodeNo = NodeNo - SeedNo;%λ�ý����Ŀ 
R = 50;%ͨ�Ű뾶 
Vmax = 20;%����˶��ٶ�
Node = BorderLength .* rand(2,NodeNo);%�����ʼ�����λ��
Seed = Node(1:2,1:SeedNo);%30��ê�ڵ㿪ʼʱ��λ��
UNNode = Node(1:2,SeedNo+1:200);%��ͨ��㿪ʼʱ��λ��
for i=1:2
    for j=1:NodeNo
        newNode(i,j) = (rand - 0.5) * 2 * Vmax + Node(i,j);%�����ӵ�λ�ý�������Ŷ�
%         r = rand(1,1) * Vmax;
%         thita = rand(1,1) * 2 * pi;
%         newNode(i,j) = Node(i,j) + r * cos(thita);
        while (newNode(i,j) > BorderLength || newNode(i,j) < 0)%�ѽڵ�λ���޶���0~100
%             newNode(i,j) = BorderLength .* rand;
            newNode(i,j) = (rand - 0.5) * 2 * Vmax + Node(i,j);
        end
    end
end
Sxy = [[1:NodeNo];newNode];%�ѽڵ�λ��ӳ�䵽���
newSeed = [Sxy(2,1:SeedNo);Sxy(3,1:SeedNo)];%ê�ڵ��Ŷ��������
newUNNode = [Sxy(2,SeedNo+1:NodeNo);Sxy(3,SeedNo+1:NodeNo)];%��ͨ�ڵ��Ŷ��������
%�������δ֪�ڵ㵽����ê�ڵ�ľ���֮��,������ͨ�����ê�ڵ�ľ���֮��ѡȡ����de����
for i=1:UNNodeNo
    sumDist(i) = 0;
    for j=1:SeedNo
        Dist(i,j) = sqrt((newUNNode(1,i) - newSeed(1,j))^2 + (newUNNode(2,i) - newSeed(2,j))^2);
        sumDist(i) = sumDist(i) + Dist(i,j);
    end
    avgDist = sumDist(i) / SeedNo;
    if avgDist <= R
        hop(i) = 1;
    elseif avgDist <= 2 * R
        hop(i) = 2;
    elseif avgDist <= 3 * R
        hop(i) = 3;
    elseif avgDist <= 4 * R
        hop(i) = 4;
    elseif avgDist <= 5 * R   
        hop(i) = 5;
    else
        hop(i) = 0;
    end
end

[Dist,Dist_Pos] = sort(Dist,2);%Dist��170*30

%ȷ��ÿ����ͨ�����ê�ڵ�֮�������,���������������������Ϊ0
for i=1:UNNodeNo
    for j=1:SeedNo
        if rem(Dist(i,j) / R, 1) == 0 && Dist(i,j) / R <= hop(i)
            Hop(i,j) = Dist(i,j) / R;
            pos(i,j) = Dist_Pos(i,j);%seedλ�õı��
        elseif rem(Dist(i,j) / R, 1) ~= 0 && Dist(i,j) / R < hop(i)
            Hop(i,j) = floor(Dist(i,j) / R) + 1;
            pos(i,j) = Dist_Pos(i,j);
        else
            Hop(i,j) = 0;
        end
    end
end

%�������170��δ֪����λ��,Ϊÿ����ͨ�����20�����ܵ�λ��
Vamx = Vmax * 3;

for i=1:UNNodeNo
    for k=1:runs
        i,k,
    count = 0;
    pos1 = [];
    pos2 = [];
    %newNode(i,j) = (rand - 0.5) * 2 * Vmax + Node(i,j);
    while(count < 20)
        Xpos =  (rand - 0.5) * 2 * Vmax + UNNode(1,i);
        while( Xpos > BorderLength || Xpos < 0)
            Xpos =  (rand - 0.5) * 2 * Vmax + UNNode(1,i);
        end
        Ypos = (rand - 0.5) * 2 * Vmax + UNNode(2,i);
        while (Ypos > BorderLength || Ypos < 0)
            Ypos = (rand - 0.5) * 2 * Vmax + UNNode(2,i);
        end
        num = 0;
        for j=1:SeedNo
%             distance = sqrt((possible(1,i) - newSeed(1,j))^2 + (possible(2,i) - newSeed(2,j))^2);
            if Hop(i,j) ~= 0 
                num = num + 1;%�ҵ�����������ê�ڵ���Ŀ
            end
        end
        flag = 1;
        for j=1:num 
            distance = sqrt((Xpos - newSeed(1,Dist_Pos(i,j)))^2 + (Ypos - newSeed(2,Dist_Pos(i,j)))^2);
%             if round(distance / R) > Hop(i,j)
%                 flag = 0;
%             end
            if distance > Hop(i,j) * R || distance <= (Hop(i,j) - 1) * R
                flag = 0;
            end
        end
        if flag == 1
            pos1 = [pos1 Xpos];
            pos2 = [pos2 Ypos];
            count = count + 1;
        end
    end
    %�ҵ�20��λ�ú���һ��ƽ��ֵ
    X = mean(pos1);
    Y = mean(pos2);
    %ʹ������Ⱥ�㷨�����Ż�
    Pos_PSO = MCB_PSO(D,pop_size,iter_max,X,Y,newUNNode(1,i),newUNNode(2,i),newSeed,SeedNo,BorderLength);
    Pos_WOA = MCB_WOA(D,pop_size,iter_max,X,Y,newUNNode(1,i),newUNNode(2,i),newSeed,SeedNo,BorderLength);
    Pos_GWO = MCB_GWO(D,pop_size,iter_max,X,Y,newUNNode(1,i),newUNNode(2,i),newSeed,SeedNo,BorderLength);
    Pos_BH_2 = MCB_BH_2(D,pop_size,iter_max,X,Y,newUNNode(1,i),newUNNode(2,i),newSeed,SeedNo,BorderLength);
    Pos_CLPSO = MCB_CLPSO(D,pop_size,iter_max,X,Y,newUNNode(1,i),newUNNode(2,i),newSeed,SeedNo,BorderLength);
    Pos_APSO = MCB_APSO(D,pop_size,iter_max,X,Y,newUNNode(1,i),newUNNode(2,i),newSeed,SeedNo,BorderLength);
%     Pos_CBH = MCB_CBH(D,pop_size,iter_max,X,Y,newUNNode(1,i),newUNNode(2,i),newSeed,SeedNo);
%     Pos_BA = MCB_BA(D,pop_size,iter_max,X,Y,newUNNode(1,i),newUNNode(2,i),newSeed,SeedNo,BorderLength);
    Pos_DE = MCB_DE(D,pop_size,iter_max,X,Y,newUNNode(1,i),newUNNode(2,i),newSeed,SeedNo,BorderLength);
    Pos_CBH = CBH(D,pop_size,X,Y,newUNNode(1,i),newUNNode(2,i),newSeed,SeedNo,BorderLength);%�Ľ��㷨
    
    X_PSO(i,k) = Pos_PSO(1);
    Y_PSO(i,k) = Pos_PSO(2);
    X_WOA(i,k) = Pos_WOA(1);
    Y_WOA(i,k) = Pos_WOA(2);
    X_GWO(i,k) = Pos_GWO(1);
    Y_GWO(i,k) = Pos_GWO(2);
    X_BH_2(i,k) = Pos_BH_2(1);
    Y_BH_2(i,k) = Pos_BH_2(2);
    X_CLPSO(i,k) = Pos_CLPSO(1);
    Y_CLPSO(i,k) = Pos_CLPSO(2);
    X_APSO(i,k) = Pos_APSO(1);
    Y_APSO(i,k) = Pos_APSO(2);
%     X_CBH(i,k) = Pos_CBH(1);
%     Y_CBH(i,k) = Pos_CBH(2);
%     X_BA(i,k) = Pos_BA(1);
%     Y_BA(i,k) = Pos_BA(2);
    X_DE(i,k) = Pos_DE(1);
    Y_DE(i,k) = Pos_DE(2);
    X_CBH(i,k) = Pos_CBH(1);
    Y_CBH(i,k) = Pos_CBH(2);
    error(i,k) = sqrt((X - newUNNode(1,i))^2 + (Y - newUNNode(2,i))^2);
    error_PSO(i,k) = sqrt((X_PSO(i,k) - newUNNode(1,i))^2 + (Y_PSO(i,k) - newUNNode(2,i))^2);
    error_WOA(i,k) = sqrt((X_WOA(i,k) - newUNNode(1,i))^2 + (Y_WOA(i,k) - newUNNode(2,i))^2);
    error_GWO(i,k) = sqrt((X_GWO(i,k) - newUNNode(1,i))^2 + (Y_GWO(i,k) - newUNNode(2,i))^2);
    error_BH_2(i,k) = sqrt((X_BH_2(i,k) - newUNNode(1,i))^2 + (Y_BH_2(i,k) - newUNNode(2,i))^2);
    error_CLPSO(i,k) = sqrt((X_CLPSO(i,k) - newUNNode(1,i))^2 + (Y_CLPSO(i,k) - newUNNode(2,i))^2);
    error_APSO(i,k) = sqrt((X_APSO(i,k) - newUNNode(1,i))^2 + (Y_APSO(i,k) - newUNNode(2,i))^2);
%     error_CBH(i,k) = sqrt((X_CBH(i,k) - newUNNode(1,i))^2 + (Y_CBH(i,k) - newUNNode(2,i))^2);
%     error_BA(i,k) = sqrt((X_BA(i,k) - newUNNode(1,i))^2 + (Y_BA(i,k) - newUNNode(2,i))^2);
    error_DE(i,k) = sqrt((X_DE(i,k) - newUNNode(1,i))^2 + (Y_DE(i,k) - newUNNode(2,i))^2);
    error_CBH(i,k) = sqrt((X_CBH(i,k) - newUNNode(1,i))^2 + (Y_CBH(i,k) - newUNNode(2,i))^2);
    end
end


for i = 1:runs
    error_total(i) = sum(error(:,i)) / UNNodeNo;
    error_total_PSO(i) = sum(error_PSO(:,i)) / UNNodeNo;
    error_total_WOA(i) = sum(error_WOA(:,i)) / UNNodeNo;
    error_total_GWO(i) = sum(error_GWO(:,i)) / UNNodeNo;
    error_total_BH_2(i) = sum(error_BH_2(:,i)) / UNNodeNo;
    error_total_CLPSO(i) = sum(error_CLPSO(:,i)) / UNNodeNo;
    error_total_APSO(i) = sum(error_APSO(:,i)) / UNNodeNo;
% %     error_total_CBH(i) = sum(error_CBH(:,i)) / UNNodeNo;%��Ч����
%     error_total_BA(i) = sum(error_BA(:,i)) / UNNodeNo;
    error_total_DE(i) = sum(error_DE(:,i)) / UNNodeNo;
    error_total_CBH(i) = sum(error_CBH(:,i)) / UNNodeNo;
end
