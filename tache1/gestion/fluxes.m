function fluxes = fluxes(T, n_nh3)

% Constants
R = 8.3144621;
pref =  1e5;
ptot = 28e5;

% Getting enthalpy and entropy
[dH1,dH2,dS1,dS2] = delta_h_and_s(T);

% Equilibrium constants
K1 = exp(-(dH1-T*dS1)/R/T);
K2 = exp(-(dH2-T*dS2)/R/T);

% Adapting to pressure
Kp1 = K1/(ptot/pref)^2;
Kp2 = K2;

% Finding unknown coefficients
abc = solve_equi(Kp1, Kp2, n_nh3);

% Evaluating fluxes
fluxes = param_fluxes() * abc;

end