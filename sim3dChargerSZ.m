Range = 0.5:.1:2;
H2ds = zeros(length(Range),1);
W2ds = zeros(length(Range),1);

for i = 1:length(Range)
    [H2ds(i),W2ds(i)] = func_sim3dcharger(Range(i));
end

pt1 = plot(Range,H2ds,'LineWidth',5);
hold on
pt2 = plot(Range,W2ds,'LineWidth',5);

grid minor 
set(gcf,'color','w');
legend([pt1 pt2],{'height in 2d','width in 2d'},'FontSize',30)

xlabel("angle(rad)",'FontSize',30,'FontWeight','bold')
ylabel("size(pixel)",'FontSize',30,'FontWeight','bold');
set(gca,'FontSize',20)
set(gca,'LineWidth',5) 