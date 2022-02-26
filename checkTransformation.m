ddd = importdata("/Users/jin/Downloads/t265_tum/data.csv");
ddd=ddd(1:4:5095,:);
xyz = zeros(floor(5095/4),4);
for i = 1:floor(5095/4)
    Tpre = eye(4);
%     Tpre(1:3, 1:3) = quat2rotm([ddd(i,8),ddd(i,5),ddd(i,6),ddd(i,7) ]);
    Tpre(1:3, 1:3) = quat2rotm([ddd(i,5),ddd(i,6),ddd(i,7),ddd(i,8) ]);
    Tpre(1:3, 4) = [ddd(i,2),ddd(i,3),ddd(i,4) ]';
    
    Tcur = eye(4);
%     Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,8),ddd(i+1,5),ddd(i+1,6),ddd(i+1,7) ]);
    Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,5),ddd(i+1,6),ddd(i+1,7),ddd(i+1,8) ]);
    Tcur(1:3, 4) = [ddd(i+1,2),ddd(i+1,3),ddd(i+1,4) ]';
    
    Tprecur = (Tpre)\Tcur;
    xyz(i,2:4) = Tprecur(1:3, 4);
    xyz(i,1) = ddd(i,1)/1e9;
end
mean(1./(xyz(2:301,1)-xyz(1:300,1)))
figure,
p1= plot(xyz(:,1),vecnorm(xyz(:,2:4)'),'LineWidth',3);



ddd = importdata("/Users/jin/Downloads/ORB-SLAM3-FrameTrajectory.txt");
xyz = zeros(length(ddd)-1,4);
for i = 1:length(ddd)-1
    Tpre = eye(4);
    Tpre(1:3, 1:3) = quat2rotm([ddd(i,8),ddd(i,5),ddd(i,6),ddd(i,7) ]);
%     Tpre(1:3, 1:3) = quat2rotm([ddd(i,8),ddd(i,5),ddd(i,6),ddd(i,7) ]);
    Tpre(1:3, 1:3) = quat2rotm([ddd(i,5),ddd(i,6),ddd(i,7),ddd(i,8) ]);
    Tpre(1:3, 4) = [ddd(i,2),ddd(i,3),ddd(i,4) ]';
    
    Tcur = eye(4);
%     Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,8),ddd(i+1,5),ddd(i+1,6),ddd(i+1,7) ]);
    Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,5),ddd(i+1,6),ddd(i+1,7),ddd(i+1,8) ]);
    Tcur(1:3, 4) = [ddd(i+1,2),ddd(i+1,3),ddd(i+1,4) ]';
    
    Tprecur = (Tpre)\Tcur;
    xyz(i,2:4) = Tprecur(1:3, 4);
    xyz(i,1) = ddd(i,1);
end
mean(1./(xyz(2:301,1)-xyz(1:300,1)))
hold on
p2= plot(xyz(:,1),vecnorm(xyz(:,2:4)'),'LineWidth',3);
grid minor
set(gca,'FontSize',20)
ylabel("m",'FontSize',20,'FontWeight','bold')
xlabel("timestamp (s)",'FontSize',20,'FontWeight','bold')
legend([p1 p2],{'groundtruth','orbslam'},'FontSize',30)
%%
ddd = importdata("/Users/jin/Downloads/t265_tum/data.csv");
ddd=ddd(1:4:5095,:);
xyz = zeros(floor(5095/4),4);
for i = 1:floor(5095/4)
    Tpre = eye(4);
%     Tpre(1:3, 1:3) = quat2rotm([ddd(i,8),ddd(i,5),ddd(i,6),ddd(i,7) ]);
    Tpre(1:3, 1:3) = quat2rotm([ddd(i,5),ddd(i,6),ddd(i,7),ddd(i,8) ]);
    Tpre(1:3, 4) = [ddd(i,2),ddd(i,3),ddd(i,4) ]';
    
    Tcur = eye(4);
%     Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,8),ddd(i+1,5),ddd(i+1,6),ddd(i+1,7) ]);
    Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,5),ddd(i+1,6),ddd(i+1,7),ddd(i+1,8) ]);
    Tcur(1:3, 4) = [ddd(i+1,2),ddd(i+1,3),ddd(i+1,4) ]';
    
    Tprecur = (Tpre)\Tcur;
    xyz(i,2:4) = Tprecur(1:3, 4);
    xyz(i,1) = ddd(i,1)/1e9;
end
mean(1./(xyz(2:301,1)-xyz(1:300,1)))
figure,
p1= plot(xyz(:,1),vecnorm(xyz(:,2:4)'),'LineWidth',3);



ddd = importdata("/Users/jin/Downloads/vins_result_no_loop.csv");
xyz = zeros(length(ddd)-1,4);
for i = 1:length(ddd)-1
    Tpre = eye(4);
    Tpre(1:3, 1:3) = quat2rotm([ddd(i,8),ddd(i,5),ddd(i,6),ddd(i,7) ]);
    Tpre(1:3, 4) = [ddd(i,2),ddd(i,3),ddd(i,4) ]';
    
    Tcur = eye(4);
    Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,8),ddd(i+1,5),ddd(i+1,6),ddd(i+1,7) ]);
    Tcur(1:3, 4) = [ddd(i+1,2),ddd(i+1,3),ddd(i+1,4) ]';
    
    Tprecur = (Tpre)\Tcur;
    xyz(i,2:4) = Tprecur(1:3, 4);
    xyz(i,1) = ddd(i,1)/1e9;
end
mean(1./(xyz(2:301,1)-xyz(1:300,1)))
hold on
p2= plot(xyz(:,1),vecnorm(xyz(:,2:4)'),'LineWidth',3);
grid minor
set(gca,'FontSize',20)
ylabel("m",'FontSize',20,'FontWeight','bold')
xlabel("timestamp (s)",'FontSize',20,'FontWeight','bold')
legend([p1 p2],{'groundtruth','VINS'},'FontSize',30)
%%
ddd = importdata("/Users/jin/Downloads/t265_tum/data.csv");
ddd=ddd(1:4:5095,:);
xyz = zeros(floor(5095/4),4);
for i = 1:floor(5095/4)
    Tpre = eye(4);
%     Tpre(1:3, 1:3) = quat2rotm([ddd(i,8),ddd(i,5),ddd(i,6),ddd(i,7) ]);
    Tpre(1:3, 1:3) = quat2rotm([ddd(i,5),ddd(i,6),ddd(i,7),ddd(i,8) ]);
    Tpre(1:3, 4) = [ddd(i,2),ddd(i,3),ddd(i,4) ]';
    
    Tcur = eye(4);
%     Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,8),ddd(i+1,5),ddd(i+1,6),ddd(i+1,7) ]);
    Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,5),ddd(i+1,6),ddd(i+1,7),ddd(i+1,8) ]);
    Tcur(1:3, 4) = [ddd(i+1,2),ddd(i+1,3),ddd(i+1,4) ]';
    
    Tprecur = (Tpre)\Tcur;
    xyz(i,2:4) = Tprecur(1:3, 4);
    xyz(i,1) = ddd(i,1)/1e9;
end
mean(1./(xyz(2:301,1)-xyz(1:300,1)))
figure,
p1= plot(xyz(:,1),vecnorm(xyz(:,2:4)'),'LineWidth',3);


fisheye = "/Users/jin/Desktop/Dreame/Code/frontend_analysis/output/tum_angle";
[d_ts,d_ls,d_tk,d_ba] = loadData(fisheye);
mean(1./(d_ts(2:301,1)-d_ts(1:300,1)))
hold on
% p2= plot(d_ts(:,1),d_ba(:,12)*80,'LineWidth',3);
p2= plot(d_ts(:,1),d_ba(:,5)*1.5,'LineWidth',3);
grid minor
set(gca,'FontSize',20)
ylabel("m",'FontSize',20,'FontWeight','bold')
xlabel("timestamp (s)",'FontSize',20,'FontWeight','bold')
legend([p1 p2],{'groundtruth','angle 1.5X'},'FontSize',30)
%%
ddd = importdata("/Users/jin/Downloads/t265_tum/data.csv");
ddd=ddd(1:4:5095,:);
xyz = zeros(floor(5095/4),4);
for i = 1:floor(5095/4)
    Tpre = eye(4);
    Tpre(1:3, 1:3) = quat2rotm([ddd(i,8),ddd(i,5),ddd(i,6),ddd(i,7) ]);
    Tpre(1:3, 4) = [ddd(i,2),ddd(i,3),ddd(i,4) ]';
    
    Tcur = eye(4);
    Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,8),ddd(i+1,5),ddd(i+1,6),ddd(i+1,7) ]);
    Tcur(1:3, 4) = [ddd(i+1,2),ddd(i+1,3),ddd(i+1,4) ]';
    
    Tprecur = (Tpre)\Tcur;
    xyz(i,2:4) = Tprecur(1:3, 4);
    xyz(i,1) = ddd(i,1)/1e9;
end
mean(1./(xyz(2:301,1)-xyz(1:300,1)))
figure,
p1= plot(xyz(:,1),vecnorm(xyz(:,2:4)'),'LineWidth',3);


fisheye = "/Users/jin/Desktop/Dreame/Code/frontend_analysis/output/tum_pixel";
[d_ts,d_ls,d_tk,d_ba] = loadData(fisheye);
mean(1./(d_ts(2:301,1)-d_ts(1:300,1)))
hold on
% p2= plot(d_ts(:,1),d_ba(:,12)*80,'LineWidth',3);
p2= plot(d_ts(:,1),d_ba(:,5)*1.4,'LineWidth',3);
grid minor
set(gca,'FontSize',20)
ylabel("m",'FontSize',20,'FontWeight','bold')
xlabel("timestamp (s)",'FontSize',20,'FontWeight','bold')
legend([p1 p2],{'groundtruth','angle 1.4X'},'FontSize',30)
%%
%% translation
ddd = importdata("/Users/jin/Downloads/t265_tum/data.csv");
ddd=ddd(1:4:5095,:);
xyz = zeros(floor(5095/4),4);
for i = 1:floor(5095/4)
    Tpre = eye(4);
%     Tpre(1:3, 1:3) = quat2rotm([ddd(i,8),ddd(i,5),ddd(i,6),ddd(i,7) ]);
    Tpre(1:3, 1:3) = quat2rotm([ddd(i,5),ddd(i,6),ddd(i,7),ddd(i,8) ]);
    Tpre(1:3, 4) = [ddd(i,2),ddd(i,3),ddd(i,4) ]';
    
    Tcur = eye(4);
%     Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,8),ddd(i+1,5),ddd(i+1,6),ddd(i+1,7) ]);
    Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,5),ddd(i+1,6),ddd(i+1,7),ddd(i+1,8) ]);
    Tcur(1:3, 4) = [ddd(i+1,2),ddd(i+1,3),ddd(i+1,4) ]';
    
    Tprecur = (Tpre)\Tcur;
    xyz(i,2:4) = Tprecur(1:3, 4);
    xyz(i,1) = ddd(i,1)/1e9;
end
% mean(1./(xyz(2:301,1)-xyz(1:300,1)))
h = figure('units','normalized','outerposition',[0 0 1 1]);

p1= plot(xyz(:,1),vecnorm(xyz(:,2:4)'),'LineWidth',3);
trans_gt = [xyz(:,1),vecnorm(xyz(:,2:4)')'];

fisheye = "/Users/jin/Desktop/Dreame/Code/frontend_analysis/output/";
[d_ts,d_ls,d_tk,d_ba] = loadData(fisheye);
hold on
p3= plot(d_ts(:,1),d_ba(:,19),'LineWidth',3);
trans_mono = [d_ts(:,1),d_ba(:,19)];


fisheye = "/Users/jin/Desktop/Dreame/Code/frontend_analysis/output/tumEEE";
[d_ts,d_ls,d_tk,d_ba] = loadData(fisheye);
% mean(1./(d_ts(2:301,1)-d_ts(1:300,1)))
hold on
p2= plot(d_ts(:,1),d_ba(:,19),':','LineWidth',3);
trans_stereoOnly = [d_ts(:,1),d_ba(:,19)];

A = repmat(trans_gt(:,1),[1 length(trans_stereoOnly(:,1))]);
[minValue,gtclosestIndex] = min(abs(A-trans_stereoOnly(:,1)'));
trans_gt_match = trans_gt(gtclosestIndex,:);

error_mono = mean(abs(trans_gt_match(:,2) - trans_mono(:,2)));
error_monoPP = 100*mean(abs(trans_gt_match(:,2) - trans_mono(:,2))./trans_gt_match(:,2));

error_stereo = mean(abs(trans_gt_match(:,2) - trans_stereoOnly(:,2)));
error_stereoPP = 100*mean(abs(trans_gt_match(:,2) - trans_stereoOnly(:,2))./trans_gt_match(:,2));

grid minor
set(gca,'FontSize',20)
ylabel("translation norm (m)",'FontSize',30,'FontWeight','bold')
xlabel("timestamp (s)",'FontSize',30,'FontWeight','bold')
legend([p1 p3 p2],{'groundtruth','mono','stereo'},'FontSize',30)
title("Error Function: Raw Pixel; RPE Mono: "+num2str(error_mono)+" "+num2str(error_monoPP)+"%, Stereo: " +num2str(error_stereo)+" "+num2str(error_stereoPP)+"%",'FontSize',32,'FontWeight','bold')
set(gca,'color','w');
set(gcf,'color','w');
% exportgraphics(h,'/Users/jin/Desktop/Dreame/Code/frontend_analysis/output/trans_pixel_only.png') 
%%
%% rotation
% clc
% close all
clear
ddd = importdata("/Users/jin/Downloads/t265_tum/data.csv");
ddd=ddd(1:4:5095,:);
xyz = zeros(floor(5095/4),2);
quatGT = zeros(floor(5095/4),4); 
for i = 1:floor(5095/4)
    Tpre = eye(4);
%     Tpre(1:3, 1:3) = quat2rotm([ddd(i,8),ddd(i,5),ddd(i,6),ddd(i,7) ]);
    Tpre(1:3, 1:3) = quat2rotm([ddd(i,5),ddd(i,6),ddd(i,7),ddd(i,8) ]);
    Tpre(1:3, 4) = [ddd(i,2),ddd(i,3),ddd(i,4) ]';
    
    Tcur = eye(4);
%     Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,8),ddd(i+1,5),ddd(i+1,6),ddd(i+1,7) ]);
    Tcur(1:3, 1:3) = quat2rotm([ddd(i+1,5),ddd(i+1,6),ddd(i+1,7),ddd(i+1,8) ]);
    Tcur(1:3, 4) = [ddd(i+1,2),ddd(i+1,3),ddd(i+1,4) ]';
    
    Tprecur = (Tpre)\Tcur;
    axang = rotm2axang(Tprecur(1:3,1:3));
    quatGT(i,:) = rotm2quat(Tprecur(1:3,1:3));
    xyz(i,2) = axang(4)*180/pi;
    xyz(i,1) = ddd(i,1)/1e9;
end
h = figure('units','normalized','outerposition',[0 0 1 1]);
angle_gt = [xyz(:,1),xyz(:,2)];
p1= plot(angle_gt(:,1),angle_gt(:,2)-angle_gt(:,2),'LineWidth',3);

%
fisheye = "/Users/jin/Desktop/Dreame/Code/frontend_analysis/output/"; % tum_unitOne %tum_angle
[d_ts,d_ls,d_tk,d_ba] = loadData(fisheye);
% mean(1./(d_ts(2:301,1)-d_ts(1:300,1)))

axis_ang = quat2axang(d_ba(:,23:26));
angle_stereo =[d_ts, axis_ang(:,4)*180/pi];
axis_ang = quat2axang(d_ba(:,9:12));
angle_mono =[d_ts, axis_ang(:,4)*180/pi];
A = repmat(angle_gt(:,1),[1 length(angle_mono(:,1))]);
[minValue,gtclosestIndex] = min(abs(A-angle_mono(:,1)'));
angle_gt_match = angle_gt(gtclosestIndex,:);

% mean(angle_gt_match(:,1) - angle_mono(:,1))
error_mono = mean(abs(angle_gt_match(:,2) - angle_mono(:,2)));
error_stereo = mean(abs(angle_gt_match(:,2) - angle_stereo(:,2)));

error_monoPP = 100*mean(abs(angle_gt_match(:,2) - angle_mono(:,2))./angle_gt_match(:,2));
error_stereoPP = 100*mean(abs(angle_gt_match(:,2) - angle_stereo(:,2))./angle_gt_match(:,2));


d_pce = importdata("/Users/jin/Desktop/Dreame/Code/frontend_analysis/output/pce2d2d.txt");
axis_ang = quat2axang(d_pce(:,4:7));
axis_ang(axis_ang(:,4)>3,4)=axis_ang(axis_ang(:,4)>3,4)-pi;
axis_ang(axis_ang(:,4)<-3,4)=axis_ang(axis_ang(:,4)<-3,4)+pi;
angle_pce =[d_ts, axis_ang(:,4)*180/pi];
error_pce = mean(abs(angle_gt_match(:,2) - angle_pce(:,2)));
error_pcePP = 100*mean(abs(angle_gt_match(:,2) - angle_pce(:,2))./angle_gt_match(:,2));

hold on
p4= plot(angle_pce(:,1),abs(angle_gt_match(:,2) - angle_pce(:,2)),'g','LineWidth',3);

hold on
p2= plot(angle_mono(:,1),abs(angle_gt_match(:,2) - angle_mono(:,2)),'r','LineWidth',3);
hold on
p3= plot(angle_stereo(:,1),abs(angle_gt_match(:,2) - angle_stereo(:,2)),'c:','LineWidth',3);


% quatGT = quatGT(gtclosestIndex,:);
% errorAngle = zeros(length(quatGT),1);
% angle_monoQ = zeros(length(quatGT),1);
% for i = 1:length(quatGT)
%     errorM = quat2rotm(quatGT(i,:))*quat2rotm(d_ba(i,23:26))';
%     axis_ang = rotm2axang(errorM);
%     angle_monoQ(i) =axis_ang(4)*180/pi;
% end
% hold on
% p4= plot(angle_mono(:,1),angle_monoQ,'r:','LineWidth',3);

grid minor
set(gca,'FontSize',20)
ylabel("axis angle (degree)",'FontSize',30,'FontWeight','bold')
xlabel("timestamp (s)",'FontSize',30,'FontWeight','bold')
legend([p1 p2 p3 p4],{'groundtruth','mono','stereo','pce'},'FontSize',30)
title("Error Function: Raw Pixel RPE (Angle)"," PCE: "+num2str(error_pce)+" "+num2str(error_pcePP)+"%, Mono: "+num2str(error_mono)+" "+num2str(error_monoPP)+"%, Stereo: " +num2str(error_stereo)+" "+num2str(error_stereoPP)+"%",'FontSize',35,'FontWeight','bold')
set(gca,'color','w');
set(gcf,'color','w');



% exportgraphics(h,'output/rotation_rawPixel_tum.png') 