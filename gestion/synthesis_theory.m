function [cons, in_reac] = synthesis_theory(recycle)

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

y = roots(27*Kp*[1 -4 6 -4 1] - [16 -64 64 0 0]);
yield = y(imag(y) == 0 & y > 0 & y < 1);
ratio_fresh = 1 - recycle*(1-yield);
yield_with_recycle = yield ./ ratio_fresh;
cons = 1 ./ yield_with_recycle;
part_ar = 1/78 ./ (1-recycle);
in_reac = 4 ./ yield + part_ar .* cons;

end

