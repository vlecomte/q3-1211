function fluxes = fluxes(T, nh3)

% Constants
Tref = 298.15;
R = 8.3144621;
pref =  1e5;
ptot = 28e5;

% Chemical properties
dHf_ch4 =  -74.81e3;
dHf_h2  =    0     ;
dHf_co  = -110.53e3;
dHf_co2 = -393.51e3;
dHf_h2o = -241.82e3;

S0_ch4 = 186.26;
S0_h2  = 130.68;
S0_co  = 197.67;
S0_co2 = 213.74;
S0_h2o = 188.83;

Cpm_ch4 = [14.23  75.30e-3 -18.00e-6]';
Cpm_h2  = [29.30  -0.84e-3   2.09e-6]';
Cpm_co  = [27.62   5.02e-3   0.00e-6]';
Cpm_co2 = [32.22  22.18e-3  -3.35e-6]';
Cpm_h2o = [30.13  10.46e-3   0.00e-6]';

% Properties of reactions
dCpm1 = 3*Cpm_h2 + Cpm_co  - Cpm_ch4 - Cpm_h2o;
dCpm2 =   Cpm_h2 + Cpm_co2 - Cpm_co  - Cpm_h2o;
dHf1  = 3*dHf_h2 + dHf_co  - dHf_ch4 - dHf_h2o;
dHf2  =   dHf_h2 + dHf_co2 - dHf_co  - dHf_h2o;
dS01  =  3*S0_h2 +  S0_co  -  S0_ch4 - S0_h2o ;
dS02  =    S0_h2 +  S0_co2 -  S0_co  - S0_h2o ;

% Enthalpy and entropy net changes
dH1 = delta_enthalpy(dHf1, dCpm1, Tref, T);
dH2 = delta_enthalpy(dHf2, dCpm2, Tref, T);
dS1 = delta_entropy (dS01, dCpm1, Tref, T);
dS2 = delta_entropy (dS02, dCpm2, Tref, T);

% Equilibrium constants
K1 = exp(-(dH1-T*dS1)/R/T);
K2 = exp(-(dH2-T*dS2)/R/T);

% Adapting with pressure
Kp1 = K1/(ptot/pref)^2;
Kp2 = K2;

% Finding unknown coefficients
abc = solve_equi(Kp1, Kp2, nh3);

% Evaluating fluxes
fluxes = param_fluxes() * abc;

end