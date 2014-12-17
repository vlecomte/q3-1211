[H_basis, S_basis] = shomate_bases();
c = shomate_coeffs();

dc = 2*c.nh3 - c.n2 - 3*c.h2_low;

recycle = 0;

%T = 750;
T = linspace(500,1000);
R = 8.3144621;
pref = 1e5;
p = 270e5;
%p = linspace(200e5,400e5);

dH = dc * H_basis(T');
dS = dc * S_basis(T');

K = exp(-(dH-T.*dS)./(R*T));
Kp = K * (p/pref).^2;

moles_ind = 4 + 1/78;
in_moles_y = recycle./(78*(1-recycle));
out_moles_y = in_moles_y - 2;

yield = zeros(size(Kp));
for i = 1:length(yield)
    y = roots(27*Kp(i)*[1 -4 6 -4 1] - ...
        4*[4 -4*moles_ind moles_ind^2 0 0]);
    yield(i) = y(imag(y) == 0 & y > 0 & y < 1);
end

figure; hold on;
box on;
grid on;
%xlabel('Pression (bar)');
xlabel('Temperature (K)');
ylabel('Taux de conversion');
%plot(p/1e5, yield);
plot(T, yield);
