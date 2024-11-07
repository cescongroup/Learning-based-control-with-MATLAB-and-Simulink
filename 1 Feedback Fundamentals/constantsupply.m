function constantsupply

% Set up the initial state
clear H L year
H(1) = 10; L(1) = 10;
% For simplicity, keep track of the year as well
year(1) = 1845;
% Set up parameters (note that c = a in the model below)
br = 0.8; df = 0.7; a = 0.014;
nperiods = 365; % simulate each day
duration = 90; % number of years for simulation
% Iterate the model
for k = 1:duration*nperiods
c = br; % constant food supply
H(k+1) = H(k) + (c*H(k) - a*L(k)*H(k))/nperiods;
L(k+1) = L(k) + (a*L(k)*H(k) - df*L(k))/nperiods;
year(k+1) = year(k) + 1/nperiods;
    if (mod(k, nperiods) == 1)
    % Store the annual population
    Ha((k-1)/nperiods + 1) = H(k);
    La((k-1)/nperiods + 1) = L(k);
    end
end
% Store the final population
Ha(duration) = H(duration*nperiods+1);
La(duration) = L(duration*nperiods+1);
% Plot the populations of rabbits and foxes versus time
figure 
plot(1845 + (1:duration), Ha, 'r.-', 1845 + (1:duration), La, 'm.--');
hold on;
grid on;
 title('Constant Food Supply')
axis([1845 1925 0 250]);
xlabel('Year');
ylabel('Population');
legend('hares','lynxes')
end