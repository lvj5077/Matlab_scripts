for i = 1:10153
    i*100/10153
    fff = fopen("/Users/jin/Q_Mac/Local_Data/02_03_2022/costco/2022-02-03T10-32-51/ios_bin/"+num2str(i)+".bin");
    M_depth = fread(fff,'int32');
    M_depth(M_depth(:,:)~=15)=0;
    M_depth  = reshape(M_depth,[513,513]);
    M_depth = M_depth';
    iii = imresize(M_depth,[480,640]);
    BW = imbinarize(iii);
    imwrite(BW,"/Users/jin/Q_Mac/Local_Data/02_03_2022/costco/2022-02-03T10-32-51/people_mask/"+num2str(i)+".png");
end

%%
close all
clc
clear
fff = fopen("/Users/jin/Desktop/PeopleSeg/PeopleSeg/result77.bin");
M_depth = fread(fff,'float32');
% histogram (M_depth)
M_depth(M_depth(:,:)~=11)=0;
M_depth  = reshape(M_depth,[1024,512]);
M_depth = M_depth';
% surf(M_depth)
%
iii = imresize(M_depth,[480,640]);
BW = imbinarize(iii);

imshow(BW)

%%
%%
close all
clc
clear
fff = fopen("/Users/jin/Desktop/6099L_mask.bin");
M_depth = fread(fff,'int32');
% histogram (M_depth)
M_depth(M_depth(:,:)~=15)=0;
M_depth  = reshape(M_depth,[513,513]);
M_depth = M_depth';
% surf(M_depth)
%
iii = imresize(M_depth,[480,640]);
BW = imbinarize(iii);

figure,imshow(BW)

clc
clear
fff = fopen("/Users/jin/Desktop/6099s_mask.bin");
M_depth = fread(fff,'int32');
% histogram (M_depth)
M_depth(M_depth(:,:)~=15)=0;
M_depth  = reshape(M_depth,[513,513]);
M_depth = M_depth';
% surf(M_depth)
%
iii = imresize(M_depth,[480,640]);
BW = imbinarize(iii);

figure,imshow(BW)
clc
clear
fff = fopen("/Users/jin/Desktop/6099sM_mask.bin");
M_depth = fread(fff,'int32');
% histogram (M_depth)
M_depth(M_depth(:,:)~=15)=0;
M_depth  = reshape(M_depth,[513,513]);
M_depth = M_depth';
% surf(M_depth)
%
iii = imresize(M_depth,[480,640]);
BW = imbinarize(iii);

figure,imshow(BW)
%%
clc
clear
fff = fopen("/Users/jin/Desktop/6099sW_mask.bin");
M_depth = fread(fff,'int32');
% histogram (M_depth)
M_depth(M_depth(:,:)~=15)=0;
M_depth  = reshape(M_depth,[513,513]);
M_depth = M_depth';
% surf(M_depth)
%
iii = imresize(M_depth,[480,640]);
BW = imbinarize(iii);

figure,imshow(BW)