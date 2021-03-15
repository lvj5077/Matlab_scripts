dilatedI = imdilate(255*uint8(BWs),offsetstrel('ball',2,2));
fff = rgb2gray(frame);
fff(dilatedI(:,:)~=0)=255;
figure, imshow(fff)