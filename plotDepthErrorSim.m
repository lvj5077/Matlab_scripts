Hs = 0.5:0.5:10;
pixelS = [1024];
pixelLengthPersp = zeros(length(Hs),length(pixelS),1);
pixelWidthPersp = zeros(length(Hs),length(pixelS),1);
pixelLengthFish = zeros(length(Hs),length(pixelS),1);
pixelWidthFish = zeros(length(Hs),length(pixelS),1);
distFish = zeros(length(Hs),length(pixelS),1);
for idx_pixel = 1:length(pixelS)
    
    for idx_H = 1:1:length(Hs)
        
%         idx_H*100/length(Hs)

        humanP3d = [20.3,0,0;20.2,0.1,0;20.2,-0.1,0;20.4,0.1,0;20.4,-0.1,0;20.3,0,0.3;20,0.3,.3;20,-0.3,.3;20.6,0.3,.3;20.6,-0.3,.3;20.3,0,1.8;20,0.3,1.8;20,-0.3,1.8;20.6,0.3,1.8;20.6,-0.3,1.8];

        H = Hs(idx_H);

        humanP3d(:,3) = humanP3d(:,3)+H;

        humanP3d = humanP3d*eul2rotm([-pi/4,0,0]);


        %
        perspective2d = zeros(length(humanP3d),2);
        fisheye2d = zeros(length(humanP3d),2);

        % focal_length = m_imageHeight/2 /tan( (fov/2) *pi/180);

        for i = 1:length(humanP3d)
            disp(idx_H*100/length(Hs)+5*i/length(humanP3d)-5)
            unipx = humanP3d(i,1)/humanP3d(i,3);
            unipy = humanP3d(i,2)/humanP3d(i,3); 
            fisheye2d(i,:) = perspective2fisheyeFLIR(unipx,unipy);
            px = unipx*387;
            py = unipy*387;
            perspective2d(i,:) = [px,py];
        %     display([px,py])

        %     display(fisheye2d(i,:))
        end
        %
    %     nexttile(tl)
    % 
    %     plot(0,0,'k*','MarkerSize',20,'LineWidth',3)
    %     hold on
    %     plot(perspective2d(1:5,1),perspective2d(1:5,2),'r.','MarkerSize',10) % red is head
    %     hold on
    %     plot(perspective2d(6:10,1),perspective2d(6:10,2),'b.','MarkerSize',10) % blue is nect
    %     hold on
    %     plot(perspective2d(11:15,1),perspective2d(11:15,2),'g.','MarkerSize',10) % green is feet
    %     grid minor

        pixelLengthPersp(idx_H,idx_pixel) = norm(perspective2d(11,:)-perspective2d(1,:));
        pixelWidthPersp(idx_H,idx_pixel) = norm(perspective2d(15,:)-perspective2d(14,:));
    %     title("f = 500 perspective: H: "+num2str(pixelLengthPersp,'%.2f') + " pixel W:" +num2str(pixelWidthPersp,'%.2f') + " pixel",'FontSize',15,'FontWeight','bold');
        % axis equal
        %
        % xlim([0,640]),ylim([0,640])

    %     nexttile(tl)
        figure
        hold on, plot(fisheye2d(:,1),fisheye2d(:,2),'b.')
        hold on,plot(fisheye2d(1,1),fisheye2d(1,2),'r*')
        hold on,plot(fisheye2d(end,1),fisheye2d(end,2),'b*')

        plot(fisheye2d(1:5,1),fisheye2d(1:5,2),'r.','MarkerSize',10) % red is head
        hold on
        plot(fisheye2d(6:10,1),fisheye2d(6:10,2),'b.','MarkerSize',10) % blue is nect
        hold on
        plot(fisheye2d(11:15,1),fisheye2d(11:15,2),'g.','MarkerSize',10) % green is feet
    
        hold on,plot(0,0,'k*','MarkerSize',20,'LineWidth',3)
        grid minor
        axis equal
        xlim([-600,0]),ylim([-600,0])
        title("drone height @ "+num2str(H)+" m",'FontSize',20,'FontWeight','bold'); 

        pixelLengthFish(idx_H,idx_pixel) = norm(fisheye2d(11,1)-fisheye2d(1,1));
        distFish(idx_H,idx_pixel) = 100*norm((fisheye2d(11,:)+fisheye2d(1,:))/2)/(512*2^.5);
        pixelWidthFish(idx_H,idx_pixel) = norm(fisheye2d(15,1)-fisheye2d(14,1));
    %     title("Fisheye: H: " +num2str(pixelLengthFish,'%.2f') + " pixel W:" +num2str(pixelWidthPersp,'%.2f') + " pixel",'FontSize',15,'FontWeight','bold');


    %     title(tl,"drone @ "+num2str(H)+" m "+"pixel @ Width:1024pixel",'FontSize',20,'FontWeight','bold'); 

    end
end
%%
%%
figure,
subplot(1,3,1)
plot (Hs, pixelLengthFish,'r','LineWidth',3)

xlabel('drone height (m)','FontSize',20,'FontWeight','bold'); 
ylabel('human pixel height (pixel)','FontSize',20,'FontWeight','bold'); 
grid minor
title("drone height vs human pixel height",'FontSize',20,'FontWeight','bold'); 

subplot(1,3,2)

plot (Hs, pixelWidthFish,'r','LineWidth',3)

xlabel('drone height (m)','FontSize',20,'FontWeight','bold'); 
ylabel('human pixel width (pixel)','FontSize',20,'FontWeight','bold'); 
grid minor
title("drone height vs human pixel width",'FontSize',20,'FontWeight','bold'); 

subplot(1,3,3)

plot (Hs, distFish,'r','LineWidth',3)

xlabel('drone height (m)','FontSize',20,'FontWeight','bold'); 
ylabel('dist to center (% height/2)','FontSize',20,'FontWeight','bold'); 
grid minor
title("drone height vs dist to center",'FontSize',20,'FontWeight','bold'); 

set(gcf,'color','w');
set(gca,'color','w');
%%
figure,
subplot(1,2,1)
for idx_pixel = 1:length(pixelS)
    hold on
    plot (Hs, pixelLengthPersp(:,idx_pixel),'r','LineWidth',3)
%     hold on
%     plot (Hs, pixelLengthFish,'r.','MarkerSize',10)
end
legend('1000','2000','4000','8000','16000','32000')

xlabel('drone height (m)','FontSize',20,'FontWeight','bold'); 
ylabel('human pixel height (pixel)','FontSize',20,'FontWeight','bold'); 
grid minor
title("drone height vs human pixel height",'FontSize',20,'FontWeight','bold'); 

subplot(1,2,2)

for idx_pixel = 1:length(pixelS)
    hold on
    plot (Hs, pixelWidthPersp(:,idx_pixel),'r','LineWidth',3)
%     hold on
%     plot (Hs, pixelLengthFish,'r.','MarkerSize',10)
end
legend('1000','2000','4000','8000','16000','32000')

xlabel('drone height (m)','FontSize',20,'FontWeight','bold'); 
ylabel('human pixel width (pixel)','FontSize',20,'FontWeight','bold'); 
grid minor
title("drone height vs human pixel width",'FontSize',20,'FontWeight','bold'); 

set(gcf,'color','w');
set(gca,'color','w');