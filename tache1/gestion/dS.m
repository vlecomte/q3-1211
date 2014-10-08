function dS = dS(dSref, coeff_dCpm, Tref, T)

dS = dSref + integral(@(t) Cpm(coeff_dCpm, t)/t, Tref, T);

end