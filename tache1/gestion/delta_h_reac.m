% Computes the enthalpy difference for all five reactions, which is equal
% to the heat brought in. As we have little information on the input and
% output temperatures, we consider as a first approximation that all
% reactions have inputs and outputs at 298.15K.
function [dH] = delta_h_reac(alpha, beta, gamma, delta, epsilon)

% Enthalpies of formation
dHm_ch4 =  -74.81e3;
dHm_co  = -110.53e3;
dHm_co2 = -393.51e3;
dHm_h2  =    0     ;
dHm_h2o = -241.82e3;
dHm_n2  =    0     ;
dHm_nh3 =  -46.11e3;
dHm_o2  =    0     ;

% The total enthalpy difference is equal to the molar enthalpy difference
% multiplied by the advancement degree of the reaction.
dH.alpha   = alpha   * (3*dHm_h2  + dHm_co   - dHm_ch4  - dHm_h2o  );
dH.beta    = beta    * (dHm_h2    + dHm_co2  - dHm_co   - dHm_h2o  );
dH.gamma   = gamma   * (4*dHm_h2  + 2*dHm_co - dHm_o2   - 2*dHm_ch4);
dH.delta   = delta   * (dHm_h2    + dHm_co2  - dHm_co   - dHm_h2o  );
dH.epsilon = epsilon * (2*dHm_nh3 - dHm_n2   - 3*dHm_h2            );

end
