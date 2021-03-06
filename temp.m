pc_btm = pcread('/Volumes/BlackSSD/drone_04_2021/drone_4_15/4/2021-04-15T18-23-03_top/pc.ply');
pc_top = pcread('/Volumes/BlackSSD/drone_04_2021/drone_4_15/4/2021-04-15T18-23-04_btm/pc.ply');%trajOnPc

pc_btm_dsp = pcdownsample(pc_btm,'gridAverage',0.1);
pc_top_dsp = pcdownsample(pc_top,'gridAverage',0.1);
%%

%
% T = eye(4);

tform = rigid3d(eul2rotm([0,2,0]*pi/180),[0 -1 -1]);
pc_top_mm = pctransform(pc_top_dsp,tform);

% tform = pcregistericp(pc_top_mm,pc_top);
% pc_top_mm = pctransform(pc_top_mm,tform);

all_pc = pcmerge(pc_btm_dsp,pc_top_mm,0.01);
% pcwrite(all_pc,"/Volumes/BlackSSD/drone_04_2021/drone_4_15/4/merge.ply")
figure, pcshow(all_pc)
xlabel("X")
ylabel("Y")
zlabel("Z")

% pc_top_traj = pcread('/Volumes/BlackSSD/drone_04_2021/drone_4_15/4/2021-04-15T18-23-03_top/traj.ply');
% pc_top_dsp = pcmerge(pc_top_dsp,pc_top_traj,0.01);
% % 
