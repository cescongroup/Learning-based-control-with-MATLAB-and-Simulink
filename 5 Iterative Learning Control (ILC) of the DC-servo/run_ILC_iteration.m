  disp('simulating ILC_pidDCsim')
  sim('ILC_pidDCsim')

idx_ILC = idx_ILC+1

% match time vectors in input and output to equal length

angle(:,idx_ILC) = interp1(ILC_pos.time,ILC_pos.signals.values,time_ILC')' ; 
angle_error_ILC(:,idx_ILC) = pos_Reference_ILC-angle(:,idx_ILC);
%
norm(angle_error_ILC(:,idx_ILC))
err = [err;norm(angle_error_ILC(:,idx_ILC))];
    
%====  update according to u_{k+1}= Q(u_k + L e_k) =========

Ld_err = noncausalfilter(Ld,angle_error_ILC(:,idx_ILC),tsamp_ILC); 
uold = correction_ILC(:,idx_ILC-1);
u = filtfilt(Qd_B,Qd_A, uold+Ld_err);
correction_ILC(:,idx_ILC) = u;

  figure(100)
  subplot(211)
  plot(time_ILC,angle_error_ILC(:,idx_ILC),'b'); hold on; 
  plot(time_ILC,correction_ILC(:,idx_ILC),'r');
  hold off; grid on
  legend('error', 'correction u_{k+1}')
  title('angle error and ILC-correction')
  subplot(212)
  plot(err,'*'); hold on
  plot(err); hold off
  ylabel('|error|')
  xlabel('iteration number')
  title('Norm of angle error')
  grid on
  
  figure(101)
  plot(time_ILC,pos_Reference_ILC,'b');
  hold on
  if idx_ILC>2
    plot(time_ILC,angle(:,idx_ILC-1));
  end  
  plot(time_ILC,angle(:,idx_ILC),'r');
  title('Simulated: angle and angle-ref')
  grid on

