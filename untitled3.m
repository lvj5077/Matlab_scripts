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