% Similar to null_of_linear_part, but gives the flux values at the output
% of the primary reformer, where the equilibrium is reached.
function eq_null = param_fluxes_eq()

% Represents the fluxes of chemicals coming out of the primary reformer
% for CH4, H2, CO, CO2 and H2O as lines, in terms of the variables from
% null_of_linear_part.m
% For example, the quantity of CH4 at equilibrium (1st line)
% is in1 - alpha.
eq_components = [
    1 0 0 0 0 0 0 -1 0 0 0 0;
    0 0 0 0 0 0 0 3 1 0 0 0;
    0 0 0 0 0 0 0 1 -1 0 0 0;
    0 0 0 0 0 0 0 0 1 0 0 0;
    0 1 0 0 0 0 0 -1 -1 0 0 0;
    ];

% By multiplying with the base of the solutions to the linear relations,
% we obtain the base of possible values for the quantities at equilibrium,
% which we can rater insert in the (non-linear) equilibrium equations,
% to find which coefficients multiply the columns.
eq_null = eq_components * param_fluxes();

end

