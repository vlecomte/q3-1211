function Cpm = Cpm(coeff, T)

n = length(coeff);
t = zeros(n,1) + T;
t = t .^ ((0:n-1)');
Cpm = coeff*t;

end