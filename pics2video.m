wspace = '/Users/jin/eight_villa/';

imageNames = dir(fullfile(wspace,'cam0/1*.png'));
imageNames = {imageNames.name}';
outputVideo = VideoWriter(fullfile(wspace,'SevenLeftCam'), 'MPEG-4');
% outputVideo.FrameRate = shuttleVideo.FrameRate;
open(outputVideo)

for ii = 1:length(imageNames)
    100*ii/length(imageNames)
   img = imread(fullfile(wspace,'cam0/',imageNames{ii}));
   img = imresize(img,.3);
   writeVideo(outputVideo,img)
end


close(outputVideo)
%%
ddd1 = importdata("/Users/jin/output/vio.csv");
figure ,plot3(ddd1(:,2),ddd1(:,3),ddd1(:,4),'g.','LineWidth',1),axis equal,grid minor

ddd1 = importdata("/Users/jin/output/vio_Tglobal.csv");
ddd1 = ddd1(:,2:4)*eul2rotm([-pi/2,0,0]);
hold on ,plot3(ddd1(:,1),ddd1(:,2),ddd1(:,3),'r.','LineWidth',1),axis equal,grid minor

axis equal
%%

ddd1 = importdata("/Users/jin/vio.csv");
hold on,
patch(ddd1(:,2),-ddd1(:,3),ddd1(:,4),ddd1(:,1),'edgecolor','flat','facecolor','none','LineWidth',3)
grid minor
view(3);colorbar
axis equal
set(gcf,'color','w');


xlabel("X (m)",'FontSize',20,'FontWeight','bold');
ylabel("Y (m)",'FontSize',20,'FontWeight','bold');
zlabel("Z (m)",'FontSize',20,'FontWeight','bold');