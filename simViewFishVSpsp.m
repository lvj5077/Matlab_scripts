% simulation fov 180 fisheye and fov 90 psp
% equivalent resolution 1pixel = 1cm @5m
disP = [0,0,5];
angles = -pi/2:pi/20:pi/2;
ringPts = zeros(length(angles),3);
for i = 1:length(angles)
    ringPts(i,:) = disP*eul2rotm([0,angles(i),0]);
end

ll = [0:-0.7854:-20,0:0.7854:20];
linePts = zeros(length(ll),3);
linePts(:,3) = 5;
linePts(:,1) = ll;


figure,
plot3(0,0,0,'k*','MarkerSize',20,'LineWidth',3)
hold on
plot3(ringPts(:,1),ringPts(:,2),ringPts(:,3),'r.','MarkerSize',20) 
hold on
plot3(linePts(:,1),linePts(:,2),linePts(:,3),'b.','MarkerSize',20) 
grid minor
axis equal
title('3D','FontSize',15,'FontWeight','bold');
set(gca,'color','w');
set(gcf,'color','w');
%%
perspective2dring = zeros(length(ringPts),2);
fisheye2dring = zeros(length(ringPts),2);

perspective2dline = zeros(length(linePts),2);
fisheye2dline = zeros(length(linePts),2);

focal_length = 500;
for i = 1:length(ringPts)
    unipx = ringPts(i,1)/ringPts(i,3);
    unipy = ringPts(i,2)/ringPts(i,3); 
    % center one pixel = 1cm
    fisheye2dring(i,:) = perspective2fisheye(unipx,unipy,1.8,1400);
    
    px = focal_length*unipx;
    py = focal_length*unipy; 
    perspective2dring(i,:) = [px,py];

%     display([px,py])
    
%     display(fisheye2d(i,:))
end

for i = 1:length(linePts)
    unipx = linePts(i,1)/linePts(i,3);
    unipy = linePts(i,2)/linePts(i,3); 
    fisheye2dline(i,:) = perspective2fisheye(unipx,unipy,1.8,1400);
    
    px = focal_length*unipx;
    py = focal_length*unipy; 
    perspective2dline(i,:) = [px,py];

end
%%

figure,
subplot(2,1,1)
plot(perspective2dring(:,1),perspective2dring(:,2),'r.','MarkerSize',20)
hold on
plot(0,0,'k*','MarkerSize',15,'LineWidth',3)
grid minor
xlim([-500,500])

subplot(2,1,2)
plot(perspective2dline(:,1),perspective2dline(:,2),'b.','MarkerSize',20)
hold on
plot(0,0,'k*','MarkerSize',15,'LineWidth',3)
grid minor
xlim([-500,500])
title('perspective','FontSize',15,'FontWeight','bold');

figure,
subplot(2,1,1)
plot(fisheye2dring(:,1),fisheye2dring(:,2),'r.','MarkerSize',20)
hold on
plot(0,0,'k*','MarkerSize',15,'LineWidth',3)
grid minor
xlim([-500,500])

subplot(2,1,2)
plot(fisheye2dline(:,1),fisheye2dline(:,2),'b.','MarkerSize',20)
hold on
plot(0,0,'k*','MarkerSize',15,'LineWidth',3)
grid minor
xlim([-500,500])
title('fisheye','FontSize',15,'FontWeight','bold');

%%
figure,
subplot(2,1,1)

fishidxxx = fisheye2dring(:,1)>-700&fisheye2dring(:,1)<700;
pspidxxx = perspective2dring(:,1)>-500&perspective2dring(:,1)<500;

plot(fisheye2dring(fishidxxx,1),fisheye2dring(fishidxxx,2)+100,'r.','MarkerSize',20)
hold on
plot(perspective2dring(:,1),perspective2dring(:,2)-100,'k.','MarkerSize',20)
hold on
plot(perspective2dring(pspidxxx,1),perspective2dring(pspidxxx,2)-100,'g.','MarkerSize',20)
hold on 
plot(0,0,'k*','MarkerSize',15,'LineWidth',3)
grid minor
xlim([-800,800])
ylim([-500,500])
legend('fisheye2dring','perspective2dring','FontSize',15)
title('Ring shape','FontSize',15,'FontWeight','bold');

fishidxxx = fisheye2dline(:,1)>-700&fisheye2dline(:,1)<700;
pspidxxx = perspective2dline(:,1)>-500&perspective2dline(:,1)<500;
subplot(2,1,2)
plot(fisheye2dline(:,1),fisheye2dline(:,2)+100,'r.','MarkerSize',20)
hold on
plot(perspective2dline(:,1),perspective2dline(:,2)-100,'k.','MarkerSize',20)
hold on
plot(perspective2dline(pspidxxx,1),perspective2dline(pspidxxx,2)-100,'g.','MarkerSize',20)
hold on
plot(0,0,'k*','MarkerSize',15,'LineWidth',3)
grid minor
xlim([-800,800])
ylim([-500,500])
legend('fisheye2dline','perspective2dline','FontSize',15)
title('Line shape','FontSize',15,'FontWeight','bold');