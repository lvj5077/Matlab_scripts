pc_top = pcread('/Volumes/BlackSSD/drone_04_2021/drone_4_15/4/merge.ply');
% pc_traj = pcread("/Volumes/BlackSSD/drone_04_2021/drone_4_15/4/2021-04-15T18-23-03_top/pcTraj.ply");

%%
ptCloud2 = pcdownsample(ptCloud2,'gridAverage',0.1);
all_pc = pcmerge(all_pc,ptCloud2,0.001);
% pcwrite(all_pc,"/Volumes/BlackSSD/drone_04_2021/drone_4_15/4/merge2.ply")
figure, pcshow(all_pc)
xlabel("X")
ylabel("Y")
zlabel("Z")