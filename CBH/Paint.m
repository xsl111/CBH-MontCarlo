PSO = xlsread('Coverage','PSO_CEC2013','31:58');
WOA = xlsread('Coverage','WOA_CEC2013','31:58');
BH = xlsread('Coverage','BlackHole_CEC2013','31:58');
EBH = xlsread('Coverage','Enhance_CEC2013','31:58');

for i = 1:28
    figure (i)
   
    plot(PSO(i,(1:20)),'r-o','LineWidth',1.5,'Marker','o','MarkerFaceColor','red');
    hold on;
    plot(WOA(i,(1:20)),'m-','LineWidth',1.5,'Marker','v','MarkerFaceColor','m');
    hold on;
    plot(BH(i,(1:20)),'g-','LineWidth',1.5,'Marker','s','MarkerFaceColor','g');
    hold on;
    plot(EBH(i,(1:20)),'b-','LineWidth',1.5,'Marker','x','MarkerFaceColor','b');
    hold on;
    set(gca,'FontName','Times New Roman','FontSize',12)
    grid on;
    legend('PSO','WOA','BH','EBH');
    xlabel('Iterations','FontSize',14);
    ylabel('Function Value','FontSize',14);
end