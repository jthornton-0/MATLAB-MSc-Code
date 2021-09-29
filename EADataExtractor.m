%% MSc Project - Appendix F: Concentration Analysis
% MATLAB code to analyse Environment Agency data to establish the
% concentration component of real-world conditions
% Prepared for: [REDACTED]
% Submitted on: 05/10/2020
% Prepared by:  [REDACTED]
% Student ID:   [REDACTED]
% Module:       MSc Project
% Module code:  [REDACTED]

%% MATLAB stuff
% This programme REQUIRES the 'Statistics and Machine Learning Toolbox' be installed.
clc; clear all;     % Standard MATLAB
t_start = tic;      % Starts timer for overall programme

%% Element names of interest
% The following elements are potential Laccase inhibitors that are included
% in the Environment Agency data, these are used to extract required data.
% Note - Cerium excluded as its not tested for by the Environment Agency

element_names = ["Fluoride","Chloride","Bromide","Iodide","Lithium",...
 "Sodium","Magnesium","Potassium","Calcium","Chromium","Manganese",...
 "Iron","Cobalt","Nickel","Copper","Zinc","Selenium","Silver",...
 "Cadmium","Barium","Mercury","Lead"];

elements_names_size = numel(element_names); %Determines size for 'for' loops

%% Downloading data spreadsheet from environment agency
%
% File was downloaded from the environment agency (EA):
% https://environment.data.gov.uk/water-quality/view/download/new
% Set the search terms - Area = All of England
% - Year = 2019
% - Purpose = both compliance and monitoring
%
% Download the file to the same folder as this programme (it's a big
% file!), preferably create a new folder and put this program and the excel
% sheet in the new folder. On the pop-up that displays, please click on the
% file. The programme should then work and analyse the data. The search
% terms can be changed along with the element names and statistics gleaned
% so this could be relevant to other researchers in the future. The CSV file
% has 1.6 million data entrys but MATLAB and excel can only load 1.05
% million, to access the other 0.55 million entries requires reading and
% deleting rows and is computationally expensive.
%
% NOTE - requires microsoft excel and a windows operating system to use.
% Takes ~ 2-3 minutes for this section

tic;                % Begins timer for accessing excel
file_type = '.csv'; % File type of the EA excel sheet

[file_name, folder] = uigetfile(file_type); %Opens window, click EA file
fullFileName = fullfile(folder, file_name); %Returns full file name C:\\
sheet = file_name(1:end-4);                 %EA sheet is called filename

excel = actxserver('Excel.Application'); %Create excel connection
fprintf('Finished Loading: Excel\n');    %Connection completed message

workbook = excel.Workbooks.Open(fullFileName); %Access EA file
fprintf('Finished Loading: Workbook\n');       %Accessed EA file message

worksheet = workbook.Worksheets.Item(sheet); %Access EA workbook sheet
fprintf('Finished Loading: Sheet\n');        %Accessed sheet message

% Copy all the data from the EA CSV sheet into MATLAB
data_EA = excel.Worksheets.Item(sheet).UsedRange.Value;
fprintf('Finished Loading: Data\n');   %Completed data transfer

excel.Quit;                             %Close excel
fprintf('Finished Closing: Excel\n\n'); %Closed excel message
time_excel = toc;                       %End timer for excel access

%% Extracting useful data from the transferred EA data
% Note - Includes every water source. Only values that are ignored are the
% data for fish carcasses. This is discussed in the discussion of the
% report. This aspect takes the longest time, approximately ~ 10 mins
% Little point in pre-allocating arrays as it varies. Not the prettiest
% code it has to be admitted. Takes around ~ 8-10 minutes.
%
% The sources excluded from further consideration with justifications are:
% Fish carcasses - bioaccumulation can occur and not representative
% Minewater - concentrated metal content, not representative, upper
% range of zinc obtained was 2,000,000 mg/l
% Flowing/Pumped Minewater - not representative, skews statistics, upper
% range of Iron obtained was 440,000 mg/l for one sample.
% Estuarine water - irrelevant as the water is flowing into the sea
% regardless, it has become an international problem.
% Sediment - not relevant to water treatment or what is actually flowing in
% the water, will also be highly concentrated with minerals
% Static - Static won’t lead into wastewater nor be representative of typical
% wastewater as it will be concentrated, so not needed.
% Pond/Lake – not representative of typical wastewater, will be concentrated
% Trade – trade effluent produced some of the largest upper ranges and is not
% typical of normal wastewater, hence it is excluded.
% Leachate – concentrations not representative of typical wastewater due to
% extracting suspended solids and solubles.
%
% Feel free to change these terms though

tic; % Begins timer for analysing contained data

% As mentioned in section intro, the following units/data are not required
% so can be excluded. Change as required.
units_undesirable = 'kg';           %kg returns values for fish carcasses
data_undesirable_1 = 'MINEWATER';   %Minewater excluded
data_undesirable_2 = 'ESTUARINE';   %Estuarine excluded
data_undesirable_3 = 'SEDIMENT';    %sediments excluded
data_undesirable_4 = 'LEACHATE';    %leachate excluded
data_undesirable_5 = 'STATIC';      %static groundwater excluded
data_undesirable_6 = 'POND';        %Ponds and static water not representative
data_undesirable_7 = 'TRADE';       %Trade effluent skews statistics
data_undesirable_8 = 'SEA';         %Sea water not relevant to wastewater

% for loop using the amount of elements/data of interest. The
% contains(data_EA) section is ugly but as data/units that needed to be
% excluded were not known from the outset, a way of excluding them as they
% arose was required.

for i = 1:elements_names_size
    z = 0;                      %index variable set to 0
    element = element_names(i); %access element name
    for j = 1:length(data_EA()) %for loop across length of EA sheet rows
        if contains(data_EA{j, 7}, element) == 1 &&...
        contains(data_EA{j, 12}, units_undesirable) == 0 && ...
        contains(data_EA{j, 13}, data_undesirable_1) == 0 && ...
        contains(data_EA{j, 13}, data_undesirable_2) == 0 && ...
        contains(data_EA{j, 13}, data_undesirable_3) == 0 && ...
        contains(data_EA{j, 13}, data_undesirable_4) == 0 && ...
        contains(data_EA{j, 13}, data_undesirable_5) == 0 && ...
        contains(data_EA{j, 13}, data_undesirable_6) == 0 && ...
        contains(data_EA{j, 13}, data_undesirable_7) == 0 && ...
        contains(data_EA{j, 13}, data_undesirable_8) == 0
            %if excludes rows that either don't contain the element
            %name or include kg as units
            z=z+1;                        %increment index
            rawdata(z,i) = data_EA{j,10}; %extract data from 10th column
            %extract units from 12th column
            rawunits(z,i) = convertCharsToStrings(data_EA{j,12});
            %extract type of source from 13th column
            rawtype(z,i) = convertCharsToStrings(data_EA{j,13});
            
            %An issue arose where some measurements of the same element
            %were in mg/l and ug/l. The following if conditions look at
            %the units of the first entry, and if the entry in z index
            %is not the same, it modifies the value and units.
            
            if j ~= 1
                if rawunits(z,i) ~= rawunits(1,i)
                    if rawunits(1,i) == "mg/l"
                        %converting ng/l data to mg/l
                        rawunits(z,i) = rawunits(1,i);
                        rawdata(z,i) = rawdata(z,i) / 1000;
                    end
                    if rawunits(1,i) == "ng/l"
                        %converting mg/l data to ng/l
                        rawunits(z,i) = rawunits(1,i);
                        rawdata(z,i) = rawdata(z,i) * 1000;
                    end
                end
            end
        end
    end
 % Displays update message on the progress of the loop - takes a while
 fprintf('Data extraction complete for: %s, %i out of %i\n',...
 element, i, elements_names_size);
end

time_extracting_data = toc; %ends timer for extracting data
fprintf('\n');              %prints new line character to seperate sections

%% Analysis of concentration data

tic;     %begins timer for concentration analysis

%extract only the first row of units, units were standarised in extraction
rawunits_table = rawunits(1,:);

%for loop across number of elements being considered
for k = 1:elements_names_size
    %sorts the data in descending order so median and others work properly
    data_to_stats = sort(rawdata(:,k),'descend');
    %calls the statistics function and saves results in kth column
    [twenty5(:,k), Median(:,k), Mean(:,k), seventy5(:,k), deviat(:,k),...
    CoV(:,k), upper(:,k), lower(:,k), total_points(:,k)]...
    = StatisticS(data_to_stats);
    %prints an update when each element is completed
    fprintf('Concentration analysis completed for: %s, %d out of %d\n',...
    element_names(k),k,elements_names_size)
end

%creates table using the statistics and element data. Assigns variable
%names to the table. Probably a more elegant way.
T_conc = table(element_names', rawunits_table', twenty5', Median',...
 Mean', seventy5', deviat', CoV', upper', lower', total_points',...
 'VariableNames',{'Element' 'Units' '25%' 'Median' 'Mean' '75%'...
 'Standard deviation' 'Coefficient of variation' 'Upper range'...
 'Lower range' 'Total data points'});

time_conc_analysis = toc; %ends timer for conc analysis
fprintf('\n'); %prints new line character to seperate sections

%% Analysis of source data

tic;    %starts timer for source data

%Obtains the unique sources from the rawtype data. rmmissing (remove
%missing) function had to be called as it filled up with tens of thousands
%of <missing> values for some reason.

unique_source = rmmissing(unique(rawtype));
unique_source_size = numel(unique_source);  %obtains number of unique sources

%nested for loop to cycle through each element (u) and source type (v)
for u = 1:elements_names_size
    for v = 1:unique_source_size
        %extracts the amount of times each source appears
        occurances_source(v,u) = sum(count(rawtype(:,u), unique_source(v)));
    end
    %counts the total appearances of each source type
    occurances_data_total(u) = sum(occurances_source(:,u),'all');
    %calculates the percentages of each source type over the total
    occurances_percentage(:,u) = round(((occurances_source(:,u) / ...
    occurances_data_total(u))*100),2,'significant');
    occurances_percentage_pie(:,u) = round(((occurances_source(:,u) / ...
    occurances_data_total(u))*100),1);
    %sums up the percentages of each source so it can be seen ~100%
    occurances_percentage_total(:,u) = sum(occurances_percentage(:,u));
    %prints an update when each element is completed
    fprintf('Source occurance completed for: %s, %d out of %d\n',...
    element_names(u),u,elements_names_size)
end

fprintf('\n'); %prints new line character to seperate sections

%Creates data table, again not the most elegant way.
occurances_data_table = [element_names; occurances_source;...
 occurances_data_total];

%Creates the row names by adding strings to ensure dimensions are fine
occurances_row_names = ['Sample source';unique_source;'Total'];

%Creates table for the source data
T_source_data = table(occurances_row_names, occurances_data_table);

% Createss percentage of total table
occurances_percent_table = [element_names; occurances_percentage; ...
 occurances_percentage_total];

T_source_percentages = table(occurances_row_names, occurances_percent_table);

time_source_analysis = toc; %ends timer for source data

%% Timing

%prints the times for each section
fprintf('Programme completed!\n')
fprintf('Time taken - Excel: %.2f\n',time_excel)
fprintf('Time taken - Extracting data: %.2f\n',time_extracting_data)
fprintf('Time taken - Analysing concentrations: %.2f\n',time_conc_analysis)
fprintf('Time taken - Analysing sources: %.2f\n',time_source_analysis)
t_end = toc(t_start); %ends overall timer
%prints overall time
fprintf('Time taken - Total: %.2f\n',t_end)
fprintf('Plotting pie charts, run section for them in code for individual\n\n')
pause(5)

%% Plotting pie chart data 1

%Use the 'run section' bit of MATLAB next to run to get each individual pie chart

%Plotting Iodide source data

t = 0;  %increment index
for r = 1:unique_source_size
    % only include percentages over 0.5% or the pie chart would be
    % cluttered
    if occurances_percentage_pie(r, 4) > 0.5 && occurances_percentage_pie(r,4) ~= 0
        t = t + 1;                                      %add one to index
        pie_label_1(t) = unique_source(r);              %store label name
        pie_data_1(t) = occurances_percentage_pie(r,4); %store percentage
    end
end

%Only include first t labels, often duplicates
pie_label_1 = pie_label_1(1:t);

%plot pie chart, nonzeros. Using explode array function to alternate
%between 1 and 0 for visibility purposes
pie(nonzeros(pie_data_1), explode_array(pie_data_1));
legend(pie_label_1)   %add legend
set(gcf,'color','w'); %set background colour to white

%% Plotting pie chart data 2

%plotting Iron source data
t= 0; %increment index
for r = 1:unique_source_size
    if occurances_percentage_pie(r, 12) > 0.5 && occurances_percentage_pie(r,12) ~= 0
    % only include percentages over 0.5% or the pie chart would be
    % cluttered
        t = t + 1;                                       %add one to index
        pie_label_2(t) = unique_source(r);               %store label name
        pie_data_2(t) = occurances_percentage_pie(r,12); %store percentage
    end
end
%Only include first t labels, often duplicates
pie_label_2 = pie_label_2(1:t);

%plot pie chart, nonzeros. Using explode array function to alternate
%between 1 and 0 for visibility purposes
pie(nonzeros(pie_data_2), explode_array(pie_data_2));
legend(pie_label_2)   %add legend
set(gcf,'color','w'); %set background colour to white

%% Plotting pie data - 3

% Plotting Chloride source data
t= 0; %increment index
for r = 1:unique_source_size
    if occurances_percentage_pie(r, 2) > 0.5 && occurances_percentage_pie(r,2) ~= 0
    % only include percentages over 0.5% or the pie chart would be
    % cluttered with values like 0.0001% etc
        t = t + 1;                                      %add one to index
        pie_label_3(t) = unique_source(r);              %store label name
        pie_data_3(t) = occurances_percentage_pie(r,2); %store percentage
    end
end

%Only include first t labels, often duplicates
pie_label_3 = pie_label_3(1:t);

%plot pie chart, nonzeros. Using explode array function to alternate
%between 1 and 0 for visibility purposes
pie(nonzeros(pie_data_3), explode_array(pie_data_3));
legend(pie_label_3)   %add legend
set(gcf,'color','w'); %set background colour to white

%% Plotting pie data - 4

% Plotting Mercury source data

t= 0;   %increment index
for r = 1:unique_source_size
    if occurances_percentage_pie(r, 21) > 0.5 && occurances_percentage_pie(r,21) ~= 0
        % only include percentages over 0.5% or the pie chart would be
        % cluttered
        t = t + 1;                                       %add one to index
        pie_label_4(t) = unique_source(r);               %store label name
        pie_data_4(t) = occurances_percentage_pie(r,21); %store percentage
    end
end

%Only include first t labels, often duplicates
pie_label_4 = pie_label_4(1:t);

%plot pie chart, nonzeros. Using explode array function to alternate
%between 1 and 0 for visibility purposes
pie(nonzeros(pie_data_4), explode_array(pie_data_4));
legend(pie_label_4)   %add legend
set(gcf,'color','w'); %set background colour to white

%% Local function 1

%Statistics function
function [twenty5, Median, Mean, seventy5, deviat, CoV,...
 upper, lower, total_points] = StatisticS(values)

% This function REQUIRES the 'Statistics and Machine Learning Toolbox' installed.

% twenty5 = 25% percentile of the data
% seventy5 = 75% percentile
% deviat = standard deviation. Default option used (N-1, not N)
% CoV = Coefficient of variation
% b is required as the rawdata variable includes 0's from MATLAB expanding
% columns due to more data being added to adjacent columns

b = values ~= 0;

twenty5  = round(prctile(values(b), 25),2,'significant');
seventy5 = round(prctile(values(b), 75),2,'significant');
Median   = round(median(values(b)),2,'significant');
Mean     = round(mean(values(b)),3,'significant');
deviat   = round(std(values(b)),3,'significant');
CoV      = round(deviat/Mean,2,'significant');
upper    = max(values);
lower    = min(values(b));

total_points = numel(values(b));
end

%% Local function 2

function array_piedata = explode_array(pie_data)
%This function is neccesary so the pie chart segments are visible

size_pie = size(pie_data); %calculates size of pie data
t = 0;                      %increment values

% loops through pie data, only second element of array as first is 1
for i = 1:size_pie(2)
    t = t + 1;                %add 1 to increment
    if rem(t,2) == 0          %if even
        array_piedata(i) = 0; %value for explode equals 0
    elseif rem(t,2) == 1      %if odd
        array_piedata(i) = 1; %value for explode equals 1
    end
end
end

%######################## END OF PROGRAMME ##########################
