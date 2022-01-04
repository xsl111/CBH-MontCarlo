
% function [Leader_score,Convergence_curve]=WOA(dim,SearchAgents_no,Max_iter,Xpos,Ypos,RXpos,RYpos,newSeed,SeedNo)
function Leader_pos=MCB_WOA(dim,SearchAgents_no,Max_iter,Xpos,Ypos,RXpos,RYpos,newSeed,SeedNo,BorderLength)
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
% initialize position vector and score for the leader
Leader_pos=zeros(1,dim);
Leader_score=inf; %change this to -inf for maximization problems


%Initialize the positions of search agents

% Positions = lb+rand(SearchAgents_no,dim)*(ub-lb);
for i=1:SearchAgents_no
    Positions(i,1) = Xmin+rand.*(Xmax-Xmin);
    Positions(i,2) = Ymin+rand.*(Ymax-Ymin);
end
Convergence_curve=zeros(1,Max_iter);

t=0;% Loop counter

% Main loop
while t<Max_iter
    for i=1:size(Positions,1)
        
        % Return back the search agents that go beyond the boundaries of the search space
%         Flag4ub=Positions(i,:)>ub;
        Flag4Xmax=Positions(i,1)>Xmax;
        Flag4Ymax=Positions(i,2)>Ymax;
%         Flag4lb=Positions(i,:)<lb;
        Flag4Xmin=Positions(i,1)<Xmin;
        Flag4Ymin=Positions(i,2)<Ymin;
%         Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        Positions(i,1)=(Positions(i,1).*(~(Flag4Xmax+Flag4Xmin)))+Xmax.*Flag4Xmax+Xmin.*Flag4Xmin;
        Positions(i,2)=(Positions(i,2).*(~(Flag4Ymax+Flag4Ymin)))+Ymax.*Flag4Ymax+Ymin.*Flag4Ymin;
        
        % Calculate objective function for each search agent
%         fitness=fobj(Positions(i,:));
%         fitness = feval(fhd,Positions(i,:)',varargin{:});
        fitness = fit_w(Positions(i,1), Positions(i,2), RXpos, RYpos, newSeed, SeedNo);
        % Update the leader
        if fitness<Leader_score % Change this to > for maximization problem
            Leader_score=fitness; % Update alpha
            Leader_pos=Positions(i,:);
        end
        
    end
    
    a=2-t*((2)/Max_iter); % a decreases linearly fron 2 to 0 in Eq. (2.3)
    
    % a2 linearly dicreases from -1 to -2 to calculate t in Eq. (3.12)
    a2=-1+t*((-1)/Max_iter);
    
    % Update the Position of search agents 
    for i=1:size(Positions,1)
        r1=rand(); % r1 is a random number in [0,1]
        r2=rand(); % r2 is a random number in [0,1]
        
        A=2*a*r1-a;  % Eq. (2.3) in the paper
        C=2*r2;      % Eq. (2.4) in the paper
        
        
        b=1;               %  parameters in Eq. (2.5)
        l=(a2-1)*rand+1;   %  parameters in Eq. (2.5)
        
        p = rand();        % p in Eq. (2.6)
        
        for j=1:size(Positions,2)
            
            if p<0.5   
                if abs(A)>=1
                    rand_leader_index = floor(SearchAgents_no*rand()+1);
                    X_rand = Positions(rand_leader_index, :);
                    D_X_rand=abs(C*X_rand(j)-Positions(i,j)); % Eq. (2.7)
                    Positions(i,j)=X_rand(j)-A*D_X_rand;      % Eq. (2.8)
                    
                elseif abs(A)<1
                    D_Leader=abs(C*Leader_pos(j)-Positions(i,j)); % Eq. (2.1)
                    Positions(i,j)=Leader_pos(j)-A*D_Leader;      % Eq. (2.2)
                end
                
            elseif p>=0.5
              
                distance2Leader=abs(Leader_pos(j)-Positions(i,j));
                % Eq. (2.5)
                Positions(i,j)=distance2Leader*exp(b.*l).*cos(l.*2*pi)+Leader_pos(j);
                
            end
            
        end
    end
    t=t+1;
    Convergence_curve(t)=Leader_score;
end



