function plotvel(T, ki, kp, m)
sim('cruise_control_model'); % Run the main simulink model
sim('cruise_animation.slx'); %Run file for animation
plot(Time,Vel)
xlabel('Time [sec]')
ylabel('Velocity [m/s]')
grid on
end