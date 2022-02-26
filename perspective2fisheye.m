function [ fishxy  ] = perspective2fisheye(px,py,m_xi,imageH)
syms fisheye_x fisheye_y;

% % T265
% m_imageWidth  = 848;
% m_imageHeight = 800;
% 
% m_xi          = 1.8;
% m_gamma1      = 810.0;
% m_gamma2      = 810.0;
% fov = 100;

% 180 fisheye
% m_imageWidth  = 1024.0;
% m_imageHeight = 1024.0;
m_imageWidth  = imageH;
m_imageHeight = imageH;

% m_xi          = 1.6;
% m_gamma1      = 1000.0;
% m_gamma2      = 1000.0;

m_gamma1  = imageH;
m_gamma2 = imageH;



m_u0          = m_imageWidth/2;
m_v0          = m_imageHeight/2;

% fov = 170;
% focal_length = m_imageHeight/2 /tan( (fov/2) *pi/180);
focal_length = 460;

m_inv_K11 = 1.0 / m_gamma1;
m_inv_K13 = -m_u0/ m_gamma1;
m_inv_K22 = 1.0 / m_gamma2;
m_inv_K23 = -m_v0/ m_gamma2;

mx_d = m_inv_K11 * fisheye_x ;
my_d = m_inv_K22 * fisheye_y ;
   
% assume no distortion
mx_u = mx_d;
my_u = my_d;

rho2_d = mx_u .* mx_u + my_u .* my_u;

pt3d = [mx_u, my_u, (  1.0 - m_xi*(rho2_d+1)./(m_xi + (1+ (1 - m_xi*m_xi).*rho2_d ).^.5  )    )   ];

% eq1 = focal_length*pt3d(:,1)./pt3d(:,3)+m_imageWidth/2 == px;
% eq2 = focal_length*pt3d(:,2)./pt3d(:,3)+m_imageHeight/2 == py;

eq1 = pt3d(:,1)./pt3d(:,3)== px;
eq2 = pt3d(:,2)./pt3d(:,3) == py;

[x0,y0] = vpasolve(eq1,eq2,fisheye_x,fisheye_y);

fishx = double(x0);
fishy = double(y0);
fishxy = [fishx,fishy];
end

