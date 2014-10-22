function [K,Kp,waste] = synthesis()

[H_basis, S_basis] = shomate_bases();
c = shomate_coeffs();

dc = 2*c.nh3 - c.n2 - 3*c.h2_low;

T = 750;
R = 8.314;
pref = 1e5;
p = 270e5;

dH = dc * H_basis(T);
dS = dc * S_basis(T);

K = exp(-(dH-T*dS)/(R*T));
Kp = K * (p/pref)^2;

syms a real positive;
f_nh3 = 1;
f_n2 = a;
f_h2 = 3*a;

f_tot = f_nh3 + f_n2 + f_h2;

a = solve((f_nh3/f_tot)^2 / ( (f_n2/f_tot) * (f_h2/f_tot)^3 ) == Kp);
a = double(a);

waste = 4*a/ (1+4*a);

end

