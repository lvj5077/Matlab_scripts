% clear
% clc
% close all
dist =30;
pointdepth = zeros(256,192,250);
% depth_path = "/Users/jin/Q_Mac/data/checkIphoneLidar/viewIverse1/FramesDpt.depth";
depth_path = "/Users/jin/Q_Mac/data/iphone2_18/angles/angle1";
 %     depth_path = [ '/Volumes/Extreme_LQ/testTraj_ipad_rgbdi/std_vs_mean/linear',num2str(dist),'/FramesDpt.depth'];
fff = fopen(depth_path+"/FramesDpt.depth");
A2 =[];
A2 = fread(fff,'float');

totalImage = round(length(A2)/(192*256))-1;
A2  = reshape(A2(1:256*192*totalImage),[256,192,totalImage]);


fff = fopen(depth_path+"/FramesDptcfd.depth");
A1 =[];
A1 = fread(fff,'uint8');
totalImage = length(A1)/(192*256);
A1  = reshape(A1,[256,192,totalImage]);

meanAll = zeros(256,192);
stdAll = zeros(256,192);

meanAll2 = zeros(256,192);

for i = 1:256
%     i
    for j = 1:192
   
        d = A2(i,j,totalImage-350:totalImage-101);
        d = reshape(d,[1,length(d)]);
        pointdepth(i,j,:) = d;
        stdAll(i,j) = std(d');
        meanAll(i,j) = mean(d');
        
        
        
        d2 = A1(i,j,totalImage-350:totalImage-101);
        d2 = reshape(d2,[1,length(d2)]);
        pointdepth(i,j,:) = d2;
        meanAll2(i,j) = mean(d2');
    end
end
stdAll = stdAll';
meanAll = meanAll';

% 
% [meanAll(99,163),1000*stdAll(99,163)]
% [meanAll(101,132),1000*stdAll(101,132)]
% [meanAll(78,147),1000*stdAll(78,147)]

figure,imagesc(meanAll),colorbar
meanAll2 = meanAll2';
figure,imagesc(meanAll2),colorbar
stdAll(meanAll2(:,:)<1.5)=0;
figure,imagesc(stdAll),colorbar

stdmm = 1000*mean(mean(stdAll(90:100,120:130)))
meanM = mean(mean(meanAll(90:100,120:130)))
%%
meanAll(meanAll2(:,:)<1.5) = 0;
stdAll(meanAll2(:,:)<1.5) = 0;
%%
close all
figure,imagesc(stdAll'),colorbar
imwrite( ind2rgb(im2uint8(mat2gray(stdAll')), parula(256)), '1stdlidar.png')
figure,imagesc(meanAll'),colorbar
imwrite( ind2rgb(im2uint8(mat2gray(meanAll')), parula(256)), '1meanlidar.png')
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