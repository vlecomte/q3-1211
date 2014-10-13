% Computes the mole flow rates returned by moles.m for a line vector of
% temperatures T, and one value of nh3.
function [n_reac, n_oven] = moles_for_temps(T, nh3)

% Pre-allocating arrays
n = length(T);
n_reac = zeros(12, n);
n_oven = zeros(4, n);

for i = 1:n
    % Filling the matrices column by column with the results
    [n_reac(:,i), n_oven(:,i)] = moles(T(i), nh3);
end

end
