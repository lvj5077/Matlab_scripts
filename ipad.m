clear
close all

fx = 212.7505;
fy = 212.7505;
skew = 0;
cy = 126.4288;
cx = 95.6402;

ddL = 21;
depth_mean = zeros(ddL,1);
depth_mean2 = zeros(ddL,1);
depth_std = zeros(ddL,1);
depth_std2 = zeros(ddL,1);
focal_length = zeros(ddL,1);
sampleN = 10;
for i = 1:ddL
    i
%     depth_path = [ '/Volumes/Extreme_LQ/testTraj_ipad_rgbdi/std_vs_mean/linear',num2str(i),'/FramesDpt.depth'];

%     intrin_path = [ '/Users/jin/Q_Mac/data/iphone_extend/iphone12_linearChar/iphone12Ext/linear',num2str(i),'/Frames.txt'];
%     intr = importdata(intrin_path);
%     focal_length = mean(intr(:,3));

    v = VideoReader([ '/Volumes/BlackSSD/iPhoneLidarCheck/6.4-4.4m/linear',num2str(i),'/Frames.m4v']);
%     frameNum = 400;
%     frame = read(v,frameNum);
%     imwrite(frame,['/Users/jin/Q_Mac/data/6.4-4.4m/',num2str(i),'.png'])
    depth_path = [ '/Volumes/BlackSSD/iPhoneLidarCheck/6.4-4.4m/linear',num2str(i),'/FramesDpt.depth'];
    fff = fopen(depth_path);
    A2 =[];
    A2 = fread(fff,'float');
    totalImage = length(A2)/(192*256);
    A2  = 1000*reshape(A2,[256,192,totalImage]);
    b = A2(128,96,totalImage-50-sampleN:totalImage-50);
%     b = A2(128,60,totalImage-50-sampleN:totalImage-50);
    b = reshape(b,[length(b),1]);
    depth_mean(i) = mean(b);
    b = A2(128,96,totalImage-50-sampleN:totalImage-50);
    b = reshape(b,[length(b),1]);
    depth_std(i) = std(b);
    
    
    b = A2(70,104,totalImage-50-sampleN:totalImage-50);
%     b = A2(128,60,totalImage-50-sampleN:totalImage-50);
    b = reshape(b,[length(b),1]);
    depth_mean2(i) = mean(b);
    b = A2(70,104,totalImage-50-sampleN:totalImage-50);
    b = reshape(b,[length(b),1]);
    depth_std2(i) = std(b);
end
% gt = importdata('/Volumes/BlackSSD/iphone12_linearChar/iphone12Ext/gt.txt');
% gt = gt(1:ddL);

gt = 6.4:-.1:4.4;
gt = gt';
step = 1:21;
gt2 = depth_mean2(21);
gt2 = (gt2+2100-step*100)/1000;
gt2 = gt2';
%%
% figure,plot(depth_mean,'.')
% figure,plot(depth_mean2,'.')
% 
% 
% figure,plot(depth_std,'.')
% figure,plot(depth_std2,'.')

gt = [gt;gt2];
depth_mean = [depth_mean;depth_mean2];
depth_std = [depth_std;depth_std2];
%%
% figure,plot(gt,gt,'o'),hold on, plot(gt,depth_mean,'.'),grid minor,title("mean")
% figure,plot(gt,1000*depth_std,'ro'),grid minor,title("std")
% %%
% % clear
% % close all
% 
% fx = 212.7505;
% fy = 212.7505;
% skew = 0;
% cy = 126.4288;
% cx = 95.6402;
% 
% ddL = 10;
% depth_mean2 = zeros(ddL,1);
% depth_std2 = zeros(ddL,1);
% sampleN = 200;
% for i = 1:ddL
%     i
% %     depth_path = [ '/Volumes/Extreme_LQ/testTraj_ipad_rgbdi/std_vs_mean/linear',num2str(i),'/FramesDpt.depth'];
%     depth_path = [ '/Users/jin/Q_Mac/data/iphone_extend/iphone12_linearChar/iphoneEXT2/3to5linear',num2str(i),'/FramesDpt.depth'];
%     fff = fopen(depth_path);
%     A2 =[];
%     A2 = fread(fff,'float');
%     totalImage = length(A2)/(192*256);
%     A2  = reshape(A2,[256,192,totalImage]);
%     b = A2(128,96,totalImage-50-sampleN:totalImage-50);
%     b = reshape(b,[length(b),1]);
%     depth_mean2(i) = mean(b);
%     depth_std2(i) = std(b);
% end
% gt2 = importdata('/Users/jin/Q_Mac/data/iphone_extend/iphone12_linearChar/iphoneEXT2/gt.txt');
% 
% figure,plot(gt2,gt2,'o'),hold on, plot(gt2,depth_mean2,'.'),grid minor,title("mean")
% figure,plot(gt2,1000*depth_std2,'ro'),grid minor,title("std")

titleSize =50
labelSize =30
xyzsize = 40

% figure,pt1 = plot(depth_mean,'r','LineWidth',5),grid minor
% plot(gt,1000*depth_std,'ro'),grid minor,title("std")
h = figure('units','normalized','outerposition',[0 0 1 1]);
pt1 = plot(gt,depth_std,'o','Color',[0.8500, 0.3250, 0.0980],'LineWidth',5)


% % hold on,plot(depth_mean,1000*depth_std,'Color',[0.8500, 0.3250, 0.0980],'LineWidth',5),grid minor
p1=fit(gt(15:end),depth_std(15:end),'poly1')
hold on, pt2 = plot(gt(15:end),p1(gt(15:end)),'Color',[0, 0.4470, 0.7410],'LineWidth',5)

% p2=fit(gt,1000*depth_std,'poly5')
% hold on, pt3 = plot(gt,p2(gt),'Color',[0.4660, 0.6740, 0.1880],'LineWidth',5)

grid minor
% title("std vs depth measurement",'FontSize',titleSize,'FontWeight','bold')
xlabel("distance (m)",'FontSize',labelSize,'FontWeight','bold')
y=ylabel("standard deviation (mm)",'FontSize',labelSize,'FontWeight','bold');
set(gca,'FontSize',xyzsize)
set(gcf,'color','w');
% xlim([4,6])
legend([pt1 pt2],{'Raw Data','Fitted Curve N =1'},'FontSize',30,'Location','northwest')
exportgraphics(h,'std4m6mext.png') 

%
% gt = 1:52;
% gt = 0.1*gt'+0.1+0.06;

% gt = 1:48;
% gt = 0.1*gt;
h = figure('units','normalized','outerposition',[0 0 1 1]);
% error = abs(depth_mean - gt)*1000;
% error = dd(:,2);
% bar(gt,error)
bar(gt,abs(1000*gt-depth_mean))
grid minor
% xlim([4,6])
xlabel("distance (m)",'FontSize',labelSize,'FontWeight','bold')
y=ylabel("mean absolute error (mm)",'FontSize',labelSize,'FontWeight','bold');
set(gca,'FontSize',xyzsize)
set(gcf,'color','w');
exportgraphics(h,'mean4m6mext.png') 

%%
 
% %%
% 
% Z = b;
% [h,w] = size(b);
% u=repmat(1:w,[h,1]);
% v=repmat(1:h,[w,1])';
% 
% X=(Z(:).*(u(:)-cx))/fx;
% Y=(Z(:).*(v(:)-cy))/fy;
% 
% xyzPoints = [X(:),Y(:),Z(:)];
% 
% xyzPoints = xyzPoints(Z(:)~=0,:);
% 
% color_image = imread('/Users/jin/Downloads/untitledfolder/2020-10-15T13-42-48/rgb/723.png');
% color_image = imresize(color_image,192/1440);
% 
% imHcolor3col = reshape(color_image,192*256,3);
% 
% imHcolor3col = imHcolor3col(Z(:)~=0,:);
% % imPotcolor3col = imPotcolor3col(Z(:)~=0,:);
% ptCloud = pointCloud(xyzPoints, 'Color', imHcolor3col); 
% figure,pcshow(ptCloud)