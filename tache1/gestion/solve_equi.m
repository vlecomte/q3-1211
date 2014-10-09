function abc = solve_equi(Kp1, Kp2, out4)

syms a b real;
param = param_fluxes();
c = out4 / param(7,3);

param_eq = param_fluxes_eq();

% Solves equilibrium of alpha for a
n_eq = param_eq * [a;b;c];
a = solve(n_eq(2)*n_eq(4) / (n_eq(3)*n_eq(5)) == Kp2, a);

% Solves equilibrium of beta for b
n_eq = param_eq * [a;b;c];
b = solve(n_eq(2)^3*n_eq(3) / (n_eq(1)*n_eq(5)*sum(n_eq)^2) == Kp1, n_eq(3) >= 0);

a = eval(a);

abc = [double(a);double(b);c];

end