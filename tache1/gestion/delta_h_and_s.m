function [dH1,dH2,dS1,dS2] = delta_h_and_s(T)

% Coefficients A through G of Shomate equation
c_ch4 = [-0.703029 108.4773 -42.52157 5.862788 0.678565 ...
    -76.84376 158.7163];
if T < 1000
    c_h2 = [33.066178 -11.363417 11.432816 -2.772874 -0.158558 ...
        -9.980797 172.707974];
else
    c_h2 = [18.563083 12.257357 -2.859786 0.268238 1.977990 ...
        -1.147438 156.288133];
end
c_co = [25.56759 6.096130 4.054656 -2.671301 0.131021 ...
    -118.0089 227.3665];
c_co2 = [24.99735 55.18696 -33.69137 7.948387 -0.136638 ...
    -403.6075 228.2431];
c_h2o = [30.09200 6.832514 6.793435 -2.534480 0.082139 ...
    -250.8810 223.3967];

% Basis functions of the approximation
H_basis_norm = @(t) 1000*[t t^2/2 t^3/3 t^4/4 -1/t 1 0]';
H_basis_T = H_basis_norm(T/1000);

S_basis_norm = @(t) [log(t) t t^2/2 t^3/3 -1/(2*t^2) 0 1]';
S_basis_T = S_basis_norm(T/1000);

% Combining the coefficients for both reactions
dc1 = 3*c_h2 + c_co - c_ch4 - c_h2o;
dc2 = c_h2 + c_co2 - c_co - c_h2o;

% Computing the sums
dH1 = dc1 * H_basis_T;
dH2 = dc2 * H_basis_T;
dS1 = dc1 * S_basis_T;
dS2 = dc2 * S_basis_T;

end

