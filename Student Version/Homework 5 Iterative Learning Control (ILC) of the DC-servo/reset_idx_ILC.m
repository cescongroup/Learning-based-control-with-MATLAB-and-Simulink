ILC_setup;

idx_ILC=1;
err=[];
angle_error_ILC=[];
sim('ILC_pidDCsim')

% dummy to update diagram
figure(101); clf; title('initialized for ILC\_pidDCsim') 
figure(100); clf; title('initialized for ILC\_pidDCsim') 