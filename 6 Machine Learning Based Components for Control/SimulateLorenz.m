% Simulate Lorenz system
Lorenz = @(t,x)([ sigma * (x(2) - x(1))       ; ...
                  rho * x(1)-x(1) * x(3) - x(2) ; ...
                  x(1) * x(2) - beta*x(3)         ]);              
ode_options = odeset('RelTol',1e-10, 'AbsTol',1e-11);

% create training data
figure()
input = []; output = [];
for j = 1:100  % training trajectories
    x0 = 30*(rand(3,1)-0.5); %initial conditions
    [t,y] = ode45(Lorenz,t,x0);
    input = [input; y(1:end-1,:)];
    output = [output; y(2:end,:)];
    plot3(y(:,1),y(:,2),y(:,3)), hold on
    plot3(x0(1),x0(2),x0(3),'ro')
end
grid on, view(-23,18)
xlabel('x(t)');
ylabel('y(t)');
zlabel('z(t)');

