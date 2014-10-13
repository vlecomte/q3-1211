% Computes mole flow rates for the reactor and the oven
function [n_reac, n_oven] = moles(T, n_nh3)

% Chemical constants
R = 8.3144621;
pref = 1e5;

% Stating hypotheses
ptot = 28e5;
T_oven = 1300;

% Computing molar enthalpy and entropy for primary reformer
[dH1,dH2,dS1,dS2] = delta_h_and_s_reformer1(T);

% Equilibrium constants of primary reformer
K1 = exp(-(dH1-T*dS1)/R/T);
K2 = exp(-(dH2-T*dS2)/R/T);

% Adapting to pressure
Kp1 = K1/(ptot/pref)^2;
Kp2 = K2;

% Computing unknown flow rate coefficients
abc = solve_equi(Kp1, Kp2, n_nh3);

% Expressing flow rates in1-3, out1-4, alpha-epsilon
n_reac = param_moles() * abc;

% Computing mole flow rate of combustion.
% n_reac(8) and (9) are the degrees of advancement alpha and beta
Q_oven = n_reac(8)*dH1 + n_reac(9)*dH2;
xi_oven = -Q_oven / delta_h_oven(T_oven);

% Expressing flow rates of CH4, O2, CO2 and H2O in the oven
n_oven = [1 2 1 2]' * xi_oven;

end