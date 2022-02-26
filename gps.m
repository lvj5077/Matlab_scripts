clear
ddd = importdata('/Users/jin/Downloads/GPS.txt');
geoplot(ddd(:,2),ddd(:,3),'r:','LineWidth',4)
geolimits([min(ddd(:,2)) max(ddd(:,2))],[min(ddd(:,3)) max(ddd(:,3))])
geobasemap satellite