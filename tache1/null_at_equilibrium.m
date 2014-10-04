% Similar to null_of_linear_part, but gives the flow values at the output
% of the primary reformer, where the equilibrium happens.
function eq_null = null_at_equilibrium()

% Represents the flows of chemicals coming out of the primary reformer
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
% which we can then insert in the (non-linear) equilibrium equations.
% The three resulting vectors can be interpreted as follows:
% in order to fit the equilibrium you can adapt
% - the amount of water going through, as both its input and its output are
%   independent from the rest;
% - the degree of advancement of reaction beta, as it can be later
%   corrected by equation delta;
% - and the overall quantity of ammonia produced.
% The latter will be fixed by the required production. The fact that
% negative amount of matter are not allowed brings interesting bounds to
% the coefficients of those vectors:
% - the first and third coefficients have to be positive
% - since the amount of CO must be positive, the second coefficient has to
%   be at least 0.5385 times as big as the third;
% - since the amount of CO2 must be positive, the second coefficient has to
%   be at most 1.1538 times as big as the third.
% Note that there may be better bounds, as this is not a complete analysis.
eq_null = eq_components * null_of_linear_part();

end

