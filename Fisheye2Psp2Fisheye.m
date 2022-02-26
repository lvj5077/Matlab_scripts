clear
close all
m_imageWidth  = 848.0;
m_imageHeight = 800.0;

m_gamma1      = 807.0;
m_gamma2      = 813.0;

m_xi          = 1.8;

m_u0 = m_imageWidth/2;
m_v0 = m_imageHeight/2;

m_inv_K11 = 1.0 / m_gamma1;
m_inv_K13 = -m_u0/ m_gamma1;
m_inv_K22 = 1.0 / m_gamma2;
m_inv_K23 = -m_v0/ m_gamma2;



I = zeros(800,848,3);
   
for fish_x = 1: 848
    for fish_y=1:800
        mx_u = m_inv_K11 * fish_x + m_inv_K13;
        my_u = m_inv_K22 * fish_y + m_inv_K23;
        rho2_d = mx_u .* mx_u + my_u .* my_u;

        pt3d = [mx_u, my_u, (  1.0 - m_xi*(rho2_d+1)./(m_xi + (1+ (1 - m_xi*m_xi).*rho2_d ).^.5  )    )   ];

        norm_x = pt3d(:,1)./pt3d(:,3);
        norm_y = pt3d(:,2)./pt3d(:,3);

        norm_xy = [norm_x,norm_y];
        z_m = 1+m_xi*norm([norm_x,norm_y,1]);
        p_u_x = norm_x/z_m;
        p_u_y = norm_y/z_m;
        calfish_x = m_gamma1*p_u_x+m_u0;
        calfish_y = m_gamma2*p_u_y+m_v0;
        calfishxy = [calfish_x,calfish_y];
        if abs(fish_x-calfish_x)>5
            I(fish_y,fish_x,:)=[255,0,0];
            if(isreal(calfish_x))
                I(fish_y,fish_x,:)=[0,255,0];
                [calfish_x,calfish_y,fish_x,fish_y]
            end
        end
    end
end
I = uint8(I);
figure,
imshow(I)