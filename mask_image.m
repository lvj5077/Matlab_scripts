II = imread("/Users/jin/Desktop/New Folder With Items/14.png");

I_mask = ones(800,848);

for j = 1:848
    for i = 1:800
        if(norm([i,j]-[400,424])>390)
            II(i,j,:)=[0,0,0];
            I_mask(i,j) = 0;
        end

        if(II(i,j,1)==255 && II(i,j,3)==0)
            II(i,j,:)=[0,0,0];
            I_mask(i,j) = 0;
            I_mask(i+1,j+1) = 0;
            I_mask(i-1,j-1) = 0;
            I_mask(i+1,j-1) = 0;
            I_mask(i-1,j+1) = 0;
        end
    end
end

imshow(II)
imwrite(I_mask,'/Users/jin/Desktop/mask.png')

%%
I=imread("/Users/jin/Downloads/WechatIMG10.jpeg");
for j = 1:881
    for i = 1:892
        if(norm([i,j]-[450,440])>425)
            I(i,j,:)=0;
        end
    end
end

imshow(I)