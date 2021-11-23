%{
Use this script was used to graph and calcultate the input resistance for each cell.
Import the data from excel sheets using the funciton inportInputRes.m.

The data in the excel sheets was retrieved by doing analysis of the 25 pA
current steps in Clampfit 10.2. I recorded the amplitude (mV) at the end of each step. By
graphing these prior to firing (steps -75 to 0 pA) vs. the injected current, I am able to find the
input resistance as the slope.
%}

%% Add paths
addpath /Users/nathansmac/Documents/MATLAB/MATLAB/
addpath /Users/nathansmac/Documents/MATLAB/MATLAB/Trains_InputStrength/Firing/

%% directory to MATLAB Folder
cd /Users/nathansmac/Documents/MATLAB/MATLAB/Trains_InputStrength/Firing/

%% Load the structre where my data is found (Unless this is the first time)
cd /Users/nathansmac/Desktop/VTA_INPUTS/GABA_Firing/6Jan2021/

load('Firing_LH2VTA.mat')

%% Create path where all my files will be found
% Change this when I change my file locations
%PATH = "/Users/nathansmac/Desktop/LH2VTA/GABA_Firing/";

MC_path = "Male Control/Resistance_MC_500ms";
MF_path = "Male Fasted/Resistance_MF_500ms";
FC_path = "Female Control/Resistance_FC_500ms";
FF_path = "Female Fasted/Resistance_FF_500ms";

%{
Use my function "importRANGE.m": Resistance = importInputRes(workbookFile, sheetName, dataLines);
dataLines are the row to start on and the row to stop on, but I don't
need to specify this, because I've set this up in my function already.
There are only two options: [2, 15] or [2, 17], and my function knows
which one to used depending on what the name of the excel sheet is.
%}

% Import Male Control Input Resistance table
for n = 1 : length(Firing.MaleControl)
    if istable(Firing.MaleControl(n).STEPS_25pA)    % This if statment is here for the few cells that do not have a current step table.
        Firing.MaleControl(n).IR_table = importInputRes(MC_path, Firing.MaleControl(1).tableRange.Tab_Names(n));
    else
        Firing.MaleControl(n).IR_table = nan;       % The cells without a current step table will just get an NaN
    end
end

% Import Male Fasted Input Resistance table
for n = 1 : length(Firing.MaleFasted)
    if istable(Firing.MaleFasted(n).STEPS_25pA)
        Firing.MaleFasted(n).IR_table = importInputRes(MF_path, Firing.MaleFasted(1).tableRange.Tab_Names(n));
    else
        Firing.MaleFasted(n).IR_table = nan;
    end
end

% Import Female Control Input Resistance table
for n = 1 : length(Firing.FemaleControl)
    if istable(Firing.FemaleControl(n).STEPS_25pA)
        Firing.FemaleControl(n).IR_table = importInputRes(FC_path, Firing.FemaleControl(1).tableRange.Tab_Names(n));
    else
        Firing.FemaleControl(n).IR_table = nan;
    end
end

% Import Female Fasted Input Resistance table
for n = 1 : length(Firing.FemaleFasted)
    if istable(Firing.FemaleFasted(n).STEPS_25pA)
        Firing.FemaleFasted(n).IR_table = importInputRes(FF_path, Firing.FemaleFasted(1).tableRange.Tab_Names(n));
    else
        Firing.FemaleFasted(n).IR_table = nan;
    end
end

clear n PATH MC_path MF_path FC_path FF_path
%% Creating Graphs

x14_values = [-25:25:300];
x16_values = [-75:25:300];

% Male Control

for n = 1:length(Firing.MaleControl)
    name = char(Firing.MaleControl(1).tableRange.Tab_Names(n));
    NAME = [name(1:end-6) '\' name(end-5:end)];
    if istable(Firing.MaleControl(n).IR_table)
        s = size(Firing.MaleControl(n).IR_table);
        if s(1) == 14
            figure; hold on;
            plot(x14_values, Firing.MaleControl(n).IR_table.Peak, '-ko', 'LineWidth', 2, 'MarkerSize', 10, 'MarkerEdgeColor', 'r');
            title(['Male Control' newline 'Input Resistance' newline NAME]);
            ylabel('Voltage (mV)');
            xlabel('Current (pA)');
            hold off;
        elseif s(1) == 16
            figure; hold on;
            plot(x16_values, Firing.MaleControl(n).IR_table.Peak, '-ko', 'LineWidth', 2, 'MarkerSize', 10, 'MarkerEdgeColor','r');
            title(['Male Control' newline 'Input Resistance' newline NAME]);
            ylabel('Voltage (mV)');
            xlabel('Current (pA)');
            hold off;
        end
    end
end


% Male Fasted

for n = 1:length(Firing.MaleFasted)
    name = char(Firing.MaleFasted(1).tableRange.Tab_Names(n));
    NAME = [name(1:end-6) '\' name(end-5:end)];
    if istable(Firing.MaleFasted(n).IR_table)
        s = size(Firing.MaleFasted(n).IR_table);
        if s(1) == 14
            figure; hold on;
            plot(x14_values, Firing.MaleFasted(n).IR_table.Peak, '-ko', 'LineWidth', 2, 'MarkerSize', 10, 'MarkerEdgeColor', 'r');
            title(['Male Fasted' newline 'Input Resistance' newline NAME]);
            ylabel('Voltage (mV)');
            xlabel('Current (pA)');
            hold off;
        elseif s(1) == 16
            figure; hold on;
            plot(x16_values, Firing.MaleFasted(n).IR_table.Peak, '-ko', 'LineWidth', 2, 'MarkerSize', 10, 'MarkerEdgeColor', 'r');
            title(['Male Fasted' newline 'Input Resistance' newline NAME]);
            ylabel('Voltage (mV)');
            xlabel('Current (pA)');
            hold off;
        end
    end
end


% Female Control

for n = 1:length(Firing.FemaleControl)
    name = char(Firing.FemaleControl(1).tableRange.Tab_Names(n));
    NAME = [name(1:end-6) '\' name(end-5:end)];
    if istable(Firing.FemaleControl(n).IR_table)
        s = size(Firing.FemaleControl(n).IR_table);
        if s(1) == 14
            figure; hold on;
            plot(x14_values, Firing.FemaleControl(n).IR_table.Peak, '-ko', 'LineWidth', 2, 'MarkerSize', 10, 'MarkerEdgeColor', 'r');
            title(['Female Control' newline 'Input Resistance' newline NAME]);
            ylabel('Voltage (mV)');
            xlabel('Current (pA)');
            hold off;
        elseif s(1) == 16
            figure; hold on;
            plot(x16_values, Firing.FemaleControl(n).IR_table.Peak, '-ko', 'LineWidth', 2, 'MarkerSize', 10, 'MarkerEdgeColor', 'r');
            title(['Female Control' newline 'Input Resistance' newline NAME]);
            ylabel('Voltage (mV)');
            xlabel('Current (pA)');
            hold off;
        end
    end
end


% Female Fasted

for n = 1:length(Firing.FemaleFasted)
    name = char(Firing.FemaleFasted(1).tableRange.Tab_Names(n));
    NAME = [name(1:end-6) '\' name(end-5:end)];
    if istable(Firing.FemaleFasted(n).IR_table)
        s = size(Firing.FemaleFasted(n).IR_table);
        if s(1) == 14
            figure; hold on;
            plot(x14_values, Firing.FemaleFasted(n).IR_table.Peak, '-ko', 'LineWidth', 2, 'MarkerSize', 10, 'MarkerEdgeColor', 'r');
            title(['Female Fasted' newline 'Input Resistance' newline NAME]);
            ylabel('Voltage (mV)');
            xlabel('Current (pA)');
            hold off;
        elseif s(1) == 16
            figure; hold on;
            plot(x16_values, Firing.FemaleFasted(n).IR_table.Peak, '-ko', 'LineWidth', 2, 'MarkerSize', 10, 'MarkerEdgeColor', 'r');
            title(['Female Fasted' newline 'Input Resistance' newline NAME]);
            ylabel('Voltage (mV)');
            xlabel('Current (pA)');
            hold off;
        end
    end
end

clear n name NAME s x14_values x16_values

%% Calculating the Input Resistance

% Male Control

x14_values = [-25 0];
x16_values = [-75 -50 -25 0];

for n = 1:length(Firing.MaleControl)
    if istable(Firing.MaleControl(n).IR_table)
        s = size(Firing.MaleControl(n).IR_table);
        if s(1) == 14
            y_values = [Firing.MaleControl(n).IR_table.Peak(1)
                        Firing.MaleControl(n).IR_table.Peak(2)];
            p = polyfit(x14_values,y_values,1);    % this polynomial is to the order of 1 (linear line that is not horizantal or vertical - requires an equation)
            % The first variable in p is the slope and the second number in p is the y-intercept
            Firing.MaleControl(n).InputResistance = p(1);
        elseif s(1) == 16
            y_values = [Firing.MaleControl(n).IR_table.Peak(1)
                        Firing.MaleControl(n).IR_table.Peak(2)
                        Firing.MaleControl(n).IR_table.Peak(3)
                        Firing.MaleControl(n).IR_table.Peak(4)];
            p = polyfit(x16_values,y_values,1);
            Firing.MaleControl(n).InputResistance = p(1);
        end
    else
        Firing.MaleControl(n).InputResistance = nan;
    end
end


% Male Fasted

x14_values = [-25 0];
x16_values = [-75 -50 -25 0];

for n = 1:length(Firing.MaleFasted)
    if istable(Firing.MaleFasted(n).IR_table)
        s = size(Firing.MaleFasted(n).IR_table);
        if s(1) == 14
            y_values = [Firing.MaleFasted(n).IR_table.Peak(1)
                        Firing.MaleFasted(n).IR_table.Peak(2)];
            p = polyfit(x14_values,y_values,1);    % this polynomial is to the order of 1 (linear line that is not horizantal or vertical - requires an equation)
            % The first variable in p is the slope and the second number in p is the y-intercept
            Firing.MaleFasted(n).InputResistance = p(1);
        elseif s(1) == 16
            y_values = [Firing.MaleFasted(n).IR_table.Peak(1)
                        Firing.MaleFasted(n).IR_table.Peak(2)
                        Firing.MaleFasted(n).IR_table.Peak(3)
                        Firing.MaleFasted(n).IR_table.Peak(4)];
            p = polyfit(x16_values,y_values,1);
            Firing.MaleFasted(n).InputResistance = p(1);
        end
    else
        Firing.MaleFasted(n).InputResistance = nan;
    end
end


% Female Control

x14_values = [-25 0];
x16_values = [-75 -50 -25 0];

for n = 1:length(Firing.FemaleControl)
    if istable(Firing.FemaleControl(n).IR_table)
        s = size(Firing.FemaleControl(n).IR_table);
        if s(1) == 14
            y_values = [Firing.FemaleControl(n).IR_table.Peak(1)
                        Firing.FemaleControl(n).IR_table.Peak(2)];
            p = polyfit(x14_values,y_values,1);    % this polynomial is to the order of 1 (linear line that is not horizantal or vertical - requires an equation)
            % The first variable in p is the slope and the second number in p is the y-intercept
            Firing.FemaleControl(n).InputResistance = p(1);
        elseif s(1) == 16
            y_values = [Firing.FemaleControl(n).IR_table.Peak(1)
                        Firing.FemaleControl(n).IR_table.Peak(2)
                        Firing.FemaleControl(n).IR_table.Peak(3)
                        Firing.FemaleControl(n).IR_table.Peak(4)];
            p = polyfit(x16_values,y_values,1);
            Firing.FemaleControl(n).InputResistance = p(1);
        end
    else
        Firing.FemaleControl(n).InputResistance = nan;
    end
end


% Female Fasted

x14_values = [-25 0];
x16_values = [-75 -50 -25 0];

for n = 1:length(Firing.FemaleFasted)
    if istable(Firing.FemaleFasted(n).IR_table)
        s = size(Firing.FemaleFasted(n).IR_table);
        if s(1) == 14
            y_values = [Firing.FemaleFasted(n).IR_table.Peak(1)
                        Firing.FemaleFasted(n).IR_table.Peak(2)];
            p = polyfit(x14_values,y_values,1);    % this polynomial is to the order of 1 (linear line that is not horizantal or vertical - requires an equation)
            % The first variable in p is the slope and the second number in p is the y-intercept
            Firing.FemaleFasted(n).InputResistance = p(1);
        elseif s(1) == 16
            y_values = [Firing.FemaleFasted(n).IR_table.Peak(1)
                        Firing.FemaleFasted(n).IR_table.Peak(2)
                        Firing.FemaleFasted(n).IR_table.Peak(3)
                        Firing.FemaleFasted(n).IR_table.Peak(4)];
            p = polyfit(x16_values,y_values,1);
            Firing.FemaleFasted(n).InputResistance = p(1);
        end
    else
        Firing.FemaleFasted(n).InputResistance = nan;
    end
end

clear n s x14_values x16_values y_values p

%% Creating a table

% Male Control
MC_IR = {};
for n = 1:length(Firing.MaleControl)
    MC_IR(n,1) = {'Male Control'};
    MC_IR(n,2) = {Firing.MaleControl(1).tableRange.Tab_Names(n)};
    MC_IR(n,3) = {Firing.MaleControl(n).InputResistance};
end    


MF_IR = {};
for n = 1:length(Firing.MaleFasted)
    MF_IR(n,1) = {'Male Fasted'};
    MF_IR(n,2) = {Firing.MaleFasted(1).tableRange.Tab_Names(n)};
    MF_IR(n,3) = {Firing.MaleFasted(n).InputResistance};
end    


FC_IR = {};
for n = 1:length(Firing.FemaleControl)
    FC_IR(n,1) = {'Female Control'};
    FC_IR(n,2) = {Firing.FemaleControl(1).tableRange.Tab_Names(n)};
    FC_IR(n,3) = {Firing.FemaleControl(n).InputResistance};
end    


FF_IR = {};
for n = 1:length(Firing.FemaleFasted)
    FF_IR(n,1) = {'Female Fasted'};
    FF_IR(n,2) = {Firing.FemaleFasted(1).tableRange.Tab_Names(n)};
    FF_IR(n,3) = {Firing.FemaleFasted(n).InputResistance};
end    

IR_nan = {nan, nan, nan};

IR_array = [IR_nan; MC_IR; IR_nan; MF_IR; IR_nan; FC_IR; IR_nan; FF_IR];

Firing.Tables.IR = array2table(IR_array,'VariableNames',{'Group','Cell_Name','Input_Resistance'});

clear n IR_nan MC_IR MF_IR FC_IR FF_IR IR_array

%% Save new data to structure

save Firing_LH2VTA

%% Creating tables showing how I calculated the Input Resistance

steps_16_num = [1:16]';         % There are 16 steps
steps_16_pA = [-75:25:300]';	% These steps are in 25 pA increments from -75 pA to 300 pA

% Male Control Input Resistance Table
% Creating variable names
variable_names = {};
for n = 1:length(Firing.MaleControl)
    variable = ['name_' char(Firing.MaleControl(1).tableRange.Tab_Names(n))];
    variable_names{1,n} = variable;
end
variable_names = ["step_num" "pA" string(variable_names)];

IR = [];
for n = 1:length(Firing.MaleControl)
    if istable(Firing.MaleControl(n).IR_table)
        if length(Firing.MaleControl(n).IR_table.Peak) < 16
            ADJUSTED = [nan; nan; Firing.MaleControl(n).IR_table.Peak];
        else
            ADJUSTED = [Firing.MaleControl(n).IR_table.Peak];
        end
    else
        ADJUSTED = nan(16,1);
    end
    IR = [IR ADJUSTED];
end

IR = [steps_16_num steps_16_pA IR];

% Creating table
Firing.Tables.MC_IR = array2table(IR,'VariableNames',variable_names);


% Male Fasted Input Resistance Table
% Creating variable names
variable_names = {};
for n = 1:length(Firing.MaleFasted)
    variable = ['name_' char(Firing.MaleFasted(1).tableRange.Tab_Names(n))];
    variable_names{1,n} = variable;
end
variable_names = ["step_num" "pA" string(variable_names)];

IR = [];
for n = 1:length(Firing.MaleFasted)
    if istable(Firing.MaleFasted(n).IR_table)
        if length(Firing.MaleFasted(n).IR_table.Peak) < 16
            ADJUSTED = [nan; nan; Firing.MaleFasted(n).IR_table.Peak];
        else
            ADJUSTED = [Firing.MaleFasted(n).IR_table.Peak];
        end
    else
        ADJUSTED = nan(16,1);
    end
    IR = [IR ADJUSTED];
end

IR = [steps_16_num steps_16_pA IR];

% Creating table
Firing.Tables.MF_IR = array2table(IR,'VariableNames',variable_names);


% Female Control Input Resistance Table
% Creating variable names
variable_names = {};
for n = 1:length(Firing.FemaleControl)
    variable = ['name_' char(Firing.FemaleControl(1).tableRange.Tab_Names(n))];
    variable_names{1,n} = variable;
end
variable_names = ["step_num" "pA" string(variable_names)];

IR = [];
for n = 1:length(Firing.FemaleControl)
    if istable(Firing.FemaleControl(n).IR_table)
        if length(Firing.FemaleControl(n).IR_table.Peak) < 16
            ADJUSTED = [nan; nan; Firing.FemaleControl(n).IR_table.Peak];
        else
            ADJUSTED = [Firing.FemaleControl(n).IR_table.Peak];
        end
    else
        ADJUSTED = nan(16,1);
    end
    IR = [IR ADJUSTED];
end

IR = [steps_16_num steps_16_pA IR];

% Creating table
Firing.Tables.FC_IR = array2table(IR,'VariableNames',variable_names);


% Female Fasted Input Resistance Table
% Creating variable names
variable_names = {};
for n = 1:length(Firing.FemaleFasted)
    variable = ['name_' char(Firing.FemaleFasted(1).tableRange.Tab_Names(n))];
    variable_names{1,n} = variable;
end
variable_names = ["step_num" "pA" string(variable_names)];

IR = [];
for n = 1:length(Firing.FemaleFasted)
    if istable(Firing.FemaleFasted(n).IR_table)
        if length(Firing.FemaleFasted(n).IR_table.Peak) < 16
            ADJUSTED = [nan; nan; Firing.FemaleFasted(n).IR_table.Peak];
        else
            ADJUSTED = [Firing.FemaleFasted(n).IR_table.Peak];
        end
    else
        ADJUSTED = nan(16,1);
    end
    IR = [IR ADJUSTED];
end

IR = [steps_16_num steps_16_pA IR];

% Creating table
Firing.Tables.FF_IR = array2table(IR,'VariableNames',variable_names);

clear n IR variable_names ADJUSTED variable steps_16_num steps_16_pA

%% Save new data to structure

save Firing_LH2VTA
%% Write table to excel

writetable(Firing.Tables.IR,'Firing_LH2VTA.xlsx','Sheet','IR','Range','A1');
writetable(Firing.Tables.MC_IR,'Firing_LH2VTA.xlsx','Sheet','MC_IR','Range','A1');
writetable(Firing.Tables.MF_IR,'Firing_LH2VTA.xlsx','Sheet','MF_IR','Range','A1');
writetable(Firing.Tables.FC_IR,'Firing_LH2VTA.xlsx','Sheet','FC_IR','Range','A1');
writetable(Firing.Tables.FF_IR,'Firing_LH2VTA.xlsx','Sheet','FF_IR','Range','A1');
