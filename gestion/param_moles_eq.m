% Similar to param_moles.m, but gives the flow rate values at the output
% of the primary reformer, where the equilibrium is reached.
function [eq_null] = param_moles_eq()

% Represents the flow rates of chemicals coming out of the primary reformer
% for CH4, H2O, H2, CO and CO2 as lines, in terms of the variables from
% param_moles.m
% For example, the quantity of CH4 at equilibrium (1st line)
% is in1 - alpha.
eq_components = [
%  in  in  in  out out out out  alpha   gamma  epsilon
% CH4 H2O air  H2O CO2  Ar NH3    . beta  . delta .
    1   0   0,   0   0   0   0,  -1   0   0   0   0; % CH4
    0   1   0,   0   0   0   0,  -1  -1   0   0   0; % H2O
    0   0   0,   0   0   0   0,   3   1   0   0   0; % H2
    0   0   0,   0   0   0   0,   1  -1   0   0   0; % CO
    0   0   0,   0   0   0   0,   0   1   0   0   0; % CO2
];

% By multiplying with the basis of the solutions to the linear relations,
% we obtain the base of possible values for the quantities at equilibrium,
% which we can rater insert in the (non-linear) equilibrium equations,
% to find which coefficients multiply the columns.
eq_null = eq_components * param_moles();

end

