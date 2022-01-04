%_________________________________________________________________________%
%  Whale Optimization Algorithm (WOA) source codes demo 1.0               %
%                                                                         %
%  Developed in MATLAB R2011b(7.13)                                       %
%                                                                         %
%  Author and programmer: Seyedali Mirjalili                              %
%                                                                         %
%         e-Mail: ali.mirjalili@gmail.com                                 %
%                 seyedali.mirjalili@griffithuni.edu.au                   %
%                                                                         %
%       Homepage: http://www.alimirjalili.com                             %
%                                                                         %
%   Main paper: S. Mirjalili, A. Lewis                                    %
%               The Whale Optimization Algorithm,                         %
%               Advances in Engineering Software , in press,              %
%               DOI: http://dx.doi.org/10.1016/j.advengsoft.2016.01.008   %
%                                                                         %
%_________________________________________________________________________%

% This function initialize the first population of search agents
% function Positions=initialization(SearchAgents_no,dim,ub,lb)
function Positions=initialization(SearchAgents_no,dim,Xpos,Ypos)
Xmin = Xpos - 10;
Xmax = Xpos + 10;
Ymin = Ypos - 10;
Ymax = Ypos + 10;
Vmax = (Xmax - Xmin) / 20;
Vmin = -Vmax;
% Boundary_no= size(up,2); % numnber of boundaries
Boundary_no= size(Xpos,2); 

% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb
if Boundary_no==1
%     Positions(1)=rand(SearchAgents_no,dim).*(ub-lb)+lb;
    for i=1:SearchAgents_no
        Positions(i,1) = Xmin + rand .* (Xmax-Xmin);
        Positions(i,2) = Ymin + rand .* (Ymax-Ymin);
    end
end

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);        
        lb_i=lb(i);
        Positions(:,i)=rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i;
    end
end
