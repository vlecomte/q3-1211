% Computes the enthalpy difference for all five reactions, which is equal
% to the heat brought in. As we have little information on the input and
% output temperatures, we consider as a first approximation that all
% reactions have inputs and outputs at 298.15K.
function [dH] = delta_h_reac(T1, alpha, beta, gamma, delta, epsilon)

Celsius = 273.15;
T2 = T1;
T3 = 900 + Celsius;
T4 = 300 + Celsius;
T5 = 750;

c = shomate_coeffs();

if T1 < 1000
    dc1 = 3*c.h2_low  + c.co      - c.ch4 - c.h2o;
    dc2 =   c.h2_low  + c.co2_low - c.co  - c.h2o;
else
    dc1 = 3*c.h2_high + c.co      - c.ch4 - c.h2o;
    dc2 =   c.h2_high + c.co2_low - c.co  - c.h2o;
end
dc3 = 2*c.co      + 4*c.h2_high - 2*c.ch4 -   c.o2    ;
dc4 =   c.co2_low +   c.h2_low  -   c.co  -   c.h2o   ;
dc5 = 2*c.nh3                   -   c.n2  - 3*c.h2_low;

H_basis = shomate_bases();

% The total enthalpy difference is equal to the molar enthalpy difference
% multiplied by the advancement degree of the reaction.
dH.alpha   = dc1 * H_basis(T1) * alpha  ;
dH.beta    = dc2 * H_basis(T2) * beta   ;
dH.gamma   = dc3 * H_basis(T3) * gamma  ;
dH.delta   = dc4 * H_basis(T4) * delta  ;
dH.epsilon = dc5 * H_basis(T5) * epsilon;

end
