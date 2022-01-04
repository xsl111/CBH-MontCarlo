%未经修改
function [Destination_fitness,Convergence_curve]=SCA(fhd,dim,N,Max_iteration,lb,ub,func_num)
% N=2*dim;
%display('SCA is optimizing your problem');
X=initialization(N,dim,ub,lb);%初始化X
Destination_position=zeros(1,dim);%目标位置
Destination_fitness=inf;%目标函数值
Convergence_curve=zeros(1,Max_iteration);%曲线
Objective_values = zeros(1,size(X,1));%存放sca前在某个函数的目标函数值
for i=1:size(X,1)
    Objective_values(1,i)=feval(fhd,X(i,:)',func_num);%根据初始化的X和某个函数生成对应的适应值
    if i==1%初始化第一组的X，然后比较进行更新
        Destination_position=X(i,:);
        Destination_fitness=Objective_values(1,i);
    elseif Objective_values(1,i)<Destination_fitness
        Destination_position=X(i,:);
        Destination_fitness=Objective_values(1,i);
    end
    %display(Destination_position);
    %display(X);
    %All_objective_values(1,i)=Objective_values(1,i);
end
%t=2;
for t=1:Max_iteration
    a = 2;
   % Max_iteration = Max_iteration;
    r1=a-t*((a)/Max_iteration);
    for i=1:size(X,1)
        for j=1:size(X,2)
            r2=(2*pi)*rand();
            r3=2*rand;
            r4=rand();
             if r4<0.5
                X(i,j)= X(i,j)+(r1*sin(r2)*abs(r3*Destination_position(j)-X(i,j)));
            else
                 X(i,j)= X(i,j)+(r1*cos(r2)*abs(r3*Destination_position(j)-X(i,j)));
            end
        end
    end%sca后生成X
    for i=1:size(X,1)
        Flag4ub=X(i,:)>ub;
        Flag4lb=X(i,:)<lb;
        X(i,:)=(X(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        Objective_values(1,i)=feval(fhd,X(i,:)',func_num);%根据后生成的X求在某个函数上的适应值
        if Objective_values(1,i)<Destination_fitness%判断是否要更新
            Destination_position=X(i,:);
            Destination_fitness=Objective_values(1,i);
        end
    end
    Convergence_curve(t)=Destination_fitness;%在t次迭代处的曲线值
    %if mod(t,1000)==0%迭代1000次处理一次
     %   display(['At iteration ', num2str(t), ' the optimum is ', num2str(Destination_fitness)]);
    %end

end