function flux_matrix = fluxes_for_temps(T, nh3)

n = length(T);
flux_matrix = zeros(12, n);
for i = 1:n
    flux_matrix(:,i) = fluxes(T(i), nh3);

end