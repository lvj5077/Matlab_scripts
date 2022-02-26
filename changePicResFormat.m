wspace = '/Users/jin/Desktop/corner/raw/';

imageNames = dir(fullfile(wspace,'r*'));
imageNames = {imageNames.name}';

for ii = 1:length(imageNames)
    ii*100/length(imageNames)
   img = imread(fullfile(wspace,imageNames{ii}));
   img = imresize(img,.5);
   imwrite(img,"/Users/jin/Desktop/corner/png/"+num2str(ii)+".png");
end