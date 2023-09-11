clear all;
close all;

%% Data loading
[fname_basic,pname_basic] = uigetfile('*.txt','Open  file with PCA data') ;
Experimental_data=load(fname_basic);


PCA_data=Experimental_data(:,3:11); % selected data for analysis
Sample_no=Experimental_data(:,1); % sample number
Compound_no=Experimental_data(:,2); % compound number

%% PCA
 [pc,score,latent,tsquare] = pca(zscore(PCA_data));

%% PCA output
percent_explained=100*latent/sum(latent);
cumsum(latent)./sum(latent);
Variables_labels = {'Docking to D.rerio ERalpha', 'Docking to D.rerio ERRgammaA','Docking to D.rerio ERRgammaB','logP','Concentration','Ethanol concentration','DMSO concentration','Mortality control', 'Mortality after 24h' };

figure(1);
biplot(pc(:,1:3),'Scores',score(:,1:3),'varlabels',Variables_labels);

figure(2);
scatter(score(:,1),score(:,2),20,Compound_no,'filled');
xlabel('1st Principal Component 20.09%');
ylabel('2nd Principal Component 16.25%');
gname(Sample_no);
figure(3);
scatter(score(:,2),score(:,3),20,Compound_no,'filled');
xlabel('2nd Principal Component 16.25%');
ylabel('3rd Principal Component 14.72%');
gname(Sample_no);
figure(4);
scatter(score(:,1),score(:,3),20,Compound_no,'filled');
xlabel('1st Principal Component 20.09%');
ylabel('3rd Principal Component 14.72%');
gname(Sample_no);

percent_explained
Variables_count=9;

figure(5);
hold on;
plot(1:Variables_count,pc(:,1),'-or');
plot(1:Variables_count,pc(:,2),'-og');
plot(1:Variables_count,pc(:,3),'-ob');

xlabel('Variables');
ylabel('PCA loadings');
legend({'1st Principal Component','2nd Principal Component','3rd Principal Component'},'location','NW');

%% Clustering
X=score(:,1:2);
rng(1);
[idx,C] = kmeans(X,4); % 4 clusters using K-means algorithm

x1 = min(X(:,1)):0.01:max(X(:,1));
x2 = min(X(:,2)):0.01:max(X(:,2));
[x1G,x2G] = meshgrid(x1,x2);
XGrid = [x1G(:),x2G(:)];

idx2Region = kmeans(XGrid,4,'MaxIter',1,'Start',C);

figure(6);
gscatter(XGrid(:,1),XGrid(:,2),idx2Region,...
    [1,0,0;0,1,0;0,1,1;1,1,0],'..');
hold on;
plot(X(:,1),X(:,2),'k*','MarkerSize',5);
title 'Principal component analysis clustering data';
xlabel 'First Principal Component 20.09%';
ylabel 'Second Principal Component 16.25%';
legend('Region 1','Region 2','Region 3','Region 4','Data','Location','SouthEast');
hold off;
