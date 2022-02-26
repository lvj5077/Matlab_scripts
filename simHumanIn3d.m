% z= 0.2:0.2:1.8;
% x= 1:20;
% y= 1:20;
% clear
% clc
% close all
% humanP3d = zeros(17,3);
% i = 0;
% H = 10.5;
% for z = 0.2:0.1:1.8
%     i = i+1;
%     humanP3d(i,:) = [20,20,z+H];
% end

humanP3d = [20.3,0,0;20.2,0.1,0;20.2,-0.1,0;20.4,0.1,0;20.4,-0.1,0;20.3,0,0.3;20,0.3,.3;20,-0.3,.3;20.6,0.3,.3;20.6,-0.3,.3;20.3,0,1.8;20,0.3,1.8;20,-0.3,1.8;20.6,0.3,1.8;20.6,-0.3,1.8];

H = 10.5;

humanP3d(:,3) = humanP3d(:,3)+H;

humanP3d = humanP3d*eul2rotm([-pi/4,0,0]);

figure,

tl = tiledlayout(1,3);

nexttile(tl)

plot3(0,0,0,'k*','MarkerSize',20,'LineWidth',3)
hold on
plot3(humanP3d(1:5,1),humanP3d(1:5,2),-humanP3d(1:5,3),'r.','MarkerSize',10) % red is head
hold on
plot3(humanP3d(6:10,1),humanP3d(6:10,2),-humanP3d(6:10,3),'b.','MarkerSize',10) % blue is nect
hold on
plot3(humanP3d(11:15,1),humanP3d(11:15,2),-humanP3d(11:15,3),'g.','MarkerSize',10) % green is feet

xlabel("X")
ylabel("Y")
zlabel("Z")
grid minor

axis equal
xlim([-5,24])
ylim([-5,24])
zlim([-15,1])
title('3D','FontSize',15,'FontWeight','bold');
set(gcf,'color','w');
set(gca,'color','w');

%
perspective2d = zeros(length(humanP3d),2);
fisheye2d = zeros(length(humanP3d),2);

% focal_length = m_imageHeight/2 /tan( (fov/2) *pi/180);
focal_length = 400;

for i = 1:length(humanP3d)
    unipx = humanP3d(i,1)/humanP3d(i,3);
    unipy = humanP3d(i,2)/humanP3d(i,3); 
    fisheye2d(i,:) = perspective2fisheye(unipx,unipy,1.8);
    
    px = focal_length*unipx;
    py = focal_length*unipy; 
    perspective2d(i,:) = [px,py];
%     display([px,py])
    
%     display(fisheye2d(i,:))
end
%
nexttile(tl)

plot(0,0,'k*','MarkerSize',20,'LineWidth',3)
hold on
plot(perspective2d(1:5,1),perspective2d(1:5,2),'r.','MarkerSize',10) % red is head
hold on
plot(perspective2d(6:10,1),perspective2d(6:10,2),'b.','MarkerSize',10) % blue is nect
hold on
plot(perspective2d(11:15,1),perspective2d(11:15,2),'g.','MarkerSize',10) % green is feet
grid minor

pixelLengthPersp = norm(perspective2d(11,1)-perspective2d(1,1));
pixelWidthPersp = norm(perspective2d(15,1)-perspective2d(14,1));
title("f = 500 perspective: H: "+num2str(pixelLengthPersp,'%.2f') + " pixel W:" +num2str(pixelWidthPersp,'%.2f') + " pixel",'FontSize',15,'FontWeight','bold');
% axis equal
%
% xlim([0,640]),ylim([0,640])

nexttile(tl)

% hold on, plot(fisheye2d(:,1),fisheye2d(:,2),'b.')
% hold on,plot(fisheye2d(1,1),fisheye2d(1,2),'r*')
% hold on,plot(fisheye2d(end,1),fisheye2d(end,2),'b*')

plot(fisheye2d(1:5,1),fisheye2d(1:5,2),'r.','MarkerSize',10) % red is head
hold on
plot(fisheye2d(6:10,1),fisheye2d(6:10,2),'b.','MarkerSize',10) % blue is nect
hold on
plot(fisheye2d(11:15,1),fisheye2d(11:15,2),'g.','MarkerSize',10) % green is feet

hold on,plot(0,0,'k*','MarkerSize',20,'LineWidth',3)
grid minor
% xlim([0,1024]),ylim([0,1024])
pixelLengthFish = norm(fisheye2d(11,1)-fisheye2d(1,1));
pixelWidthFish = norm(fisheye2d(15,1)-fisheye2d(14,1));
title("Fisheye: H: " +num2str(pixelLengthFish,'%.2f') + " pixel W:" +num2str(pixelWidthFish,'%.2f') + " pixel",'FontSize',15,'FontWeight','bold');


title(tl,"drone @ "+num2str(H)+" m "+"pixel @ Width:1024pixel",'FontSize',20,'FontWeight','bold');
%%
figure,
hold on, plot(fisheye2d(:,1),fisheye2d(:,2),'b.')
hold on,plot(fisheye2d(1,1),fisheye2d(1,2),'r*')
hold on,plot(fisheye2d(end,1),fisheye2d(end,2),'b*')

hold on, plot(fisheye2d_10m(:,1),fisheye2d_10m(:,2),'b.')
hold on,plot(fisheye2d_10m(1,1),fisheye2d_10m(1,2),'r*')
hold on,plot(fisheye2d_10m(end,1),fisheye2d_10m(end,2),'b*')

hold on,plot(512,512,'bo')
grid minor
axis equal
xlim([0,1024]),ylim([0,1024])
norm(fisheye2d(end,1)-fisheye2d(1,1))


%%
fisheye2d = zeros(64,2);
for i = 1:64
    i
    fisheye2d(i,:) = perspective2fisheye(10*i,10*i,1.6);
end
figure,plot(fisheye2d(:,1),fisheye2d(:,2),'.')
hold on, plot(400,424,'r*')
xlim([0,800]),ylim([0,800])
%%
for i = 1:200
    i
    perspective2d(i,:) = liftProjectiveMei([4*i,4*i]);
end
figure,plot(perspective2d(:,1),perspective2d(:,2),'.')
xlim([0,800]),ylim([0,800])
