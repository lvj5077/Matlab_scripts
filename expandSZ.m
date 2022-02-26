close all
clc
clear

% t265 286.28
focal_length = 300;
LargeW = 2*focal_length;
I = imread("/Users/jin/Downloads/calibr_cata/png/left-00017.png");
I = rgb2gray(I);
outpath = "/Users/jin/Downloads/testCataOut.jpg";
figure, imshow(I)
m_xi        = 1.3055863193;
m_k1        = -0.3122501738;
m_k2        = 0.1976074243;
m_p1        = -0.0006213341;
m_p2        = 0.0014708529;
m_gamma1    = 677.4430202578;
m_gamma2    = 677.3642933470;
% Mirror Parameters
%             xi 1.3055863193
% Distortion Parameters
%             k1 -0.3122501738
%             k2 0.1976074243
%             p1 -0.0006213341
%             p2 0.0014708529
% Projection Parameters
%         gamma1 677.4430202578
%         gamma2 677.3642933470
%             u0 686.5746584142
%             v0 522.4568873584
m_u0        = 686.5746584142;
m_v0        = 522.4568873584;

m_imageWidth  = 1280;
m_imageHeight = 1024;

idxx =0;


m_inv_K11 = 1.0 / m_gamma1;
m_inv_K13 = -m_u0/ m_gamma1;
m_inv_K22 = 1.0 / m_gamma2;
m_inv_K23 = -m_v0/ m_gamma2;



[h,w,d] = size(I);

for i =1:h
    for j = 1:w
        if(norm([j,i]-[m_u0,m_v0])>490)
            I(i,j,:) = [0];
        end
    end
end

I_temp = zeros(LargeW,LargeW,1);

I_center = zeros(LargeW,LargeW,1);
I_left = zeros(LargeW,LargeW,1);
I_right = zeros(LargeW,LargeW,1);
I_top = zeros(LargeW,LargeW,1);
I_bottom = zeros(LargeW,LargeW,1);

Iremap = zeros(size(I));

for i = 1:h
    for j = 1:w

        fish_x = j;
        fish_y = i;
        mx_u = m_inv_K11 * fish_x + m_inv_K13;
        my_u = m_inv_K22 * fish_y + m_inv_K23;


        mx_d = mx_u;
        my_d = my_u;

        mx2_d = mx_d.*mx_d;
        my2_d = my_d.*my_d;
        mxy_d = mx_d.*my_d;
        rho2_d = mx2_d+my2_d;
        rho4_d = rho2_d.*rho2_d;
        radDist_d = m_k1*rho2_d+m_k2*rho4_d;
        Dx_d = mx_d.*radDist_d + m_p2.*(rho2_d+2*mx2_d) + 2*m_p1.*mxy_d;
        Dy_d = my_d.*radDist_d + m_p1.*(rho2_d+2*my2_d) + 2*m_p2.*mxy_d;
        inv_denom_d = 1/(1+4*m_k1*rho2_d+6*m_k2*rho4_d+8*m_p1*my_d+8*m_p2*mx_d);

        mx_u = mx_d - inv_denom_d*Dx_d;
        my_u = my_d - inv_denom_d*Dy_d;

        rho2_d = mx_u .* mx_u + my_u .* my_u;

        pt3d = [mx_u, my_u, (  1.0 - m_xi*(rho2_d+1)./(m_xi + (1+ (1 - m_xi*m_xi).*rho2_d ).^.5  )    )   ];

        % pt3d = [pt3d(:,3),-pt3d(:,2),-pt3d(:,1)];

        % pt3d = [pt3d(:,1),-pt3d(:,3),pt3d(:,2)];


        pt2dL(:,1) = focal_length*pt3d(:,1)./pt3d(:,3);
        pt2dL(:,2) = focal_length*pt3d(:,2)./pt3d(:,3);

        x = (round(pt2dL(2)))+LargeW/2;
        y = (round(pt2dL(1)))+LargeW/2;
        if ( x<=LargeW && y<=LargeW && x>=1 && y>=1 )
            if (isreal(pt2dL))
                I_temp(x,y,:) = I(i,j,:);
                Iremap(i,j,:) = I(i,j,:);
            else
                idxx= idxx +1;
                Iremap(i,j,:) = 255;
            end

        end

    end
end
%
Iremap = uint8(Iremap);
I_temp = uint8(I_temp);

figure,imshow(Iremap)
% set(gcf,'color','w');
% set(gca,'color','w');

I_center = I_temp;

%%
I_temp = zeros(LargeW,LargeW,1);
for i = 1:h/2
    for j = 1:w

        fish_x = j;
        fish_y = i;
        mx_u = m_inv_K11 * fish_x + m_inv_K13;
        my_u = m_inv_K22 * fish_y + m_inv_K23;


        mx_d = mx_u;
        my_d = my_u;

        mx2_d = mx_d.*mx_d;
        my2_d = my_d.*my_d;
        mxy_d = mx_d.*my_d;
        rho2_d = mx2_d+my2_d;
        rho4_d = rho2_d.*rho2_d;
        radDist_d = m_k1*rho2_d+m_k2*rho4_d;
        Dx_d = mx_d.*radDist_d + m_p2.*(rho2_d+2*mx2_d) + 2*m_p1.*mxy_d;
        Dy_d = my_d.*radDist_d + m_p1.*(rho2_d+2*my2_d) + 2*m_p2.*mxy_d;
        inv_denom_d = 1/(1+4*m_k1*rho2_d+6*m_k2*rho4_d+8*m_p1*my_d+8*m_p2*mx_d);

        mx_u = mx_d - inv_denom_d*Dx_d;
        my_u = my_d - inv_denom_d*Dy_d;

        rho2_d = mx_u .* mx_u + my_u .* my_u;

        pt3d = [mx_u, my_u, (  1.0 - m_xi*(rho2_d+1)./(m_xi + (1+ (1 - m_xi*m_xi).*rho2_d ).^.5  )    )   ];

        % pt3d = [pt3d(:,3),-pt3d(:,2),-pt3d(:,1)];

        pt3d = [pt3d(:,1),pt3d(:,3),-pt3d(:,2)];


        pt2dL(:,1) = focal_length*pt3d(:,1)./pt3d(:,3);
        pt2dL(:,2) = focal_length*pt3d(:,2)./pt3d(:,3);

        x = (round(pt2dL(2)))+LargeW/2;
        y = (round(pt2dL(1)))+LargeW/2;
        if ( x<=LargeW && y<=LargeW && x>=1 && y>=1 )
            if (isreal(pt2dL))
                I_temp(x,y,:) = I(i,j,:);
                Iremap(i,j,:) = I(i,j,:);
            else
                idxx= idxx +1;
                Iremap(i,j,:) = 255;
            end

        end

    end
end
%
Iremap = uint8(Iremap);
I_temp = uint8(I_temp);


% figure,imshow(I_temp)
% set(gcf,'color','w');
% set(gca,'color','w');

I_top = I_temp;
%%
I_temp = zeros(LargeW,LargeW,1);
for i = h/2:h
    for j = 1:w

        fish_x = j;
        fish_y = i;
        mx_u = m_inv_K11 * fish_x + m_inv_K13;
        my_u = m_inv_K22 * fish_y + m_inv_K23;


        mx_d = mx_u;
        my_d = my_u;

        mx2_d = mx_d.*mx_d;
        my2_d = my_d.*my_d;
        mxy_d = mx_d.*my_d;
        rho2_d = mx2_d+my2_d;
        rho4_d = rho2_d.*rho2_d;
        radDist_d = m_k1*rho2_d+m_k2*rho4_d;
        Dx_d = mx_d.*radDist_d + m_p2.*(rho2_d+2*mx2_d) + 2*m_p1.*mxy_d;
        Dy_d = my_d.*radDist_d + m_p1.*(rho2_d+2*my2_d) + 2*m_p2.*mxy_d;
        inv_denom_d = 1/(1+4*m_k1*rho2_d+6*m_k2*rho4_d+8*m_p1*my_d+8*m_p2*mx_d);

        mx_u = mx_d - inv_denom_d*Dx_d;
        my_u = my_d - inv_denom_d*Dy_d;

        rho2_d = mx_u .* mx_u + my_u .* my_u;

        pt3d = [mx_u, my_u, (  1.0 - m_xi*(rho2_d+1)./(m_xi + (1+ (1 - m_xi*m_xi).*rho2_d ).^.5  )    )   ];

        % pt3d = [pt3d(:,3),-pt3d(:,2),-pt3d(:,1)];

        pt3d = [pt3d(:,1),-pt3d(:,3),pt3d(:,2)];


        pt2dL(:,1) = focal_length*pt3d(:,1)./pt3d(:,3);
        pt2dL(:,2) = focal_length*pt3d(:,2)./pt3d(:,3);

        x = (round(pt2dL(2)))+LargeW/2;
        y = (round(pt2dL(1)))+LargeW/2;
        if ( x<=LargeW && y<=LargeW && x>=1 && y>=1 )
            if (isreal(pt2dL))
                I_temp(x,y,:) = I(i,j,:);
                Iremap(i,j,:) = I(i,j,:);
            else
                idxx= idxx +1;
            end

        end

    end
end
%
Iremap = uint8(Iremap);
I_temp = uint8(I_temp);

% figure,imshow(I_temp)
% set(gcf,'color','w');
% set(gca,'color','w');

I_bottom = I_temp;
%%
I_temp = zeros(LargeW,LargeW,1);
for i = 1:h
    for j = 1:w/2

        fish_x = j;
        fish_y = i;
        mx_u = m_inv_K11 * fish_x + m_inv_K13;
        my_u = m_inv_K22 * fish_y + m_inv_K23;


        mx_d = mx_u;
        my_d = my_u;

        mx2_d = mx_d.*mx_d;
        my2_d = my_d.*my_d;
        mxy_d = mx_d.*my_d;
        rho2_d = mx2_d+my2_d;
        rho4_d = rho2_d.*rho2_d;
        radDist_d = m_k1*rho2_d+m_k2*rho4_d;
        Dx_d = mx_d.*radDist_d + m_p2.*(rho2_d+2*mx2_d) + 2*m_p1.*mxy_d;
        Dy_d = my_d.*radDist_d + m_p1.*(rho2_d+2*my2_d) + 2*m_p2.*mxy_d;
        inv_denom_d = 1/(1+4*m_k1*rho2_d+6*m_k2*rho4_d+8*m_p1*my_d+8*m_p2*mx_d);

        mx_u = mx_d - inv_denom_d*Dx_d;
        my_u = my_d - inv_denom_d*Dy_d;

        rho2_d = mx_u .* mx_u + my_u .* my_u;

        pt3d = [mx_u, my_u, (  1.0 - m_xi*(rho2_d+1)./(m_xi + (1+ (1 - m_xi*m_xi).*rho2_d ).^.5  )    )   ];

        pt3d = [pt3d(:,3),pt3d(:,2),-pt3d(:,1)];

        % pt3d = [pt3d(:,1),-pt3d(:,3),pt3d(:,2)];


        pt2dL(:,1) = focal_length*pt3d(:,1)./pt3d(:,3);
        pt2dL(:,2) = focal_length*pt3d(:,2)./pt3d(:,3);

        x = (round(pt2dL(2)))+LargeW/2;
        y = (round(pt2dL(1)))+LargeW/2;
        if ( x<=LargeW && y<=LargeW && x>=1 && y>=1 )
            if (isreal(pt2dL))
                I_temp(x,y,:) = I(i,j,:);
                Iremap(i,j,:) = I(i,j,:);
            else
                idxx= idxx +1;
            end

        end

    end
end
%
Iremap = uint8(Iremap);
I_temp = uint8(I_temp);

% figure,imshow(I_temp)
% set(gcf,'color','w');
% set(gca,'color','w');
I_left = I_temp;
%%
I_temp = zeros(LargeW,LargeW,1);
for i = 1:h
    for j = w/2:w

        fish_x = j;
        fish_y = i;
        mx_u = m_inv_K11 * fish_x + m_inv_K13;
        my_u = m_inv_K22 * fish_y + m_inv_K23;


        mx_d = mx_u;
        my_d = my_u;

        mx2_d = mx_d.*mx_d;
        my2_d = my_d.*my_d;
        mxy_d = mx_d.*my_d;
        rho2_d = mx2_d+my2_d;
        rho4_d = rho2_d.*rho2_d;
        radDist_d = m_k1*rho2_d+m_k2*rho4_d;
        Dx_d = mx_d.*radDist_d + m_p2.*(rho2_d+2*mx2_d) + 2*m_p1.*mxy_d;
        Dy_d = my_d.*radDist_d + m_p1.*(rho2_d+2*my2_d) + 2*m_p2.*mxy_d;
        inv_denom_d = 1/(1+4*m_k1*rho2_d+6*m_k2*rho4_d+8*m_p1*my_d+8*m_p2*mx_d);

        mx_u = mx_d - inv_denom_d*Dx_d;
        my_u = my_d - inv_denom_d*Dy_d;

        rho2_d = mx_u .* mx_u + my_u .* my_u;

        pt3d = [mx_u, my_u, (  1.0 - m_xi*(rho2_d+1)./(m_xi + (1+ (1 - m_xi*m_xi).*rho2_d ).^.5  )    )   ];

        pt3d = [pt3d(:,3),-pt3d(:,2),-pt3d(:,1)];

        % pt3d = [pt3d(:,1),-pt3d(:,3),pt3d(:,2)];


        pt2dL(:,1) = focal_length*pt3d(:,1)./pt3d(:,3);
        pt2dL(:,2) = focal_length*pt3d(:,2)./pt3d(:,3);

        x = (round(pt2dL(2)))+LargeW/2;
        y = (round(pt2dL(1)))+LargeW/2;
        if ( x<=LargeW && y<=LargeW && x>=1 && y>=1 )
            if (isreal(pt2dL))
                I_temp(x,y,:) = I(i,j,:);
                Iremap(i,j,:) = I(i,j,:);
            else
                idxx= idxx +1;
            end

        end

    end
end
%
Iremap = uint8(Iremap);
I_temp = uint8(I_temp);

% figure,imshow(I_temp)
% set(gcf,'color','w');
% set(gca,'color','w');

I_right = I_temp;
%%

Icube = zeros(3*LargeW,3*LargeW,1);

Icube(1:LargeW,1+LargeW:LargeW+LargeW,:) = I_top;
Icube(1+2*LargeW:LargeW+2*LargeW,1+LargeW:LargeW+LargeW,:) = I_bottom;
Icube(1+LargeW:LargeW+LargeW,1+LargeW:LargeW+LargeW,:) = I_center;
Icube(1+LargeW:LargeW+LargeW,1:LargeW,:) = I_left;
Icube(1+LargeW:LargeW+LargeW,1+2*LargeW:LargeW+2*LargeW,:) = I_right;

Icube(Icube(:,:)==0)=nan;
Icube=inpaint_nans(Icube,5);

Icube = uint8(Icube);

figure, imshow(Icube)
% imwrite(Icube,outpath+"/flatCube.png")
%%
III =[imrotate(I_left,90),I_bottom,imrotate(I_right,-90)];

III =III(1:300,:);
figure,imshow(III)
III = double(III);
III(III(:,:)==0)=nan;
III=inpaint_nans(III,5);
III = uint8(III);
figure,imshow(III)
