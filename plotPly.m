titleSize =70
labelSize =40
xyzsize = 50
% dd = importdata("/Users/jin/Downloads/repaintAll.csv");
x_l = 1000*[0.805905, 0.999542, 1.17967, 1.39792, 1.60014, 1.80247, 1.99245, 2.23163, 2.41875, 2.59499, 2.79938, 3.01259, 3.187, 3.39712, 3.58915, 3.77409, 3.96532, 4.16022, 4.33841, 4.56283, 4.93774, 5.08778, 5.33211, 5.49748, 5.74617, 5.90959, 6.12074, 6.29149, 6.58892, 6.71939, 6.95399, 7.1355];
std_l =1000*[0.000727939, 0.00117601, 0.00166713, 0.00221071, 0.00171963, 0.00289148, 0.0043574, 0.00439971, 0.00620145, 0.00542744, 0.0125936, 0.0104017, 0.00840924, 0.0105343, 0.011435, 0.0148287, 0.0164929, 0.0174127, 0.0140677, 0.0172327, 0.033716, 0.02063, 0.0268778, 0.0336935, 0.0279987, 0.0407693, 0.0360158, 0.0388805, 0.043303, 0.0465069, 0.0757872, 0.054274];
dd = [x_l;std_l]';

figure,pt1 = plot(dd(:,1),dd(:,2),'o','Color',[0, 0.4470, 0.7410],'LineWidth',5),grid minor
p1=fit(dd(1:32,1),dd(1:32,2),'poly2')
hold on, pt2 = plot(dd(:,1),p1(dd(:,1)),'r','LineWidth',5)
hold on, pt3 = plot(dd(:,1),p1(dd(:,1)),'b.','MarkerSize',20)

title("Depth Measurement Error",'FontSize',titleSize,'FontWeight','bold')
xlabel("Distance (mm)",'FontSize',labelSize,'FontWeight','bold')
y=ylabel("Depth RMS Error (mm)",'FontSize',1.3*labelSize,'FontWeight','bold');


% set(y, 'position', get(y,'position')-[0.01,0,0]); 
xlim([800 7200])
ylim([0 80])

% xlim([400 2400])
% ylim([4 24])

set(get(gca,'ylabel'),'rotation',0)
set(gca,'FontSize',xyzsize)
set(gcf,'color','w');
set(get(gca,'YLabel'),'Rotation',90)
legend([pt1 pt2 pt3],{'Raw Data','Fitted Curve', 'Fitted Data'},'FontSize',30)