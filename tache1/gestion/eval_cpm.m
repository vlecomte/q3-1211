% T is a line vector
function Cpm = eval_cpm(coeff, T)

T = T';
t = [T.^0 T.^1 T.^2];
Cpm = (t*coeff)';

end