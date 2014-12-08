% Imposes an output of NH3 and solves the equilibrium equations in order to
% find the three parameters that multiply the columns of param_fluxes()
% and thus calculate the final expression of the mole flow rates.
function [abc] = solve_equi(Kp1, Kp2, out4)

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
b = solve(n_eq(3)^3*n_eq(4) / (n_eq(1)*n_eq(2)*sum(n_eq)^2) == Kp1, ...
    n_eq(4) >= 0, b);

% Converting to doubles
b = double(b);
a = eval(a);
c = double(c);

abc = [a;b;c];

end
