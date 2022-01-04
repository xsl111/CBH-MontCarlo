% [x,y,coordinate] = peaks(50);
% surf(x,y,z);
% save coordinate.mat coordinate;
clc
clear
load coordinate.mat;
% surf(coordinate);
%% 初始化
Obstacle = 0;
boundary = 50;
Node_num = 100;
Radius = 10;
Positions = 1+(boundary-1)*rand(100,2);
for i = 1:Node_num
    Positions(i,3) = coordinate(round(Positions(i,1)),round(Positions(i,2)));
end
Conect_Matrix = zeros(Node_num,Node_num);
% Coverage_Matrix = zeros(boundary,boundary);

for i = 1:Node_num-1
    for j = i+1:Node_num
        distance = Distance(Positions(i,:),Positions(j,:),3);
        if distance < Radius
            Conect_Matrix(i,j) = 1;
            Conect_Matrix(j,i) = 1;
        end
    end
end

for i = 1:Node_num-1
    for j = i+1:Node_num
        if Conect_Matrix(i,j) == 1
            a = 1;
            [v,d] = max(abs(Positions(i,1:2)-Positions(j,1:2)));%寻找变化比较大的维度，d代表变化大的维度，a表示变化比较小的维度
            if d == 1
                a = 2;
            end
            k = abs(Positions(j,a)-Positions(i,a))/(Positions(j,d)-Positions(i,d));%x,y之间的斜率
            h = abs(Positions(j,3)-Positions(i,3))/(Positions(j,d)-Positions(i,d));%高度和变化较大维度之间的斜率
            %%
            Differ = abs(fix(Positions(i,d)) - fix(Positions(j,d)))-1;
            if fix(Positions(i,d)) - fix(Positions(j,d)) < 0
                symbol = 1;
                start_d = fix(Positions(i,d))+1;
            else
                symbol = -1;
                start_d = fix(Positions(i,d));
            end
            start_a = Positions(i,a) + k*(start_d - Positions(i,d));
            start_h = Positions(i,3) + h*(start_d - Positions(i,d));
            for s = 1:Differ
                D = start_d + s * symbol;
                A = start_a + s * symbol * k;
                A = min(boundary,A);
                High = start_h + s * symbol * h;
                if a == 1
                    if coordinate(round(A),round(D)) >  High
                        Conect_Matrix(i,j) = 0;
                        Conect_Matrix(j,i) = 0;
                        Obstacle = Obstacle + 1;
                    else
                        
                    end
                else
                    if coordinate(round(A),round(D)) >  High
                        Conect_Matrix(i,j) = 0;
                        Conect_Matrix(j,i) = 0;
                        Obstacle = Obstacle + 1;
                    end
                end
            end
        end
    end
end



