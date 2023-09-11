clear all;
close all;
load test_net8;

% Prediction
Prediction_data = load('ANN_prediction.txt');
sst1 = size(Prediction_data);
Input = Prediction_data(:,3:10)';

A=sim(test_net8,Input);
