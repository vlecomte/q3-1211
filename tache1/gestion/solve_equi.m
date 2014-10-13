% Imposes an output of NH3 and solves the equilibrium equations in order to
% find the three parameters that multiply the columns of param_fluxes()
% and thus calculate the final expression of the fluxes.
function [abc] = solve_equi(Kp1, Kp2, out4)

% The unknown flux coefficients
syms a b c real;

% The basis for fluxes in1-3, out1-4, alpha-epsilon (see param_fluxes.m)
param_gen = param_fluxes();
% The basis for fluxes of CH4, H2, CO, CO2, H2O at equilibrium
% (see param_fluxes_eq.m)
param_eq = param_fluxes_eq();

% Equating flux at out4 to find c
n_gen = param_gen * [a;b;c];
c = solve(n_gen(7) == out4, c);

% Solving equilibrium of alpha for a
n_eq = param_eq * [a;b;c];
a = solve(n_eq(2)*n_eq(4) / (n_eq(3)*n_eq(5)) == Kp2, a);

% Solving equilibrium of beta for b
n_eq = param_eq * [a;b;c];
b = solve(n_eq(2)^3*n_eq(3) / (n_eq(1)*n_eq(5)*sum(n_eq)^2) == Kp1, ...
    n_eq(3) >= 0, b);

% Converting to doubles
b = double(b);
a = eval(a);
c = double(c);

abc = [a;b;c];

end