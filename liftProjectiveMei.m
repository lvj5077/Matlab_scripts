function [pt2dL,focal_length] = liftProjectiveMei(pt2d)
% m_imageWidth  = 848;
% m_imageHeight = 800;
% 
% m_xi          = 1.833520715696702;
% m_k1          = 0.03312798577100497;
% m_k2          = -0.18400575464664853;
% m_p1          = 0.0006455357755426988;
% m_p2          = 0.001779817603737575;
% m_gamma1      = 811.1617801398031;
% m_gamma2      = 810.7955229935435;
% m_u0          = 416.63310860537547;
% m_v0          = 400.0037433078293;

m_xi          = 1.8082228930882507e+00;

% m_xi          = 2.15;

m_k1          = -4.8155096188300234e-01;
m_k2          = 2.2606098435793691e-02;
m_p1          = -1.8039601977670558e-03;
m_p2          = -1.3976262998824433e-05;

% 
% m_k1          = 0;
% m_k2          = 0;
% m_p1          = 0;
% m_p2          = 0;


m_gamma1      = 1.0860364756094386e+03;
m_gamma2      = 1.0855284174282228e+03;
m_u0          = 6.1315328293176401e+02;
m_v0          = 5.2561546993273339e+02;


focal_length = m_gamma1*(  1 - m_xi/( m_xi + 1 ) );
focal_length = 460;

% m_u0          = 1224/2;
% m_v0          = 1024/2;

m_inv_K11 = 1.0 / m_gamma1;
m_inv_K13 = -m_u0/ m_gamma1;
m_inv_K22 = 1.0 / m_gamma2;
m_inv_K23 = -m_v0/ m_gamma2;

mx_d = m_inv_K11 * pt2d(:,1) + m_inv_K13;
my_d = m_inv_K22 * pt2d(:,2) + m_inv_K23;
   

% mx_u = mx_d;
% my_u = my_d;
% 
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


d_u = distortion([mx_d, my_d],m_k1,m_k2,m_p1,m_p2);
mx_u = mx_d - d_u(:,1);
my_u = my_d - d_u(:,2);


for i=1:10
   d_u=  distortion([mx_u, my_u],m_k1,m_k2,m_p1,m_p2);
    mx_u = mx_d - d_u(:,1);
    my_u = my_d - d_u(:,2);

end

rho2_d = mx_u .* mx_u + my_u .* my_u;

pt3d = [mx_u, my_u, (  1.0 - m_xi*(rho2_d+1)./(m_xi + (1+ (1 - m_xi*m_xi).*rho2_d ).^.5  )    )   ]
% 
% pt2dL(:,1) = 460*pt3d(:,1)./pt3d(:,3)+m_imageWidth/2;
% pt2dL(:,2) = 460*pt3d(:,2)./pt3d(:,3)+m_imageHeight/2;

% pt3d = [pt3d(:,3),-pt3d(:,2),-pt3d(:,1)];

% pt3d = [pt3d(:,1),-pt3d(:,3),pt3d(:,2)];
% pt3d = pt3d(pt2d(:,2)>512,:);

pt2dL(:,1) = focal_length*pt3d(:,1)./pt3d(:,3);
pt2dL(:,2) = focal_length*pt3d(:,2)./pt3d(:,3);

% pt2dL(:,1) = pt3d(:,1)./pt3d(:,3);
% pt2dL(:,2) = pt3d(:,2)./pt3d(:,3);
%     
end

