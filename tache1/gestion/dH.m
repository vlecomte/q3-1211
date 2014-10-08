function dH = dH(dHform, coeff_dCpm, Tref, T)

dH = dHform + integral(@(t) Cpm(coeff_dCpm, t), Tref, T);

end