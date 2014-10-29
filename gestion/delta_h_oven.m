% Computes the molar enthalpy of the combustion reaction in the oven.
function [dH] = delta_h_oven(T_oven)

[c,h] = shomate_coeffs();
H_basis = shomate_bases();

if T_oven < 1200
    dH = (c.co2_low  + 2*c.h2o) * H_basis(T_oven) - h.ch4 - 2*h.o2;
else
    dH = (c.co2_high + 2*c.h2o) * H_basis(T_oven) - h.ch4 - 2*h.o2;
end

end
