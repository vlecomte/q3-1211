% Computes the molar enthalpy of the combustion reaction in the oven.
function [dH] = delta_h_oven(T_oven)

c = shomate_coeffs();
H_basis = shomate_bases();

if T_oven < 1200
    dc = c.co2_low  + 2*c.h2o - c.ch4 - 2*c.o2;
else
    dc = c.co2_high + 2*c.h2o - c.ch4 - 2*c.o2;
end

dH = dc * H_basis(T_oven);

end
