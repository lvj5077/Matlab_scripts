clear
s=1000;
fx = 4.59357e+02 ;
fy = 4.59764e+02 ;
skew = 0;
cx = 3.32695e+02;
cy = 2.58998e+02;


R_c2b = [0.00193013, -0.999997, 0.00115338, 
        -0.999996, -0.0019327, -0.00223606, 
        0.00223829, -0.00114906, -0.999997];
t_c2b = [-0.00817048, 0.015075, -0.0110795];  

gt = importdata('/Users/jin/Desktop/wroma/vins-fusion/ss_wroma_2020-10-20-21-48-47.csv');
ptCloud2 = pointCloud([0,0,0],'Color',[0,0,0]);
for i = 1:50:length(gt)
    i
    str_name = num2str(gt(i,1));
    color_pth = "/Volumes/Mac_bkp/ss/color/"+str_name(1:4)+"."+str_name(5:13)+".png";
    depth_pth = "/Volumes/Mac_bkp/ss/depth/"+str_name(1:4)+"."+str_name(5:13)+".png";
    imcolor = imread(color_pth);
    imdepth = imread(depth_pth);
    imcolor3col1 = reshape(imcolor,480*640,3);
    imdepth = double(imdepth);

    Z = imdepth/1000;
    Z(Z(:,:)>4)=0;
    [h,w] = size(imdepth);
    u=repmat(1:w,[h,1]);
    v=repmat(1:h,[w,1])';

    X=(Z(:).*(u(:)-cx))/fx;
    Y=(Z(:).*(v(:)-cy))/fy;

    xyzPoints = [X(:),Y(:),Z(:)];

    xyzPoints = xyzPoints(Z(:)~=0,:);
    imcolor3col1 = imcolor3col1(Z(:)~=0,:);
%     ptCloud2 = pointCloud(xyzPoints, 'Color', imcolor3col1); 


    T1= eye(4);
    T2= eye(4);

    % T1(1:3,1:3) = quat2rotm([gt(172,8),gt(172,5:7)]);
    T1(1:3,1:3) = quat2rotm([gt(i,5:8)]);
    T1(1:3,4) =(gt(i,2:4))';
    % T2(1:3,1:3) = quat2rotm([gt(170,8),gt(170,5:7)]);
%     T2(1:3,1:3) = quat2rotm(gt(1,5:8));
%     T2(1:3,4) =(gt(1,2:4))';

    
    TT = eye(4);
    TT = inv(T2)*(T1)
    RR = TT(1:3,1:3);

    tt = TT(1:3,4);

    xyzPoints1_2c = (R_c2b*(RR*R_c2b'*xyzPoints'+tt))';
    ptCloud1_2c = pointCloud(xyzPoints1_2c, 'Color', imcolor3col1); 

    ptCloud2 = pcmerge(ptCloud2,ptCloud1_2c,0.01);
end

figure,
pcshow(ptCloud2)
%%
accumTform = rigid3d(T2(1:3,1:3)',[0,0,0]);
ptCloud2Aligned = pctransform(ptCloud2, accumTform);
% figure, pcshow(ptCloud2Aligned)

traj_xyz = (R_c2b*(gt(:,2:4)'))';
traj_color = zeros(length(traj_xyz),3);
traj_color(:,1) = 255;
traj_pc = pointCloud(traj_xyz, 'Color', traj_color);
all_pc = pcmerge(traj_pc,ptCloud2Aligned,0.01);
figure, pcshow(all_pc)


gt2 = importdata('/Users/jin/ss_wroma_2020-10-20-21-48-47_tum.tum');
traj_xyz = (R_c2b*(gt2(:,2:4)'))';
traj_color = zeros(length(traj_xyz),3);
traj_color(:,2) = 255;
traj_pc = pointCloud(traj_xyz, 'Color', traj_color);
all_pc_2 = pcmerge(all_pc,traj_pc,0.01);
figure, pcshow(all_pc_2)