th.recycle = linspace(0,0.99);
[th.yeff, th.in_reac] = synthesis_theory(th.recycle);
[asp.recycle, asp.yeff, asp.in_reac] = synthesis_aspen();

figure; hold on;
box on;
grid on;
xlabel('Rapport de recyclage');
ylabel('Taux de conversion');
plot(th.recycle, th.yeff, asp.recycle, asp.yeff);
% xlabel('Rapport de recyclage');
% ylabel('Debit relatif dans le reacteur');
% plot(th.recycle, th.in_reac, asp.recycle, asp.in_reac);
