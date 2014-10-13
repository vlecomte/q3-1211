% Solves the matter conservation equations, and returns the solution in
% parametric form.
function [n] = param_fluxes()

% A describes the system in terms of
%   - in1, in2, in3: the inputs of CH4, H2O and air;
%   - out1, out2, out3, out4: the outputs of H2O, CO2, Ar and NH3;
%   - alpha, beta, gamma, delta, epsilon: the degrees of advancement;
% as the columns, in that order.
%
% The lines represent matter conservation for
%   CH4, H2O, H2, CO, CO2, O2, N2, Ar, NH3
% in that order.
A = [
    1 0 0 0 0 0 0 -1 0 -2 0 0;
    0 1 0 -1 0 0 0 -1 -1 0 -1 0;
    0 0 0 0 0 0 0 3 1 4 1 -3;
    0 0 0 0 0 0 0 1 -1 2 -1 0;
    0 0 0 0 -1 0 0 0 1 0 1 0;
    0 0 .21 0 0 0 0 0 0 -1 0 0;
    0 0 .78 0 0 0 0 0 0 0 0 -1;
    0 0 .01 0 0 -1 0 0 0 0 0 0;
    0 0 0 0 0 0 -1 0 0 0 0 2;
    ];

% Solves the above homogeneous system of equations.
% As there are 12 variables and 9 equations, the solution is of
% the form a*v1 + b*v2 + c*v3 with a,b,c flux parameters in [mol/s].
% n is the matrix [v1 v2 v3].
n = null(A, 'r');

% The three resulting vectors can be interpreted as follows:
% - v1: you can add water at in2, as long as you drain as much at out1;
% - v2: since the reactions beta and delta are equivalent,
%   you can reduce the work done by beta and increase that made by delta;
% - v3: when producing one mole of NH3, most other necessary quantities can
%   be deduced.

end
