%Converts mass flows from ton/day to kg/s.
function kgs = to_kgs(td)

kg_per_ton = 1000;
s_per_day = 24*60*60;
kgs = td * kg_per_ton / s_per_day;

end