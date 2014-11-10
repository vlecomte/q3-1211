function [M] = molar_masses()

M.ar  = 39.948e-3;
M.ch4 = 16.0425e-3;
M.co2 = 44.0095e-3;
M.h2o = 18.0153e-3;
M.n2  = 28.0134e-3;
M.nh3 = 17.0305e-3;
M.o2  = 31.9988e-3;
M.air = .78*M.n2 + .21*M.o2 + .01*M.ar;

end

