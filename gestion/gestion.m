function gestion()
%Gestion is a management tool for ammonia production plant
%Inspired by Gaetan Cassiers' code.

%Initialization tasks

%Construct the components
fh = figure('MenuBar', 'none', ...
    'Name', 'Management tool for ammonia production plant', ...
    'NumberTitle', 'off', ...
    'Position', [100, 100, 600, 500]);

f_layout = uiextras.VBox('Parent', fh);



panel_params = uiextras.Panel('Parent',f_layout,'Title','Parameters');

l_act = uiextras.VBox('Parent', panel_params);

l_params = uiextras.VBox('Parent', l_act);

l_NH3 = uiextras.HBox('Parent', l_params);

label_NH3 = uicontrol('Parent', l_NH3,'Style','text',...
    'String','Ammonia production (tons/day)');

input_NH3 = uicontrol('Parent', l_NH3,'Style','edit', 'Callback', @update);
l_T = uiextras.HBox('Parent', l_params);

label_T = uicontrol('Parent', l_T,'Style','text',...
    'String','Temperature in the primary reformer (K)');

input_T = uicontrol('Parent', l_T,'Style','edit', 'Callback', @update);

button_go = uicontrol('Parent', l_act, 'Style', 'pushbutton', 'String', 'OK', 'Callback', @update);


display_fields = {'m (t/d)', 'n (mol/s)'};

display_components_in = {'CH4', 'H2O', 'air'};

display_components_out = {'H2O', 'CO2', 'Ar', 'NH3'};

display_components_oven_in = {'CH4', 'O2'};

display_components_oven_out = {'CO2', 'H2O'};




l_mat = uiextras.HBox('Parent', f_layout);

panel_in = uiextras.Panel('Parent', l_mat, 'Title', 'Reactants');

t_in = uitable('Parent', panel_in, 'ColumnName', display_fields, 'RowName',display_components_in);

panel_out = uiextras.Panel('Parent', l_mat, 'Title', 'Products');

t_out = uitable('Parent', panel_out, 'ColumnName', display_fields, 'RowName',display_components_out);







panel_oven = uiextras.Panel('Parent', f_layout, 'Title', 'Oven');

l_oven = uiextras.HBox('Parent', panel_oven);

p_oven_in = uiextras.Panel('Parent', l_oven, 'Title', 'Reactants');

t_oven_in = uitable('Parent', p_oven_in, 'ColumnName', display_fields,'RowName',display_components_oven_in);

p_oven_out = uiextras.Panel('Parent', l_oven, 'Title', 'Products');

t_oven_out = uitable('Parent', p_oven_out, 'ColumnName', display_fields,'RowName',display_components_oven_out);


panel_others = uiextras.Panel('Parent', f_layout, 'Title', 'Others');
l_others = uiextras.VBox('Parent', panel_others);
nb_pipes = uicontrol('Parent', l_others,'Style','text');


%  Initialization tasks
set(input_NH3, 'String', '1000');

set(input_T, 'String', '1000');

update();


%  Callback
    function update(~, ~, ~)
        m_NH3 = str2double(get(input_NH3,'string')); %[t/d]
        
        T = str2double(get(input_T,'string')); %[K]
        
        if T<500 || T>1500
            errordlg('The temperature must be within the interval [500, 1500]K','Invalid Input','modal');
            return
        end
        
        [m_reac, m_oven, q_reac] = masses_and_heat(T, m_NH3);
        
        m_NH3_2 = to_kgs(m_NH3);
        n_NH3=m_NH3_2/0.017;
        
        [n_reac, n_oven] = moles(T, n_NH3);
        
        tables = {t_in, t_out, t_oven_in, t_oven_out};
        
        A=[m_reac.in_ch4 n_reac.in_ch4;
            m_reac.in_h2o n_reac.in_h2o;
            m_reac.in_air n_reac.in_air];
        
        for i = 1:size(A,1)
            for j=1:size(A,2)
                    A2{i,j} = num2str(A(i,j), '%.4g');
            end
        end
        
        set(t_in, 'Data', A2);
        
        B=[m_reac.out_h2o n_reac.out_h2o;
            m_reac.out_co2 n_reac.out_co2;
            m_reac.out_ar n_reac.out_ar;
            m_reac.out_nh3 n_reac.out_nh3];
        
        for i = 1:size(B,1)
            for j=1:size(B,2)
                    B2{i,j} = num2str(B(i,j), '%.4g');
            end
        end
        set(t_out, 'Data', B2);
        
        
        C=[m_oven.ch4 n_oven.in_ch4;
            m_oven.o2 n_oven.in_o2];
        
        for i = 1:size(C,1)
            for j=1:size(C,2)
                    C2{i,j} = num2str(C(i,j), '%.4g');
            end
        end
        set(t_oven_in, 'Data', C2);
        
        
        D=[m_oven.co2 n_oven.out_co2;
            m_oven.h2o n_oven.out_h2o];
        
        for i = 1:size(D,1)
            for j=1:size(D,2)
                    D2{i,j} = num2str(D(i,j), '%.4g');
            end
        end
        
        set(t_oven_out, 'Data', D2);
        
      
  
        set(nb_pipes, 'String', sprintf('Number of pipes at entry of primary reforming : %d',...
            number_pipes(T, m_NH3)));
        
    end
end