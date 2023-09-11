clear all;
close all;

% Training
Experimental_data=load('ANN_training0.txt'); % providing an input data for training
ss=size(Experimental_data);

Training_data=zeros(ss);
Training_data(:,1:8)=Experimental_data(:,3:10);
Input=Training_data(:,1:8)';
Target=Experimental_data(:,11)'; % mortality after 24h
y=Experimental_data(:,1)'; % sample number

Range=zeros(8,2);
Range(:,2)=1;

net=newff(Range,[100 45 15 1],{ 'tansig' 'tansig' 'tansig' 'logsig'},'traingdm');

net.trainParam.epochs=20000;
net.trainParam.lr=0.01;
net.trainParam.mc=0.9;
net.trainParam.goal=0.001;

net=train(net,Input,Target);
view(net)

A1=sim(net,Input);

figure(1);
plot(Target,A1,'o');

R = corrcoef(Target',A1') % correlation coefficient

% Testing
Experimental_data_2 = load('ANN_walidacja.txt'); % providing an input data for testing

sst=size(Experimental_data_2);
Testing_data=zeros(sst);
Testing_data=Experimental_data_2(:,1:8);

Testing_data(:,1:8)=Experimental_data_2(:,3:10);

Input2=Testing_data';
Target2=Experimental_data_2(:,11)';

A2=sim(net,Input2);

figure(3);
plot(Target2,A2,'o');

R = corrcoef(Target2',A2') % correlation coefficient

% Saving net for prediction
test_net20= net;
save test_net20
