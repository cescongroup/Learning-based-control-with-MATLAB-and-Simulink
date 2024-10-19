%% Time Series Forecasting Using Deep Learning
% This example shows how to forecast time series data using a long short-term 
% memory (LSTM) network.
% _Copyright 2018 The MathWorks, Inc._
% Modified MC 04/26/2024

%% Load Sequence Data
% Load the example data. 
data = chickenpox_dataset;
% Reshape the data to be a row vector.
data = [data{:}];

figure(4)
plot(data)
xlabel("Month")
ylabel("Cases")
title("Monthy Cases of Chickenpox")
%% 
% Partition the training and test data. Train on the first 90% of the sequence 
% and test on the last 10%.

numTimeStepsTrain = floor(0.9*numel(data));

dataTrain = data(1:numTimeStepsTrain+1);
dataTest = data(numTimeStepsTrain+1:end);
%% Standardize Data
% Note that at prediction time, you must 
% standardize the test data using the same parameters as the training data.
mu = mean(dataTrain);
sigma = std(dataTrain);

dataTrainStandardized = (dataTrain - mu) / sigma;
dataTestStandardized = (dataTest - mu) / sigma;

%% Prepare Predictors and Responses

XTrain = dataTrainStandardized(1:end-1);
YTrain = dataTrainStandardized(2:end);
XTest  = dataTestStandardized(1:end-1);
YTest = dataTestStandardized(2:end);


%% *Define LSTM Network Architecture*
% Create an LSTM regression network. 

numFeatures = 1;
numResponses = 1;
numHiddenUnits = num_hidden_layers; 

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    fullyConnectedLayer(numResponses)
    regressionLayer];
%% 
% Specify the training options. 

options = trainingOptions('adam', ... % Set the solver to |'adam'|
    'MaxEpochs',Max_Epochs, ...            
    'ValidationData',{XTest,YTest}, ...
    'ValidationFrequency',2,...
    'GradientThreshold',1, ... %To prevent the gradients from exploding, set the gradient threshold to 1.
    'InitialLearnRate',0.005, ... %Specify the initial learn rate 0.005
    'LearnRateSchedule','piecewise', ... 
    'LearnRateDropPeriod',125, ... % drop the learn rate after 125 epochs by multiplying by a factor of 0.2.
    'LearnRateDropFactor',0.2, ...
    'Verbose',0, ...
    'Plots','training-progress');
%% Train LSTM Network
% Train the LSTM network with the specified training options by using |trainNetwork|.

net = trainNetwork(XTrain,YTrain,layers,options);
%% Forecast Future Time Steps
% To forecast the values of multiple time steps in the future, use the |predictAndUpdateState| 
% function to predict time steps one at a time and update the network state at 
% each prediction. For each prediction, use the previous prediction as input to 
% the function.
% 
% Standardize the test data using the same parameters as the training data.


%% 
% To initialize the network state, first predict on the training data |XTrain|. 
% Next, make the first prediction using the last time step of the training response 
% |YTrain(end)|. Loop over the remaining predictions and input the previous prediction 
% to |predictAndUpdateState|.
% 
% For large collections of data, long sequences, or large networks, predictions 
% on the GPU are usually faster to compute than predictions on the CPU. Otherwise, 
% predictions on the CPU are usually faster to compute. For single time step predictions, 
% use the CPU. To use the CPU for prediction, set the |'ExecutionEnvironment'| 
% option of |predictAndUpdateState| to |'cpu'|.

net = predictAndUpdateState(net,XTrain);
[net,YPred] = predictAndUpdateState(net,YTrain(end));

numTimeStepsTest = numel(XTest);
for i = 2:numTimeStepsTest
    [net,YPred(:,i)] = predictAndUpdateState(net,YPred(:,i-1),'ExecutionEnvironment','cpu');
end
%% 
% Unstandardize the predictions using the parameters calculated earlier.

YPred = sigma*YPred + mu;
%% 
% The training progress plot reports the root-mean-square error (RMSE) calculated 
% from the standardized data. Calculate the RMSE from the unstandardized predictions.

YTest = dataTest(2:end);
rmse = sqrt(mean((YPred-YTest).^2));
%% 
% Plot the training time series with the forecasted values.

figure(5)
plot(dataTrain(1:end-1))
hold on
idx = numTimeStepsTrain:(numTimeStepsTrain+numTimeStepsTest);
plot(idx,[data(numTimeStepsTrain) YPred],'.-')
hold off
xlabel("Month")
ylabel("Cases")

%% 
% Compare the forecasted values with the test data.
figure(6)
subplot(2,1,1)
plot(YTest)
hold on
plot(YPred,'.-')
hold off
legend(["Observed" "Forecast"])
ylabel("Cases")
title("Forecast (infinite horizon)")

subplot(2,1,2)
stem(YPred - YTest)
xlabel("Month")
ylabel("Error")
title("RMSE = " + rmse)
%% Update Network State with Observed Values
% If you have access to the actual values of time steps between predictions, 
% then you can update the network state with the observed values instead of the 
% predicted values.
% 
% First, initialize the network state. To make predictions on a new sequence, 
% reset the network state using |resetState|. Resetting the network state prevents 
% previous predictions from affecting the predictions on the new data. Reset the 
% network state, and then initialize the network state by predicting on the training 
% data.

net = resetState(net);
net = predictAndUpdateState(net,XTrain);
%% 
% Predict on each time step. For each prediction, predict the next time 
% step using the observed value of the previous time step. Set the |'ExecutionEnvironment'| 
% option of |predictAndUpdateState| to |'cpu'|.

YPred = [];
numTimeStepsTest = numel(XTest);
for i = 1:numTimeStepsTest
    [net,YPred(:,i)] = predictAndUpdateState(net,XTest(:,i),'ExecutionEnvironment','cpu');
end
%% 
% Unstandardize the predictions using the parameters calculated earlier.

YPred = sigma*YPred + mu;
%% 
% Calculate the root-mean-square error (RMSE).

rmse = sqrt(mean((YPred-YTest).^2))
%% 
% Compare the forecasted values with the test data.

figure(7)
subplot(2,1,1)
plot(YTest)
hold on
plot(YPred,'.-')
hold off
legend(["Observed" "Predicted"])
ylabel("Cases")
title("Forecast (one time step)")

subplot(2,1,2)
stem(YPred - YTest)
xlabel("Month")
ylabel("Error")
title("RMSE = " + rmse)
%% 
% Here, the predictions are more accurate when updating the network state 
% with the observed values instead of the predicted values.