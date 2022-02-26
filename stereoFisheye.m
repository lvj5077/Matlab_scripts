clear 
format short g
% clc
baseline = 0.2;     % m
humanTall = 1.8;    % m
humanWidth = 0.6;   % m
H = .5;             % m
P3d_head = [20,0,0.5]+[0,0,H];
P3d_feet = [20,0,2.3]+[0,0,H];

noiseLevel = 1;

P3d_head_R = P3d_head-[baseline/2,0,0];
P3d_feet_R = P3d_feet-[baseline/2,0,0];

P3d_head_L = P3d_head+[baseline/2,0,0];
P3d_feet_L = P3d_feet+[baseline/2,0,0];



P2d_head_Rfish = perspective2fisheye(P3d_head_R(1)/P3d_head_R(3),P3d_head_R(2)/P3d_head_R(3),1.8,1000);
P2d_feet_Rfish = perspective2fisheye(P3d_feet_R(1)/P3d_feet_R(3),P3d_feet_R(2)/P3d_feet_R(3),1.8,1000);

P2d_head_Lfish = perspective2fisheye(P3d_head_L(1)/P3d_head_L(3),P3d_head_L(2)/P3d_head_L(3),1.8,1000);
P2d_feet_Lfish = perspective2fisheye(P3d_feet_L(1)/P3d_feet_L(3),P3d_feet_L(2)/P3d_feet_L(3),1.8,1000);


H = baseline/(P3d_head_L(1)/P3d_head_R(3) - P3d_head_R(1)/P3d_head_L(3));
L_R = P3d_head_R(1);


disp([H,L_R])
%%
clc
disp('~~~~~ 1 pixel noise on virtual perspective ~~~~~~')
disp("groundtruth ")
disp([H,L_R])
noiseLevel = 0.1;

noise = (noiseLevel/2)*wgn(10000,1,0);

[P2d_head_Rpp, focal_length] = liftProjectiveMeiNodist(P2d_head_Rfish,1.8,1000);
[P2d_head_Lpp, focal_length] = liftProjectiveMeiNodist(P2d_head_Lfish,1.8,1000);

% H_pp_est = baseline/(((P2d_head_Lpp(1) - P2d_head_Rpp(1))+noiseLevel)/focal_length);
% L_pp_estR = H_pp_est*(P2d_head_Rpp(1)+noiseLevel/2)/focal_length;
% disp([H_pp_est,L_pp_estR])
% L_pp_estR = H_pp_est*(P2d_head_Rpp(1)-noiseLevel/2)/focal_length;
% disp([H_pp_est,L_pp_estR])
% H_pp_est = baseline/(((P2d_head_Lpp(1) - P2d_head_Rpp(1))-noiseLevel)/focal_length);
% L_pp_estR = H_pp_est*(P2d_head_Rpp(1)+noiseLevel/2)/focal_length;
% disp([H_pp_est,L_pp_estR])
% L_pp_estR = H_pp_est*(P2d_head_Rpp(1)-noiseLevel/2)/focal_length;
% disp([H_pp_est,L_pp_estR])

P2d_head_Lpp_n = P2d_head_Lpp(1) + (noiseLevel/2)*wgn(10000,1,0);
P2d_head_Rpp_n = P2d_head_Rpp(1) + (noiseLevel/2)*wgn(10000,1,0);

H_pp_est_n = baseline./((P2d_head_Lpp_n - P2d_head_Rpp_n)./focal_length);
L_pp_estR_n = H_pp_est_n.*P2d_head_Rpp_n./focal_length;

disp("perspective avg ") 
disp([mean(H_pp_est_n),mean(L_pp_estR_n)])
disp("perspective median ") 
disp([median(H_pp_est_n),median(L_pp_estR_n)])
disp("perspective std ") 
disp([std(H_pp_est_n),std(L_pp_estR_n)])
%

disp('~~~~~ 1 pixel noise on cmos fisheye ~~~~~~')
% noiseLevel = .1;
P2d_head_Rfish_n= P2d_head_Rfish + [(noiseLevel/2)*wgn(10000,1,0),zeros(10000,1)];
P2d_head_Lfish_n= P2d_head_Lfish + [(noiseLevel/2)*wgn(10000,1,0),zeros(10000,1)];

[P2d_head_Rpp_n, focal_length] = liftProjectiveMeiNodist(P2d_head_Rfish_n,1.8,1000);
[P2d_head_Lpp_n, focal_length] = liftProjectiveMeiNodist(P2d_head_Lfish_n,1.8,1000);
H_fish_est_n = baseline./(((P2d_head_Lpp_n(:,1) - P2d_head_Rpp_n(:,1)))./focal_length);
L_fish_estR_n = H_fish_est_n.*(P2d_head_Rpp_n(:,1))/focal_length;

disp("fisheye succ ") 
L_fish_estR_n_nvld = L_fish_estR_n(H_fish_est_n>0);
H_fish_est_nvld = H_fish_est_n(H_fish_est_n>0);

disp(length(H_fish_est_nvld)/length(H_fish_est_n))
disp("fisheye avg ") 
disp([mean(H_fish_est_nvld),mean(L_fish_estR_n_nvld)])
disp("fisheye median ") 
disp([median(H_fish_est_nvld),median(L_fish_estR_n_nvld)])
disp("fisheye std ") 
disp([std(H_fish_est_nvld),std(L_fish_estR_n_nvld)])

% [P2d_head_Rpp, focal_length] = liftProjectiveMeiNodist(P2d_head_R+[noiseLevel/2,0],1.8,1000);
% [P2d_head_Lpp, focal_length] = liftProjectiveMeiNodist(P2d_head_L+[noiseLevel/2,0],1.8,1000);
% H_fish_est = baseline/(((P2d_head_Lpp(1) - P2d_head_Rpp(1)))/focal_length);
% L_fish_estR = H_fish_est*(P2d_head_Rpp(1))/focal_length;
% disp([H_fish_est,L_fish_estR])
% 
% [P2d_head_Rpp, focal_length] = liftProjectiveMeiNodist(P2d_head_R-[noiseLevel/2,0],1.8,1000);
% [P2d_head_Lpp, focal_length] = liftProjectiveMeiNodist(P2d_head_L+[noiseLevel/2,0],1.8,1000);
% H_fish_est = baseline/(((P2d_head_Lpp(1) - P2d_head_Rpp(1)))/focal_length);
% L_fish_estR = H_fish_est*(P2d_head_Rpp(1))/focal_length;
% disp([H_fish_est,L_fish_estR])
% 
% [P2d_head_Rpp, focal_length] = liftProjectiveMeiNodist(P2d_head_R+[noiseLevel/2,0],1.8,1000);
% [P2d_head_Lpp, focal_length] = liftProjectiveMeiNodist(P2d_head_L-[noiseLevel/2,0],1.8,1000);
% H_fish_est = baseline/(((P2d_head_Lpp(1) - P2d_head_Rpp(1)))/focal_length);
% L_fish_estR = H_fish_est*(P2d_head_Rpp(1))/focal_length;
% disp([H_fish_est,L_fish_estR])
% 
% [P2d_head_Rpp, focal_length] = liftProjectiveMeiNodist(P2d_head_R-[noiseLevel/2,0],1.8,1000);
% [P2d_head_Lpp, focal_length] = liftProjectiveMeiNodist(P2d_head_L-[noiseLevel/2,0],1.8,1000);
% H_fish_est = baseline/(((P2d_head_Lpp(1) - P2d_head_Rpp(1)))/focal_length);
% L_fish_estR = H_fish_est*(P2d_head_Rpp(1))/focal_length;
% disp([H_fish_est,L_fish_estR])