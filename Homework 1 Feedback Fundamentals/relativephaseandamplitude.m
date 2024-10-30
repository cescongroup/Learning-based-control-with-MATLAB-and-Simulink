function relativephaseandamplitude(tend,A,omega,range,y)
u = A*cos(omega*tend); 
udot = -A*omega*sin(omega*tend);
ampu = mean( sqrt((u .* u) + (udot/omega .* udot/omega)) );

%Amplitude:
y_1=y(range,1);
y_2=y(range,2);
y_1dot=y(range,3);
y_2dot=y(range,4);

ampu1=mean( sqrt((y_1 .* y_1) + (y_1dot/omega .* y_1dot/omega)) );
ampu2=mean( sqrt((y_2 .* y_2) + (y_2dot/omega .* y_2dot/omega)) );

%Phase
phase1=max(atan(y_1dot./(-y_1*omega))-omega*tend);
phase2=max(atan(y_2dot./(-y_2*omega))-omega*tend)+pi;

yy1=ampu1*cos(omega*tend +phase1);
yy2=ampu2*cos(omega*tend +phase2 );
fprintf('\n Relative Amplitude 1 = %0.5e m \n Relative Amplitude 2 = %0.5e m \n Relative Phase 1 = %g rad/s \n Relative Phase 2 = %g rad/s', ampu1, ampu2, phase1, phase2)

fprintf('\n \n \n Plotting computed outputs...')
clf
figure(3)
plot(tend,yy2,tend,yy1,tend,u);
legend('u=A*cos(\omegat)','computed y1','computed y2' )
xlabel('Time[s]')
ylabel('Position [m]')
title({'Computed Outputs using relative phase and amplitude';sprintf('A = %s [m] and \\omega = %s [rad]',num2str(A),num2str(omega))})
grid on
end
