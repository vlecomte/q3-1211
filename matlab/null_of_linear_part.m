function n = null_of_linear_part()
% Finds the linear space of flow values that satisfy all linear relations
% in the complex process of ammonia production.

% A describes the system in terms of
%   - in1, in2, in3: the inputs of CH4, H2O and air;
%   - out1, out2, out3, out4: the outputs of H2O, CO2, Ar and NH3;
%   - alpha, beta, gamma, delta, epsilon;
% as the columns, in that order.
%
% The lines represent matter conservation for
%   CH4, H2O, H2, CO, CO2, O2, N2, Ar, NH3
% in that order.
A = [
    1 0 0 0 0 0 0 -1 0 -8 0 0;
    0 1 0 -1 0 0 0 -1 -1 0 -1 0;
    0 0 0 0 0 0 0 3 1 0 1 -3;
    0 0 0 0 0 0 0 1 -1 2 -1 0;
    0 0 0 0 -1 0 0 0 1 0 1 0;
    0 0 .21 0 0 0 0 0 0 -1 0 0;
    0 0 .78 0 0 0 0 0 0 0 0 -1;
    0 0 .01 0 0 -1 0 0 0 0 0 0;
    0 0 0 0 0 0 -1 0 0 0 0 1;
    ];

% Finds one (fairly simple) base for the space of
%   {x | A*x = 0}
% The three resulting vectors can be interpreted as follows:
% - you can add water at in2, as long as you drain as much at out1;
% - since the reactions beta and delta are equivalent,
%   you can reduce the work done by beta and increase that made by delta;
% - when producing one mole of NH3, most other necessary quantities can
%   be deduced.
n = null(A, 'r');

end
