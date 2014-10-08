function dH = delta_enthalpy(dHform, dCpm, Tref, T)

dH = dHform + integral(@(t) eval_cpm(dCpm, t), Tref, T);

end