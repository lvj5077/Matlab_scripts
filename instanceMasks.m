instances = zeros(480,640,7);
readin = importdata("/Users/jin/Desktop/test/masks1.csv");
readin(1,:)=[];
N = nnz(readin)
instances(:,:,1) = readin;

readin = importdata("/Users/jin/Desktop/test/masks2.csv");
readin(1,:)=[];
N = nnz(readin)
instances(:,:,2) = readin;

readin = importdata("/Users/jin/Desktop/test/masks3.csv");
readin(1,:)=[];
N = nnz(readin)
instances(:,:,3) = readin;

readin = importdata("/Users/jin/Desktop/test/masks4.csv");
readin(1,:)=[];
N = nnz(readin)
instances(:,:,4) = readin;

readin = importdata("/Users/jin/Desktop/test/masks5.csv");
readin(1,:)=[];
N = nnz(readin)
instances(:,:,5) = readin;

readin = importdata("/Users/jin/Desktop/test/masks6.csv");
readin(1,:)=[];
N = nnz(readin)
instances(:,:,6) = readin;

readin = importdata("/Users/jin/Desktop/test/masks7.csv");
readin(1,:)=[];
N = nnz(readin)
instances(:,:,7) = readin;

instancesSum = sum(instances,3);

figure,imagesc(instancesSum)

nnz(instancesSum>1)

%%
p = randperm(n,k)