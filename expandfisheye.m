% close all
clc
clear

% t265 286.28
focal_length = 200;
LargeW = 2*focal_length;

addpath('/Users/jin/Third_party/mexopencv');

% "fx": 367.4444180249881,
% "fy": 370.6028360821689,
% "cx": 1011.7507878973677,
% "cy": 540.0245011066808,
% "k1": 0.02469854014753059,
% "k2": 0.01169272690234126,
% "k3": -0.009891994547990602,
% "k4": 0.0011382144339248547
                    
K_mat = [367.4444180249881 0 1011.7507878973677; 0 370.6028360821689 540.0245011066808; 0 0 1];
dist_k4 = [0.02469854014753059, 0.01169272690234126,-0.009891994547990602,0.0011382144339248547];

% cv.fisheyeUndistortPoints([286.23 507.973],K_mat, dist_k4)
%%
I = imread("/Users/jin/Downloads/fisheye220.png");
% I = imread("/Users/jin/Downloads/1625812899.113249128.png");
outpath = "/Users/jin/Desktop/testFisheye";
figure, imshow(I)

I = rgb2gray(I);
idxx =0;

% I = imresize(I,0.5);
[h,w,d] = size(I);
% [h,w,d] = size(I);

for i =1:h
    for j = 1:w
        if(norm([j,i]-[w/2,h/2])>750)
            I(i,j,:) = 0;
        end
    end
end
figure,imshow(I)

%%
I_temp = zeros(LargeW,LargeW,1);

I_center = zeros(LargeW,LargeW,1);
I_left = zeros(LargeW,LargeW,1);
I_right = zeros(LargeW,LargeW,1);
I_top = zeros(LargeW,LargeW,1);
I_bottom = zeros(LargeW,LargeW,1);

Iremap = zeros(size(I));
%%
for i = 1:h
    for j = 1:w

        fish_x = j;
        fish_y = i;
        pt3d2 =cv.fisheyeUndistortPoints([fish_x fish_y],K_mat, dist_k4);
        pt3d = [pt3d2, 1  ];

        % pt3d = [pt3d(:,3),-pt3d(:,2),-pt3d(:,1)];

        % pt3d = [pt3d(:,1),-pt3d(:,3),pt3d(:,2)];


        pt2dL(:,1) = focal_length*pt3d(:,1)./pt3d(:,3);
        pt2dL(:,2) = focal_length*pt3d(:,2)./pt3d(:,3);

        x = (round(pt2dL(2)))+LargeW/2;
        y = (round(pt2dL(1)))+LargeW/2;
        if ( x<=LargeW && y<=LargeW && x>=1 && y>=1 )
            if (isreal(pt2dL))
                I_temp(x,y,:) = I(i,j);
                Iremap(i,j,:) = I(i,j);
            else
                idxx= idxx +1
                Iremap(i,j,:) = 255;
            end

        end

    end
end
%
Iremap = uint8(Iremap);
I_temp = uint8(I_temp);

figure,imshow(Iremap)
% set(gcf,'color','w');
% set(gca,'color','w');

I_center = I_temp;
figure,imshow(I_center)

%%
I_temp = zeros(LargeW,LargeW,1);
for i = h/2:h
    for j = 1:w
        
        fish_x = j;
        fish_y = i;
        pt3d2 =cv.fisheyeUndistortPoints([fish_x fish_y],K_mat, dist_k4);
        pt3d = [pt3d2, 1  ];

        % pt3d = [pt3d(:,3),-pt3d(:,2),-pt3d(:,1)];

        pt3d = [pt3d(:,1),pt3d(:,3),pt3d(:,2)];


        pt2dL(:,1) = focal_length*pt3d(:,1)./pt3d(:,3);
        pt2dL(:,2) = -focal_length*pt3d(:,2)./pt3d(:,3);

        x = (round(pt2dL(2)))+LargeW/2;
        y = (round(pt2dL(1)))+LargeW/2;
        if ( x<=LargeW && y<=LargeW && x>=1 && y>=1 )
            if (isreal(pt2dL))
                I_temp(x,y,:) = I(i,j,:);
                Iremap(i,j,:) = I(i,j,:);
            else
                idxx= idxx +1
            end

        end

    end
end
%
Iremap = uint8(Iremap);
I_temp = uint8(I_temp);

% figure,imshow(I_temp)
% set(gcf,'color','w');
% set(gca,'color','w');

I_bottom = I_temp;
%%
I_temp = zeros(LargeW,LargeW,1);
for i = 1:h/2
    for j = 1:w
        
        fish_x = j;
        fish_y = i;
        pt3d2 =cv.fisheyeUndistortPoints([fish_x fish_y],K_mat, dist_k4);
        pt3d = [pt3d2, 1  ];

        % pt3d = [pt3d(:,3),-pt3d(:,2),-pt3d(:,1)];

        pt3d = [pt3d(:,1),-pt3d(:,3),pt3d(:,2)];


        pt2dL(:,1) = -focal_length*pt3d(:,1)./pt3d(:,3);
        pt2dL(:,2) = focal_length*pt3d(:,2)./pt3d(:,3);

        x = (round(pt2dL(2)))+LargeW/2;
        y = (round(pt2dL(1)))+LargeW/2;
        if ( x<=LargeW && y<=LargeW && x>=1 && y>=1 )
            if (isreal(pt2dL))
                I_temp(x,y,:) = I(i,j,:);
                Iremap(i,j,:) = I(i,j,:);
            else
                idxx= idxx +1
            end

        end

    end
end
%
Iremap = uint8(Iremap);
I_temp = uint8(I_temp);

% figure,imshow(I_temp)
% set(gcf,'color','w');
% set(gca,'color','w');

I_top = I_temp;
%%
I_temp = zeros(LargeW,LargeW,1);
for i = 1:h
    for j = 1:w/2

        fish_x = j;
        fish_y = i;
        pt3d2 =cv.fisheyeUndistortPoints([fish_x fish_y],K_mat, dist_k4);
        pt3d = [pt3d2, 1  ];

        pt3d = [pt3d(:,3),pt3d(:,2),-pt3d(:,1)];

        % pt3d = [pt3d(:,1),-pt3d(:,3),pt3d(:,2)];


        pt2dL(:,1) = focal_length*pt3d(:,1)./pt3d(:,3);
        pt2dL(:,2) = focal_length*pt3d(:,2)./pt3d(:,3);

        x = (round(pt2dL(2)))+LargeW/2;
        y = (round(pt2dL(1)))+LargeW/2;
        if ( x<=LargeW && y<=LargeW && x>=1 && y>=1 )
            if (isreal(pt2dL))
                I_temp(x,y,:) = I(i,j,:);
                Iremap(i,j,:) = I(i,j,:);
            else
                idxx= idxx +1
            end

        end

    end
end
%
Iremap = uint8(Iremap);
I_temp = uint8(I_temp);

% figure,imshow(I_temp)
% set(gcf,'color','w');
% set(gca,'color','w');
I_left = I_temp;
%%
I_temp = zeros(LargeW,LargeW,1);
for i = 1:h
    for j = w/2:w

        fish_x = j;
        fish_y = i;
        pt3d2 =cv.fisheyeUndistortPoints([fish_x fish_y],K_mat, dist_k4);
        pt3d = [pt3d2, 1  ];
        pt3d = [pt3d(:,3),-pt3d(:,2),-pt3d(:,1)];

        % pt3d = [pt3d(:,1),-pt3d(:,3),pt3d(:,2)];


        pt2dL(:,1) = focal_length*pt3d(:,1)./pt3d(:,3);
        pt2dL(:,2) = focal_length*pt3d(:,2)./pt3d(:,3);

        x = (round(pt2dL(2)))+LargeW/2;
        y = (round(pt2dL(1)))+LargeW/2;
        if ( x<=LargeW && y<=LargeW && x>=1 && y>=1 )
            if (isreal(pt2dL))
                I_temp(x,y,:) = I(i,j,:);
                Iremap(i,j,:) = I(i,j,:);
            else
                idxx= idxx +1
            end

        end

    end
end
%
Iremap = uint8(Iremap);
I_temp = uint8(I_temp);

% figure,imshow(I_temp)
% set(gcf,'color','w');
% set(gca,'color','w');

I_right = I_temp;
%%

Icube = zeros(3*LargeW,3*LargeW,1);

Icube(1:LargeW,1+LargeW:LargeW+LargeW,:) = I_top;
Icube(1+2*LargeW:LargeW+2*LargeW,1+LargeW:LargeW+LargeW,:) = I_bottom;
Icube(1+LargeW:LargeW+LargeW,1+LargeW:LargeW+LargeW,:) = I_center;
Icube(1+LargeW:LargeW+LargeW,1:LargeW,:) = I_left;
Icube(1+LargeW:LargeW+LargeW,1+2*LargeW:LargeW+2*LargeW,:) = I_right;

Icube = uint8(Icube);

figure, imshow(Icube)
imwrite(Icube,outpath+"/flatCube.png")
%%
rL = imrotate( I_left ,90 );
% imshow(rL)
rR = imrotate( I_right ,-90 );
% imshow(rR)
rT = imrotate( I_top ,180 );

Iring =[rL,I_bottom,rR,rT];
imshow(Iring)