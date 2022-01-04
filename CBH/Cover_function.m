function  Rate  = Cover_function( pop, Node_num, coordinate, Radius )

%% 初始化
Obstacle = 0;
boundary = size(coordinate,1);
n = 1;
for i = 1:2:size(pop,2)
    Positions(n,1) = pop(i);
    Positions(n,2) = pop(i+1);
    n = n+1;
end
for i = 1:Node_num
    Position_high(i) = coordinate(round(Positions(i,1)),round(Positions(i,2)));
end
Conect_Matrix = zeros(boundary,boundary);
% Coverage_Matrix = zeros(boundary,boundary);

for i = 1:Node_num
    for x = 1:boundary
        for y = 1:boundary
            distance = Distance(Positions(i,:),[x,y,coordinate(x,y)],3,Position_high(i));
            if distance < Radius
%                 Conect_Matrix(x,y) = 1;
                
                
                a = 1;
                C = x;
                V = y;
            [v,d] = max(abs(Positions(i,1:2) - [x,y]));%寻找变化比较大的维度，d代表变化大的维度，a表示变化比较小的维度
            if d == 1
                a = 2;
                C = y;
                V = x;
            end
            k = (C - Positions(i,a)) / (V - Positions(i,d));%x,y之间的斜率
            h = (coordinate(x,y) - Position_high(i)) / (V - Positions(i,d));%高度和变化较大维度之间的斜率
            %%
            Differ = abs(fix(Positions(i,d)) - V)-1;
            if (fix(Positions(i,d)) - V) < 0
                symbol = 1;
                start_d = fix(Positions(i,d))+1;
            else
                symbol = -1;
                start_d = fix(Positions(i,d));
            end
            start_a = Positions(i,a) + k*(start_d - Positions(i,d));
            start_h = Position_high(i) + h*(start_d - Positions(i,d));
            for s = 1:Differ
                D = start_d + s * symbol;
                A = start_a + s * symbol * k;
                A = min(boundary,A);
                High = start_h + s * symbol * h;
                if a == 1
                    if coordinate(round(A),round(D)) <  High || coordinate(round(A),round(D)) ==  High
                        Conect_Matrix(x,y) = 1;
                        Obstacle = Obstacle + 1;
                    end
                else
                    if coordinate(round(D),round(A)) <  High || coordinate(round(D),round(A)) ==  High
                         Conect_Matrix(x,y) = 1;
                        Obstacle = Obstacle + 1;
                    end
                end
            end
            
            
            end
        end
    end
end
Rate = sum(Conect_Matrix(:)==1)/(boundary * boundary);

end

