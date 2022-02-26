clear
ddd1 = importdata("/Users/jin/gps0.txt");
ddd1 = ddd1(ddd1(:,5)<1,:);

% ddd1 = ddd1(( ddd1(:,1)-ddd1(1,1))<700,:);
% ddd1 = ddd1(1:9000,:);
% acc = vecnorm([ddd1(:,5).^0.5,ddd1(:,6).^0.5,ddd1(:,7).^0.5]');
acc = 100*ddd1(:,5).^0.5;
figure,plot(ddd1(:,1)-ddd1(1,1),acc,'LineWidth',3)
hold on,
accZ = 100*ddd1(:,7).^0.5;
plot(ddd1(:,1)-ddd1(1,1),accZ,'LineWidth',3)
grid minor
xlabel("t (s)",'FontSize',20,'FontWeight','bold');
ylabel("XY -Axis Std (cm)",'FontSize',20,'FontWeight','bold');
set(gca,'FontSize',15,'FontWeight','bold')
set(gcf,'color','w');
set(gca,'color','w');
legend({'XY - Axis','Z - Axis'},'FontSize',30)
title("RTK std",'FontSize',25,'FontWeight','bold');
%%
% acc(acc>0.5) = 0.2;
MaxAcc = max(acc);
MinAcc = min(acc);
xxx = linspace(MinAcc,MaxAcc,100);

rrr = linspace(0,1,100);
% ccc = interp1(.5.^xxx,rrr,.5.^acc);
ccc = interp1(xxx,rrr,acc);
% plot(ccc)
%
% plot(1:100,1:100,'o','MarkerFaceColor',[1*bbb,0.5,1*rrr])
xyz_enu = lla2enu(ddd1(1,2:4),ddd1(:,2:4),'ellipsoid');
h = figure('units','normalized','outerposition',[0 0 0.7 1]);
% for i = 1:length(xyz_enu)
%     hold on 
%     plot3(xyz_enu(i,1),xyz_enu(i,2),xyz_enu(i,3),'o','MarkerSize',4,'LineWidth',3,'MarkerEdgeColor',[1*ccc(i),0,1-1*ccc(i)]);
% end

plot3(xyz_enu(:,1),xyz_enu(:,2),xyz_enu(:,3),'LineWidth',3);


grid minor

axis equal
view(0,90)
set(gcf,'color','w');
set(gca,'color','w');

xlabel("X (m)",'FontSize',20,'FontWeight','bold');
ylabel("Y (m)",'FontSize',20,'FontWeight','bold');
zlabel("Z (m)",'FontSize',20,'FontWeight','bold');
%%
% exportgraphics(h,'/Users/jin/Desktop/downstair_all/02/rtk_traj.png') 
xyz_enu = lla2enu(ddd1(1,2:4),ddd1(:,2:4),'ellipsoid');
M=[ddd1(:,1),xyz_enu(:,1),xyz_enu(:,2),zeros(length(xyz_enu(:,1)),5)];
dlmwrite('/Users/jin/xy_enu.txt',M,'precision',16,'Delimiter',' ')
M=[ddd1(:,1),xyz_enu(:,1),xyz_enu(:,2),xyz_enu(:,3),zeros(length(xyz_enu(:,1)),4)];
dlmwrite('/Users/jin/xyz_enu.txt',M,'precision',16,'Delimiter',' ')
