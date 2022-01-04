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

    nVar=Dimension;         %�Ա���ά��   % Number of Decision Variables

    VarSize=[1 nVar];    %���߱��������С % Decision Variables Matrix Size

%     VarMin= Popmin;          % Lower Bound of Decision Variables  
%     VarMax= Popmax;          % Upper Bound of Decision Variables

    %% DE Parameters

    MaxIt=Max_Gen;      % Maximum Number of Iterations  1000

    nPop=Particle_Number;        % Population Size    50

    beta_min=0.2;   % Lower Bound of Scaling Factor  % ���������½� 
    beta_max=0.8;   % Upper Bound of Scaling Factor  % ���������Ͻ� 

    pCR=0.2;        % Crossover Probability  %  �������
    beta = 0.7;
%     T = zeros(1,MaxIt);
    %% Initialization

    empty_individual.Position=[];   
    empty_individual.Cost=[];

    BestSol.Cost=inf;

    pop=repmat(empty_individual,nPop,1);

    for i=1:nPop

%         pop(i).Position=unifrnd(VarMin,VarMax,VarSize);  % ���������������
        pop(i).Position(1)=unifrnd(Xmin,Xmax,1);  % ���������������
        pop(i).Position(2)=unifrnd(Ymin,Ymax,1);  % ���������������
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
        % �������죨�м��壩��Ⱥ
        for i=1:nPop

            x=pop(i).Position;

            A=randperm(nPop); %����˳������������� %�������1~nPop����nPop�����ݣ��Ҹ�����ͬ

            A(A==i)=[];  %��ǰ��������λ���ڿգ����������м���ʱ��ǰ���岻���룩 %A��ʵ�ʳ���Ϊ nPop -1

            %��ԭ��Ⱥ����ѡ����������ͬ�ĸ�����н������
            a=A(1);
            b=A(2);
%             c=A(3);

            % Mutation
            %beta=unifrnd(beta_min,beta_max);
%             beta=unifrnd(beta_min,beta_max,VarSize); % ���������������
%             y = pop(a).Position+beta.*(pop(b).Position-pop(c).Position); % �����м���
            y = BestSol.Position+beta.*(pop(a).Position-pop(b).Position); % �����м���
            %��ֹ�м���Խ��
%             y = max(y, VarMin);
%             y = min(y, VarMax);
            y(1) = max(Xmin,min(Xmax,y(1)));
            y(2) = max(Ymin,min(Ymax,y(2)));

            % �����Ӵ���Ⱥ��������� Crossover
            z=zeros(size(x));    % ��ʼ��һ���¸���
            j0=randi([1 numel(x)]);  % ����һ��α���������ѡȡ������ά�ȱ��
            for j=1:numel(x)   % ����ÿ��ά��
                if j==j0 || rand<=pCR    %�����ǰά���Ǵ�����ά�Ȼ����������С�ڽ������
                    z(j)=y(j);      %�¸��嵱ǰά��ֵ�����м����Ӧά��ֵ
                else
                    z(j)=x(j);   %�¸��嵱ǰά��ֵ���ڵ�ǰ�����Ӧά��ֵ
                end
            end

            NewSol.Position=z;    %�������֮��õ��¸���
%             NewSol.Cost=feval(fhd,NewSol.Position',func_num);  %�¸���Ŀ�꺯��ֵ
            NewSol.Cost=fit_w( NewSol.Position(1),NewSol.Position(2), RXpos, RYpos, newSeed, SeedNo);
            if NewSol.Cost<pop(i).Cost    % ����Ӵ��������ڸ�������
                pop(i)=NewSol;            % ���¸�������
            end

        end
        for i=1:nPop
            if pop(i).Cost<BestSol.Cost  % ����ȫ�����Ÿ���
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

