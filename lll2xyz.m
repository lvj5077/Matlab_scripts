gps_data = importdata("/Volumes/Dreame/Dreame/data/Dreame_data/9_10/dataset_0910/3/gps0.log");
lll  = gps_data(:,5:7);

origin = lll(1,:);

[xx,yy,zz] = latlon2local(lll(:,1),lll(:,2),lll(:,3),origin);
trajGPS = [gps_data(:,1)/1e6,xx,yy,zz];

plot3(xx,yy,zz)
axis equal
grid minor

csvwrite('xyz.csv', [xx,yy,zz])
%%

plot3(gps_data(:,5),gps_data(:,6),gps_data(:,7))
% axis equal