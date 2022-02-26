ddd = importdata("/Users/jin/Desktop/Dreame/testIdea/summaryYtest/data.txt");
I = imread("/Users/jin/Desktop/Dreame/testIdea/summaryYtest/color/1.png");
%%
figure,imshow(I)

hold on,
plot(ddd((ddd(:,1)==1),4),ddd((ddd(:,1)==1),5),'g.','LineWidth',20,'MarkerSize',20)

%%
i=2
I = imread("/Users/jin/Desktop/Dreame/testIdea/summaryYtest/color/"+num2str(i)+".png");
figure,imshow(I)

hold on,
plot(ddd((ddd(:,1)==i),4),ddd((ddd(:,1)==i),5),'g.','LineWidth',20,'MarkerSize',20)

hold on,
plot(ddd((ddd(:,1)==i)&(ddd(:,2)==0),4),ddd((ddd(:,1)==i)&(ddd(:,2)==0),5),'r.','LineWidth',20,'MarkerSize',20)
%%
for i = [1,9,18]
    I = imread("/Users/jin/Desktop/Dreame/testIdea/summaryYtest/color/"+num2str(i)+".png");
    figure,imshow(I)
    hold on,
    plot(ddd((ddd(:,1)==i),4),ddd((ddd(:,1)==i),5),'g.','LineWidth',20,'MarkerSize',20)
    hold on,
    plot(ddd((ddd(:,1)==i)&(ddd(:,2)==0),4),ddd((ddd(:,1)==i)&(ddd(:,2)==0),5),'r.','LineWidth',20,'MarkerSize',20)
    pause(0.3)
end


%
for i = [1,9,18]
    I = imread("/Users/jin/Desktop/Dreame/testIdea/summaryYtest/color/"+num2str(19-i)+".png");
    figure,imshow(I)
    hold on,
    plot(ddd((ddd(:,1)==18+i),4),ddd((ddd(:,1)==18+i),5),'g.','LineWidth',20,'MarkerSize',20)
    hold on,
    plot(ddd((ddd(:,1)==18+i)&(ddd(:,2)==0),4),ddd((ddd(:,1)==18+i)&(ddd(:,2)==0),5),'r.','LineWidth',20,'MarkerSize',20)
    pause(0.3)
end
%%
I = imread("/Users/jin/Desktop/Dreame/testIdea/summaryYtest/color/1.png");
figure,imshow(I)
hold on,
plot(ddd((ddd(:,1)==37),4),ddd((ddd(:,1)==37),5),'g.','LineWidth',20,'MarkerSize',20)
hold on,
plot(ddd((ddd(:,1)==37)&(ddd(:,2)==0),4),ddd((ddd(:,1)==37)&(ddd(:,2)==0),5),'r.','LineWidth',20,'MarkerSize',20)

%%
i = 18
I = imread("/Users/jin/Desktop/Dreame/testIdea/summaryYtest/color/"+num2str(19-i)+".png");
hold on,
plot(ddd((ddd(:,1)==18+i)&(ddd(:,2)==1),4),ddd((ddd(:,1)==18+i)&(ddd(:,2)==1),5),'rx','LineWidth',20,'MarkerSize',20)
%%
hold on,
plot(ddd((ddd(:,1)==18+i)&(ddd(:,2)==1),4),ddd((ddd(:,1)==18+i)&(ddd(:,2)==1),5),'g.','LineWidth',20,'MarkerSize',20)
