function [K,Kp,waste] = synthesis()

[H_basis, S_basis] = shomate_bases();
c = shomate_coeffs();

dc = 2*c.nh3 - c.n2 - 3*c.h2_low;

T = 750;
R = 8.3144621;
pref = 1e5;
p = 270e5;

dH = dc * H_basis(T);
dS = dc * S_basis(T);

K = exp(-(dH-T*dS)/(R*T));
Kp = K * (p/pref)^2;

syms a real positive;
n_nh3 = 1;
n_n2 = a;
n_h2 = 3*a;

n_tot = n_nh3 + n_n2 + n_h2;

a = solve((n_nh3/n_tot)^2 / ((n_n2/n_tot) * (n_h2/n_tot)^3) == Kp);

waste = double(eval((n_n2 + n_h2) / n_tot));

end

