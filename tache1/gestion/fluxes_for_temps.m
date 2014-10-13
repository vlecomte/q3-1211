% Computes the fluxes returned by fluxes.m for a line vector of
% temperatures T, for one flux value nh3.
function [reac, oven] = fluxes_for_temps(T, nh3)

% Pre-allocating arrays
n = length(T);
reac = zeros(12, n);
oven = zeros(4, n);

for i = 1:n
    % Filling the matrices column by column with the results
    [reac(:,i), oven(:,i)] = fluxes(T(i), nh3);
end

end
