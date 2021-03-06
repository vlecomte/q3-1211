% Solves the matter conservation equations, and returns the solution in
% parametric form.
function [n] = param_moles()

global ideal_synth
if ideal_synth
    c = 1;
else
    % Taking into account a 95% recycle ratio in the synthesis reactor.
    c = 1 / synthesis_theory(0.95);
end

% A describes the system in terms of the mole flow rates:
%   - in1, in2, in3: the inputs of CH4, H2O and air;
%   - out1, out2, out3, out4: the outputs of H2O, CO2, Ar and NH3;
%   - alpha, beta, gamma, delta, epsilon: the degrees of advancement;
% as the columns, in that order.
%
% The lines represent matter conservation for
%   CH4, H2O, H2, CO, CO2, O2, N2, Ar, NH3
% in that order.
A = [
%  in  in  in  out out out out  alpha   gamma  epsilon
% CH4 H2O air  H2O CO2  Ar NH3    . beta  . delta .
    1   0   0,   0   0   0   0,  -1   0  -2   0   0  ; % CH4
    0   1   0,  -1   0   0   0,  -1  -1   0  -1   0  ; % H2O
    0   0   0,   0   0   0   0,   3   1   4   1  -3*c; % H2
    0   0   0,   0   0   0   0,   1  -1   2  -1   0  ; % CO
    0   0   0,   0  -1   0   0,   0   1   0   1   0  ; % CO2
    0   0 .21,   0   0   0   0,   0   0  -1   0   0  ; % O2
    0   0 .78,   0   0   0   0,   0   0   0   0  -1*c; % N2
    0   0 .01,   0   0  -1   0,   0   0   0   0   0  ; % Ar
    0   0   0,   0   0   0  -1,   0   0   0   0   2  ; % NH3
];

% Solves the above homogeneous system of equations.
% As there are 12 variables and 9 equations, the solution is of
% the form a*v1 + b*v2 + c*v3 with a,b,c flux parameters in [mol/s].
% n is the matrix [v1 v2 v3].
n = null(A, 'r');

% The three resulting vectors can be interpreted as follows:
% - v1: you can add water at in2, as long as you drain as much at out1;
% - v2: since the reactions beta and delta are equivalent, you can reduce
%       the work done by beta and increase that made by delta;
% - v3: when producing one mole of NH3, most other necessary quantities can
%       be deduced.

end
