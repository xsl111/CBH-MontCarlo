clear
CBH_7 = xlsread('E:\result\mydata\mydata','CBH_7','1:28');
% Copy_of_CBH7 = xlsread('E:\result\mydata\mydata','Copy_of_CBH7','1:28');
PSO = xlsread('E:\result\mydata\mydata','PSO','1:28');
WOA = xlsread('E:\result\mydata\mydata','WOA','1:28');
BH = xlsread('E:\result\mydata\mydata','BH','1:28');
CLPSO = xlsread('E:\result\mydata\mydata','CLPSO','1:28');
DE = xlsread('E:\result\mydata\mydata','DE','1:28');
BA = xlsread('E:\result\mydata\mydata','BA','1:28');
% GA = xlsread('E:\result\mydata\mydata','GA','1:28');
SCA = xlsread('E:\result\mydata\mydata','SCA','1:28');
GWO = xlsread('E:\result\mydata\mydata','SCA','1:28');
% % cABC = xlsread('mydata','CEC_cABC','2:29');
% % cSCA = xlsread('mydata','CEC_cSCA','2:29');
% % cBA = xlsread('mydata','CEC_cBA','2:29');
% SCA = xlsread('mydata','CEC_SCA','2:29');

for i = 1:28
    i
    figure (i);
    
    plot(CBH_7(i,(1:100)),'r-o','LineWidth',1,'Marker','.','MarkerFaceColor','r');
    hold on;
    plot(PSO(i,(1:100)),'g-','LineWidth',1,'Marker','.','MarkerFaceColor','g');
    hold on;
    plot(WOA(i,(1:100)),'m-','LineWidth',1,'Marker','.','MarkerFaceColor','m');
    hold on;
    plot(BH(i,(1:100)),'k-','LineWidth',1,'Marker','.','MarkerFaceColor','k');
    hold on;
    plot(CLPSO(i,(1:100)),'y-','LineWidth',1,'Marker','.','MarkerFaceColor','y');
    hold on;
    plot(DE(i,(1:100)),'b-','LineWidth',1,'Marker','.','MarkerFaceColor','b');
    hold on;
    plot(BA(i,(1:100)),'m-','LineWidth',1,'Marker','*','MarkerFaceColor','m');
    hold on;
%     plot(GA(i,(1:100)),'b-','LineWidth',1,'Marker','.','MarkerFaceColor','b');
%     hold on;
    plot(SCA(i,(1:100)),'c-','LineWidth',1,'Marker','.','MarkerFaceColor','c');
    hold on;
    plot(GWO(i,(1:100)),'k-','LineWidth',1,'Marker','.','MarkerFaceColor','k');
    hold on;
%     plot(cABC(i,(2:21)),'m-','LineWidth',1,'Marker','+','MarkerFaceColor','m');
%     hold on;
%     plot(cSCA(i,(2:21)),'k-','LineWidth',1,'Marker','x','MarkerFaceColor','k');
%     hold on;
%     plot(cBA(i,(2:21)),'b-','LineWidth',1,'Marker','s','MarkerFaceColor','b');
%     hold on;
%     plot(SCA(i,(2:21)),'c-','LineWidth',1,'Marker','d','MarkerFaceColor','c');
%     hold on;
%     set(gca,'FontName','Times New Roman','FontSize',12)
%     set(gca,'XTick',0:2:20)
%     set(gca,'XTicklabel',{'0','300','600','900','1200','1500','1800','2100','2400','2700','3000'})
    axis ([1 100 -inf inf])
    grid off
%     legend('cAPSO','cPSO','cABC','cSCA','cBA')
%     legend('CBH_7','PSO','WOA','BH','CLPSO','DE','BA','GA','SCA')
    legend('CBH_7','PSO','WOA','BH','CLPSO','DE','BA','SCA','GWO')
%     legend('CBH_7')

    xlabel('Iterations','FontSize',14);
    ylabel('Function Value','FontSize',14);
    saveas(i,strcat('E:\result\picture_of_result_14_parfor\new_image_3\',num2str(i),'.png'),'png');% ±£¥Ê÷°
end