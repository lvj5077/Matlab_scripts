close all
clear 
r = 0;
Num = 300;
d = zeros(Num,(2*r+1),(2*r+1));

v = 240+60;
u = 320+60;

for i = 1:Num
    100*i/Num
    idx = 100+i;
    id = imread("/Users/jin/Q_Mac/data/dstereo/OBS200/depth/d"+num2str(idx)+".png");
%     id = imread("/Users/jin/Q_Mac/data/dstereo/RS_10kDepth/depth/"+num2str(idx)+".png");
    d(i,:,:) = id(v-r:v+r,u-r:u+r);
    
end
d = reshape(d,[Num*(2*r+1)^2,1]);
%%
d = d(d>0);
ivd = 1./d;
%
meanm = mean(d)
stdm = std(d)

errm = d - meanm;
titleszie = 40;

%%
figure,
% histfit(d);
histogram(d,'Normalization', 'pdf')
title("Depth",'FontSize',titleszie)

figure
histogram(ivd, 'Normalization', 'pdf')
% ,histfit(1./d);
title("Inverse Depth SC",'FontSize',titleszie)

%%
pd_d = fitdist(d,'Normal');
(pd_d.mu+2*pd_d.sigma) - (pd_d.mu-2*pd_d.sigma)
pd_d.sigma

1./(pd_d.sigma)
%%
pd_invd = fitdist(ivd,'Normal');
1/(pd_invd.mu-2*pd_invd.sigma) - 1/(pd_invd.mu+2*pd_invd.sigma)
pd_invd.sigma

%%
d = 0.2:0.1:80;
sigma_d_linear = d;
sigma_d_quadra = 5*d.^2;
d = 1000*d;

u_linear = zeros(length(d),1);
u_quadra = zeros(length(d),1);

sigma_linear = zeros(length(d),1);
sigma_quadra = zeros(length(d),1);

for i = 1:length(d)
    pppp_linear = d(i)+sigma_d_linear(i)*wgn(10000,1,0);
    pppp_linear = 1./pppp_linear;
    pd_invd = fitdist(pppp_linear,'Normal');
    u_linear(i) = pd_invd.mu;
    sigma_linear(i) = pd_invd.sigma;
    
    pppp_quadra = d(i)+sigma_d_quadra(i)*wgn(10000,1,0);
    pppp_quadra = 1./pppp_quadra;
    pd_invd = fitdist(pppp_quadra,'Normal');
    u_quadra(i) = pd_invd.mu;
    sigma_quadra(i) = pd_invd.sigma;
end

%%

figure,plot(d,sigma_d_linear,'.'),title("d vs sigma linear")
figure,plot(d,sigma_d_quadra,'.'),title("d vs sigma quardra")
figure,plot(1./d,sigma_linear,'.'),title("invd vs inv sigma linear")
figure,plot(1./d,sigma_quadra,'.'),title("invd vs inv sigma quardra")
%%
figure,plot(d,sigma_linear,'.'),title("d vs inv sigma linear")
figure,plot(d,sigma_quadra,'.'),title("d vs inv sigma quardra")

%%
figure,plot(sigma_d_quadra./d.^2,sigma_quadra,'.'),title("sigma quardra/d2 vs inv sigma quardra")
%%
for i = 1:100:700
    ps = d(i)+sigma_d_linear(i)*wgn(10000,1,0);
    figure, 
    subplot(2,1,1),
    histogram(ps, 'Normalization', 'pdf')
    subplot(2,1,2),
    histogram(1./ps, 'Normalization', 'pdf')
end
%%
for i = 1:100:700
    ps = 1./d(i)+(1e-6)*wgn(10000,1,0);
    figure, 
    subplot(2,1,1),
    histogram(ps, 'Normalization', 'pdf')
    subplot(2,1,2),
    histogram(1./ps, 'Normalization', 'pdf')
end
%%
std = 1.5;
u = 40;
x= linspace(30,50,100000);
X = (1/(2*pi*std)^.5)*exp(-((x-u).^2)/(2*std^2));
figure,plot(1./x,1./X);
%%
ps = 1/0.01+(1e-6)*wgn(10000,1,0);histogram(1./ps, 'Normalization', 'pdf')
ps = 1/0.1+(1e-6)*wgn(10000,1,0);histogram(1./ps, 'Normalization', 'pdf')


%%
y1 = (0.005)*wgn(1000,1,0)+3;
y2 = 0.5*wgn(1000,1,0)+200;
stdZ = std(y1)
stdx = std(y2)
mean(y1)
%%

y = y1.*(y2-320)/460;
stdX = std(y)
histfit(y)

hsf=(( std(y1)^2 * std(y2)^2)/( std(y1)^2 + std(y2)^2))^.5


%%
std = 1.5;
u = 40;
x= linspace(30,50,100000);
X = (1/(2*pi*std)^.5)*exp(-((x-u).^2)/(2*std^2));
figure,plot(x,X);
std = 1.5/1000;
u = 4;
d= linspace(3.9,4.1,100000);
D = (1/(2*pi*std)^.5)*exp(-((d-u).^2)/(2*std^2)); 
figure,plot(d,D);

XX = X.*D;

figure,plot(d,D);
%%
%%

depth = [1,2,4,8,12,16];
z = linspace(0.00001,20,10000);
invz = linspace(0.00001,1.5,10000);
figure
subplot(3,1,1)
for i = 1:length(depth)
    u = depth(i);
    std = (u*0.3+0.3)/10;
    hold on
    D = (1/(2*pi*std)^.5)*exp(-((z-u).^2)/(2*std^2));
    plot(z,D,'LineWidth',5);
end
grid minor
set(gca,'FontSize',30)
legend({'1m','2m','4m','8m','12m','16m'},'FontSize',20)
title("Depth likelihood",'FontSize',40,'FontWeight','bold')
%
subplot(3,1,2)
for i = 1:length(depth)
    u = depth(i);
    std = (u*0.3+0.3)/10;
    hold on
    D = (1./((invz.^2)*2*pi*std).^.5).*exp(-((1./invz-u).^2)/(2*std^2));
    plot(invz,D,'LineWidth',5);
end
grid minor
set(gca,'FontSize',30)
legend({'1m','2m','4m','8m','12m','16m'},'FontSize',20)
title("Inverse depth likelihood",'FontSize',40,'FontWeight','bold')
%
subplot(3,1,3)
for i = 1:length(depth)
    u = depth(i);
    std_ = (u*0.3+0.3)/10 /(u^2);
    hold on
    D = (1./(2*pi*std_).^.5).*exp(-((invz-1/u).^2)/(2*std_^2));
    plot(invz,D,'LineWidth',5);
end
grid minor
set(gca,'FontSize',30)
legend({'1m','2m','4m','8m','12m','16m'},'FontSize',20)
title("Inverse depth Approxi likelihood",'FontSize',40,'FontWeight','bold')
%%
depth = [1,2,3,4,5];
z = linspace(0.00001,7,10000);
invz = linspace(0.00001,1.1,10000);
figure
subplot(3,1,1)
std = 5e-3;
for i = 1:length(depth)
    u = 1/depth(i);
%     std = 5e-5;
    hold on
    D = (1/(2*pi*std)^.5)*exp(-((invz-u).^2)/(2*std^2));
    plot(invz,D,'LineWidth',5);
end
grid minor
set(gca,'FontSize',30)
legend({'1m','2m','3m','4m','5m'},'FontSize',20)
title("Inverse Depth likelihood",'FontSize',40,'FontWeight','bold')
%
subplot(3,1,2)
for i = 1:length(depth)
    u = 1/depth(i);
    
    hold on
    D = (1./((z.^2)*2*pi*std).^.5).*exp(-((1./z-u).^2)/(2*std^2));
    plot(z,D,'LineWidth',3);
end
% xlim([0,20])
grid minor
set(gca,'FontSize',30)
legend({'1m','2m','3m','4m','5m'},'FontSize',20)
title("Depth likelihood",'FontSize',40,'FontWeight','bold')
subplot(3,1,3)
for i = 1:length(depth)
    u = depth(i);
    
    std = 5e-3 * u^2;
    hold on
    D = (1/(2*pi*std)^.5)*exp(-((z-u).^2)/(2*std^2));
    plot(z,D,'LineWidth',3);
end
% xlim([0,20])
grid minor
set(gca,'FontSize',30)
legend({'1m','2m','3m','4m','5m'},'FontSize',20)
title("Depth Approxi likelihood",'FontSize',40,'FontWeight','bold')