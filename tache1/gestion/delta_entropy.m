function dS = delta_entropy(dSref, dCpm, Tref, T)

dS = dSref + integral(@(t) eval_cpm(dCpm, t)./t, Tref, T);

end