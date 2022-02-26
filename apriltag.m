intrinsics = cameraIntrinsics([485.4578, 485.4578],[319.5942,223.1393],[640,480]);
tagSize = 0.100706;

I_ref = imread("/Users/jin/Downloads/AprilTag/xy_summary/x/1.png");

[id,loc,pose] = readAprilTag(I_ref,"tag36h11",intrinsics,tagSize);
worldPoints = [0 0 0; tagSize/2 0 0; 0 tagSize/2 0; 0 0 tagSize/2];
for i = 1:length(pose)
    % Get image coordinates for axes.
    imagePoints = worldToImage(intrinsics,pose(i).Rotation, ...
                  pose(i).Translation,worldPoints);

    % Draw colored axes.
    I_ref = insertShape(I_ref,"Line",[imagePoints(1,:) imagePoints(2,:); ...
        imagePoints(1,:) imagePoints(3,:); imagePoints(1,:) imagePoints(4,:)], ...
        "Color",["red","green","blue"],"LineWidth",7);

    I_ref = insertText(I_ref,loc(1,:,i),id(i),"BoxOpacity",1,"FontSize",25);
end

imshow(I_ref)

T_ref = eye(4);
T_ref(1:3,1:3) = pose.Rotation;
T_ref(1:3,4) = pose.Translation;

T_ref

for i =1:13
    I_mv = imread("/Users/jin/Downloads/AprilTag/xy_summary/x/"+num2str(i)+".png");
%     figure, imshow(I_mv)
    [id,loc,pose] = readAprilTag(I_mv,"tag36h11",intrinsics,tagSize);
    

    for i = 1:length(pose)
        % Get image coordinates for axes.
        imagePoints = worldToImage(intrinsics,pose(i).Rotation, ...
                      pose(i).Translation,worldPoints);
    
        % Draw colored axes.
        I_mv = insertShape(I_mv,"Line",[imagePoints(1,:) imagePoints(2,:); ...
            imagePoints(1,:) imagePoints(3,:); imagePoints(1,:) imagePoints(4,:)], ...
            "Color",["red","green","blue"],"LineWidth",7);
    
        I_mv = insertText(I_mv,loc(1,:,i),id(i),"BoxOpacity",1,"FontSize",25);
    end
    
    figure, imshow(I_mv)

    T_mv = eye(4);
    T_mv(1:3,1:3) = pose.Rotation;
    T_mv(1:3,4) = pose.Translation;
    
    TT = T_ref\(T_mv);
    t = TT(1:3,4)';
    axisAngle = rotm2axang(TT(1:3,1:3));

    showRes = [norm(t),axisAngle(4)*180/pi]
end

%%

intrinsics = cameraIntrinsics([485.4578, 485.4578],[319.5942,223.1393],[640,480]);
tagSize = 0.100706;

I_ref = imread("/Users/jin/Downloads/AprilTag/xy_summary/y/1.png");

[id,loc,pose] = readAprilTag(I_ref,"tag36h11",intrinsics,tagSize);
worldPoints = [0 0 0; tagSize/2 0 0; 0 tagSize/2 0; 0 0 tagSize/2];
for i = 1:length(pose)
    % Get image coordinates for axes.
    imagePoints = worldToImage(intrinsics,pose(i).Rotation, ...
                  pose(i).Translation,worldPoints);

    % Draw colored axes.
    I_ref = insertShape(I_ref,"Line",[imagePoints(1,:) imagePoints(2,:); ...
        imagePoints(1,:) imagePoints(3,:); imagePoints(1,:) imagePoints(4,:)], ...
        "Color",["red","green","blue"],"LineWidth",7);

    I_ref = insertText(I_ref,loc(1,:,i),id(i),"BoxOpacity",1,"FontSize",25);
end

imshow(I_ref)

T_ref = eye(4);
T_ref(1:3,1:3) = pose.Rotation;
T_ref(1:3,4) = pose.Translation;

T_ref

for i =1:18
    I_mv = imread("/Users/jin/Downloads/AprilTag/xy_summary/y/"+num2str(i)+".png");
%     figure, imshow(I_mv)
    [id,loc,pose] = readAprilTag(I_mv,"tag36h11",intrinsics,tagSize);
    

    for i = 1:length(pose)
        % Get image coordinates for axes.
        imagePoints = worldToImage(intrinsics,pose(i).Rotation, ...
                      pose(i).Translation,worldPoints);
    
        % Draw colored axes.
        I_mv = insertShape(I_mv,"Line",[imagePoints(1,:) imagePoints(2,:); ...
            imagePoints(1,:) imagePoints(3,:); imagePoints(1,:) imagePoints(4,:)], ...
            "Color",["red","green","blue"],"LineWidth",7);
    
        I_mv = insertText(I_mv,loc(1,:,i),id(i),"BoxOpacity",1,"FontSize",25);
    end
    
    figure, imshow(I_mv)

    T_mv = eye(4);
    T_mv(1:3,1:3) = pose.Rotation;
    T_mv(1:3,4) = pose.Translation;
    
    TT = T_ref\(T_mv);
    t = TT(1:3,4)';
    axisAngle = rotm2axang(TT(1:3,1:3));

    showRes = [norm(t),axisAngle(4)*180/pi]
end
