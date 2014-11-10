% Computes mass flow rates for the reactor and the oven,
% and heat brought to the reactions.
function [m_reac, m_oven, q_reac] = masses_and_heat(T, m_nh3)

M = molar_masses();

% Computing mole flow rates
[n_reac, n_oven] = moles(T, m_nh3/M.nh3);

% Mass flow rates in and out of the reactor
m_reac.in1  = n_reac(1) * M.ch4;
m_reac.in2  = n_reac(2) * M.h2o;
m_reac.in3  = n_reac(3) * M.air;
m_reac.out1 = n_reac(4) * M.h2o;
m_reac.out2 = n_reac(5) * M.co2;
m_reac.out3 = n_reac(6) * M.ar ;
m_reac.out4 = n_reac(7) * M.nh3;

% Mass flow rates in and out of the oven
m_oven.ch4 = n_oven(1) * M.ch4;
m_oven.o2  = n_oven(2) * M.o2 ;
m_oven.co2 = n_oven(3) * M.co2;
m_oven.h2o = n_oven(4) * M.h2o;

% Heat brought to the five reactions
q_reac = delta_h_reac(T, n_reac(8), n_reac(9), n_reac(10), n_reac(11), ...
    n_reac(12));

end
