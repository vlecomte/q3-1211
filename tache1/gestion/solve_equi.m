function abc = solve_equi(Kp1, Kp2, out4)

syms a b real;
n = null_of_linear_part();
c = out4 / n(7,3);

% Solves equilibrium of alpha for a
eq = express_equi(a, b, c);
a = solve(eq(2)*eq(4) / (eq(3)*eq(5)) == Kp2, a);

% Solves equilibrium of beta for b
eq = express_equi(a, b, c);
b = solve(eq(2)^3*(3) / (eq(1)*eq(5)*sum(eq)^2) == Kp1);
a = eval(a);

abc = [a;b;c];

end