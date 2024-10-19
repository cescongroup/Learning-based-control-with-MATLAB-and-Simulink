%% Simulation parameters
tsim_ILC = 20; % total simulation time
tsamp_ILC = 0.010; % sample time
ref_period = 10;    
time_ILC = [0:tsamp_ILC:tsim_ILC-tsamp_ILC]';

%% Reference trajectory
pos_Reference_ILC = square(2*pi/ref_period*time_ILC);
correction_ILC = zeros(size(pos_Reference_ILC));

% ---  To describe transfer functions in discrete and continous time 
z = tf([1 0],1,tsamp_ILC);     
s = tf([1 0],1);

%% Heuristic filter design
Qd = c2d( 1/(s/p+1),tsamp_ILC);
Ld = alpha*z^beta;

[Ld_B,Ld_A] = tfdata(Ld,'v');
[Qd_B,Qd_A] = tfdata(Qd,'v');

%% Initialize ILC iterations
err=[];
idx_ILC=1;