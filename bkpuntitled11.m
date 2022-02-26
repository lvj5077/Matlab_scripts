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

humanP3d = [20.2,0.1,0;20.2,-0.1,0;20.4,0.1,0;20.4,-0.1,0;20,0.3,.3;20,-0.3,.3;20.6,0.3,.3;20.6,-0.3,.3;20,0.3,1.8;20,-0.3,1.8;20.6,0.3,1.8;20.6,-0.3,1.8];

H = 0.5;

humanP3d(:,3) = humanP3d(:,3)+H;

humanP3d = humanP3d*eul2rotm([-pi/4,0,0]);

figure,

tl = tiledlayout(1,3);

nexttile(tl)

plot3(0,0,0,'k*','MarkerSize',20,'LineWidth',3)
hold on
plot3(humanP3d(1:4,1),humanP3d(1:4,2),-humanP3d(1:4,3),'r.','MarkerSize',10) % red is head
hold on
plot3(humanP3d(5:8,1),humanP3d(5:8,2),-humanP3d(5:8,3),'b.','MarkerSize',10) % blue is nect
hold on
plot3(humanP3d(9:12,1),humanP3d(9:12,2),-humanP3d(9:12,3),'g.','MarkerSize',10) % green is feet

xlabel("X")
ylabel("Y")
zlabel("Z")
grid minor

axis equal
xlim([-5,24])
ylim([-5,24])
zlim([-15,1])
title('3D');

%
perspective2d = zeros(length(humanP3d),2);
fisheye2d = zeros(length(humanP3d),2);

% focal_length = m_imageHeight/2 /tan( (fov/2) *pi/180);
focal_length = 460;

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
plot(perspective2d(1:4,1),perspective2d(1:4,2),'r.','MarkerSize',10) % red is head
hold on
plot(perspective2d(5:8,1),perspective2d(5:8,2),'b.','MarkerSize',10) % blue is nect
hold on
plot(perspective2d(9:12,1),perspective2d(9:12,2),'g.','MarkerSize',10) % green is feet
grid minor
title('perspective');
% axis equal
%
% xlim([0,640]),ylim([0,640])

nexttile(tl)

% hold on, plot(fisheye2d(:,1),fisheye2d(:,2),'b.')
% hold on,plot(fisheye2d(1,1),fisheye2d(1,2),'r*')
% hold on,plot(fisheye2d(end,1),fisheye2d(end,2),'b*')

plot(fisheye2d(1:4,1),fisheye2d(1:4,2),'r.','MarkerSize',10) % red is head
hold on
plot(fisheye2d(5:8,1),fisheye2d(5:8,2),'b.','MarkerSize',10) % blue is nect
hold on
plot(fisheye2d(9:12,1),fisheye2d(9:12,2),'g.','MarkerSize',10) % green is feet

hold on,plot(0,0,'k*','MarkerSize',20,'LineWidth',3)
grid minor
% xlim([0,1024]),ylim([0,1024])

title('Fisheye');

norm(fisheye2d(end,1)-fisheye2d(1,1))
title(tl,"drone @ 0.5m",'FontSize',20,'FontWeight','bold');
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

%%
fisheye2d(i,:) = perspective2fisheye(unipx,unipy,1.8);
%%
L = zeros(390,1);
W = zeros(390,1);
P = zeros(390,2);

for i = 1:390
    pt2d = [i-1,i-1;i,i]*2^.5/2;
    [pt2dL] = liftProjectiveMeit265(pt2d);
    
    L(i) = norm (pt2dL(1,:)-pt2dL(2,:));
    P(i,:) = pt2dL(1,:);
    pt2d = [i,0;i+1,0];
    [pt2dL] = liftProjectiveMeit265(pt2d);
    W(i) = norm (pt2dL(1,:)-pt2dL(2,:));
    pt2d = [0,i;0,i+1];
    [pt2dL] = liftProjectiveMeit265(pt2d);
    H(i) = norm (pt2dL(1,:)-pt2dL(2,:));

end
%
figure,
plot(1:390,H/H(1),'r.')
hold on
plot(1:390,W/W(1),'bo')
hold on
plot((1:390),L/L(1),'g.')
% hold on
% plot(W)
grid minor
% 
figure,
plot(vecnorm(P'),L/L(1),'g.')
