titleSize =50
labelSize =20
xyzsize = 30 


x = 1:10;
x = [0.5,x];
de = zeros(8,1);
for i = 1:11
    de(i) = 20*20*1/(0.2*500*i);
end

p1 = plot(640*x,de*1000,'r','LineWidth',3);

hold on,
p2 = plot(640*x,de*1000*2,'g','LineWidth',3);

hold on,
p3 = plot(640*x,de*1000*3,'b','LineWidth',3);

grid minor

title("depth error vs resolution @ 20 m",'FontSize',titleSize,'FontWeight','bold')
xlabel("resolution (pixel)",'FontSize',labelSize,'FontWeight','bold')
y=ylabel("std (mm)",'FontSize',1.3*labelSize,'FontWeight','bold');
set(gca,'FontSize',xyzsize)
set(gcf,'color','w');

legend("baseline = 200mm","baseline = 100mm","baseline = 50mm")


%%
clear
clc
resS = [640,1280,1920,2560,3200,3840,5120,7680,8960,10240];
baselineS = [10,20,30,40,50,60]/100;
distanceS = [0.2,0.5,1,2,5,10,15,20];


[X,Y] = meshgrid(baselineS,distanceS);
res = resS(10)
ZF = 1000*Y.*Y*1./(X*500*res/640);


%%
titleSize =50
labelSize =20
xyzsize = 30 
x = 320*[1:29];
y = 10*[10, 20, 30, 40, 50, 60];
z = 1:20;
[X,Y] = meshgrid(x,y);

F = 1000*20*20*1./(Y/1000*500.*X/640);
figure,surf(X,Y,F)
colorbar
title("depth error vs resolution and baseline @ distance = 20m",'FontSize',titleSize,'FontWeight','bold')
xlabel("resolution (pixel)",'FontSize',labelSize,'FontWeight','bold')
ylabel("baseline (mm)",'FontSize',1.3*labelSize,'FontWeight','bold');
zlabel("std (mm)",'FontSize',1.3*labelSize,'FontWeight','bold');
set(gca,'FontSize',xyzsize)
set(gcf,'color','w');
%%
%%
titleSize =50;
labelSize =20;
xyzsize = 30; 
x = 320*[1:29];
y = 10*[10, 20, 30, 40, 50, 60];
z = 1:20;
[X,Y] = meshgrid(x,z);

F = 1000*Y.*Y*1./(.2*500.*X/640);
figure,surf(X,Y,F)
colorbar
title("depth error vs resolution and distance @ baseline = 20 cm",'FontSize',titleSize,'FontWeight','bold')
xlabel("resolution (pixel)",'FontSize',labelSize,'FontWeight','bold')
ylabel("distance (m)",'FontSize',1.3*labelSize,'FontWeight','bold');
zlabel("std (mm)",'FontSize',1.3*labelSize,'FontWeight','bold');
set(gca,'FontSize',xyzsize)
set(gcf,'color','w');
%%
titleSize =50;
labelSize =20;
xyzsize = 30; 
x = 320*[1:29];
y = 10*[10, 20, 30, 40, 50, 60];
z = 1:20;
[X,Y] = meshgrid(y,z);

F = 1000*Y.*Y*1./(500*6*X/1000);
figure,surf(X,Y,F)
colorbar
title("depth error vs distance and baseline @ resolution = 3840(4k)",'FontSize',titleSize,'FontWeight','bold')
xlabel("baseline (mm)",'FontSize',labelSize,'FontWeight','bold')
ylabel("distance (m)",'FontSize',1.3*labelSize,'FontWeight','bold');
zlabel("std (mm)",'FontSize',1.3*labelSize,'FontWeight','bold');
set(gca,'FontSize',xyzsize)
set(gcf,'color','w');