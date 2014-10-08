function Kp = Kp(K, ptot, ngas)

% Reference pressure = 1bar
pref = 100000;

Kp = K*(pref/ptot)^ngas;

end