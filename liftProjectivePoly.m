function [pt3d,pt2dL] = liftProjectivePoly(pt2d)
% pt2d = prevPts;
m_imageWidth  = 848;
m_imageHeight = 800;

k2=1.4883871068786588e-03;
k3=-4.0041365957719545e-02;
k4=1.0475982508022741e-01;
k5=-6.1475339439914609e-02;
k6=2.3463607911536049e-03;
k7=-5.1751367290696513e-03;
p1=-4.6184732530195317e-09;
p2=-2.3481938092958704e-08;
a11=2.8753215022342374e+02;
a12=-1.9409366069582853e-01;
a22=2.8738689085357436e+02;
u0=4.1731857243743809e+02;
v0=4.0038830498456008e+02;

K = [a11, a12, u0; 0, a22, v0; 0, 0, 1];
K_inv = inv(K);
m_inv_K11 = K_inv(1, 1);
m_inv_K12 = K_inv(1, 2);
m_inv_K13 = K_inv(1, 3);
m_inv_K22 = K_inv(2, 2);
m_inv_K23 = K_inv(2, 3);

% p_u = [ m_inv_K11 .* pt2d(:,1) + m_inv_K12 .* pt2d(:,2) + m_inv_K13,m_inv_K22 .* pt2d(:,2) + m_inv_K23];
% 
% r = vecnorm(p_u');
% 
% 
% 
% sin_phi = p_u(:,2) / r;
% cos_phi = p_u(:,1) / r;
% 
% theta = poly->getOneRealRoot(r, 0.0, MAX_INCIDENT_ANGLE_DEGREE / RAD2DEG);
% % if (theta < 1e-10)
% %     theta = 3.14;
% 
% sin_theta = sin(theta);
% cos_theta = cos(theta);
% end


p_u = [m_inv_K11 * pt2d(:,1) + m_inv_K13, m_inv_K22 .* pt2d(:,2) + m_inv_K23];

r = vecnorm(p_u');
sin_phi = p_u(:,2) ./ r;
cos_phi = p_u(:,1) ./ r;
cos_theta = cos(r);
sin_theta = (1 - cos_theta .* cos_theta).^.5; 

pt3d = [cos_phi * sin_theta', sin_phi' * sin_theta', cos_theta'];

pt2dL(:,1) = 460*pt3d(:,1)./pt3d(:,3)+m_imageWidth/2;
pt2dL(:,2) = 460*pt3d(:,2)./pt3d(:,3)+m_imageHeight/2;
end

