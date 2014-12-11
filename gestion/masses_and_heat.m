% Computes mass flow rates for the reactor and the oven,
% and heat brought to the reactions.
function [m_reac, m_oven, q_reac] = masses_and_heat(T, m_nh3)

M = molar_masses();

% Computing mole flow rates
[n_reac, n_oven] = moles(T, m_nh3/M.nh3);

% Mass flow rates in and out of the reactor
m_reac.in_ch4  = n_reac.in_ch4  * M.ch4;
m_reac.in_h2o  = n_reac.in_h2o  * M.h2o;
m_reac.in_air  = n_reac.in_air  * M.air;
m_reac.out_h2o = n_reac.out_h2o * M.h2o;
m_reac.out_co2 = n_reac.out_co2 * M.co2;
m_reac.out_ar  = n_reac.out_ar  * M.ar ;
m_reac.out_nh3 = n_reac.out_nh3 * M.nh3;

% Mass flow rates in and out of the oven
m_oven.ch4 = n_oven.in_ch4  * M.ch4;
m_oven.o2  = n_oven.in_o2   * M.o2 ;
m_oven.co2 = n_oven.out_co2 * M.co2;
m_oven.h2o = n_oven.out_h2o * M.h2o;

% Heat brought to the five reactions
q_reac = delta_h_reac(T, n_reac.alpha, n_reac.beta, n_reac.gamma,...
    n_reac.delta, n_reac.epsilon);

end
