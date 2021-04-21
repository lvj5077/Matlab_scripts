path = '/Volumes/BlackSSD/drone_04_2021/drone411/2021-04-11T13-21-36/';
acc = importdata(path+"acc.txt");
vis = importdata(path+"Frames.txt");

validlength = min(acc(end,1),vis(end,1)) - max(acc(1,1),vis(1,1))

freq_acc = acc(2:end,1)-acc(1:end-1,1);
mean(1./freq_acc)

freq_vis = vis(2:end,1)-vis(1:end-1,1);
mean(1./freq_vis)