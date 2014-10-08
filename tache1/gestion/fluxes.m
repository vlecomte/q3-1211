function fluxes = fluxes(T, nh3)

% Constants
Tref = 298.15;
R = 8.3144621;
pref = 1*10^5;
ptot = 28*10^5;

% Chemical properties
dHf_ch4 = -74.81*10^3;
dHf_h2 = 0;
dHf_co = -110.53*10^3;
dHf_co2 = -393.51*10^3;
dHf_h2o = -241.82*10^3;

S0_ch4 = 186.26;
S0_h2 = 130.68;
S0_co = 197.67;
S0_co2 = 213.74;
S0_h2o = 188.83;

f = [1, 10^(-3), 10^(-6)]';
Cpm_ch4 = [14.23 75.3 -18.00]' .* f;
Cpm_h2 = [29.30 -0.84 2.09]' .* f;
Cpm_co = [27.62 5.02 0]' .* f;
Cpm_co2 = [32.22 22.18 -3.35]' .* f;
Cpm_h2o = [30.13 10.46 0]' .* f;

% Properties of reactions
dCpm1 = 3*Cpm_h2 + Cpm_co - Cpm_ch4 - Cpm_h2o;
dCpm2 = Cpm_h2 + Cpm_co2 - Cpm_co - Cpm_h2o;
dHf1 = 3*dHf_h2 + dHf_co - dHf_ch4 - dHf_h2o;
dHf2 = dHf_h2 + dHf_co2 - dHf_co - dHf_h2o;
dS01 = 3*S0_h2 + S0_co - S0_ch4 - S0_h2o;
dS02 = S0_h2 + S0_co2 - S0_co - S0_h2o;

% Enthalpy and entropy net changes
dH1 = delta_enthalpy(dHf1, dCpm1, Tref, T);
dH2 = delta_enthalpy(dHf2, dCpm2, Tref, T);
dS1 = delta_entropy(dS01, dCpm1, Tref, T);
dS2 = delta_entropy(dS02, dCpm2, Tref, T);

% Equilibrium constants
K1 = exp(-(dH1-T*dS1)/R/T);
K2 = exp(-(dH2-T*dS2)/R/T);

% Adapting with pressure
Kp1 = K1/(ptot/pref)^2;
Kp2 = K2;

% Finding unknown coefficients
abc = solve_equi(Kp1, Kp2, nh3);

% Evaluating fluxes
fluxes = null_of_linear_part() * abc;

end