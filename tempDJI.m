close all
clear

titleSize =50
labelSize =20
xyzsize = 30

xy = [0.00171,55.0441
0.39751,48.055
0.53019,46.3086
0.59425,45.5027
0.67659,44.7421
0.79554,43.5337
1.12951,40.2222
1.21872,39.4169
1.29649,38.9703
2.69171,31.1999];

xx = linspace(-.5,2.7,100);
p1=fit(xy(:,1),xy(:,2),'poly2');
yy = p1(xx);
% yy = interp1(xy(:,1),xy(:,2),xx);
figure
plot(xx,yy,'r','LineWidth',5)

hold on
plot(xy(:,1),xy(:,2),'b.','LineWidth',5,'MarkerSize',50)
% hold on
grid minor

xlim([0,3])
xlabel("Payload Weight (kg)",'FontSize',labelSize,'FontWeight','bold')
y=ylabel("Max Flight Time (min)",'FontSize',1.3*labelSize,'FontWeight','bold');
set(y, 'position', get(y,'position')-[0.01,0,0]); 
set(get(gca,'YLabel'),'Rotation',90)

set(gca,'FontSize',xyzsize)
set(gcf,'color','w');