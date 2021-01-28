clear
close all

fx = 212.7505;
fy = 212.7505;
skew = 0;
cy = 126.4288;
cx = 95.6402;
%%
depth_mean = zeros(52,1);
depth_std = zeros(52,1);

for i = 1:52
    i
    depth_path = [ '/Volumes/Extreme_LQ/testTraj_ipad_rgbdi/std_vs_mean/linear',num2str(i),'/FramesDpt.depth'];
    fff = fopen(depth_path);
    A2 =[];
    A2 = fread(fff,'float');
    totalImage = length(A2)/(192*256);
    A2  = reshape(A2,[256,192,totalImage]);
    b = A2(128,96,120:totalImage-120);
    b = reshape(b,[length(b),1]);
    depth_mean(i) = mean(b);
    depth_std(i) = std(b);
end
%%
titleSize =50
labelSize =30
xyzsize = 40
% figure,pt1 = plot(depth_mean,'r','LineWidth',5),grid minor

h = figure('units','normalized','outerposition',[0 0 1 1]);
pt1 = plot(depth_mean,1000*depth_std,'o','Color',[0.8500, 0.3250, 0.0980],'LineWidth',5)


% hold on,plot(depth_mean,1000*depth_std,'Color',[0.8500, 0.3250, 0.0980],'LineWidth',5),grid minor
p1=fit(depth_mean,1000*depth_std,'poly1')
hold on, pt2 = plot(depth_mean,p1(depth_mean),'Color',[0, 0.4470, 0.7410],'LineWidth',5)

p2=fit(depth_mean,1000*depth_std,'poly2')
hold on, pt3 = plot(depth_mean,p2(depth_mean),'Color',[0.4660, 0.6740, 0.1880],'LineWidth',5)

grid minor
% title("std vs depth measurement",'FontSize',titleSize,'FontWeight','bold')
xlabel("distance (m)",'FontSize',labelSize,'FontWeight','bold')
y=ylabel("standard deviation (mm)",'FontSize',labelSize,'FontWeight','bold');
set(gca,'FontSize',xyzsize)
set(gcf,'color','w');

legend([pt1 pt2 pt3],{'Raw Data','Fitted Curve N =1','Fitted Curve N =2'},'FontSize',30,'Location','southeast')
exportgraphics(h,'std.png') 

%%
% gt = 1:52;
% gt = 0.1*gt'+0.1+0.06;

gt = 1:48;
gt = 0.1*gt;
h = figure('units','normalized','outerposition',[0 0 1 1]);
% error = abs(depth_mean - gt)*1000;
error = dd(:,2);
bar(gt,error)
grid minor
xlim([0,5])
xlabel("distance (m)",'FontSize',labelSize,'FontWeight','bold')
y=ylabel("mean absolute error (mm)",'FontSize',labelSize,'FontWeight','bold');
set(gca,'FontSize',xyzsize)
set(gcf,'color','w');
exportgraphics(h,'meanE.png') 

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