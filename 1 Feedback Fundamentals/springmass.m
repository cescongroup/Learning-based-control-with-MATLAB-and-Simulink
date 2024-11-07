% This function contains the differential equation that describes the mass spring system. 
% It allows individual mass and spring values, plus sinusoidal forcing. The state is stored in the vector y. The values for y are 
% y(1) = q1, position of first mass
% y(2) = q2, position of second mass
% y(3) = q1dot, velocity of first mass
% y(4) = q2dot, velocity of second mass
function dydt = springmass(t, y, k1, k2, k3, m1, m2, c, A, omega)
% compute the input to drive the system
u = A*cos(omega*t);
% compute the time derivative of the state vector
dydt = [
y(3);
y(4);
-(k1+k2)/m1*y(1) + k2/m1*y(2);
k2/m2*y(1) - (k2+k3)/m2*y(2) - c/m2*y(4) + k3/m2*u
];
end