% clear
% close all
format short g
% clc
addpath('/Users/jin/Third_party/mexopencv');

m_imageWidth  = 848;
m_imageHeight = 800;

        
%
Ipre = imread("/Users/jin/Desktop/FisheyeExpension/testT265expand/out/flatCubeS5.png");
Ipre = rgb2gray(Ipre);
% % % Inxt = imread("/Users/jin/1622128334.037772058.png");
Inxt = imread("/Users/jin/Desktop/FisheyeExpension/testT265expand/out/flatCubeS5.png");
Inxt = rgb2gray(Inxt);
% Inxt = imread("/Users/jin/1622128348.737936605.png");
% Ipre = imresize(Ipre,.5);
% Inxt = imresize(Inxt,.5);


% for i =1:h
%     for j = 1:w
%         if(norm([j,i]-[w/2,h/2])>370)
%             Ipre(i,j,:) = 0;
%         end
%     end
% end

% I_mask = imread("/Users/jin/t265Mask.png");
tempCell = cv.goodFeaturesToTrack(Ipre, 'MaxCorners', 200, 'QualityLevel', 0.01, 'MinDistance', 20);

% tempCell = cv.goodFeaturesToTrack(Ipre, 'MaxCorners', 200, 'QualityLevel', 0.01, 'MinDistance', 10,'Mask',I_mask);
prevPts = double(reshape(cell2mat(tempCell)',[2,length(tempCell)]))';


tempCell = cv.calcOpticalFlowPyrLK(Ipre, Inxt, prevPts);
nextPts = double(reshape(cell2mat(tempCell)',[2,length(tempCell)]))';



% C2 = double(reshape(tempMat',[2,length(tempMat)/2]))';
idx = find(nextPts(:,1)>0&nextPts(:,1)<848&nextPts(:,2)>0&nextPts(:,2)<800);
nextPts = nextPts(idx,:);
prevPts = prevPts(idx,:);

% tempCell = cv.calcOpticalFlowPyrLK(Inxt,Ipre, prevPts);
% prevPts = double(reshape(cell2mat(tempCell)',[2,length(tempCell)]))';
% idx = find(prevPts(:,1)>0&prevPts(:,1)<848&prevPts(:,2)>0&prevPts(:,2)<800);
% nextPts = nextPts(idx,:);
% prevPts = prevPts(idx,:);



figure, imshow(Ipre),hold on, plot(prevPts(:,1),prevPts(:,2),'ro'),title("pre")

%%
pause(1)
figure, imshow(Inxt),hold on, plot(nextPts(:,1),nextPts(:,2),'ro'),title("next")

figure,showMatchedFeatures(Ipre,Inxt,prevPts,nextPts,'montage'),title("before ransac",'FontSize',40)
%%
[prevPtsL,~] = liftProjectiveMei(prevPts);
[nextPtsL,~] = liftProjectiveMei(nextPts);

% [~,prevPtsL] = liftProjectivePoly(prevPts);
% [~,nextPtsL] = liftProjectivePoly(nextPts);

[F, mask] = cv.findFundamentalMat(prevPtsL, nextPtsL, 'Method','Ransac','RansacReprojThreshold',1);
% [F, mask] = cv.findFundamentalMat(prevPts, nextPts, 'Method','Ransac','RansacReprojThreshold',1);
nextPtsF = nextPts(mask==1,:);
prevPtsF = prevPts(mask==1,:);

figure,showMatchedFeatures(Ipre,Inxt,prevPtsF,nextPtsF,'montage'),title("Mei(Gao) ransac",'FontSize',40)