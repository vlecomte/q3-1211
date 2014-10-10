function compare()

approx1 = @(t) 14.63 + 75.30*t + -18.00*t.^2;
approx2 = @(t) -0.703029 + 108.4772*t + -42.52157*t.^2 + 5.862788*t.^3 + 0.678565./t.^2;

T = linspace(300,1300);
plot(T, approx1(T/1000), '-r', T, approx2(T/1000), '-g');

end

