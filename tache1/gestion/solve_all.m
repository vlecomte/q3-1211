function fluxes = solve_all(T, nh3)

dHf_ch4 = ;
dHf_h2 = ;
dHf_co = ;
dHf_co2 = ;
dHf_h2o = ;

S0_ch4 = ;
S0_h2 = ;
S0_co = ;
S0_co2 = ;
S0_h2o = ;

factors = [1, 10^(-3), 10^(-6)];
Cpm_ch4 = [14.23 75.3 -18.00] .* factors;
Cpm_h2 = [29.30 -0.84 2.09] .* factors;
Cpm_co = [27.62 5.02 0.00] .* factors;
Cpm_co2 = [32.22 22.18 -3.35] .* factors;
Cpm_h2o = [30.13 10.46 0.00] .* factors;

coeff_dCpm1 = 3*Cpm_h2 + Cpm_co - Cpm_ch4 - Cpm_h2o;
coeff_dCpm2 = Cpm_h2 + Cpm_co2 - Cpm_co - Cpm_h2o;
dHf1 = 3*dHf_h2 + dHf_co - dHf_ch4 - dHf_h2o;
dHf2 = dHf_h2 + dHf_co2 - dHf_co - dHf_h2o;
dS01 = 3*S0_h2 + S0_co - S0_ch4 - S0_h2o;
dS02 = S0_h2 + S0_co2 - S0_co - S0_h2o;

Tref = 298.15;
dH1 = dH(dHf1, coeff_dCpm1, Tref, T);
dH2 = dH(dHf2, coeff_dCpm2, Tref, T);
dS1 = dS(dS01, coeff_dCpm1, Tref, T);
dS2 = dS(dS02, coeff_dCpm2, Tref, T);

K1 = exp(-dG(dH1, dS1, T));
K2 = exp(-dG(dH2, dS2, T));

ptot = 2800000;
Kp1 = Kp(K1, ptot, 2);
Kp2 = Kp(K2, ptot, 0);

fluxes = null_of_linear_part() * solve_equi(Kp1, Kp2, nh3);

end