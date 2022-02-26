function [pixelL] = checkPixelLength(H)
humanP3d = zeros(4,3);
i = 0;
% H = 10.5;
for z = [0.2,1,1.6,1.8]
    i = i+1;
    humanP3d(i,:) = [20,20,z+H];
end

perspective2d = zeros(length(humanP3d),2);
fisheye2d = zeros(length(humanP3d),2);

% focal_length = m_imageHeight/2 /tan( (fov/2) *pi/180);
focal_length = 460;

for i = 1:length(humanP3d)
    unipx = humanP3d(i,1)/humanP3d(i,3);
    unipy = humanP3d(i,2)/humanP3d(i,3); 
    fisheye2d(i,:) = perspective2fisheye(unipx,unipy,1.6);
    
    px = focal_length*unipx+320;
    py = focal_length*unipy+320; 
    perspective2d(i,:) = [px,py];
%     display([px,py])
    
%     display(fisheye2d(i,:))
end

% figure,plot(perspective2d(:,1),perspective2d(:,2),'.')
% hold on,plot(perspective2d(1,1),perspective2d(1,2),'r*')
% hold on,plot(perspective2d(end,1),perspective2d(end,2),'b*')
% grid minor
% xlim([0,640]),ylim([0,640])
% 
% figure,
hold on, plot(fisheye2d(:,1),fisheye2d(:,2),'b-')
hold on,plot(fisheye2d(1,1),fisheye2d(1,2),'r*')
hold on,plot(fisheye2d(end,1),fisheye2d(end,2),'b*')
hold on,plot(512,512,'bo')
grid minor
xlim([0,1024]),ylim([0,1024])
pixelL = norm(fisheye2d(end,1)-fisheye2d(1,1));
end

