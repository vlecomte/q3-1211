function synthesis_graphs()

th.recycle = linspace(0,0.99,1000);
[th.cons, th.in_reac] = synthesis_theory(th.recycle);
[asp.recycle, asp.cons, asp.in_reac] = synthesis_aspen();

subplot(1,2,1);
plot(th.recycle, th.cons, asp.recycle, asp.cons);
subplot(1,2,2);
plot(th.recycle, th.in_reac, asp.recycle, asp.in_reac);

end
