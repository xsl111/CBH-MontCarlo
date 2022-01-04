% function [gbestval,cg_curve] = DE( fhd,Dimension,Particle_Number,Max_Gen,Popmin,Popmax,func_num)
function gbest = MCB_DE( Dimension, Particle_Number, Max_Gen, Xpos, Ypos, RXpos, RYpos, newSeed, SeedNo, BorderLength)

Xmin = Xpos - 10;
Xmax = Xpos + 10;
Ymin = Ypos - 10;
Ymax = Ypos + 10;
Xmax = min(BorderLength,max(0,Xmax));
Xmin = min(BorderLength,max(0,Xmin));
Ymax = min(BorderLength,max(0,Ymax));
Ymax = min(BorderLength,max(0,Ymax));
Vmax = (Xmax - Xmin) / 20;
Vmin = -Vmax;
    %% Problem Definition

    %CostFunction=@(x) Sphere(x);    % Cost Function
%     CostFunction=@(x) F5(x);    %modified by arp

    nVar=Dimension;         %自变量维数   % Number of Decision Variables

    VarSize=[1 nVar];    %决策变量矩阵大小 % Decision Variables Matrix Size

%     VarMin= Popmin;          % Lower Bound of Decision Variables  
%     VarMax= Popmax;          % Upper Bound of Decision Variables

    %% DE Parameters

    MaxIt=Max_Gen;      % Maximum Number of Iterations  1000

    nPop=Particle_Number;        % Population Size    50

    beta_min=0.2;   % Lower Bound of Scaling Factor  % 缩放因子下界 
    beta_max=0.8;   % Upper Bound of Scaling Factor  % 缩放因子上界 

    pCR=0.2;        % Crossover Probability  %  交叉概率
    beta = 0.7;
%     T = zeros(1,MaxIt);
    %% Initialization

    empty_individual.Position=[];   
    empty_individual.Cost=[];

    BestSol.Cost=inf;

    pop=repmat(empty_individual,nPop,1);

    for i=1:nPop

%         pop(i).Position=unifrnd(VarMin,VarMax,VarSize);  % 随机产生缩放因子
        pop(i).Position(1)=unifrnd(Xmin,Xmax,1);  % 随机产生缩放因子
        pop(i).Position(2)=unifrnd(Ymin,Ymax,1);  % 随机产生缩放因子
%         pop(i).Cost=feval(fhd,pop(i).Position',func_num);
        pop(i).Cost=fit_w( pop(i).Position(1),pop(i).Position(2), RXpos, RYpos, newSeed, SeedNo);
        if pop(i).Cost<BestSol.Cost
            BestSol=pop(i);
            BestSol.Cost = pop(i).Cost;
        end

    end
    GA=BestSol.Cost;
    BestCost=zeros(1,MaxIt);
    gbest = zeros(1,Dimension);
    %% DE Main Loop
    for it=1:MaxIt
        % 产生变异（中间体）种群
        for i=1:nPop

            x=pop(i).Position;

            A=randperm(nPop); %个体顺序重新随机排列 %随机生成1~nPop共计nPop个数据，且各不相同

            A(A==i)=[];  %当前个体所排位置腾空（产生变异中间体时当前个体不参与） %A的实际长度为 nPop -1

            %在原种群中任选三个互不相同的个体进行交叉变异
            a=A(1);
            b=A(2);
%             c=A(3);

            % Mutation
            %beta=unifrnd(beta_min,beta_max);
%             beta=unifrnd(beta_min,beta_max,VarSize); % 随机产生缩放因子
%             y = pop(a).Position+beta.*(pop(b).Position-pop(c).Position); % 产生中间体
            y = BestSol.Position+beta.*(pop(a).Position-pop(b).Position); % 产生中间体
            %防止中间体越界
%             y = max(y, VarMin);
%             y = min(y, VarMax);
            y(1) = max(Xmin,min(Xmax,y(1)));
            y(2) = max(Ymin,min(Ymax,y(2)));

            % 产生子代种群，交叉操作 Crossover
            z=zeros(size(x));    % 初始化一个新个体
            j0=randi([1 numel(x)]);  % 产生一个伪随机数，即选取待交换维度编号
            for j=1:numel(x)   % 遍历每个维度
                if j==j0 || rand<=pCR    %如果当前维度是待交换维度或者随机概率小于交叉概率
                    z(j)=y(j);      %新个体当前维度值等于中间体对应维度值
                else
                    z(j)=x(j);   %新个体当前维度值等于当前个体对应维度值
                end
            end

            NewSol.Position=z;    %交叉操作之后得到新个体
%             NewSol.Cost=feval(fhd,NewSol.Position',func_num);  %新个体目标函数值
            NewSol.Cost=fit_w( NewSol.Position(1),NewSol.Position(2), RXpos, RYpos, newSeed, SeedNo);
            if NewSol.Cost<pop(i).Cost    % 如果子代个体优于父代个体
                pop(i)=NewSol;            % 更新父代个体
            end

        end
        for i=1:nPop
            if pop(i).Cost<BestSol.Cost  % 更新全局最优个体
               BestSol=pop(i);
               BestSol.Cost = pop(i).Cost;
               gbest = pop(i).Position;
            end
        end
        % Update Best Cost
        
        BestCost(it)=BestSol.Cost;
        
        % Show Iteration Information
%         disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
        cg_curve(it)=BestCost(it);
    end
     gbestval = BestSol.Cost;
%     cg_curve(it)=gbestval;
end

