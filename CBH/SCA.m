%δ���޸�
function [Destination_fitness,Convergence_curve]=SCA(fhd,dim,N,Max_iteration,lb,ub,func_num)
% N=2*dim;
%display('SCA is optimizing your problem');
X=initialization(N,dim,ub,lb);%��ʼ��X
Destination_position=zeros(1,dim);%Ŀ��λ��
Destination_fitness=inf;%Ŀ�꺯��ֵ
Convergence_curve=zeros(1,Max_iteration);%����
Objective_values = zeros(1,size(X,1));%���scaǰ��ĳ��������Ŀ�꺯��ֵ
for i=1:size(X,1)
    Objective_values(1,i)=feval(fhd,X(i,:)',func_num);%���ݳ�ʼ����X��ĳ���������ɶ�Ӧ����Ӧֵ
    if i==1%��ʼ����һ���X��Ȼ��ȽϽ��и���
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
    end%sca������X
    for i=1:size(X,1)
        Flag4ub=X(i,:)>ub;
        Flag4lb=X(i,:)<lb;
        X(i,:)=(X(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        Objective_values(1,i)=feval(fhd,X(i,:)',func_num);%���ݺ����ɵ�X����ĳ�������ϵ���Ӧֵ
        if Objective_values(1,i)<Destination_fitness%�ж��Ƿ�Ҫ����
            Destination_position=X(i,:);
            Destination_fitness=Objective_values(1,i);
        end
    end
    Convergence_curve(t)=Destination_fitness;%��t�ε�����������ֵ
    %if mod(t,1000)==0%����1000�δ���һ��
     %   display(['At iteration ', num2str(t), ' the optimum is ', num2str(Destination_fitness)]);
    %end

end