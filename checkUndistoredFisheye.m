clear
close all
clc


undist = imread("/Users/jin/undistorted.png");
undist(undist(:,:)==0)=nan;
undistR = undist;
undistR(undist(:,:)==0)=255;

undist =  cat(3,undistR,undist,undist);

figure,imshow(undist)
%%
% %%s
% undist(undist(:,:)==255)=nan;
% figure,imshow(undist)
%

[w,h] =size(undist);
S = 8;
undistS = zeros(w/S,h/S);
for i = 1:w/S
    for j = 1:h/S
        undistS(i,j) = max(max(undist(1+(i-1)*S:S+(i-1)*S,1+(j-1)*S:S+(j-1)*S)));
    end
end
undistS = uint8(undistS);
figure,imshow(undistS)

%%
img = imread("/Users/jin/1622128334.205493874.png");
%%
mask = zeros(800,848);
for i = 1:800
    for j = 1:848
        if (norm([i,j]-[400,424])<350)
            mask(i,j) = true;
        end
    end
end

% mask(1:410,:) = 0;
mask = imbinarize(mask);
figure,imshow(mask)
imwrite(mask,'/Users/jin/fisheye_mask.jpg')
%%

img(mask(:,:)==0)=0;
figure,imshow(img)