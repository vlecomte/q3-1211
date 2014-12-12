function [pipes]=number_pipes(T, m_nh3)

c=2;
r=0.1/2;
p=3.1e6;
R = 8.3144621;

flow_pipe=c*pi*r^2;

m_nh3=to_kgs(m_nh3);

n_nh3=m_nh3/0.017;

[n_reac, n_oven] = moles(T, n_nh3);

n_in=n_reac.in_ch4 + n_reac.in_h2o;

flow_tot=(n_in*R*T)/p;

pipes=ceil(flow_tot/flow_pipe);
end
