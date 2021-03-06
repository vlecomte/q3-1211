% Synthesis simulation with ASPEN PLUS
% yield_eff and in_reac are the conversion rate and the relative flow
% rate entering the reactor
function [recycle, yield_eff, in_reac] = synthesis_aspen()

% For 1 mol/s N2, 3 mol/s H2 and 1/78 mol/s Ar input.
% So 3.6 kmol/hr N2, 10.8 kmol/hr H2 and 0.0462 kmol/hr Ar input.

% RK-SOAVE
% Recycle split fraction
recycle = [
    0.0     0.1     0.2     0.3     0.4     0.5     0.6  ...
    0.7     0.8     0.85    0.9     0.93    0.95    0.96 ...
    0.97    0.98    0.99
];
% Ammonia, kmol/hr
amm = [
    2.92681 3.11079 3.31946 3.55820 3.83384 4.15586 4.53701 ...
    4.99514 5.55661 5.88834 6.26149 6.50961 6.68674 6.77896 ...
    6.87386 6.97157 7.07226
];
% Reactor mole flow in, kmol/hr
in_reac_abs = [
    14.4462 15.3457 16.3666 17.5357 18.8869 20.4679 22.3434 ...
    24.6056 27.3956 29.0576 30.9461 32.2181 33.1376 33.6212 ...
    34.1233 34.6457 35.1924
];

epsilon = amm / 2;
yield_eff = epsilon / 3.6;
in_reac = in_reac_abs ./ epsilon;

end