% Computes mole flow rates for the reactor and the oven
function [n_reac, n_oven] = moles(T, n_nh3)

% Chemical constants
R = 8.3144621;
pref = 1e5;

% Stating hypotheses
ptot = 26e5;
T_oven = 1300;
eta_oven = .75;

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
n_r = param_moles() * abc;
n_reac.in_ch4  = n_r(1);
n_reac.in_h2o  = n_r(2);
n_reac.in_air  = n_r(3);
n_reac.out_h2o = n_r(4);
n_reac.out_co2 = n_r(5);
n_reac.out_ar  = n_r(6);
n_reac.out_nh3 = n_r(7);
n_reac.alpha   = n_r(8);
n_reac.beta    = n_r(9);
n_reac.gamma   = n_r(10);
n_reac.delta   = n_r(11);
n_reac.epsilon = n_r(12);

% Computing mole flow rate of combustion.
% n_reac(8) and (9) are the degrees of advancement alpha and beta
Q_oven = n_reac.alpha*dH1 + n_reac.beta*dH2;
xi_oven = -Q_oven / eta_oven / delta_h_oven(T_oven);

% Expressing flow rates of CH4, O2, CO2 and H2O in the oven
n_oven.in_ch4  = 1 * xi_oven;
n_oven.in_o2   = 2 * xi_oven;
n_oven.out_co2 = 1 * xi_oven;
n_oven.out_h2o = 2 * xi_oven;

end
