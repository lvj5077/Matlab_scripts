clear
clc
% close all
dist =30;
pointdepth = zeros(256,192,150);
depth_path = "/Volumes/Extreme_LQ/rotateIP12/y_axis/0_00/FramesDpt.depth";
 %     depth_path = [ '/Volumes/Extreme_LQ/testTraj_ipad_rgbdi/std_vs_mean/linear',num2str(dist),'/FramesDpt.depth'];
fff = fopen(depth_path);
A2 =[];
A2 = fread(fff,'float');
totalImage = length(A2)/(192*256);
A2  = reshape(A2,[256,192,totalImage]);
for i = 1:256
    i
    for j = 1:192
   
        d = A2(i,j,totalImage-250:totalImage-101);
        d = reshape(d,[1,length(d)]);
        pointdepth(i,j,:) = d;
    end
end
%%
figure,
% imagesc((pointdepth(120:180,50:100,5) - mean(pointdepth(120:180,50:100,:),3))')
for i = 1:9
    subplot(3,3,i)
    imagesc((pointdepth(120:180,50:100,10*i) - mean(pointdepth(120:180,50:100,:),3))')
end

%%
localrow = reshape(pointdepth(192,1:192,1:150),[192,150]);
localrowMean = (ones(150,1).*mean(pointdepth(192,1:192,:),3))';
figure,imagesc(localrow - localrowMean )
%%
figure,plot((pointdepth(:,10)),pointdepth(:,10)-mean(pointdepth(:,:),2),'r*')
% for i = 1:150
%     hold on,plot((pointdepth(:,i)),pointdepth(:,i)-mean(pointdepth(:,:),2)),'go')
% end

hold on,plot((pointdepth(:,20)),pointdepth(:,20)-mean(pointdepth(:,:),2),'g*')

hold on,plot((pointdepth(:,30)),pointdepth(:,30)-mean(pointdepth(:,:),2),'b*')

hold on,plot((pointdepth(:,40)),pointdepth(:,40)-mean(pointdepth(:,:),2),'m*')
%%
figure,plot(40:120,pointdepth(40:120,30)-mean(pointdepth(40:120,:),2),'r*')
%%
% figure,
% for i = 1:20
%     subplot(10,2,i)
%     plot(pointdepth(i,:)-mean(pointdepth(i,:)))
% end
xxxx=pointdepth(x(2),y(2),:)-mmm(x(2),y(2));
hold on,plot(reshape(xxxx,[150,1]))

xxxx=pointdepth(x(3),y(3),:)-mmm(x(3),y(3));
hold on,plot(reshape(xxxx,[150,1]))

xxxx=pointdepth(x(4),y(4),:)-mmm(x(4),y(4));
hold on,plot(reshape(xxxx,[150,1]))

xxxx=pointdepth(x(5),y(5),:)-mmm(x(5),y(5));
hold on,plot(reshape(xxxx,[150,1]))