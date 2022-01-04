clear
clc
n=100;
fhd=str2func('cec13_func');
func_num=28;
dim = 50;
Max_gen=3000;
down=-100;
up=100;
times=20;
    f_cs=zeros(times,func_num);
    f_pacs=zeros(times,func_num);
    f_pso=zeros(times,func_num);
    f_pcs=zeros(times,func_num);
    f_sca=zeros(times,func_num);
    f_woa=zeros(times,func_num);
    f_gwo=zeros(times,func_num);
    f_de=zeros(times,func_num);
    cst=zeros(func_num,times);
    pcst=zeros(func_num,times);
    pacst=zeros(func_num,times);
    psot=zeros(func_num,times);
    pcst=zeros(func_num,times);
    scat=zeros(func_num,times);
    gwot=zeros(func_num,times);
    det=zeros(func_num,times);
for func_num_i=1:func_num
     for i=1:times
        [value_cs,cs_t]=cuckoo_searchn(fhd,n,Max_gen,down,up,dim,func_num_i);
        [value_pacs,pacs_t]=P_cuckoo_search_sin(fhd,n,Max_gen,down,up,dim,func_num_i);
        [value_pso,pso_t]=PSO_1(fhd,dim,n,Max_gen,down,up,func_num_i);
        [value_pcs,pcs_t]=P_cuckoo_search(fhd,n,Max_gen,down,up,dim,func_num_i);
        [value_sca,sca_t]=SCA2(Max_gen,n,fhd,dim,func_num_i);
        [value_woa,woa_t]=WOA(fhd,n,Max_gen,down,up,dim,func_num_i);
        [value_gwo,gwo_t]=GWO(fhd,n,Max_gen,down,up,dim,func_num_i);
        [value_de,de_t]=DE(fhd,n,Max_gen,dim,func_num_i);
        cst(func_num_i,i)=cs_t;
        pcst(func_num_i,i)=pcs_t;
        pacst(func_num_i,i)=pacs_t;
        psot(func_num_i,i)=pso_t;
        scat(func_num_i,i)=sca_t;
        woat(func_num_i,i)=woa_t;
        gwot(func_num_i,i)=gwo_t;
        det(func_num_i,i)=de_t;
        f_cs(i,func_num_i)=value_cs;%Ë°?‰∏∫Ê¨°Êï∞ÔºåÂà?‰∏∫ÊµãËØïÂáΩÊï∞ÔºåÂÄº‰∏∫ÊØèÊ¨°Êú?ºòÂÄ?
        f_pacs(i,func_num_i)=value_pacs;
        f_pso(i,func_num_i)=value_pso;
        f_pcs(i,func_num_i)=value_pcs;
        f_sca(i,func_num_i)=value_sca;
        f_woa(i,func_num_i)=value_woa;
        f_gwo(i,func_num_i)=value_gwo;
        f_de(i,func_num_i)=value_de;
    end
    f_mean_cs=sum(f_cs(:,func_num_i))./times;
    f_mean_pacs=sum(f_pacs)./times;
    f_mean_pso=sum(f_pso)./times;
    f_mean_pcs=sum(f_pcs)./times;
    f_mean_sca=sum(f_sca)./times;
    f_mean_woa=sum(f_woa)./times;
    f_mean_gwo=sum(f_gwo)./times;
    f_mean_de=sum(f_de)./times;
    mean_s(1,func_num_i)=mean(f_cs(:,func_num_i));%ÂùáÂ?
    mean_s(3,func_num_i)=mean(f_pacs(:,func_num_i));
    mean_s(4,func_num_i)=mean(f_pso(:,func_num_i));
    mean_s(2,func_num_i)=mean(f_pcs(:,func_num_i));
    mean_s(5,func_num_i)=mean(f_sca(:,func_num_i));
    mean_s(6,func_num_i)=mean(f_woa(:,func_num_i));
    mean_s(7,func_num_i)=mean(f_gwo(:,func_num_i));
    mean_s(8,func_num_i)=mean(f_de(:,func_num_i));
   min_s(1,func_num_i)=min(f_cs(:,func_num_i));%Êú?∞èÂÄ?
   min_s(3,func_num_i)=min(f_pacs(:,func_num_i));
   min_s(4,func_num_i)=min(f_pso(:,func_num_i));
   min_s(2,func_num_i)=min(f_pcs(:,func_num_i));
   min_s(5,func_num_i)=min(f_sca(:,func_num_i));
   min_s(6,func_num_i)=min(f_woa(:,func_num_i));
   min_s(7,func_num_i)=min(f_gwo(:,func_num_i));
   min_s(8,func_num_i)=min(f_de(:,func_num_i));
    max_s(1,func_num_i)=max(f_cs(:,func_num_i));%Êú?§ßÂÄ?
    max_s(3,func_num_i)=max(f_pacs(:,func_num_i));
    max_s(4,func_num_i)=max(f_pso(:,func_num_i));
    max_s(2,func_num_i)=max(f_pcs(:,func_num_i));
    max_s(5,func_num_i)=max(f_sca(:,func_num_i));
    max_s(6,func_num_i)=max(f_woa(:,func_num_i));
    max_s(7,func_num_i)=max(f_gwo(:,func_num_i));
    max_s(8,func_num_i)=max(f_de(:,func_num_i));
    a_std(func_num_i,1)=std(f_cs(:,func_num_i));%Ê†áÂáÜÂ∑?
    a_std(func_num_i,3)=std(f_pacs(:,func_num_i));
    a_std(func_num_i,2)=std(f_pcs(:,func_num_i));
    a_std(func_num_i,4)=std(f_pso(:,func_num_i));
    a_std(func_num_i,5)=std(f_sca(:,func_num_i));
    a_std(func_num_i,6)=std(f_woa(:,func_num_i));
    a_std(func_num_i,7)=std(f_gwo(:,func_num_i));
    a_std(func_num_i,8)=std(f_de(:,func_num_i));
%     figure(func_num_i);
%     plot(f_mean_cs,'m');
%     hold on;
%     plot(f_mean_pcs,'--r');
%     plot(f_mean_pacs,'r');
%     plot(f_mean_pso,'b');
%     plot(f_mean_sca,'y');
%     plot(f_mean_woa,'c');
% %     plot(f_mean_eo,'m');
%     plot(f_mean_gwo,'g');
% %     plot(f_mean_mvo,'k');
%     plot(f_mean_de,'k');
%     legend('CS','PCS','PACS','PSO','SCA','WOA','GWO','DE');%,'eo'
%     saveas(func_num_i,strcat('C:\Users\LENOVO\Desktop\',num2str(func_num_i),'.fig'),'fig');% ‰øùÂ≠òÂ∏?
end