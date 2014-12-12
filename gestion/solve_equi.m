% Imposes an output of NH3 and solves the equilibrium equations in order to
% find the three parameters that multiply the columns of param_fluxes()
% and thus calculate the final expression of the mole flow rates.
function [abc] = solve_equi(Kp1, Kp2, out4)

% This function stores its output in a hash table
global result_map;
if ~isa(result_map, 'containers.Map')
    result_map = containers.Map;
end
hash = num2str([Kp1 Kp2], '%.6f %.6f');
if result_map.isKey(hash)
    abc = out4 * result_map(hash);
    return
end

% The unknown flux coefficients
syms a b c real;

% The basis for mole flow rates in1-3, out1-4, alpha-epsilon
% (see param_fluxes.m)
param_gen = param_moles();
% The basis for mole flow rates of CH4, H2O, H2, CO, CO2 at equilibrium
% (see param_fluxes_eq.m)
param_eq = param_moles_eq();

% Equating flow rate at out4 to find c
n_gen = param_gen * [a;b;c];
c = solve(n_gen(7) == out4, c);

% Solving equilibrium of alpha for a
n_eq = param_eq * [a;b;c];
a = solve(n_eq(3)*n_eq(5) / (n_eq(4)*n_eq(2)) == Kp2, a);

% Solving equilibrium of beta for b
n_eq = param_eq * [a;b;c];
warning('off','all');
b = solve(n_eq(3)^3*n_eq(4) / (n_eq(1)*n_eq(2)*sum(n_eq)^2) == Kp1, ...
    n_eq(4) >= 0, b);
warning('on','all');

% Converting to doubles
b = double(b);
a = eval(a);
c = double(c);

abc = [a;b;c];
% Storing this result for later
result_map(hash) = abc / out4;

end
