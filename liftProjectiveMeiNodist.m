function [pt2dL,focal_length] = liftProjectiveMeiNodist(pt2d,m_xi,imageH)

m_imageWidth  = imageH;
m_imageHeight = imageH;

m_gamma1  = imageH;
m_gamma2 = imageH;



m_u0          = m_imageWidth/2;
m_v0          = m_imageHeight/2;


focal_length = m_gamma1*(  1 - m_xi/( m_xi + 1 ) );


m_inv_K11 = 1.0 / m_gamma1;
m_inv_K22 = 1.0 / m_gamma2;

mx_d = m_inv_K11 * pt2d(:,1);
my_d = m_inv_K22 * pt2d(:,2);
   
mx_u = mx_d;
my_u = my_d;

rho2_d = mx_u .* mx_u + my_u .* my_u;

pt3d = [mx_u, my_u, (  1.0 - m_xi*(rho2_d+1)./(m_xi + (1+ (1 - m_xi*m_xi).*rho2_d ).^.5  )    )   ];


pt2dL(:,1) = focal_length*pt3d(:,1)./pt3d(:,3);
pt2dL(:,2) = focal_length*pt3d(:,2)./pt3d(:,3);

    
end

