function [d_u] = distortion(p_u,m_k1,m_k2,m_p1,m_p2)

% m_k1          = 0.03312798577100497;
% m_k2          = -0.18400575464664853;
% m_p1          = 0.0006455357755426988;
% m_p2          = 0.001779817603737575;

mx2_u = p_u(:,1) .* p_u(:,1);
my2_u = p_u(:,2) .* p_u(:,2);
mxy_u = p_u(:,1) .* p_u(:,1);
rho2_u = mx2_u + my2_u;
rad_dist_u = m_k1 * rho2_u + m_k2 * rho2_u .* rho2_u;
d_u  = [p_u(:,1) .* rad_dist_u + 2.0 * m_p1 .* mxy_u + m_p2 * (rho2_u + 2.0 * mx2_u),p_u(:,2) .* rad_dist_u + 2.0 * m_p2 .* mxy_u + m_p1 .* (rho2_u + 2.0 * my2_u)];

end

