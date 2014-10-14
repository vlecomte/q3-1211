% Calculates molar enthalpy and entropy values for the two reactions in the
% primary reformer. 
function [dH1, dH2, dS1, dS2] = delta_h_and_s_reformer1(T)

[H_basis, S_basis] = shomate_bases();
c = shomate_coeffs();

if T < 1000
    dc1 = 3*c.h2_low  + c.co      - c.ch4 - c.h2o;
    dc2 =   c.h2_low  + c.co2_low - c.co  - c.h2o;
else
    dc1 = 3*c.h2_high + c.co      - c.ch4 - c.h2o;
    dc2 =   c.h2_high + c.co2_low - c.co  - c.h2o;
end

dH1 = dc1 * H_basis(T);
dH2 = dc2 * H_basis(T);
dS1 = dc1 * S_basis(T);
dS2 = dc2 * S_basis(T);

end
