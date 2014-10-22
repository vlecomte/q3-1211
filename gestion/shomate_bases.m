% This function uses the Shomate equations, which describe molar heat
% capacities, formation enthalpy and entropy as functions of temperature:
%   / Cpm(t)    = A        + B*t     + C*t^2   + D*t^3   + E/t^2
%   | dH(t)     = A*t      + B*t^2/2 + C*t^3/3 + D*t^4/4 - E/t    + F
%   \ S(t)      = A*log(t) + B*t     + C*t^2/2 + D*t^3/3 - E/2t^2     + G
% with t = T/1000 and units of [J/mol*K], [kJ/mol] and [J/mol*K].
%
% It returns the basis functions for evaluating dH and S
function [H_basis, S_basis] = shomate_bases()

% Basis functions of the approximation.
% H_basis_norm and S_basis_norm are functions of t = T/1000,
% whereas H_basis and S_basis are functions of T.
H_basis_norm = @(t) 1000*[t t^2/2 t^3/3 t^4/4 -1/t 1 0]';
H_basis = @(T) H_basis_norm(T/1000);

S_basis_norm = @(t) [log(t) t t^2/2 t^3/3 -1/(2*t^2) 0 1]';
S_basis = @(T) S_basis_norm(T/1000);

end
