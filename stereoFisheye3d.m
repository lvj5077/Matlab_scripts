clear 
% clc
baseline = 0.2;     % m
humanTall = 1.8;    % m
humanWidth = 0.6;   % m
H = 10;             % m
P3d_head = [20,0,0.5]+[0,0,H];
P3d_feet = [20,0,2.3]+[0,0,H];

noiseLevel = 1;

P3d_head_R = P3d_head-[baseline/2,0,0];
P3d_feet_R = P3d_feet-[baseline/2,0,0];

P3d_head_L = P3d_head+[baseline/2,0,0];
P3d_feet_L = P3d_feet+[baseline/2,0,0];



P2d_head_R = perspective2fisheye(P3d_head_R(1)/P3d_head_R(3),P3d_head_R(2)/P3d_head_R(3),1.8,1000);
P2d_feet_R = perspective2fisheye(P3d_feet_R(1)/P3d_feet_R(3),P3d_feet_R(2)/P3d_feet_R(3),1.8,1000);

P2d_head_L = perspective2fisheye(P3d_head_L(1)/P3d_head_L(3),P3d_head_L(2)/P3d_head_L(3),1.8,1000);
P2d_feet_L = perspective2fisheye(P3d_feet_L(1)/P3d_feet_L(3),P3d_feet_L(2)/P3d_feet_L(3),1.8,1000);


H = baseline/(P3d_head_L(1)/P3d_head_R(3) - P3d_head_R(1)/P3d_head_L(3));
L_R = P3d_head_R(1);

disp([H,L_R])

%%
% noise = 0.5*wgn(1000,1,0);

disp('~~~~~ 1 pixel noise on virtual perspective ~~~~~~')
noiseLevel = 1;
[P2d_head_Rpp, focal_length] = liftProjectiveMeiNodist(P2d_head_R,1.8,1000);
[P2d_head_Lpp, focal_length] = liftProjectiveMeiNodist(P2d_head_L,1.8,1000);

H_pp_est = baseline/(((P2d_head_Lpp(1) - P2d_head_Rpp(1))+noiseLevel)/focal_length);
L_pp_estR = H_pp_est*(P2d_head_Rpp(1)+noiseLevel/2)/focal_length;
disp([H_pp_est,L_pp_estR])
L_pp_estR = H_pp_est*(P2d_head_Rpp(1)-noiseLevel/2)/focal_length;
disp([H_pp_est,L_pp_estR])
H_pp_est = baseline/(((P2d_head_Lpp(1) - P2d_head_Rpp(1))-noiseLevel)/focal_length);
L_pp_estR = H_pp_est*(P2d_head_Rpp(1)+noiseLevel/2)/focal_length;
disp([H_pp_est,L_pp_estR])
L_pp_estR = H_pp_est*(P2d_head_Rpp(1)-noiseLevel/2)/focal_length;
disp([H_pp_est,L_pp_estR])

disp('~~~~~ 1 pixel noise on cmos fisheye ~~~~~~')
noiseLevel = 1;
[P2d_head_Rpp, focal_length] = liftProjectiveMeiNodist(P2d_head_R+[noiseLevel/2,0],1.8,1000);
[P2d_head_Lpp, focal_length] = liftProjectiveMeiNodist(P2d_head_L+[noiseLevel/2,0],1.8,1000);
H_fish_est = baseline/(((P2d_head_Lpp(1) - P2d_head_Rpp(1)))/focal_length);
L_fish_estR = H_fish_est*(P2d_head_Rpp(1))/focal_length;
disp([H_fish_est,L_fish_estR])

[P2d_head_Rpp, focal_length] = liftProjectiveMeiNodist(P2d_head_R-[noiseLevel/2,0],1.8,1000);
[P2d_head_Lpp, focal_length] = liftProjectiveMeiNodist(P2d_head_L+[noiseLevel/2,0],1.8,1000);
H_fish_est = baseline/(((P2d_head_Lpp(1) - P2d_head_Rpp(1)))/focal_length);
L_fish_estR = H_fish_est*(P2d_head_Rpp(1))/focal_length;
disp([H_fish_est,L_fish_estR])

[P2d_head_Rpp, focal_length] = liftProjectiveMeiNodist(P2d_head_R+[noiseLevel/2,0],1.8,1000);
[P2d_head_Lpp, focal_length] = liftProjectiveMeiNodist(P2d_head_L-[noiseLevel/2,0],1.8,1000);
H_fish_est = baseline/(((P2d_head_Lpp(1) - P2d_head_Rpp(1)))/focal_length);
L_fish_estR = H_fish_est*(P2d_head_Rpp(1))/focal_length;
disp([H_fish_est,L_fish_estR])

[P2d_head_Rpp, focal_length] = liftProjectiveMeiNodist(P2d_head_R-[noiseLevel/2,0],1.8,1000);
[P2d_head_Lpp, focal_length] = liftProjectiveMeiNodist(P2d_head_L-[noiseLevel/2,0],1.8,1000);
H_fish_est = baseline/(((P2d_head_Lpp(1) - P2d_head_Rpp(1)))/focal_length);
L_fish_estR = H_fish_est*(P2d_head_Rpp(1))/focal_length;
disp([H_fish_est,L_fish_estR])