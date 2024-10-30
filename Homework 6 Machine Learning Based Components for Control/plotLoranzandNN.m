
%% testing
rng(6);
figure(2)
x0 = 20*(rand(3,1)-0.5);
[t,y] = ode45(Lorenz,t,x0);
plot3(y(:,1),y(:,2),y(:,3),'r'), hold on
plot3(x0(1),x0(2),x0(3),'go','Linewidth',[2])
grid on
%%
ynn(1,:) = x0;
for jj = 2:length(t)
    y0 = net(x0);
    ynn(jj,:) = y0.';
    x0 = y0;
end
%%
plot3(ynn(:,1),ynn(:,2),ynn(:,3),'b','Linewidth',[2])
legend('ODE (true)','x(0)','NN (prediction)','Location','best')
xlabel('x(t)');
ylabel('y(t)');
zlabel('z(t)');
%fixfig

figure(3)
title('Evaluation for two different x(0) (right vs left)')
subplot(3,2,1), plot(t,y(:,1),t,ynn(:,1),'Linewidth',[2])
subplot(3,2,3), plot(t,y(:,2),t,ynn(:,2),'Linewidth',[2])
subplot(3,2,5), plot(t,y(:,3),t,ynn(:,3),'Linewidth',[2])

%%

figure(2)
x0=20*(rand(3,1)-0.5);
[t,y] = ode45(Lorenz,t,x0);
plot3(y(:,1),y(:,2),y(:,3)','r'), hold on
plot3(x0(1),x0(2),x0(3),'go','Linewidth',[2])
grid on
ynn(1,:) = x0;
for jj = 2:length(t)
    y0 = net(x0);
    ynn(jj,:) = y0.';
    x0 = y0;
end
plot3(ynn(:,1),ynn(:,2),ynn(:,3),'b','Linewidth',[2])
view(-75,15)
legend('ODE (true)','x(0)','NN (prediction)','Location','best')

figure(3)
subplot(3,2,2), plot(t,y(:,1),t,ynn(:,1),'Linewidth',[2])
subplot(3,2,4), plot(t,y(:,2),t,ynn(:,2),'Linewidth',[2])
subplot(3,2,6), plot(t,y(:,3),t,ynn(:,3),'Linewidth',[2])

%%

figure(3)
subplot(3,2,1), set(gca,'Fontsize',[15],'Xlim',[0 8])
ylabel('x(t)')
subplot(3,2,2), set(gca,'Fontsize',[15],'Xlim',[0 8])
subplot(3,2,3), set(gca,'Fontsize',[15],'Xlim',[0 8])
ylabel('y(t)')
subplot(3,2,4), set(gca,'Fontsize',[15],'Xlim',[0 8])
subplot(3,2,5), set(gca,'Fontsize',[15],'Xlim',[0 8])
ylabel('z(t)')
subplot(3,2,6), set(gca,'Fontsize',[15],'Xlim',[0 8])
legend('Lorenz','NN')