imcolor = imread('/Volumes/BlackSSD/ss/color/2038.366245433.png');
% 212,335,320,495
bf = -25;
imcolor(274+bf:274-bf,408+bf:408-bf,1) = 0;
imcolor(274+bf:274-bf,408+bf:408-bf,2) = 255;
imcolor(274+bf:274-bf,408+bf:408-bf,3) = 0;

imshow(imcolor)

%%
imcolor3col1 = reshape(imcolor,480*640,3);
imdepth = imread('/Volumes/BlackSSD/ss/depth/2038.366245433.png');
imdepth = double(imdepth);

s=1000;
fx = 4.59357e+02 ;
fy = 4.59764e+02 ;
skew = 0;
cx = 3.32695e+02;
cy = 2.58998e+02;

Z = imdepth/1000;
Z(Z(:,:)>4)=0;
[h,w] = size(imdepth);
u=repmat(1:w,[h,1]);
v=repmat(1:h,[w,1])';

X=(Z(:).*(u(:)-cx))/fx;
Y=(Z(:).*(v(:)-cy))/fy;

xyzPoints1 = [X(:),Y(:),Z(:)];

xyzPoints1 = xyzPoints1(Z(:)~=0,:);
imcolor3col1 = imcolor3col1(Z(:)~=0,:);
ptCloud1 = pointCloud(xyzPoints1, 'Color', imcolor3col1); 
figure,pcshow(ptCloud1)

%%
imcolor = imread('/Volumes/BlackSSD/ss/color/2106.960131610.png');
% figure,imshow(imcolor)
% imcolor(:,:,1) = 255;
% imcolor(:,:,2) = 0;
% imcolor(:,:,3) = 0;
% % imcolor = 0.8*imcolor;

imcolor3col2 = reshape(imcolor,480*640,3);
imdepth = imread('/Volumes/BlackSSD/ss/depth/2106.960131610.png');
imdepth = double(imdepth);

s=1000;
fx = 4.59357e+02 ;
fy = 4.59764e+02 ;
skew = 0;
cx = 3.32695e+02;
cy = 2.58998e+02;

Z = imdepth/1000;
Z(Z(:,:)>4)=0;
[h,w] = size(imdepth);
u=repmat(1:w,[h,1]);
v=repmat(1:h,[w,1])';

X=(Z(:).*(u(:)-cx))/fx;
Y=(Z(:).*(v(:)-cy))/fy;

xyzPoints2 = [X(:),Y(:),Z(:)];

xyzPoints2 = xyzPoints2(Z(:)~=0,:);
imcolor3col2 = imcolor3col2(Z(:)~=0,:);
ptCloud2 = pointCloud(xyzPoints2, 'Color', imcolor3col2); 
% figure,pcshow(ptCloud2)
%%
% [tform,movingReg] = pcregistericp(ptCloud2,ptCloud1);
% ptCloudOut = pcmerge(ptCloud1,movingReg,0.001);
% figure,pcshow(ptCloudOut)
%%
gt = importdata('/Users/jin/Desktop/wroma/vins-rgbd/ss_wroma_2020-10-20-21-48-47.csv');
% figure,plot3(gt(:,2),gt(:,3),gt(:,4),'b','LineWidth',3);
% axis equal
% grid minor
% xlabel("x")
% ylabel("y")
% zlabel("z")
% hold on
% plot3(gt(287,2),gt(287,3),gt(287,4),'go','LineWidth',3);
% hold on
% plot3(gt(1020,2),gt(1020,3),gt(1020,4),'ro','LineWidth',3);

T1= eye(4);
T2= eye(4);

% T1(1:3,1:3) = quat2rotm([gt(172,8),gt(172,5:7)]);
T1(1:3,1:3) = quat2rotm([gt(287,5:8)]);
T1(1:3,4) =(gt(287,2:4))'
% T2(1:3,1:3) = quat2rotm([gt(170,8),gt(170,5:7)]);
T2(1:3,1:3) = quat2rotm(gt(973,5:8));
T2(1:3,4) =(gt(973,2:4))'

%%

R_c2b = [0.00193013, -0.999997, 0.00115338, 
        -0.999996, -0.0019327, -0.00223606, 
        0.00223829, -0.00114906, -0.999997];
t_c2b = [-0.00817048, 0.015075, -0.0110795];  
    
TT = eye(4);
TT = inv(T2)*(T1)
RR = TT(1:3,1:3)

tt = TT(1:3,4);
% accumTform.T
% ptCloud2Aligned = pctransform(ptCloud2, accumTform);

% RR = tform.Rotation';
% tt = tform.Translation';

xyzPoints1_2c = (R_c2b*(RR*R_c2b'*xyzPoints1'+tt))';
ptCloud1_2c = pointCloud(xyzPoints1_2c, 'Color', imcolor3col1); 

% xyzPoints2_2c = (R_c2b'*xyzPoints2')';
% ptCloud2_2c = pointCloud(xyzPoints2_2c, 'Color', imcolor3col2); 
% 

ptCloudOut = pcmerge(ptCloud2,ptCloud1_2c,0.001);


figure,pcshow(ptCloudOut)


%%
% [tform,movingReg] = pcregistericp(ptCloud1_2c,ptCloud2);
% ptCloudOut = pcmerge(ptCloud2,movingReg,0.001);
% figure,pcshow(ptCloudOut)

newXYZ = ptCloudOut.Location;
newColor = ptCloudOut.Color;
sizeXYZ = length(newXYZ);
newPixelXY = zeros(sizeXYZ,2);
for i = 1:sizeXYZ
    newPixelXY(i,1) = fx*newXYZ(i,1)/newXYZ(i,3)+cx;
    newPixelXY(i,2) = fy*newXYZ(i,2)/newXYZ(i,3)+cy;
end

newPixelXY = round(newPixelXY);

xxx = max(640,max(newPixelXY(:,1)))
yyy = max(480,max(newPixelXY(:,2)))

newPic = uint8(zeros(yyy,xxx,3));
imcolor = imread('/Volumes/BlackSSD/ss/color/2106.960131610.png');

newPic(1:480,1:640,:) = imcolor;

for i = 1:sizeXYZ
    newPic(newPixelXY(i,2),newPixelXY(i,1),:) = newColor(i,:);
end



figure,imshow(newPic)