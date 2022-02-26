%%
img = imread("/Users/jin/Desktop/Dreame/cpu_data/track9.png");
[H,W,channel] = size(img);

mask = zeros(H,W);
for i = 1:H
    for j = 1:W
        if (norm([i,j]-[H/2,W/2])<380) % 750 fisheye
            mask(i,j) = true;
        end
%         if (norm([i,j]-[H/2,W/2])<200)
%             mask(i,j) = false;
%         end
    end
end

% mask(1:380,:) = 0;
mask = imbinarize(mask);
figure,imshow(mask)
imwrite(mask,'/Users/jin/Desktop/Dreame/template/fisheye_mask.jpg')
%

img(mask(:,:)==0)=0;
figure,imshow(img)