function [ fishxy  ] = perspective2fisheyeSZ(px,py)
syms fisheye_x fisheye_y;

m_xi          = 1.6251176280117137e+00;

m_k1          = -2.6856346207595089e-01;
m_k2          = 2.1779060171627043e-03;
m_p1          = 2.4472150289470505e-03;
m_p2          = -7.2768398305902548e-04;



m_gamma1      = 7.0546098247632870e+02;
m_gamma2      = 7.0628523918581345e+02;
m_u0          = 9.3694082238300712e+02;
m_v0          = 5.7349729602745151e+02;


m_inv_K11 = 1.0 / m_gamma1;
m_inv_K13 = -m_u0/ m_gamma1;
m_inv_K22 = 1.0 / m_gamma2;
m_inv_K23 = -m_v0/ m_gamma2;

mx_d = m_inv_K11 * fisheye_x;
my_d = m_inv_K22 * fisheye_y;
   
% assume no distortion
mx_u = mx_d;
my_u = my_d;

% mx2_d = mx_d.*mx_d;
% my2_d = my_d.*my_d;
% mxy_d = mx_d.*my_d;
% rho2_d = mx2_d+my2_d;
% rho4_d = rho2_d.*rho2_d;
% radDist_d = m_k1*rho2_d+m_k2*rho4_d;
% Dx_d = mx_d.*radDist_d + m_p2.*(rho2_d+2*mx2_d) + 2*m_p1.*mxy_d;
% Dy_d = my_d.*radDist_d + m_p1.*(rho2_d+2*my2_d) + 2*m_p2.*mxy_d;
% inv_denom_d = 1/(1+4*m_k1*rho2_d+6*m_k2*rho4_d+8*m_p1*my_d+8*m_p2*mx_d);
% 
% mx_u = mx_d - inv_denom_d*Dx_d;
% my_u = my_d - inv_denom_d*Dy_d;

rho2_d = mx_u .* mx_u + my_u .* my_u;
pt3d = [mx_u, my_u, (  1.0 - m_xi*(rho2_d+1)./(m_xi + (1+ (1 - m_xi*m_xi).*rho2_d ).^.5  )    )   ];

eq1 = pt3d(:,1)./pt3d(:,3)== px;
eq2 = pt3d(:,2)./pt3d(:,3) == py;

[x0,y0] = vpasolve(eq1,eq2,fisheye_x,fisheye_y);

fishx = double(x0) + m_u0;
fishy = double(y0) + m_v0;
fishxy = [fishx,fishy];
end

