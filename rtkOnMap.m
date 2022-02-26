ddd1 = importdata("/Users/jin/Desktop/downstair03/gps0.txt");
ddd1 = ddd1(ddd1(:,5)<1,:);
acc = 100*ddd1(:,5).^0.5;
ts = ddd1(:,1)-ddd1(1,1);

tt = 500000;
acc = acc(ts<tt);
latS = ddd1(ts<tt,2);
lonS = ddd1(ts<tt,3);

ts = ts(ts<tt);
figure,
geoplot(latS(1),lonS(1),'o','MarkerSize',4,'LineWidth',3);
hold on
geoplot(latS(:),lonS(:),'LineWidth',3);
% MaxAcc = max(acc);
% MinAcc = min(acc);
% xxx = linspace(MinAcc,MaxAcc,100);
% rrr = linspace(0,1,100);
% ccc = interp1(xxx,rrr,acc);
% figure,
% geoplot(latS(1),lonS(1),'o','MarkerSize',4,'LineWidth',3,'MarkerEdgeColor',[1*ccc(1),0,1-1*ccc(1)]);
% 
% % h = figure('units','normalized','outerposition',[0 0 0.7 1]);
% for i = 1:length(ts)
%     hold on 
%     geoplot(latS(i),lonS(i),'o','MarkerSize',4,'LineWidth',3,'MarkerEdgeColor',[1*ccc(i),0,1-1*ccc(i)]);
% end

geolimits([min(latS)-0.0001 max(latS)+0.0001],[min(lonS)-0.00001 max(lonS)+0.00001])
geobasemap satellite