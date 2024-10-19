function [tend,A,omega,range,y]=springmassSolver(A,omega,m1,m2,k1,k2,k3,titl)
% Spring mass system
c = 10; % damping
tspan=[0 500]; % time range for simulation
y0 = [0; 0; 0; 0]; % initial conditions
% Call ode45 routine
[t,y] = ode45(@springmass, tspan, y0, [], k1, k2, k3, m1, m2, c, A, omega);
% Plot the input and outputs over entire period

figure(1)
plot(t, A*cos(omega*t), t, y(:,1), t, y(:,2) );
legend('u=A*cos(\omegat)','y1','y2' )
xlabel('Time[s]')
ylabel('Position [m]')
 grid on
title({sprintf('Input and Outputs over entire period');titl})
% Now plot the data for the final 10% (assuming this is long enough...)
endlen = round(length(t)/10); % last 10% of data record
range = (length(t)-endlen:length(t))'; % create vector of indices (note ')
tend = t(range);

figure(2)
plot(tend, A*cos(omega*tend), tend, y(range,1), tend, y(range,2) );
legend('u=A*cos(\omegat)','y1','y2' )
xlabel('Time[s]')
ylabel('Position [m]')
title({sprintf('Input and Steady state Outputs');titl})
 grid on
end