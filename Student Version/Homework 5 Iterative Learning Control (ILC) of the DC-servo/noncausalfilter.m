function y = noncausalfilter(G,x,ts)
%
%noncausalfilter(G,x,ts)  Applies the noncausal filter G to the
%sequence x.
%
%Parameters:-  G - noncausal filter on the form
%                              (b_m z^m +...+b_0)/(a_n z^n+...+a_0)
%               -  x  - column vector with the sequence to be filtered
%               -  ts - sampling time

[b,a] = tfdata(G,'v');
Nb = min(find(abs(b) > eps));
Na = min(find(abs(a) > eps));
lag = Na-Nb;
if (lag < 0)
  lag = 0;
end
a = [a(1,Na:end) zeros(1,Na-1)];
y = lsim(tf(b,a,ts),[x;zeros(lag,1)]);
y = y(lag+1:end);