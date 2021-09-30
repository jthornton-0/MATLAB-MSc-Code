%% MSc Project - Appendix E: Inhibition data analysis
% MATLAB code to analyse the inhibition data obtained from literature.
% Prepared for: [REDACTED]
% Submitted on: 05/10/2020
% Prepared by:  [REDACTED]
% Student ID:   [REDACTED]
% Module:       MSc Project
% Module code:  [REDACTED]

%% MATLAB stuff
clc; clear all; % Standard MATLAB starting
close all;      % Vital as this program will create hidden figures

% Change to on if you want the plots to show, there will be ~100+ of them.
% Best is to run the programme with 'off' set and then copy and paste the 
% 'set' code below, paste it into the command window and then run sections.

set(groot,'defaultFigureVisible','off');

%% Concentration data from Appendix C (obtained from Appendix F)

% Element name, units, 25th %ile, mean, 75th %ile, standard deviation,
% coefficient of variation (CoV). From the methodology, if coefficient of
% variation is greater than 1 (standard deviation / mean) then it means the
% variance of the data is large, so the 25th and 75th %iles will be used as
% the concentration range. If CoV is less than 1, then the mean +- standard
% deviation will be used.
%
% Element abbreviations have their usual meaning.

conc_EA = ["F","mg/l","0.14","0.325","0.33","0.589","1.8";...
    "Cl","mg/l","46","153","86","1010","6.6";...
    "Br","mg/l","0.081","3.63","0.15","30.6","8.4";...
    "I","mg/l","0.003","0.00364","0.003","0.00348","0.96";...
    "Li","ug/l","100","105","100","63.8","0.61";...
    "Na","mg/l","16","51.5","38","217","4.2";...
    "Mg","mg/l","8.8","14.8","18","21","1.4";...
    "K","mg/l","2.7","4.87","5.8","9.2","1.9";...
    "Ca","mg/l","70","83.3","110","181","2.2";...
    "Cr","ug/l","0.5","1.02","0.5","12.1","12";...
    "Mn","ug/l","15","80","45","311","3.9";...
    "Fe","ug/l","190","529","530","1460","2.8";...
    "Co","ug/l","1","3.28","1.2","9.07","2.8";...
    "Ni","ug/l","1.4","4.25","2.8","82.1","19";...
    "Cu","ug/l","1.3","5.09","3","44.9","8.8";...
    "Zn","ug/l","11","98.3","36","525","5.3";...
    "Se","ug/l","1","1.38","1","3.1","2.2";...
    "Ag","ug/l","1","0.928","1","0.219","0.24";...
    "Cd","ug/l","0.071","0.34","0.14","1.65",...
    "4.9";"Ba","ug/l","62","116","110","441","3.8";...
    "Hg","ug/l","0.01","0.0151","0.01","0.058","3.8";...
    "Pb","ug/l","0.36","7.4","2","42.1","5.7"];

% Molecular weights of the elements in order
MW = ["18.998";"35.45";"79.904";"126.9";"6.94";"22.99";"24.305";"39.098"...
 ;"40.078";"51.996";"54.938";"55.845";"58.933";"58.693";"63.546";"65.38"...
 ;"78.97";"107.87";"112.41";"137.44";"200.59";"207.2"];

%Calls concentration function to extract useable ranges
conc_use_raw = concentration_converter(conc_EA);

%Combines both arrays
conc_use_MW = [conc_use_raw, MW];

%Calculates the total concentrations
[conc_lower_total, conc_upper_total] = conc_total(conc_use_MW);

%Results structure
results.elements = [];

%% Data from literature

% First author names so that loops can be done. Probably best to use cells
% or classes but this was committed to and there was no going back.
data.author = ["abadulla", "chmelova", "farnet", "murugesan", "seema",...
    "shankar", "hu", "xu"];

% Most of the fields have self-explanatory names. Free means the enzyme was
% not immobilized, immob means the enzyme was immobilized

% Abadulla et al. (2000).
data.names.abadulla                = ["F", "Cl", "Br"];

data.laccase.abadulla              = ["Trametes hirsuta"];
data.results.abadulla.free.values  = [80, 50, 190];
data.results.abadulla.units        = ["mu M", "m M", "m M"];
data.results.abadulla.free.error   = [2, 1, 8];
data.results.abadulla.immob.values = [200, 85, 340];
data.results.abadulla.immob.error  = [8, 2, 14];

data.conds.temp.abadulla           = 30;
data.conds.pH.abadulla             = 4.5;
data.conds.substrate.name.abadulla = "DMP";
data.conds.time.abadulla           = 5;
data.conds.substrate.concentration.abadulla = [1, "mM"];

data.type.abadulla                 = "IC50";

% Chmelova et al. (2015)
data.names.chmelova = ["Ag","Ba","Ca","Cu","Fe","K","Li",...
 "Mg","Mn","Na","Se","Zn"];

data.laccase.chmelova = ["Trametes versicolor"];

data.results.chmelova.control        = 0;
data.results.chmelova.concentrations = [0, 1, 5, 10];
data.results.chmelova.value = [100, 103.1, 95.5, 94.3; 100, 103.5...
 149, 139.2; 100, 93.9, 119.7, 107.1; 100, 105.8, 93.4, 210; 100, 86.2,...
 34.8, 4.7; 100, 104.8, 89.4, 47.6; 100, 110.3, 105.1, 86.9; ...
 100, 109.6, 103.8, 116.3; 100, 143.7, 123.9, 134.4; 100, 96.6, 78.4, 64.2;...
 100, 101.5, 99.7, 99.6; 100, 121.2, 104.1, 107.2];
data.results.chmelova.error = [0, 1.5, 3.1, 4.7; 0, 1.8,4.9,6.3;...
 0, 0.9, 5.3, 5.2; 0, 3.7, 3.8, 4; 0, 2.2, 2, 3.4; 0, 9, 3.7, 0.6; ...
 0, 3.1, 2.5, 3.1; 0, 4.9, 0.4, 1.1; 0, 4, 2.1, 2.1; 0, 7.5, 3.3, 0.9;...
 0, 1.9, 4.9, 2.6; 0, 1.5, 5.1, 2.1];
data.results.chmelova.units = "%";

data.conds.temp.chmelova                    = 20;
data.conds.pH.chmelova                      = 5;
data.conds.substrate.name.chmelova          = "ABTS";
data.conds.substrate.concentration.chmelova = [1,"m M"];
data.conds.time.chmelova                    = 10;

data.type.chmelova                          = "Relative";

% Farnet et al. 2008
data.names.farnet = ["F", "Cl", "Br", "I", "Na", "Ca", "Mn", "Cu", "Hg"];

data.laccase.farnet = ["Marasmius quercophilus"];

data.results.farnet.values = [2.7, 7.5, 20, 3.3, 1, 1, 1, 0.5, 13];
data.results.farnet.units  = "m M";
data.results.farnet.error  = "NA";

data.conds.temp.farnet                    = 25;
data.conds.pH.farnet                      = 4;
data.conds.substrate.name.farnet          = "Syringaldazine";
data.conds.substrate.concentration.farnet = [4.5, "mM" ];
data.conds.time.farnet                    = 0;

data.type.farnet = "IC50";

% Murugeaen et al. (2009)
data.names.murugesan = ["Ca","Cd","Co","Cu","Fe","Hg","Li",...
 "Mn","Ni","K","Na","Zn"];

data.laccase.murugesan = ["Ganoderma lucidum"];

data.results.murugesan.control        = 0;
data.results.murugesan.concentrations = [0.5, 1, 5, 10];
data.results.murugesan.value = [104.6, 104.5, 106.3, 99; ...
 100, 93.4, 82.9, 80.3; 106.5, 104.5, 93.5, 83.4;...
 105.5, 116.5, 136.1, 172.3;...
 0.002, 0, 0, 0; 54.5, 40, 18, 6.5; 91, 90.5, 85.3, 70.4;...
 94, 95.5, 81.5, 76.1; 96.4, 102, 87.4, 81.2; 100, 100, 92.9, 92.1;...
 90.6, 75.21, 64.23, 9.6; 106.6, 118.5, 123.7, 137];
data.results.murugesan.error = "NA";
data.results.murugesan.units = "%";

data.conds.temp.murugesan                    = 30;
data.conds.pH.murugesan                      = 5;
data.conds.substrate.name.murugesan          = "ABTS";
data.conds.substrate.concentration.murugesan = [1,"m M"];
data.conds.time.murugesan                    = 60;

data.type.murugesan = "Relative";

% Seema et al. (2020)
data.names.seema = ["Cu","Mg","Zn","Mn","Ca", "Na"];

data.laccase.seema = ["Alcaligenes faecalis"];

data.results.seema.control        = 0;
data.results.seema.concentrations = [1, 3, 5];
data.results.seema.value = [112.24, 135.39, 152.46;...
 109.68, 80.71, 74.56; 99.43, 73.03, 55.75; 105.91, 79.3, 64.84;...
 94.76, 80.39, 76.99; 110.92, 101.18, 56.76];
data.results.seema.error = [1.33, 0.96, 1.61; 1.45, 2.63, 2.58;...
 3.25, 1.32, 2.41; 1.36, 1.17, 2.5; 1.49, 2.06, 3.45; 1.66, 2.14, 1.88];
data.results.seema.units = "%";

data.conds.temp.seema                    = 85;
data.conds.pH.seema                      = 8;
data.conds.substrate.name.seema          = "DMP";
data.conds.substrate.concentration.seema = [1, "mM"];
data.conds.time.seema                    = 30;

data.type.seema = "Relative";

% Shankar et al. (2015)
data.names.shankar = ["Mn","Ni","Hg","Cd","Co", "Na", "Ca", "Cu"];

data.laccase.shankar = ["Peniophora sp."];

data.results.shankar.concentrations = [0.5, 1, 10, 15];
data.results.shankar.control        = 0;
data.results.shankar.value = [100, 120, 110, 105; 140, 110, 110, 100;...
 19, 17, 5, 0; 100, 105, 122, 142; 105, 112, 120, 132; 116, 120, 128 ...
 136; 138, 132, 114, 112; 102, 138, 82, 65];
data.results.shankar.error = [5, 5, 5, 5; 8, 8, 6, 5; 1, 1, 0, 0;...
 4, 4, 6, 4; 4, 6, 4, 5; 8, 6, 6, 5; 8, 6, 4, 4; 6, 5, 2, 5];
data.results.shankar.units = "%";

data.conds.temp.shankar                    = 30;
data.conds.pH.shankar                      = 5;
data.conds.substrate.name.shankar          = "Guaiacol";
data.conds.substrate.concentration.shankar = [5, "mM"];
data.conds.time.shankar                    = 60;

data.type.shankar = "Relative";

% Hu et al. (2015)
data.names.hu = ["Cu","Co","Mn","Ca","Mg", "Na", "Fe", "K", "Hg", "Cd"];

data.laccase.hu = ["Leptographium qinlingensis"];

data.results.hu.control        = 0;
data.results.hu.concentrations = [1, 10];
data.results.hu.value = [102, 98; 45, 15; 74, 22; 84, 36;...
 95, 42; 98, 95; 77, 32; 96, 62; 36, 3; 76, 38];
data.results.hu.error = [1,2; 4, 1; 5, 3; 1, 2; 1, 2; 1, 2;...
 3, 4; 3, 4; 3, 1; 5, 3];
data.results.hu.units = "%";

data.conds.temp.hu                    = 25;
data.conds.pH.hu                      = 5;
data.conds.substrate.name.hu          = "Guaiacol";
data.conds.substrate.concentration.hu = [1.76, "mM"];
data.conds.time.hu                    = 30;

data.type.hu = "Relative";

% Xu et al. (2018)
data.names.xu = ["Ag","Ca","Cd","Co","Cu", "Hg", "K", "Li", "Mg", "Mn", ...
 "Na", "Ni", "Pb", "Zn"];

data.laccase.xu = ["Cerrena sp."];

data.results.xu.concentrations = [10, 100];
data.results.xu.control        = 0;
data.results.xu.value = [23.82, 2.51; 99.7, 104.33; 99.7, 93.28;...
 97.51, 93.34; 73.57, 85.82; 0.54, 0.01; 97.51, 98.06; 81.32, 28.18;...
 97.68, 102.84; 98.91, 105.37; 98.6, 97.61; 97.98, 99.7; 95.49, 50.15;...
 94.55, 97.46];
data.results.xu.error = [0.12, 0.01; 0.22, 0.86; 1.47, 1.71;2.16, 1.8;...
 2.6, 1.06; 0.03, 0.04; 0.89, 3.92; 3.68, 2.95; 0.2, 0.21; 1.41, 0.83;...
 2.2, 0.29; 0.9, 1.06; 5.61, 3.24; 1.69, 0.93];
data.results.xu.units = "%";

data.conds.temp.xu                    = 40;
data.conds.pH.xu                      = 5;
data.conds.substrate.name.xu          = "Guaiacol";
data.conds.substrate.concentration.xu = [1, "mM"];
data.conds.time.xu                    = 0;

data.type.xu = "Relative";

%% Laccase temperature and pH data

% Laccase data so that the real-world conditions aspect (temperature and pH
% effects on Laccase activity) could be investigated. Only two Laccases data
% could be obtained for a range that included <20C otherwise more would have been used.

Laccase.ostreatus.temp.values     = [20, 15, 10, 5];
Laccase.ostreatus.temp.activities = [41, 33, 28, 17]./100; % percents
Laccase.ostreatus.pH.values       = [5, 5.5, 6, 6.5, 7];
Laccase.ostreatus.pH.activities   = [100, 95, 90, 68, 40]./100; % percents

Laccase.tremetes.pH.values        = [5, 5.5, 6, 6.5, 7];
Laccase.tremetes.pH.activities    = [40, 22, 10, missing, missing]./100; % percents
Laccase.tremetes.temp.values      = [20, 15, 10, 5];
Laccase.tremetes.temp.activities  = [38, 22, 16, 12]./100; % percents

%% Farnet A - IC50 data

% The following code is not the best but it worked whilst under time
% pressure to write dissertation so it was used.

title_Farnet = "Farnet et al.";             %title for plots using farnet data
units_plot = data.results.farnet.units;     %units for plots
values_Farnet = data.results.farnet.values; %the actual values of IC50 etc

%loop through all of the element names in Farnet
for F_count = 1:numel(values_Farnet)
    F_index = 0;                          %index for loop
    laccase = data.laccase.farnet;        %loads Laccase source organism
    element = data.names.farnet(F_count); %loads element name as string

    %calls environment agency extract function to obtain element data
    [name_far{F_count}, ~, lower_far{F_count}, upper_far{F_count},...
    mw_f{F_count}] = ea_extract(element, conc_use_MW);

    %loop through values to plot IC50 dose response curves
    for conc = 0:0.01:1000
        F_index = F_index + 1; %increments index
        %calculates v/v0 from equation 1
        v_v0_farnet(F_count, F_index) = IC50(conc, values_Farnet(F_count));
        x_vals_far(F_index) = conc; %saves the concentration values
    end

    % Calculating the lower and upper concentration range in moles
    conc_lower(F_count) = str2num(lower_far{F_count})/str2num(mw_f{F_count});
    conc_upper(F_count) = str2num(upper_far{F_count})/str2num(mw_f{F_count});

    % Calculating the IC50 response curves and errors
    % Upper = upper range value, lower = lower range value, neg =
    % negative values, pos = positive values
    v_v0_farnet_lower(F_count) = IC50(conc_lower(F_count),...
    values_Farnet(F_count));
    v_v0_farnet_upper(F_count) = IC50(conc_upper(F_count),...
    values_Farnet(F_count)); 

    % Plotting values
    figure();             % Opens new figure so old one isnt deleted
    set(gcf,'color','w'); % Sets background colour to white
    % Plots semilog graph, log axis being the x axis
    semilogx(x_vals_far, v_v0_farnet(F_count, :),'Color', 'k',...
    'DisplayName','IC_5_0 dose curve')

    %Title and conditions so that each graph can be deciphered for what
    %element it was, conditions etc.
    string_element = [title_Farnet, ': Element - ', data.names.farnet(F_count)];
    string_conds_1 = ['Temp: ',data.conds.temp.farnet, 'C', ' Time: ',...
    data.conds.time.farnet,' mins', 'pH: ', data.conds.pH.farnet, ...
    'Substrate: ',data.conds.substrate.name.farnet];
    string_conds_2 = ['Substrate concentration', ...
    str2num(data.conds.substrate.concentration.farnet(1)),...
    data.conds.substrate.concentration.farnet(2), 'Laccase source: ',...
    data.laccase.farnet];

    % Creates x label depending upond the concentration units
    string_xlabel = ['Concentration, ', units_plot];
    % Joins and adds the titles
    title({join(string_element), join(string_conds_1), join(string_conds_2)});
    % Joins and adds the x-label
    xlabel(join(string_xlabel))
    % Adds the ylabel
    ylabel('Relative Laccase activity, %')
    % Calculates the maximum value in the y-axis
    ylim_val = max(v_v0_farnet(F_count));
    % Sets the ylimit of the axis little higher for readability
    ylim([0 (ylim_val+0.05*ylim_val)])
    grid on
    hold on

    % Plotting lines of lower concentration range from wastewater
    line([conc_lower(F_count) conc_lower(F_count)], ...
    [0 v_v0_farnet_lower(F_count)], 'Color','b','DisplayName','Lower conc.')
    % Adding text identifier with error and values
    text_lower = join(['Activity loss: ', ...
    num2str(round(100*(1-v_v0_farnet_lower(F_count)),2,'significant')),'%']);
    text(conc_lower(F_count)*1.5, v_v0_farnet_lower(F_count)*0.6,...
    text_lower, 'Color','b');

    % Adding IC50 identifier
    text_IC50 = join(['\leftarrow IC_5_0 ' num2str(values_Farnet(F_count)),...
    data.results.farnet.units]);
    text(values_Farnet(F_count), 0.5, text_IC50,'HorizontalAlignment','left');
    % Plotting lines of upper concentration range from wastewater
    line([conc_upper(F_count) conc_upper(F_count)], ...
    [0 v_v0_farnet_upper(F_count)], 'Color','r','DisplayName','Upper conc.');
    % Adding text identifier with error and values
    text_upper = join(['Activity loss: ', num2str(round(100*...
    (1-v_v0_farnet_upper(F_count)),2,'significant')),'%']);
    text(conc_upper(F_count)*1.5, v_v0_farnet_upper(F_count)*0.5,...
    text_upper, 'Color','r');
    legend(); %adds legend using the DisplayName's

    %calcs the lower and upper values of the Ci/Ct ratio (Ci/Ct = conc of 
    % i/total conc of i)
    conc_ratio_lower = str2num(lower_far{F_count})/conc_lower_total;
    conc_ratio_upper = str2num(upper_far{F_count})/conc_upper_total;

    %calculates the activity loss, 100 = activity without inhibitors
    activity_lost_rwconc_lower = conc_ratio_lower* (100-...
    v_v0_farnet_lower(F_count))/100;
    activity_lost_rwconc_upper = conc_ratio_upper* (100-...
    v_v0_farnet_upper(F_count))/100;

    %creates new field named farnet to store each element in. The missing
    %values are a placeholder so that indexing later on can work
    results.elements.(element).("farnet") = [element, laccase, missing, ...
    missing, missing,v_v0_farnet_lower(F_count)*100 ,...
    v_v0_farnet_upper(F_count)*100 ,missing, activity_lost_rwconc_lower...
    , activity_lost_rwconc_upper, missing, missing];
end

%% Abadulla et al - IC50 data

% Abadulla et al required a loop because they included immobilization data
% too which could have been of interest. 
% 
% Like the prior section, this could be better coded.

fn = fieldnames(data.results.abadulla); %Loads field names as strings
Z = 0;                                  %index variable

% Loop through the number of elements
for k = 1:numel(fn)
    Z = Z + 1; %adds 1 to increment
    if fn{k} == "free" %checks to see if the current field is free enzymes
        title_ABA_free = "Abadulla et al. Free enzyme"; %Creates title text
        units_plot = data.results.abadulla.units(k);    %loads units for plot
        values_A = data.results.abadulla.free.values;   %loads values
        errors = data.results.abadulla.free.error;      %loads errors
        laccase = data.laccase.abadulla;                %loads laccase source
        for index_A = 1:numel(values_A)
            var_A = 0;   %creates a new index
            %calls environment agency extract function to load element data
            [name_aba{index_A}, ~, lower_aba{index_A}, upper_aba{index_A},...
            mw_aba{index_A}] = ea_extract(data.names.abadulla(index_A),...
            conc_use_MW);

            %loop through the IC50 concentration values I. Errors were
            %checked but they were so insignificant it wasnt worth memory
            for conc = 0:0.1:1000 %change precision as required
                var_A = var_A + 1;
                v_v0_free_A(index_A, var_A) = IC50(conc, values_A(index_A));
                x_vals_A(index_A, var_A) = conc;
            end

            % Calculating the lower and upper concentration range in moles
            conc_lower(index_A) = str2num(lower_aba{index_A})/...
            str2num(mw_aba{index_A});
            conc_upper(index_A) = str2num(upper_aba{index_A})/...
            str2num(mw_aba{index_A});

            % Calculating the IC50 response curves and errors
            % Upper = upper range value, lower = lower range value, neg =
            % negative values, pos = positive values
            v_v0_ABA_free_exact_lower(index_A) = IC50(conc_lower(index_A),...
            values_A(index_A));
            v_v0_ABA_free_exact_lower_neg(index_A) = IC50(conc_lower(index_A),...
            values_A(index_A)-errors(index_A));
            v_v0_ABA_free_exact_lower_plus(index_A) = IC50(conc_lower(index_A),...
            values_A(index_A)+errors(index_A));
            v_v0_ABA_free_exact_upper(index_A) = IC50(conc_upper(index_A), ...
            values_A(index_A));
            v_v0_ABA_free_exact_upper_neg(index_A) = IC50(conc_upper(index_A),...
            values_A(index_A)-errors(index_A));
            v_v0_ABA_free_exact_upper_plus(index_A) = IC50(conc_upper(index_A),...
            values_A(index_A)+errors(index_A));

            % Plotting values
            figure();             % Opens new figure so old one isnt deleted
            set(gcf,'color','w'); % Sets background colour to white
            % Plots semilog graph, log axis being the x axis
            semilogx(x_vals_A(index_A, :), v_v0_free_A(index_A, :),'Color',...
            'k', 'DisplayName','IC_5_0 dose curve')
            hold on
            %First part of string so all the conditions are included
            string_element = [title_ABA_free, ': Element - ',...
            data.names.abadulla(index_A)];
            string_conds_1 = ['Temp: ',data.conds.temp.abadulla, 'C', ...
            ' Time: ',data.conds.time.abadulla,' mins', 'pH: ', ...
            data.conds.pH.abadulla, 'Substrate: ',...
            data.conds.substrate.name.abadulla];
            string_conds_2 = ['Substrate concentration', ...
            str2num(data.conds.substrate.concentration.abadulla(1)), ...
            data.conds.substrate.concentration.abadulla(2),...
            'Laccase source: ', data.laccase.abadulla];

            % Creates x label depending upond the concentration units
            string_xlabel = ['Concentration, ', data.results.abadulla.units(index_A)];
            % Joins and adds the titles
            title({join(string_element), join(string_conds_1), join(string_conds_2)});
            % Joins and adds the x-label
            xlabel(join(string_xlabel))
            % Adds the ylabel
            ylabel('Relative Laccase activity, %')
            % Calculates the maximum value in the y-axis
            ylim_val = max(v_v0_free_A(index_A));
            % Sets the ylimit of the axis little higher for readability
            ylim([0 (ylim_val+0.05*ylim_val)])
            grid on
            hold on

            % Errors for relative activity
            average_error_lower_neg(index_A) = ...
            (v_v0_ABA_free_exact_lower(index_A)-...
            v_v0_ABA_free_exact_lower_neg(index_A))...
            /numel(v_v0_ABA_free_exact_lower_neg(index_A));
            average_error_lower_plus(index_A) = ...
            (v_v0_ABA_free_exact_lower_plus(index_A)...
            -v_v0_ABA_free_exact_lower(index_A))/...
            numel(v_v0_ABA_free_exact_lower_neg(index_A));
            average_error_upper_neg(index_A) = ...
            (v_v0_ABA_free_exact_upper(index_A)-...
            v_v0_ABA_free_exact_upper_neg(index_A))...
            /numel(v_v0_ABA_free_exact_upper_neg(index_A));
            average_error_upper_plus(index_A) = ...
            (v_v0_ABA_free_exact_upper_neg(index_A)...
            -v_v0_ABA_free_exact_upper(index_A))/...
            numel(v_v0_ABA_free_exact_upper_neg(index_A));

            % Calculates the average error from the total errors
            average_error_lower(index_A) = round((...
            average_error_lower_neg(index_A)...
            +average_error_lower_plus(index_A))/2,4);
            average_error_upper(index_A) = round((...
            average_error_upper_neg(index_A)...
            +average_error_upper_plus(index_A))/2,4);

            % Plotting lines of lower concentration range from wastewater
            line([conc_lower(index_A) conc_lower(index_A)], [0 ...
            v_v0_ABA_free_exact_lower(index_A)], 'Color'...
            ,'b','DisplayName','Lower conc.')

            % Adding text identifier with error and values
            text_lower = join(['Activity loss: ', num2str(100-(round...
            (v_v0_ABA_free_exact_lower(index_A)*100,4,'significant'))),' '...
            , char(177),' ', num2str(round(100*average_error_lower(index_A)...
            ,4,'significant'))]);
            text(conc_lower(index_A)*1.3, v_v0_ABA_free_exact_lower(index_A),...
            text_lower, 'Color','b');

            % Adding IC50 identifier
            text_IC50 = join(['IC_5_0 ' num2str(values_A(index_A)), char(177),...
            errors(index_A), data.results.abadulla.units(index_A),'\rightarrow']);
            text(values_A(index_A), 0.5, text_IC50,'HorizontalAlignment','right');

            % Plotting lines of upper concentration range from wastewater
            line([conc_upper(index_A) conc_upper(index_A)], [0 ...
            v_v0_ABA_free_exact_upper(index_A)], 'Color','r',...
            'DisplayName','Upper conc.');

            % Adding text identifier with error and values
            text_upper = join(['Activity loss: ', num2str(100 - ...
            round(v_v0_ABA_free_exact_upper(index_A)*100,4,'significant')),...
            ' ', char(177),' ', num2str(round(100*average_error_upper(index_A)...
            ,4, 'significant'))]);
            text(conc_upper(index_A)*1.4, v_v0_ABA_free_exact_upper(index_A)...
            *0.95, text_upper, 'Color','r');
            legend(); %adds legend

            %Calculates Ci/Ct (concentration of species i over total
            %concentration)
            conc_ratio_lower = str2num(lower_aba{index_A})/conc_lower_total;
            conc_ratio_upper = str2num(upper_aba{index_A})/conc_upper_total;

            %calculates the activity loss, the 100- is the assumed laccase
            %activity without inhibitors
            activity_lost_rwconc_lower = conc_ratio_lower* (100-...
            (100*v_v0_ABA_free_exact_lower(index_A)))/100;
            activity_lost_rwconc_upper = conc_ratio_upper* (100-...
            (100*v_v0_ABA_free_exact_upper(index_A)))/100;

            %Saves the results in a new field called abadulla. missing is
            %just placeholders so indexing can work later
            results.elements.(name_aba{index_A}).("abadulla") = ...
            [name_aba{index_A}, laccase, missing, ...
            missing, missing, v_v0_ABA_free_exact_lower(index_A)*100, ...
            v_v0_ABA_free_exact_upper(index_A)*100,...
            missing,...
            activity_lost_rwconc_lower , activity_lost_rwconc_upper,...
            missing, missing];
        end
    end
    %Loop for immobilized enzyme
    if fn{k} == "immob"
        title_ABA_immob = "Abadulla et al. Immobilized enzyme"; %plot title
        values_A = data.results.abadulla.immob.values;          %extracts values
        errors = data.results.abadulla.immob.error;             %extracts errors

        %for loop across the elements in abadulla immobilized
        for index_A = 1:numel(values_A)
            var_A = 0;       %sets index variable as 0
            %extracts element information from the environment agency data
            [name_aba{index_A}, ~, lower_aba{index_A}, upper_aba{index_A},...
            mw_aba{index_A}] = ea_extract(data.names.abadulla(index_A),...
            conc_use_MW);

            %for loop to get plotting IC50 data
            for conc = 0:0.1:1000
                var_A = var_A + 1; %adds 1 to the increment
                %calls IC50 function
                v_v0_ABA_immob(index_A, var_A) = IC50(conc, values_A(index_A));
                x_vals_A(index_A,var_A) = conc;
            end

            % Calculating the lower and upper concentration range in moles
            conc_lower(index_A) = str2num(lower_aba{index_A})/...
            str2num(mw_aba{index_A});
            conc_upper(index_A) = str2num(upper_aba{index_A})/...
            str2num(mw_aba{index_A});

            % Calculating the IC50 response curves and errors
            % Upper = upper range value, lower = lower range value, neg =
            % negative values, pos = positive values
            v_v0_A_immob_exact_lower(index_A) = IC50(conc_lower(index_A), ...
            values_A(index_A));
            v_v0_A_immob_exact_lower_neg(index_A) = IC50(conc_lower(index_A),...
            values_A(index_A)-errors(index_A));
            v_v0_A_immob_exact_lower_plus(index_A) = IC50(conc_lower(index_A),...
            values_A(index_A)+errors(index_A));
            v_v0_A_immob_exact_upper(index_A) = IC50(conc_upper(index_A),...
            values_A(index_A));
            v_v0_A_immob_exact_upper_neg(index_A) = IC50(conc_upper(index_A),...
            values_A(index_A)-errors(index_A));
            v_v0_A_immob_exact_upper_plus(index_A) = IC50(conc_upper(index_A),...
            values_A(index_A)+errors(index_A));

            % Plotting values
            figure(); % Opens new figure so old one isnt deleted
            set(gcf,'color','w');% Sets background colour to white
            % Plots semilog graph, log axis being the x axis
            semilogx(x_vals_A(index_A, :), v_v0_ABA_immob(index_A, :),'Color',...
            'k', 'DisplayName','IC_5_0 dose curve')
            %First part of string so all the conditions are included
            string_element = [title_ABA_immob, ': Element - ', ...
            data.names.abadulla(index_A)];
            string_conds_1 = ['Temp: ',data.conds.temp.abadulla, 'C', ' Time: ',...
            data.conds.time.abadulla,' mins', 'pH: ', data.conds.pH.abadulla,...
            'Substrate: ',data.conds.substrate.name.abadulla];
            string_conds_2 = ['Substrate concentration', ...
            str2num(data.conds.substrate.concentration.abadulla(1)),...
            data.conds.substrate.concentration.abadulla(2), 'Laccase source: ',...
            data.laccase.abadulla];

            % Creates x label depending upond the concentration units
            string_xlabel = ['Concentration, ', data.results.abadulla.units(index_A)];
            % Joins and adds the titles
            title({join(string_element), join(string_conds_1), join(string_conds_2)});
            % Joins and adds the x-label
            xlabel(join(string_xlabel))
            % Adds the ylabel
            ylabel('Relative Laccase activity, %')
            % Calculates the maximum value in the y-axis
            ylim_val = max(v_v0_ABA_immob(index_A));
            % Sets the ylimit of the axis little higher for readability
            ylim([0 (ylim_val+0.05*ylim_val)])
            grid on
            hold on

            % Errors for relative activity
            average_error_lower_neg(index_A) = (v_v0_A_immob_exact_lower(index_A)...
            -v_v0_A_immob_exact_lower_neg(index_A))/...
            numel(v_v0_A_immob_exact_lower_neg(index_A));
            average_error_lower_plus(index_A) = ...
            (v_v0_A_immob_exact_lower_plus(index_A)...
            -v_v0_A_immob_exact_lower(index_A))...
            /numel(v_v0_A_immob_exact_lower_neg(index_A));
            average_error_upper_neg(index_A) = ...
            (v_v0_A_immob_exact_upper(index_A)...
            -v_v0_A_immob_exact_upper_neg(index_A))...
            /numel(v_v0_A_immob_exact_upper_neg(index_A));
            average_error_upper_plus(index_A) = ...
            (v_v0_A_immob_exact_upper_neg(index_A)...
            -v_v0_A_immob_exact_upper(index_A))/...
            numel(v_v0_A_immob_exact_upper_neg(index_A));

            % Calculates the average error from the total errors
            average_error_lower(index_A) = round((...
            average_error_lower_neg(index_A)...
            +average_error_lower_plus(index_A))/2,4);
            average_error_upper(index_A) = round((...
            average_error_upper_neg(index_A)...
            +average_error_upper_plus(index_A))/2,4);

            % Plotting lines of lower concentration range from wastewater
            line([conc_lower(index_A) conc_lower(index_A)], ...
            [0 v_v0_A_immob_exact_lower(index_A)], 'Color','b')
            % Adding text identifier with error and values. Rounds to 4 s.f
            text_lower = join(['Activity loss: ', num2str(100 - ...
            round(v_v0_A_immob_exact_lower(index_A)*100, 4, 'significant')),...
            ' ', char(177),' ', num2str(round(average_error_lower(index_A)*100,...
            4, 'significant'))]);
            text(conc_lower(index_A)*1.9, v_v0_A_immob_exact_lower(index_A),...
            text_lower, 'Color','b','DisplayName','Lower conc.');

            % Adding IC50 identifier, char(177) is +-
            text_IC50 = join(['IC_5_0 ' num2str(values_A(index_A)), char(177),...
            errors(index_A), data.results.abadulla.units(index_A),'\rightarrow']);
            text(values_A(index_A), 0.5, text_IC50,'HorizontalAlignment','right');

            % Plotting lines of upper concentration range from wastewater
            line([conc_upper(index_A) conc_upper(index_A)], [0 ...
            v_v0_A_immob_exact_upper(index_A)], 'Color','r', ...
            'DisplayName', 'Upper conc.');

            % Adding text identifier with error and values
            text_upper = join(['Activity loss: ', num2str(100-...
            round(v_v0_A_immob_exact_upper(index_A)*100, 4, 'significant')),...
            ' ', char(177),' ', num2str(round(average_error_upper(index_A)*100,4, ...
            'significant'))]);
            text(conc_upper(index_A)*2.2, v_v0_A_immob_exact_upper(index_A)*0.94, ...
            text_upper, 'Color','r');
            legend(); %adds legend
        end
    end
end

%% Relative Laccase activity - data extraction

% If the authors data does not contain IC50 data then it is considered here
% and graphs/calculations obtained.

% Loop through all of the fields with data.type = Relative
fn = fieldnames(data.type); %loads field names
ind = 0;                    %sets index as 0

%Loads element list and Laccase list
elements_list = [{"F","Cl","Br","I","Li","Na","Mg","K","Ca","Cr","Mn","Fe",...
 "Co","Ni","Cu","Zn","Se","Ag","Cd","Ba","Hg","Pb"}];
results.laccase = []; %creates empty structure to store values

%for loop across all of the author names
for k = 1:numel(fn)
    if data.type.(data.author(k)) == "Relative"
        ind = ind + 1;  % adds 1 to increment
        %extracts values to use in this iteration
        vals_r       = data.results.(data.author(k)).value;
        conc_rel     = data.results.(data.author(k)).concentrations;
        elements_rel = data.names.(data.author(k));
        laccase_rel  = data.laccase.(data.author(k));

        %checks the errors to see if NA is displayed, then sets the errors
        %as 0's, so it doesnt break later on
        if strcmp(data.results.(data.author(k)).error, "NA") == 1
            error = zeros(size(vals_r));
        else
            error = data.results.(data.author(k)).error;
        end

        %extracts row and columns of vals_r to loop through
        [row, col] = size(vals_r);
        ind_1 = 0;
        for rel_count = 1:row
            ind_1 = ind_1 + 1; %adds 1 to increment
            %extracts data for the element from the environment agency data
            [name, ~, lower, upper, mw] = ea_extract...
            (elements_rel(rel_count), conc_use_MW);

            %calculates lower and upper concentrations ratios
            conc_ratio_lower = (str2num(lower)/conc_lower_total);
            conc_ratio_upper = str2num(upper)/conc_upper_total;

            %converts concentrations from moles to mass
            concentrations_mass = conc_rel*str2num(mw);
            %extracts the rel_count rows values
            values_ind = vals_r(rel_count,:);

            %calls polyfit to find the line of best fit equations
            poly_fit = polyfit(concentrations_mass, values_ind, 1);
            %calculates the errors from polyfit
            poly_fit_errors = polyfit(concentrations_mass, values_ind +...
            error(rel_count,:), 1);
            %evaluates the line of best fit equation at each point
            poly_val = polyval(poly_fit, concentrations_mass);

            %calculates the errors
            poly_val_errors = 100-(poly_val/polyval(poly_fit_errors, ...
            concentrations_mass))*100;

            %calculates the exact value of lower/upper concentration from
            %the environment agency data
            poly_realconc_lower = polyval(poly_fit, str2num(lower));
            poly_realconc_upper = polyval(poly_fit, str2num(upper));

            %calculates the activity loss for each range lower and upper
            activity_lost_rwconc_lower = conc_ratio_lower*...
            (100-poly_realconc_lower)/100;
            activity_lost_rwconc_upper = conc_ratio_upper*...
            (100-poly_realconc_upper)/100;

            %calcultes the error of the activity losses
            activity_lost_lower_error = (conc_ratio_lower*...
            (poly_realconc_lower*(poly_val_errors/100))/100);
            activity_lost_upper_error = (conc_ratio_upper*...
            (poly_realconc_upper*(poly_val_errors/100))/100);

            %calculates the regression coefficient in 2 steps
            regress = corrcoef(values_ind, poly_val);
            %squares one of the diagonals to get R^2
            regress = regress(2,1)^2;

            % Change name string to select what chemical species plots are 
            % wanted, in this case it is Calcium 'Ca'
            if name == 'Ca'
                plot_var = 1;
            else
                plot_var = 0;
            end
            %plots the data below
            if plot_var == 1
                figure();
                errorbar(concentrations_mass, values_ind, ...
                error(rel_count,:),'x r',...
                'DisplayName','Observed values');
                set(gcf,'color','w');% Sets background colour to white
                hold on
                grid on

                plot(concentrations_mass, poly_val, 'k',...
                'DisplayName','Best fit')
                line([str2num(upper) str2num(upper)], ...
                [0 poly_realconc_upper], 'Color',...
                'r','DisplayName','Upper conc.');
                line([str2num(lower) str2num(lower)], ...
                [0 poly_realconc_lower], 'Color','b',...
                'DisplayName','Lower conc.');

                [x_label, y_label, title_graph] =...
                graph_info(k, rel_count, 1, data);
                title(title_graph)
                xlabel(x_label)
                ylabel(y_label)
                legend();

                equation_label = sprintf('y = %f*x + %f',poly_fit(1), poly_fit(2));
                regress_label = sprintf('R^2 = %f',regress);
                text(concentrations_mass(2), poly_val(2)/2, equation_label);
                text(concentrations_mass(2), poly_val(2)/2.5, regress_label);
            end

            %stores the results in a new element name field with the
            %authors name as a subfield so each elements data can be kept
            %together
            results.elements.(elements_rel(rel_count)).(data.author(k))...
            = [name, laccase_rel, regress, ...
            poly_fit(1), poly_fit(2), poly_realconc_lower, ...
            poly_realconc_upper,...
            poly_val_errors, activity_lost_rwconc_lower, ...
            activity_lost_rwconc_upper,...
            activity_lost_lower_error, activity_lost_upper_error];
        end
    end
end
%% Cumulative inhibition with individual tallys

%Graphs and calculates the cumulative inhibition. Most of it is self
%explanatory

fnames = fieldnames(results.elements); %Obtaining names of elements
t = 0;                                 %set increment to 0
for q = 1:numel(fnames)                %cycling through elements
    t = t+1;                           %add 1 to increment
    %Cycle through the author names for each element
    fnames_2 = fieldnames(results.elements.(fnames{q}));
    z = 0;                             %author name increment
    for p = 1:numel(fnames_2)
        z = z+1;                       %add 1 to author name increment
        activity_lost_lower_comb(t,p) = str2num...
        (results.elements.(fnames{q}).(fnames_2{p})(9));
        activity_lost_upper_comb(t,p) = str2num...
        (results.elements.(fnames{q}).(fnames_2{p})(10));
        name_final(t) = results.elements.(fnames{q}).(fnames_2{p})(1);
        error_upper_comb(t,p) = 100*sum(str2num...
        (results.elements.(fnames{q}).(fnames_2{p})(11)));
        error_lower_comb(t,p) = 100*sum(str2num...
        (results.elements.(fnames{q}).(fnames_2{p})(12)));
    end
    average_lost_lower(t) = 100.*mean...
    (nonzeros(activity_lost_lower_comb(t,:)));
    average_lost_upper(t) = 100.*mean...
    (nonzeros(activity_lost_upper_comb(t,:)));

    %Finding the average errors without 0 being considered
    error_upper(t) = sum(error_upper_comb(t,:)/nnz(error_upper_comb(t,:)));
    error_lower(t) = sum(error_lower_comb(t,:)/nnz(error_lower_comb(t,:)));
end

average_lost_lower_sum = sum(average_lost_lower);
average_lost_upper_sum = sum(average_lost_upper);

error_upper_sum = nansum(error_upper);
error_lower_sum = nansum(error_lower);

%Adds the total data to a postition in the array
error_upper(t+1) = error_upper_sum;
error_lower(t+1) = error_lower_sum;
name_final(t+1)  = ".Total";

%Combines the individual data (1) and the total sum of data (2)
average_lower_final = [average_lost_lower, average_lost_lower_sum];
average_upper_final = [average_lost_upper, average_lost_upper_sum];

%% Plotting cumulative graphs

% Cumulative graphs show the effects of the real-world concentrations of
% enzyme inhibitors on Laccase enzyme activity

set(groot,'defaultFigureVisible','on'); %Setting figure visibily to on
set(gcf,'color','w');                   %setting figure colour to white
figure();                               %open new figure

% Making bar graph
bar(categorical(name_final),average_upper_final)
hold on
grid on

%Making error bars
er_U = errorbar(categorical(name_final), average_upper_final...
, error_upper, error_upper);
er_U.LineStyle = 'none';
er_U.Color = [0 0 0];

%Labelling the figure
xlabel('Elements')
ylabel('Laccase activity loss at real-world concentrations, %')
title('Upper concentration range')

% Grid, labels on the values with a high contribution like Ca or Na
for i = 1:numel((average_upper_final))
    if islarger_bar(average_upper_final(i)) == 1
        if isnan(error_upper(i)) == 0
            error_plot = num2str(round(error_upper(i),2));
        else
            error_plot = num2str(0);
        end
        text_upper = join([' ', num2str(round(average_upper_final(i),2)),' ',...
        char(177),' ',error_plot,'%']);
        text(categorical(name_final(i)), average_upper_final(i)*1.1,text_upper)
    end
end

%change ylims to zoom in on certain data
% ylim([-0.00015 0.0001])
figure(); %creates new figure

%creates bar chart for lower concentration range
bar(categorical(name_final),average_lower_final)
hold on
grid on

%adds error bars to lower concentration data
er_L = errorbar(categorical(name_final), average_lower_final,...
error_lower, error_lower);
er_L.LineStyle = 'none';
er_L.Color = [0 0 0];

%adds labels and title
xlabel('Elements')
ylabel('Laccase activity loss at real-world concentrations, %')
title('Lower concentration range')

%Cycles through the elements and labels element data if its greater than
%0.5%
for i = 1:numel((average_lower_final))
    if islarger_bar(average_lower_final(i)) == 1
        if isnan(error_lower(i)) == 0
            error_plot = num2str(round(error_lower(i),2));
        else
            error_plot = num2str(0);
        end
        text_lower = join([' ', num2str(round(average_lower_final(i),2)),' ',...
        char(177),' ',error_plot,'%']);
        text(categorical(name_final(i)), average_lower_final(i)*1.1,text_lower)
    end
end

%sets figures back to off
set(groot,'defaultFigureVisible','off');

%% Temperature and pH effects on total calculated in previous section

%Same as above, most of the names are self explanatory if enzyme knowledge
%is known

laccase_fn        = fieldnames(Laccase);
lower_inhib_multi = average_lost_lower_sum/100;
upper_inhib_multi = average_lost_upper_sum/100;
error_lower       = error_lower_sum;
error_upper       = error_upper_sum;

for k = 1:2
    laccase_temp_activ  = Laccase.(laccase_fn{k}).temp.activities;
    laccase_pH_activ    = Laccase.(laccase_fn{k}).pH.activities;
    laccase_temp_values = Laccase.(laccase_fn{k}).temp.values;
    laccase_pH_values   = Laccase.(laccase_fn{k}).pH.values;
    loop_temp           = numel(laccase_temp_activ);
    loop_pH             = numel(laccase_pH_activ);
    full_activity       = 1;

    %Loops through all the temps and pHs one at a time so each combination
    %is considered (for the effect on Laccase activity whilst under
    %real-world inhibitor concentrations AND with tempatures <20C and pH
    %5-7 which are usual for wastewater treatment conditions.
    
    for i = 1:loop_temp
        for j = 1:loop_pH
            lower_inhib_all(j, i) = round((full_activity - lower_inhib_multi)...
            *laccase_temp_activ(i) *laccase_pH_activ(j),4,'significant')*100;
            upper_inhib_all(j, i) = round((full_activity - upper_inhib_multi)...
            *laccase_temp_activ(i) *laccase_pH_activ(j),4, 'significant')*100;

            lower_inhib_error(j, i) = round((full_activity - error_lower)*...
            laccase_temp_activ(i) *laccase_pH_activ(j),2,'significant');
            upper_inhib_error(j, i) = round((full_activity - error_upper)*...
            laccase_temp_activ(i) *laccase_pH_activ(j),2,'significant');

            strings_lower{j, i} = string(strcat(num2str(lower_inhib_all(j,i)),...
            {' '}, char(177),{' '}, num2str(lower_inhib_error(j, i))));
            strings_upper{j, i} = string(strcat(num2str(upper_inhib_all(j,i)),...
            {' '}, char(177),{' '}, num2str(upper_inhib_error(j, i))));
        end
    end

    %saves results in new fields and subfields
    Laccase.("results").(laccase_fn{k}).("lower") = strings_lower;
    Laccase.("results").(laccase_fn{k}).("upper") = strings_upper;
end

%% Calculated data for report

results_fn = fieldnames(results.elements); % Gets element names
T          = table;                        %creates empty table

for i = 1:length(results_fn) %loops through names
    authors_ = fieldnames(results.elements.(results_fn{i}));
    for j = 1:length(authors_) %loops through authors
        author_name = authors_(j);
        values_     = results.elements.(results_fn{i}).(authors_{j});
        for_table   = table([values_ author_name]);
        T           = [T; for_table];
    end
end

%Splits single column of table distinct columns with abbreviated names
rough_table = splitvars(T, "Var1",'NewVariableNames',...
 {'Element','Laccase source', 'R^2', 'm', 'c', 'Low C', 'Up C','C errors'...
 , 'Low L', 'Up L', 'Low L err', 'Up L err', 'Author'});

%Loop through columns 9 to 12 to convert them from decimals to percents
for r = 9:12
    rough_table.(r) = str2double(rough_table{:,r}); %converts string to number
    rough_table.(r) = rough_table.(r).*100;         %turns to %
    rough_table.(r) = num2str(rough_table{:,r});    %changes back to string
end

%Creates table after sorting rows
tableforreport = sortrows(rough_table);

%% Local function 1 - turns concentration raw data into useable ranges

function conc_use = concentration_converter(conc_EA)
% Converts raw concentration data from EA into usable form

%Copying first and second rows (element names and units)
conc_use(:,1) = conc_EA(:,1);
conc_use(:,2) = conc_EA(:,2);

%for loop for the size of conc_EA, first column
for i = 1:size(conc_EA, 1)
    %7th column accessed
    if str2double(conc_EA(i, 7)) < 1
        %Turning the mean and standard deviation into ranges
        mean           = conc_EA(i, 4);
        sd             = conc_EA(i, 6);
        conc_use(i, 3) = num2str(str2num(mean)-str2num(sd));
        conc_use(i, 4) = num2str(str2num(mean)+str2num(sd));
    elseif str2double(conc_EA(i, 7)) > 1
        conc_use(i, 3) = conc_EA(i, 3);
        conc_use(i, 4) = conc_EA(i, 5);
    end
 
    % Converts units to mg/l so the conversion mM to mg is easier
    if strcmp(conc_use(i, 2), 'ug/l') == 1
        conc_use(i, 3) = num2str(str2num(conc_EA(i, 3))/1000);
        conc_use(i, 4) = num2str(str2num(conc_EA(i, 4))/1000);
        conc_use(i, 2) = 'mg/l';
    end
end
end

%% Local function 2 - extracts relevant data from the EA data

function [name, units, lower, upper, mw] = ea_extract(string, conc_use_MW)
%Given a string, returns the named data

for j = 1:length(conc_use_MW) %for loop across length of EA sheet rows
    if strcmp(conc_use_MW(j, 1), string) == 1
        name  = conc_use_MW(j, 1);
        units = conc_use_MW(j, 2);
        lower = conc_use_MW(j, 3); % Lower concentration
        upper = conc_use_MW(j, 4); % Upper concentration
        mw    = conc_use_MW(j, 5); % Molecular weight
    end
end
end

%% Local function 3 - IC50 equation

function v_v0 = IC50(I, IC50)
%Included to not repeat the same equation repeatedly
%The IC50 dose response curve equation as given in textbooks/literature

v_v0 = 1/(1+(I/IC50));

end

%% Local function 4 - extracts the y-labels, title content etc for graphs
function [x_label, y_label, title_graph] = graph_info(k, element_index, ...
 units_converted, data)
%Extracts strings for use in plotting labels, titles etc from the relevant
%field, simplifies the code although not the prettiest.
string_element = sprintf('%s et al. Element - %s',data.author(k), ...
    data.names.(data.author(k))(element_index));
string_conds_1 = sprintf('Temp: %d C. Time: %d mins. pH: %.2f. Substrate: %s',...
    data.conds.temp.(data.author(k)),data.conds.time.(data.author(k)),...
    data.conds.pH.(data.author(k)),data.conds.substrate.name.(data.author(k)));
string_conds_2 = sprintf('Substrate concentration: %.3f %s. Laccase source: %s',...
    str2num(data.conds.substrate.concentration.(data.author(k))(1)),...
    data.conds.substrate.concentration.(data.author(k))(2),...
    data.laccase.(data.author(k)));
title_graph = strcat({string_element; string_conds_1; string_conds_2});

%loops through to see what the units are
if units_converted == 1
    x_label = 'Concentration, mg/l';
else
    x_label = 'Concentration, m M';
end

y_label = 'Relative Laccase activity, %';

end

%% Local function 5 - converts concentration strings to numbers

function [conc_lower, conc_upper] = conc_total(conc_table)
% used to turn the EA data into its useable number form

for i = 1:length(conc_table)
    conc_l(i) = str2num(conc_table(i,3));
end
conc_lower = sum(conc_l);

for i = 1:length(conc_table)
    conc_u(i) = str2num(conc_table(i,4));
end
conc_upper = sum(conc_u);

end

%% Local function 6 - checks value of data

function [a] = islarger_bar(data)
%Simple function to check if a value is large enough to merit a text label

if data > 0.5
    a = 1;
else
    a = 0;
end
end

%######################## END OF PROGRAMME ##########################