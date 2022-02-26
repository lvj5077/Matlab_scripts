function [ H2d,W2d  ] = func_sim3dcharger(var)

    Z = 0.23;
    
    H = 0.1;
    W = 0.2;
%     tilt_angle = pi/6;
    tilt_angle = var;
    R = 1.5; % range
    
    charger3d = zeros(6,3);
    charger3d(1,:)=[0,0,0];
    charger3d(2,:)=[0,0,H];
    charger3d(3,:)=[-W/2,0,H];
    charger3d(4,:)=[W/2,0,H];
    charger3d(5,:)=[-W/2,0,0];
    charger3d(6,:)=[W/2,0,0];
    
    charger3d_org= charger3d;
    % plot3(0,0,0,'ko')
    % 
    % hold on
    % plot3(charger3d(:,1),charger3d(:,2),charger3d(:,3),'r*')
    
    axis equal;
    grid minor
    xlabel("X")
    ylabel("Y")
    zlabel("Z")
    
    % hold on
    % plot3(charger3d(1:2,:),charger3d(1:2,:),'r')
    % arrow3(charger3d(1,:),charger3d(2,:),'r')
    
    
    charger3d = charger3d*eul2rotm([0,0,tilt_angle]);
    charger3d = charger3d+[0,-Z*sin(tilt_angle),-Z*cos(tilt_angle)];
    charger3d = charger3d+[0,-R*cos(tilt_angle),R*sin(tilt_angle)];
    
    % hold on 
    % plot3(charger3d(:,1),charger3d(:,2),charger3d(:,3),'bo')
    % 
    % arrow3(charger3d(1,:),charger3d(2,:),'b')
    % arrow3(charger3d_org(1,:),charger3d_org(2,:),'r')
    %%
    
    fisheye2d = zeros(length(charger3d),2);
    
    for i = 1:length(charger3d)
        unipx = charger3d(i,1)/charger3d(i,3);
        unipy = charger3d(i,2)/charger3d(i,3); 
        fisheye2d(i,:) = perspective2fisheyeSZ(unipx,unipy);
    end
    
    
%     figure,
%     hold on, plot(fisheye2d(:,1),fisheye2d(:,2),'b.')
%     hold on,plot(fisheye2d(1,1),fisheye2d(1,2),'r*')
%     hold on,plot(fisheye2d(2,1),fisheye2d(2,2),'b*')
%     grid minor
%     
%     axis equal
%     xlim([0,1920]),ylim([0,1080])
    H2d = norm(fisheye2d(1,:)-fisheye2d(2,:));
    W2d = norm(fisheye2d(5,:)-fisheye2d(6,:));
end
