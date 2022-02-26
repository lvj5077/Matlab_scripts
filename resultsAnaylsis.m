clc
clear
titleSize =30;
labelSize =20;
xyzsize = 30;

titleSize =30;
labelSize =20;
xyzsize = 30;

base_dir = "/Users/jin/Desktop/Dreame/Code/frontend_analysis/output/";

sub_dir = "1/";
d_ls = importdata(base_dir+sub_dir+"checkLifespan.txt");
d_ts = importdata(base_dir+sub_dir+"timestamp.txt");
% d_ts = 1:length(d_ls);
h = figure('units','normalized','outerposition',[0 0 0.7 1]);
p1 = plot(d_ts, d_ls(:,10) ./ d_ls(:,1),'LineWidth',5);

sub_dir = "2/";
d_ls = importdata(base_dir+sub_dir+"checkLifespan.txt");
d_ts = importdata(base_dir+sub_dir+"timestamp.txt");
% d_ts = 1:length(d_ls);
hold on,
p2 = plot(d_ts, d_ls(:,10) ./ d_ls(:,1) ,'LineWidth',5);