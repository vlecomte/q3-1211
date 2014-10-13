% Computes mass flow rates for the reactor and the oven
function [m_reac, m_oven] = masses(T, m_nh3)

% Molar masses
M_ar  = 40e-3;
M_ch4 = 16e-3;
M_co2 = 44e-3;
M_h2o = 18e-3;
M_n2  = 28e-3;
M_nh3 = 17e-3;
M_o2  = 32e-3;
M_air = .78*M_n2 + .21*M_o2 + .01*M_ar;

% Computing mole flow rates
[n_reac, n_oven] = moles(T, m_nh3/M_nh3);

% Mass flow rates in and out of the reactor
m_reac.in1  = n_reac(1) * M_ch4;
m_reac.in2  = n_reac(2) * M_h2o;
m_reac.in3  = n_reac(3) * M_air;
m_reac.out1 = n_reac(4) * M_h2o;
m_reac.out2 = n_reac(5) * M_co2;
m_reac.out3 = n_reac(6) * M_ar ;
m_reac.out4 = n_reac(7) * M_nh3;

% Mass flow rates in and out of the oven
m_oven.ch4 = n_oven(1) * M_ch4;
m_oven.o2  = n_oven(2) * M_o2 ;
m_oven.co2 = n_oven(3) * M_co2;
m_oven.h2o = n_oven(4) * M_h2o;

end
