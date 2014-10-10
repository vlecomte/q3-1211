function abc = solve_equi(Kp1, Kp2, out4)

syms a b c real;

param_gen = param_fluxes();
param_eq = param_fluxes_eq();

% Equates flux at out4 to find c
n_gen = param_gen * [a;b;c];
c = solve(n_gen(7) == out4, c);

% Solves equilibrium of alpha for a
n_eq = param_eq * [a;b;c];
a = solve(n_eq(2)*n_eq(4) / (n_eq(3)*n_eq(5)) == Kp2, a);

% Solves equilibrium of beta for b
n_eq = param_eq * [a;b;c];
b = solve(n_eq(2)^3*n_eq(3) / (n_eq(1)*n_eq(5)*sum(n_eq)^2) == Kp1, ...
    n_eq(3) >= 0, b);

% Converting to doubles
b = double(b);
a = eval(a);
c = double(c);

abc = [a;b;c];

end