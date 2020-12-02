function CVGA(G)

for i=1: size(G,1)
    Min_gli(i) = prctile(G(i,:),2.5);
    Max_gli(i) = prctile(G(i,:),97.5);
end
p=polyfit([110 180 300 400],[0 20 40 60],3);
Max_gli = polyval(p,Max_gli);



figure
hold on
%fill zone C
X_pcmeno = [40 60 60 40]; Y_pcmeno = [0 0 20 20]; fill(X_pcmeno,Y_pcmeno,[1 1 0]);
%fill zone D
X_pdmeno = [40 60 60 40]; Y_pdmeno = [20 20 40 40]; fill(X_pdmeno,Y_pdmeno,[1 0.6 0]);
%fill zone E
X_pe = [40 60 60 40]; Y_pe = [40 40 60 60]; fill(X_pe,Y_pe,[1 0 0]);
%fill zone B
X_pbmeno = [20 40 40 20]; Y_pbmeno = [0 0 20 20]; fill(X_pbmeno,Y_pbmeno,[7/255 135/255 0/255]);
%fill zone C
X_pc = [20 40 40 20]; Y_pc = [20 20 40 40]; fill(X_pc,Y_pc,[7/255 135/255 0/255]);
%fill zone D+
X_pdpiu = [20 40 40 20]; Y_pdpiu = [40 40 60 60]; fill(X_pdpiu,Y_pdpiu,[1 0.6 0]);
%fill zone A
X_pa = [0 20 20 0]; Y_pa = [0 0 20 20]; fill(X_pa,Y_pa,[0 1 0]);
%fill zone B+
X_pbpiu = [0 20 20 0]; Y_pbpiu = [20 20 40 40]; fill(X_pbpiu,Y_pbpiu,[7/255 135/255 0/255]);
%fill zone C+
X_pcpiu = [0 20 20 0]; Y_pcpiu = [40 40 60 60]; fill(X_pcpiu,Y_pcpiu,[1 1 0]);
text(10,10,'\textbf{A}','HorizontalAlignment','center','Interpreter','Latex','Fontsize',15);
text(10,30,'\textbf{Upper B}','HorizontalAlignment','center','Interpreter','Latex' ,'Fontsize',15);
text(10,50,'\textbf{Upper C}','HorizontalAlignment','center','Interpreter','Latex' ,'Fontsize',15);
text(30,10,'\textbf{Lower B}','HorizontalAlignment','center','Interpreter','Latex' ,'Fontsize',15);
text(30,30,'\textbf{B}','HorizontalAlignment','center','Interpreter','Latex' ,'Fontsize',15);
text(30,50,'\textbf{Upper D}','HorizontalAlignment','center','Interpreter','Latex' ,'Fontsize',15);
text(50,10,'\textbf{Lower C}','HorizontalAlignment','center','Interpreter','Latex' ,'Fontsize',15);
text(50,30,'\textbf{Lower D}','HorizontalAlignment','center','Interpreter','Latex' ,'Fontsize',15);
text(50,50,'\textbf{E}','HorizontalAlignment','center','Interpreter','Latex' ,'Fontsize',15);
set(gca,'YTick',[0 20 40 60])
set(gca,'XTick',[0 20 40 60])
set(gca,'XTickLabel',{'>110' '90' '70' '<50'})
set(gca,'YTickLabel',{'<110' '180' '300' '>400'})
scatter(min(max(110 - Min_gli,0),60),min(max(Max_gli,0),60),'ow','filled');
xlabel('Minimum BG'),ylabel('Maximum BG')
grid on
box on