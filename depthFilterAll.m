clear
close all
clc
s=1000;
load('/Users/jin/Q_Mac/work/pre_iphoneData/MeanE.mat');
%
path = "/Users/jin/Downloads/2021-09-28T17-27-13/";

fff = fopen(path+"FramesDpt.depth");
M_depth =[];
M_depth = fread(fff,'float');
totalImage = length(M_depth)/(192*256);
M_depth  = reshape(M_depth,[256,192,totalImage]);

fff = fopen(path+"FramesDptcfd.depth");
M_cfd =[];
M_cfd = fread(fff,'uint8');
totalImage = length(M_cfd)/(192*256);
M_cfd  = reshape(M_cfd,[256,192,totalImage]);
%
% totalImage = 2;
for frameNum = 1:totalImage
    frameNum/totalImage*100
    imdepthcfd = M_cfd(:,:,frameNum);
    imdepthcfd = double(imdepthcfd);
    imdepthcfd = imrotate( imdepthcfd , -90 );
    imdepthcfd = fliplr(imdepthcfd);
    
    imdepth = M_depth(:,:,frameNum);
    imdepth = double(imdepth);
    imdepth = imrotate( imdepth , -90 );
    imdepth = fliplr(imdepth); 
    Z1 = uint16(1000*imdepth);
    imwrite(Z1,path+"depth/"+num2str(frameNum)+".png");
    
%     
%     [~,threshold] = edge(imdepth,'sobel');
%     fudgeFactor = 0.5;
%     BWs = edge(imdepth,'sobel',threshold * fudgeFactor);
% 
%     se = offsetstrel('ball',2,2);
% 
%     dilatedI = imdilate(255*uint8(BWs),se);
%     %     break
%     % imdepth(dilatedI(:,:)==255)=0;
% 
%     imdepth_temp = imdepth;
%     for i =3:190
%         for j = 3:253
%             if (dilatedI(i,j) == 255)
%                 surround = imdepth_temp(i-1:i+1,j-1:j+1);
%                 surroundN = reshape(surround,[9,1]);
%                 imdepth(i,j) = min(surroundN);
% 
%             end
%         end
%     end
%     
%     Z2 = imdepth;
%     Z2(Z2(:,:)>4)=0;
%     Z2(Z2(:,:)<0.25)=0;
%     
%     Z2(Z2(:,:)>1)=interp1(meanE(:,1),meanE(:,2),Z2(Z2(:,:)>1));
%     
%     imwrite(uint16(1000*Z2),path+"depth_filter/"+num2str(frameNum)+".png");
% 
%     Z3 = imdepth;
%     Z3(imdepthcfd(:,:)<1.5)=0;
% % 	Z3 = interp1(meanE(:,1),meanE(:,2),Z2(:,:));
%     imwrite(uint16(1000*Z3),path+"depth_cfd/"+num2str(frameNum)+".png");
end