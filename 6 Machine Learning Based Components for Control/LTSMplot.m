%% Forecast Future Time Steps

% Convert last input of training set to dlarray (to warm up LSTM state)
nnet=net;
dlXTrain = dlarray(XTrain', 'TC'); 
dlYTrain = dlarray(YTrain(end), 'TC');  
 
 [~,state]=predict(nnet,dlXTrain);
 nnet.State=state;

 [Z,state]=predict(nnet,dlYTrain);
 nnet.State=state;
 YPred = [];     
 YPred(:,1) = Z(:,end);

 numTimeStepsTest = numel(XTest);

for i = 2:numTimeStepsTest
    [YPred(:,i),state] = predict(nnet,YPred(:,i-1));
    nnet.State = state;
end


%% 
% Unstandardize the predictions using the parameters calculated earlier.

YPred = sigma*(YPred) + mu;
%% 
% The training progress plot reports the root-mean-square error (RMSE) calculated 
% from the standardized data. Calculate the RMSE from the unstandardized predictions.

YTest = dataTest(2:end);
rmse = sqrt(mean((YPred-YTest).^2));
%% 
% Plot the training time series with the forecasted values.

figure(101)
plot(dataTrain(1:end-1))
hold on
idx = numTimeStepsTrain:(numTimeStepsTrain+numTimeStepsTest);
plot(idx,[data(numTimeStepsTrain) YPred],'.-')
hold off
xlabel("Month")
ylabel("Cases")

%% 
% Compare the forecasted values with the test data.
figure(102)
subplot(2,1,1)
plot(YTest)
hold on
plot(YPred,'.-')
hold off
legend(["Observed" "Forecast"])
ylabel("Cases")
title("Forecast (infinite horizon)")

subplot(2,1,2)
stem((YPred) - YTest)
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

nnet = resetState(nnet);

dlXTest = dlarray(XTest', 'TC'); 

[~,state]=predict(nnet,dlXTrain);
nnet.State=state;

YPred = [];

numTimeStepsTest = numel(XTest);
for i = 1:numTimeStepsTest
    [YPred(:,i),state] = predict(nnet,dlXTest(:,i));
    nnet.State = state; 
end
%% 
% Unstandardize the predictions using the parameters calculated earlier.

YPred = sigma*YPred + mu;
%% 
% Calculate the root-mean-square error (RMSE).

rmse = sqrt(mean((YPred-YTest).^2));
%% 
% Compare the forecasted values with the test data.

figure(103)
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