% set_pressure is in [barg]
% T_celsius is in [degree celsius]
% dH is in [kJ/kg]
% env_f is dimensionless
function [A] = gauge_surface(set_pressure, T_celsius, dH, env_F)

k = 1.33; % Cp/Cv for NH3
C = 0.03948 * sqrt( k * (2/(k+1)) ^ ((k+1)/(k-1)) ); % formula
display(C);
Kd = 0.975; % default
Kb = 1.0; % conventional PSV
Kc = 1.0; % PSV only
Z = 1.0; % from statement
M = 17; % [kg/kmol] = [g/mol]

% all in m or m^2
tank_radius = 3;
hemisphere_surface = (4 * pi * tank_radius^2) / 2;

nh3_height = 8;
fire_height = 7.62;
height = min(nh3_height, fire_height);
cyl_height = height - tank_radius;
cyl_surface = cyl_height * 2 * pi * tank_radius;

wetted_surface = hemisphere_surface + cyl_surface;
display(wetted_surface);

C1 = 43200; % defined, SI
Q = C1 * env_F * wetted_surface^0.82; % formula
display(Q);
W = Q / (dH*1000) * 3600; % W is in [kg/hr], dH was in [kJ/kg]
display(W);

fire_pressure_factor = 1.21; % defined for fire cases
P1 = (set_pressure+1) * fire_pressure_factor; % before or after?
P1 = P1 * 100; % converting bar -> kPa
display(P1);

T = T_celsius + 273.15;

A.mm2 = W / (P1 * C * Kb * Kc * Kd) * sqrt(T*Z/M); % formula
A.in2 = A.mm2 / 645.16; % 645.16 mm^2 in inch^2
display(A);

end

