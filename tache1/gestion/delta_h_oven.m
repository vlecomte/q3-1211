% Computes the molar enthalpy of the combustion reaction in the oven.
function [dH] = delta_h_oven(T_oven)

% Molar enthalpies of formation at 298.15K.
% CH4 and O2 are taken to enter the oven at room temperature.
Hform_ch4 = -74.87310e3;
Hform_o2  =   0;

% Coefficients A through F of Shomate equations.
% See delta_h_and_s_reformer1.m
if T_oven<1200
    c_co2 = [24.99735 55.18696 -33.69137 7.948387 -0.136638 -403.6975];
else
    c_co2 = [58.16639 2.720074 -0.492289 0.038844 -6.447293 -425.9186];
end
c_h2o = [30.09200 6.832514 6.793435 -2.534480 0.082139 -250.8810];

% Basis function of the approximation
H_basis_norm = @(t) 1000*[t t^2/2 t^3/3 t^4/4 -1/t 1]';
H_basis_T = H_basis_norm(T_oven/1000);

% Computing the enthalpy difference
dH = (c_co2 + 2*c_h2o) * H_basis_T - Hform_ch4 - 2*Hform_o2;
