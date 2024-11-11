function theta_hat = rlsupdate(data)
% RLS 
% MC 02/21/2024
%
persistent P theta phi
    %
if isempty(P)
    %initial conditions
    P = 1*eye(2);
    theta = [0 0]'; 
    phi = [0 0]'; %regressors 
    
end

u = data(1);
y = data(2);

% recursive equations

e = ...;
 
P = ...;

theta = ...;

theta_hat = ...;

phi=...;

return
