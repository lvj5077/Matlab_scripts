
fisheye_x = 1000;
fisheye_y = 1000;

syms m_xi;



% 180 fisheye
m_imageWidth  = 1024.0;
m_imageHeight = 1024.0;

% m_xi          = 1.6;
m_gamma1      = 1024.0;
m_gamma2      = 1024.0;


m_u0          = m_imageWidth/2;
m_v0          = m_imageHeight/2;

m_inv_K11 = 1.0 / m_gamma1;
m_inv_K13 = -m_u0/ m_gamma1;
m_inv_K22 = 1.0 / m_gamma2;
m_inv_K23 = -m_v0/ m_gamma2;

mx_d = m_inv_K11 * fisheye_x + m_inv_K13;
my_d = m_inv_K22 * fisheye_y + m_inv_K23;
   
% assume no distortion
mx_u = mx_d;
my_u = my_d;

rho2_d = mx_u .* mx_u + my_u .* my_u;

eq = (  1.0 - m_xi*(rho2_d+1)./(m_xi + (1+ (1 - m_xi*m_xi).*rho2_d ).^.5  )    )  == 0.0000001;

[xi0] = vpasolve(eq,m_xi);


double(xi0)

%%

xi = 1.6:0.1:1.9;
z = (  1.0 - xi.*(rho2_d+1)./(xi + (1+ (1 - xi.*xi).*rho2_d ).^.5  )    );
plot(xi,z)
%%
H = 1:10;
pixelL = zeros(length(H),1);
for i = 1:length(H)
    pixelL(i) = checkPixelLength(H(i));
end
%
figure, plot (H,pixelL,'LineWidth',3);
hold on, plot (H,pixelL,'r*','MarkerSize',5);
grid minor
xlabel ("camera height",'FontSize',20,'FontWeight','bold');
ylabel ("human pixel length @1024 pixel",'FontSize',20,'FontWeight','bold');

%%
syms focal_length

eq = 4 * asin (800/(focal_length* 4))*180/pi == 100;

[focal_length0] = vpasolve(eq, focal_length);

double(focal_length0)