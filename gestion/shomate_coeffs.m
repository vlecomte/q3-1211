% For an explanation of the Shomate equation or coefficients,
% see shomate_bases.m
function [c, h] = shomate_coeffs()

% Coefficients A through G of the Shomate equation.
c.ch4      = [... %  298K - 1300K
    -0.703029 108.4773 -42.52157 5.862788 0.678565 ...
    -76.84376 158.7163];
c.co       = [... %  298K - 1200K
    25.56759 6.096130 4.054656 -2.671301 0.131021 ...
    -118.0089 227.3665];
c.co2_low  = [... %  298K - 1200K
    24.99735 55.18696 -33.69137 7.948387 -0.136638 ...
    -403.6075 228.2431];
c.co2_high = [... % 1200K - 6000K
    58.16639 2.720074 -0.492289 0.038844 -6.447293 ...
    -425.9186 263.6125];
c.h2_low   = [... %  298K - 1000K
    33.066178 -11.363417 11.432816 -2.772874 -0.158558 ...
    -9.980797 172.707974];
c.h2_high  = [... % 1000K - 2500K
    18.563083 12.257357 -2.859786 0.268238 1.977990 ...
    -1.147438 156.288133];
c.h2o      = [... %  500K - 1700K
    30.09200 6.832514 6.793435 -2.534480 0.082139 ...
    -250.8810 223.3967];
c.n2       = [... %  500K - 2000K
    19.50583 19.88705 -8.598535 1.369784 0.527601 ...
    -4.935202 212.3900];
c.nh3      = [... %  298K - 1400K
    19.99563 49.77119 -15.37599 1.921168 0.189174 ...
    -53.30667 203.8591];
c.o2       = [... %  700K - 2000K
    30.03235 8.772972 -3.988133 0.788313 -0.741599 ...
    -11.32468 236.1663];

% Coefficient H, which is equal to the standard enthalpy of formation.
h.ch4 = -74.87310e3;
h.co  = -110.5271e3;
h.co2 = -393.5224e3;
h.h2  = 0;
h.h2o = -241.8264e3;
h.n2  = 0;
h.nh3 = -45.89806e3;
h.o2  = 0;

end
