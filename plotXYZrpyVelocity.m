% close all

clear
clc
vins = importdata('/Users/jin/Desktop/4min/rgbd640_dist0.2/rgbd_vio_vins_cp.csv');
vins(:,1) = vins(:,1)+0.03;
% vins = vins(1:5:135,:);
gt = importdata('/Users/jin/Q_Mac/data/temp/4min/groundtruth/gt_cp/4min_gt_cp_cp.csv'); 

vins(:,2:4) = 100*vins(:,2:4);
gt(:,2:4) = 100*gt(:,2:4);

% gt(:,1) = gt(:,1) - 0.0458;
gt = gt(gt(:,1)<max((vins(:,1)+.1)),:);



rpy_vins = quat2eul([vins(:,8),vins(:,5:7)])*180/pi;
rpy_gt = quat2eul([gt(:,8),gt(:,5:7)])*180/pi;


rpy_vins = [vins(:,1),rpy_vins];
rpy_gt = [gt(:,1),rpy_gt];
% rpy_oldgt = [oldgt(:,1),rpy_oldgt];


rpy_gt(rpy_gt(:,1)<50&rpy_gt(:,4)<-50,4) = rpy_gt(rpy_gt(:,1)<50&rpy_gt(:,4)<-50,4)+360;
rpy_gt(rpy_gt(:,1)<95&rpy_gt(:,1)>85&rpy_gt(:,4)>0,4) = rpy_gt(rpy_gt(:,1)<95&rpy_gt(:,1)>85&rpy_gt(:,4)>0,4)-360;
% [24021;21207;17766;8045]
L = length(rpy_gt);
rpy_gt(8478:L,4)=rpy_gt(8478:L,4)+360;
rpy_gt(17759:L,4)=rpy_gt(17759:L,4)+360;
% rpy_gt(21207:L,4)=rpy_gt(21207:L,4)+360;
% rpy_gt(24021:L,4)=rpy_gt(24021:L,4)+360;



rpy_vins(rpy_vins(:,1)<40&rpy_vins(:,1)>20&rpy_vins(:,4)<-0,4) = rpy_vins(rpy_vins(:,1)<40&rpy_vins(:,1)>20&rpy_vins(:,4)<-0,4)+360;
rpy_vins(rpy_vins(:,1)<90&rpy_vins(:,1)>65&rpy_vins(:,4)<-0,4) = rpy_vins(rpy_vins(:,1)<90&rpy_vins(:,1)>65&rpy_vins(:,4)<-0,4)+360;
% [1670;1547;959]
rpy_vins(960:1547,4)=rpy_vins(960:1547,4)+360;
rpy_vins(1548:1670,4)=rpy_vins(1548:1670,4)+360+360;
figure
subplot(3,1,1)
plot(rpy_vins(:,1),rpy_vins(:,2),'g'),grid minor
subplot(3,1,2)
plot(rpy_vins(:,1),rpy_vins(:,3),'g'),grid minor
subplot(3,1,3)
plot(rpy_vins(:,1),rpy_vins(:,4),'g'),grid minor

figure
subplot(3,1,1)
plot(rpy_gt(:,1),rpy_gt(:,2),'g'),grid minor
subplot(3,1,2)
plot(rpy_gt(:,1),rpy_gt(:,3),'g'),grid minor
subplot(3,1,3)
plot(rpy_gt(:,1),rpy_gt(:,4),'g'),grid minor
%%
vins = vins(vins(:,1)>02&vins(:,1)<38,:);
rpy_vins = rpy_vins(rpy_vins(:,1)>02&rpy_vins(:,1)<38,:);
% rpy_gt = rpy_gt(rpy_gt(:,1)>0&rpy_gt(:,1)<10,:);


A = repmat(gt(:,1),[1 length(vins(:,1))]);
[minValue,gtclosestIndex] = min(abs(A-vins(:,1)'));
gt_match = gt(gtclosestIndex,:);
rpy_gt_match = rpy_gt(gtclosestIndex,:);
%%
labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);

subplot(3,1,1)
plot(rpy_vins(:,1),rpy_vins(:,2),'r','LineWidth',2)
grid minor,hold on
plot(rpy_gt_match(:,1),rpy_gt_match(:,2),'b','LineWidth',2)
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(['$\phi (^{\circ})$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,0,0]); 
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')
    
subplot(3,1,2)
plot(rpy_vins(:,1),rpy_vins(:,3),'r','LineWidth',2)
grid minor,hold on
plot(rpy_gt_match(:,1),rpy_gt_match(:,3),'b','LineWidth',2)

xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(['$\theta (^{\circ})$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,0,0]); 
set(gca,'FontSize',xyzsize)


subplot(3,1,3)
plot(rpy_vins(:,1),rpy_vins(:,4),'r','LineWidth',2)
grid minor,hold on
plot(rpy_gt_match(:,1),rpy_gt_match(:,4),'b','LineWidth',2)

xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(['$\psi (^{\circ})$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,-50,0]); 
set(gca,'FontSize',xyzsize)


set(gcf,'color','w');

exportgraphics(h,'angle_closet.png') 
%%
clc
mean(abs(rpy_vins(:,1)-rpy_gt_match(:,1)))
mean(abs(rpy_vins(:,2)-rpy_gt_match(:,2)))
mean(abs(rpy_vins(:,3)-rpy_gt_match(:,3)))
mean(abs(rpy_vins(:,4)-rpy_gt_match(:,4)))

std(abs(rpy_vins(:,2)-rpy_gt_match(:,2)))
std(abs(rpy_vins(:,3)-rpy_gt_match(:,3)))
std(abs(rpy_vins(:,4)-rpy_gt_match(:,4)))

%%

labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);

subplot(3,1,1)
plot(vins(:,1),vins(:,2),'r','LineWidth',2)
grid minor,hold on
plot(gt_match(:,1),gt_match(:,2),'b','LineWidth',2)
hold on;bar(vins(:,1),10.5*(vins(:,2)-gt_match(:,2)))
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(['$x (cm)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,0,0]); 
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')
    
subplot(3,1,2)
plot(vins(:,1),vins(:,3),'r','LineWidth',2)
grid minor,hold on
plot(gt_match(:,1),gt_match(:,3),'b','LineWidth',2)
hold on;bar(vins(:,1),10.5*(vins(:,3)-gt_match(:,3)))
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(['$y (cm)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,-0,0]); 
set(gca,'FontSize',xyzsize)


subplot(3,1,3)
plot(vins(:,1),vins(:,4),'r','LineWidth',2)
grid minor,hold on
plot(gt_match(:,1),gt_match(:,4),'b','LineWidth',2)
hold on;bar(vins(:,1),10.5*(vins(:,4)-gt_match(:,4)))
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(['$z (cm)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,0,0]); 
set(gca,'FontSize',xyzsize)

set(gcf,'color','w');

exportgraphics(h,'xyz_closest.png') 
%%
clc
mean(abs(vins(:,1)-gt_match(:,1)))
mean(abs(vins(:,2)-gt_match(:,2)))
mean(abs(vins(:,3)-gt_match(:,3)))
mean(abs(vins(:,4)-gt_match(:,4)))

% std(abs(vins(:,1)-gt(closestIndex,1)))
std(abs(vins(:,2)-gt_match(:,2)))
std(abs(vins(:,3)-gt_match(:,3)))
std(abs(vins(:,4)-gt_match(:,4)))
%%
Lvins = length(vins);
vins_Vxyz(:,1) = (vins(2:Lvins,1)+vins(1:Lvins-1,1))/2;
vins_Vxyz(:,2:4) = (vins(2:Lvins,2:4)-vins(1:Lvins-1,2:4))./(vins(2:Lvins,1)-vins(1:Lvins-1,1));

Lgt = length(gt_match);
gt_Vxyz(:,1) = (gt_match(2:Lgt,1)+gt_match(1:Lgt-1,1))/2;
gt_Vxyz(:,2:4) = (gt_match(2:Lgt,2:4)-gt_match(1:Lgt-1,2:4))./(gt_match(2:Lgt,1)-gt_match(1:Lgt-1,1));


labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);

subplot(3,1,1)
plot(vins_Vxyz(:,1),vins_Vxyz(:,2),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vxyz(:,1),gt_Vxyz(:,2),'b--','LineWidth',2)

xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(["$v_x$","$ (cm/s)$"],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,-5,0]); 
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','northeast')
    
subplot(3,1,2)
plot(vins_Vxyz(:,1),vins_Vxyz(:,3),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vxyz(:,1),gt_Vxyz(:,3),'b--','LineWidth',2)
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(["$v_y$","$ (cm/s)$"],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,-5,0]); 
set(gca,'FontSize',xyzsize)


subplot(3,1,3)
plot(vins_Vxyz(:,1),vins_Vxyz(:,4),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vxyz(:,1),gt_Vxyz(:,4),'b--','LineWidth',2)
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(["$v_z$","$ (cm/s)$"],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,-5.0,0]); 
set(gca,'FontSize',xyzsize)


set(gcf,'color','w');

exportgraphics(h,'Vxyz_closest.png') 
%%
clc
mean(abs(vins_Vxyz(:,1)-gt_Vxyz(:,1)))
mean(abs(vins_Vxyz(:,2)-gt_Vxyz(:,2)))
mean(abs(vins_Vxyz(:,3)-gt_Vxyz(:,3)))
mean(abs(vins_Vxyz(:,4)-gt_Vxyz(:,4)))

std(abs(vins_Vxyz(:,2)-gt_Vxyz(:,2)))
std(abs(vins_Vxyz(:,3)-gt_Vxyz(:,3)))
std(abs(vins_Vxyz(:,4)-gt_Vxyz(:,4)))
%%
Lvins = length(rpy_vins);
vins_Vrpy(:,1) = (rpy_vins(2:Lvins,1)+rpy_vins(1:Lvins-1,1))/2;
vins_Vrpy(:,2:4) = (rpy_vins(2:Lvins,2:4)-rpy_vins(1:Lvins-1,2:4))./(rpy_vins(2:Lvins,1)-rpy_vins(1:Lvins-1,1));

Lgt = length(rpy_gt_match);
clear gt_Vrpy
gt_Vrpy(:,1) = (rpy_gt_match(2:Lgt,1)+rpy_gt_match(1:Lgt-1,1))/2;
gt_Vrpy(:,2:4) = (rpy_gt_match(2:Lgt,2:4)-rpy_gt_match(1:Lgt-1,2:4))./(rpy_gt_match(2:Lgt,1)-rpy_gt_match(1:Lgt-1,1));


labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);

subplot(3,1,1)
plot(vins_Vrpy(:,1),vins_Vrpy(:,2),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vrpy(:,1),gt_Vrpy(:,2),'b--','LineWidth',2)
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(["$w_{\phi}$","$(^{\circ}/s)$"],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,-24,0]); 
set(gca,'FontSize',xyzsize)

    
subplot(3,1,2)
plot(vins_Vrpy(:,1),vins_Vrpy(:,3),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vrpy(:,1),gt_Vrpy(:,3),'b--','LineWidth',2)

xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(["$w_{\theta}$","$(^{\circ}/s)$"],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,-7,0]); 
set(gca,'FontSize',xyzsize)


subplot(3,1,3)
plot(vins_Vrpy(:,1),vins_Vrpy(:,4),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vrpy(:,1),gt_Vrpy(:,4),'b--','LineWidth',2)

xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(["$w_{\psi}$","$(^{\circ}/s)$"],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,-13,0]); 
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

set(gcf,'color','w');

exportgraphics(h,'Wrpy_closest.png') 
%%
clc
mean(abs(vins_Vrpy(:,1)-gt_Vrpy(:,1)))
mean(abs(vins_Vrpy(:,2)-gt_Vrpy(:,2)))
mean(abs(vins_Vrpy(:,3)-gt_Vrpy(:,3)))
mean(abs(vins_Vrpy(:,4)-gt_Vrpy(:,4)))

std(abs(vins_Vrpy(:,2)-gt_Vrpy(:,2)))
std(abs(vins_Vrpy(:,3)-gt_Vrpy(:,3)))
std(abs(vins_Vrpy(:,4)-gt_Vrpy(:,4)))
%%
trj = vins;
L = length(trj);
r_xyz = zeros(L-1,3);
r_rpy = zeros(L-1,3);
for i = 1:L-1
    T1= eye(4);
    T2= eye(4);
    T1(1:3,1:3) = quat2rotm([trj(i,8),trj(i,5:7)]);
    T1(1:3,4) =(trj(i,2:4))';
    T2(1:3,1:3) = quat2rotm([trj(i+1,8),trj(i+1,5:7)]);
    T2(1:3,4) =(trj(i+1,2:4))';
    T12 = T1\T2;
    r_xyz(i,:) = T12(1:3,4);
    r_rpy(i,:) = rotm2eul(T12(1:3,1:3))*180/pi;
end

r_vins = [vins(2:L,1),r_xyz];
r_vinsEul = [vins(2:L,1),r_rpy];

trj = gt_match;
L = length(trj);
r_xyz = zeros(L-1,3);
r_rpy = zeros(L-1,3);
for i = 1:L-1
    T1= eye(4);
    T2= eye(4);
    T1(1:3,1:3) = quat2rotm([trj(i,8),trj(i,5:7)]);
    T1(1:3,4) =(trj(i,2:4))';
    T2(1:3,1:3) = quat2rotm([trj(i+1,8),trj(i+1,5:7)]);
    T2(1:3,4) =(trj(i+1,2:4))';
    T12 = T1\T2;
    r_xyz(i,:) = T12(1:3,4);
    r_rpy(i,:) = rotm2eul(T12(1:3,1:3))*180/pi;
end

r_gt = [trj(2:L,1),r_xyz];
r_gtEul = [trj(2:L,1),r_rpy];
%%
mean( abs((r_vinsEul(:,2)-r_gtEul(:,2))) )
mean( abs((r_vinsEul(:,3)-r_gtEul(:,3))) )
mean( abs((r_vinsEul(:,4)-r_gtEul(:,4))) )

std( abs((r_vinsEul(:,2)-r_gtEul(:,2))) )
std( abs((r_vinsEul(:,3)-r_gtEul(:,3))) )
std( abs((r_vinsEul(:,4)-r_gtEul(:,4))) )
%%
mean( abs((r_vins(:,2)-r_gt(:,2))) )
mean( abs((r_vins(:,3)-r_gt(:,3))) )
mean( abs((r_vins(:,4)-r_gt(:,4))) )

std( abs((r_vins(:,2)-r_gt(:,2))) )
std( abs((r_vins(:,3)-r_gt(:,3))) )
std( abs((r_vins(:,4)-r_gt(:,4))) )

%%
labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);

subplot(3,1,1)
plot(r_vinsEul(:,1),r_vinsEul(:,2),'r','LineWidth',2)
grid minor,hold on
plot(r_gtEul(:,1),r_gtEul(:,2),'b--','LineWidth',2)
hold on;bar(r_vinsEul(:,1),10.5*(r_vinsEul(:,2)-r_gtEul(:,2)))
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(['$\phi (^{\circ})$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,0,0]); 
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')
    
subplot(3,1,2)
plot(r_vinsEul(:,1),r_vinsEul(:,3),'r','LineWidth',2)
grid minor,hold on
plot(r_gtEul(:,1),r_gtEul(:,3),'b--','LineWidth',2)
hold on;bar(r_vinsEul(:,1),10.5*(r_vinsEul(:,3)-r_gtEul(:,3)))
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(['$\theta (^{\circ})$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,0,0]); 
set(gca,'FontSize',xyzsize)


subplot(3,1,3)
plot(r_vinsEul(:,1),r_vinsEul(:,4),'r','LineWidth',2)
grid minor,hold on
plot(r_gtEul(:,1),r_gtEul(:,4),'b--','LineWidth',2)
hold on;bar(r_vinsEul(:,1),10.5*(r_vinsEul(:,4)-r_gtEul(:,4)))

xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(['$\psi (^{\circ})$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,0,0]); 
set(gca,'FontSize',xyzsize)


set(gcf,'color','w');

exportgraphics(h,'angle_Rcloset.png') 
%%

labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);

subplot(3,1,1)
plot(r_vins(:,1),r_vins(:,2),'r','LineWidth',2)
grid minor,hold on
plot(r_gt(:,1),r_gt(:,2),'b--','LineWidth',2)
hold on;bar(r_vins(:,1),10.5*(r_vins(:,2)-r_gt(:,2)))
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(['$x (cm)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,0,0]); 
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')
    
subplot(3,1,2)
plot(r_vins(:,1),r_vins(:,3),'r','LineWidth',2)
grid minor,hold on
plot(r_gt(:,1),r_gt(:,3),'b--','LineWidth',2)
hold on;bar(r_vins(:,1),10.5*(r_vins(:,3)-r_gt(:,3)))

xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(['$y (cm)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,-0,0]); 
set(gca,'FontSize',xyzsize)


subplot(3,1,3)
plot(r_vins(:,1),r_vins(:,4),'r','LineWidth',2)
grid minor,hold on
plot(r_gt(:,1),r_gt(:,4),'b--','LineWidth',2)
hold on;bar(r_vins(:,1),10.5*(r_vins(:,4)-r_gt(:,4)))

xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
yl = ylabel(['$z (cm)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold');
set(get(gca,'YLabel'),'Rotation',0)
set(yl, 'position', get(yl,'position')+[-1,0,0]); 
set(gca,'FontSize',xyzsize)

set(gcf,'color','w');

exportgraphics(h,'xyz_Rclosest.png') 
%%
rpy_vins = r_vinsEul;
rpy_gt = r_gtEul;
Lvins = length(rpy_vins);
clear vins_Vrpy
vins_Vrpy(:,1) = (rpy_vins(2:Lvins,1)+rpy_vins(1:Lvins-1,1))/2;
vins_Vrpy(:,2:4) = (rpy_vins(2:Lvins,2:4)-rpy_vins(1:Lvins-1,2:4))./(rpy_vins(2:Lvins,1)-rpy_vins(1:Lvins-1,1));

Lgt = length(rpy_gt);
clear gt_Vrpy
gt_Vrpy(:,1) = (rpy_gt(2:Lgt,1)+rpy_gt(1:Lgt-1,1))/2;
gt_Vrpy(:,2:4) = (rpy_gt(2:Lgt,2:4)-rpy_gt(1:Lgt-1,2:4))./(rpy_gt(2:Lgt,1)-rpy_gt(1:Lgt-1,1));


labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);

subplot(3,1,1)
plot(vins_Vrpy(:,1),vins_Vrpy(:,2),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vrpy(:,1),gt_Vrpy(:,2),'b--','LineWidth',2)
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
ylabel(["Velocity ","(degree/s)"],'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
% legend("Estimate","Groundtruth",'Location','southeast')
    
subplot(3,1,2)
plot(vins_Vrpy(:,1),vins_Vrpy(:,3),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vrpy(:,1),gt_Vrpy(:,3),'b--','LineWidth',2)
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
ylabel(["Velocity ","(degree/s)"],'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
% legend("Estimate","Groundtruth",'Location','southeast')

subplot(3,1,3)
plot(vins_Vrpy(:,1),vins_Vrpy(:,4),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vrpy(:,1),gt_Vrpy(:,4),'b--','LineWidth',2)
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
ylabel(["Velocity ","(degree/s)"],'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
% legend("Estimate","Groundtruth",'Location','southeast')

set(gcf,'color','w');

exportgraphics(h,'Wrpy_r.png') 

%%
clear vins_Vxyz
clear gt_Vxyz
Lvins = length(r_vins);
vins_Vxyz(:,1) = (vins(2:Lvins+1,1)+vins(1:Lvins,1))/2;
vins_Vxyz(:,2:4) = r_vins(:,2:4)./(vins(2:Lvins+1,1)-vins(1:Lvins,1));

Lgt = length(r_gt);
gt_Vxyz(:,1) = (gt_match(2:Lgt+1,1)+gt_match(1:Lgt,1))/2;
gt_Vxyz(:,2:4)= r_gt(:,2:4)./(gt_match(2:Lgt+1,1)-gt_match(1:Lgt,1));

labelsize = 20;
titleszie = 24;
xyzsize = 24;
h = figure('units','normalized','outerposition',[0 0 0.7 1]);

subplot(3,1,1)
plot(vins_Vxyz(:,1),vins_Vxyz(:,2),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vxyz(:,1),gt_Vxyz(:,2),'b--','LineWidth',2)

xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
ylabel("V x (cm/s)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
% legend("Estimate","Groundtruth",'Location','northeast')
    
subplot(3,1,2)
plot(vins_Vxyz(:,1),vins_Vxyz(:,3),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vxyz(:,1),gt_Vxyz(:,3),'b--','LineWidth',2)
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
ylabel("V y (cm/s)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
% legend("Estimate","Groundtruth",'Location','southeast')

subplot(3,1,3)
plot(vins_Vxyz(:,1),vins_Vxyz(:,4),'r','LineWidth',2)
grid minor,hold on
plot(gt_Vxyz(:,1),gt_Vxyz(:,4),'b--','LineWidth',2)
xlabel(['$t (s)$'],'interpreter','latex','FontSize',labelsize,'FontWeight','bold')
ylabel("V z (cm/s)",'FontSize',labelsize,'FontWeight','bold')
set(gca,'FontSize',xyzsize)
legend("Estimate","Groundtruth",'Location','southeast')

set(gcf,'color','w');

exportgraphics(h,'Vxyz_r.png') 