%{
Use this script to get the resting membrane potential (in instances of no
firing, number of action potentials (in instances of firing), average
frequency and the average interevent interval. After this analysis, I
removed all cells with spontaneous action potentials, as those can
interfere with accurate resting membrane potential measurements.

Import the data from excel sheets using the funciton inportRMP.m and also
importAPs.m

These excel sheelts contain data from analysis that I did in Clampfit 10.2 of 5
minute long membrane potential recordings of cells where no current was added.
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
PATH = "/Users/nathansmac/Desktop/LH2VTA/GABA_Firing/100pA_1s/RMP.xlsx";

%% Importing the tables that contain the Resting Membrane Potentials

%{
Use my function "importRMP.m": RMP = importRMP(workbookFile, sheetName,
dataLines); - RMP is actual the table
dataLines are the row to start on and the row to stop on. The first number
is always 2 and the second number is always one longer that the length of
the corresponding structure.
%}

% Import Male Control Resting Membrane Potential table
Firing.MaleControl(1).RMP_table = importRMP(PATH, "Male_Control", [2, (length(Firing.MaleControl)+1)]);
Firing.MaleFasted(1).RMP_table = importRMP(PATH, "Male_Fasted", [2, (length(Firing.MaleFasted)+1)]);
Firing.FemaleControl(1).RMP_table = importRMP(PATH, "Female_Control", [2, (length(Firing.FemaleControl)+1)]);
Firing.FemaleFasted(1).RMP_table = importRMP(PATH, "Female_Fasted", [2, (length(Firing.FemaleFasted)+1)]);

clear n 

%% Getting the Resting Membrane Potential

% Male Control

for n = 1:length(Firing.MaleControl)
    if Firing.MaleControl(1).RMP_table.APs(n) == 'No'
        Firing.MaleControl(n).RMP = Firing.MaleControl(1).RMP_table.AverageRMPmV(n)
    else
        Firing.MaleControl(n).RMP = nan;    % If there are action potentials then I will just write NaN
    end
end


% Male Fasted

for n = 1:length(Firing.MaleFasted)
    if Firing.MaleFasted(1).RMP_table.APs(n) == 'No'
        Firing.MaleFasted(n).RMP = Firing.MaleFasted(1).RMP_table.AverageRMPmV(n)
    else
        Firing.MaleFasted(n).RMP = nan;    % If there are action potentials then I will just write NaN
    end
end


% Female Control

for n = 1:length(Firing.FemaleControl)
    if Firing.FemaleControl(1).RMP_table.APs(n) == 'No'
        Firing.FemaleControl(n).RMP = Firing.FemaleControl(1).RMP_table.AverageRMPmV(n)
    else
        Firing.FemaleControl(n).RMP = nan;    % If there are action potentials then I will just write NaN
    end
end


% Female Fasted

for n = 1:length(Firing.FemaleFasted)
    if Firing.FemaleFasted(1).RMP_table.APs(n) == 'No'
        Firing.FemaleFasted(n).RMP = Firing.FemaleFasted(1).RMP_table.AverageRMPmV(n)
    else
        Firing.FemaleFasted(n).RMP = nan;    % If there are action potentials then I will just write NaN
    end
end

clear n
%% Getting the action potential tables

PATH = "/Users/nathansmac/Desktop/LH2VTA/GABA_Firing/100pA_1s/RMP.xlsx";


% Male Control

for n = 1:length(Firing.MaleControl)
    if ~ismissing(Firing.MaleControl(1).RMP_table.Index(n))
        Firing.MaleControl(n).RMP_APs = importAPs(PATH, 'MC_' + Firing.MaleControl(1).RMP_table.CellName(n), Firing.MaleControl(1).RMP_table.Index(n));
    else
        Firing.MaleControl(n).RMP_APs = nan;
    end
end


% Male Fasted

for n = 1:length(Firing.MaleFasted)
    if ~ismissing(Firing.MaleFasted(1).RMP_table.Index(n))
        Firing.MaleFasted(n).RMP_APs = importAPs(PATH, 'MF_' + Firing.MaleFasted(1).RMP_table.CellName(n), Firing.MaleFasted(1).RMP_table.Index(n));
    else
        Firing.MaleFasted(n).RMP_APs = nan;
    end
end


% Female Control

for n = 1:length(Firing.FemaleControl)
    if ~ismissing(Firing.FemaleControl(1).RMP_table.Index(n))
        Firing.FemaleControl(n).RMP_APs = importAPs(PATH, 'FC_' + Firing.FemaleControl(1).RMP_table.CellName(n), Firing.FemaleControl(1).RMP_table.Index(n));
    else
        Firing.FemaleControl(n).RMP_APs = nan;
    end
end


% Female Fasted

for n = 1:length(Firing.FemaleFasted)
    if ~ismissing(Firing.FemaleFasted(1).RMP_table.Index(n))
        Firing.FemaleFasted(n).RMP_APs = importAPs(PATH, 'FF_' + Firing.FemaleFasted(1).RMP_table.CellName(n), Firing.FemaleFasted(1).RMP_table.Index(n));
    else
        Firing.FemaleFasted(n).RMP_APs = nan;
    end
end

clear n PATH
%% Getting the number of action potentials, frequency, and IEI

% Male Control

% Number of Action Potentials
for n = 1:length(Firing.MaleControl)
    if istable(Firing.MaleControl(n).RMP_APs)
        s = size(Firing.MaleControl(n).RMP_APs);
        Firing.MaleControl(n).RMP_numAP = s(1);
    else
        Firing.MaleControl(n).RMP_numAP = nan;
    end
end

% Frequency of Action Potentials
for n = 1:length(Firing.MaleControl)
    if istable(Firing.MaleControl(n).RMP_APs)
        Firing.MaleControl(n).RMP_freq = nanmean(Firing.MaleControl(n).RMP_APs.InstFreqHz)
    else
        Firing.MaleControl(n).RMP_freq = nan;
    end
end

% IEI of Action Potentials
for n = 1:length(Firing.MaleControl)
    if istable(Firing.MaleControl(n).RMP_APs)
        Firing.MaleControl(n).RMP_IEI = nanmean(Firing.MaleControl(n).RMP_APs.IntereventIntervalms)
    else
        Firing.MaleControl(n).RMP_IEI = nan;
    end
end


% Male Fasted

% Number of Action Potentials
for n = 1:length(Firing.MaleFasted)
    if istable(Firing.MaleFasted(n).RMP_APs)
        s = size(Firing.MaleFasted(n).RMP_APs);
        Firing.MaleFasted(n).RMP_numAP = s(1);
    else
        Firing.MaleFasted(n).RMP_numAP = nan;
    end
end

% Frequency of Action Potentials
for n = 1:length(Firing.MaleFasted)
    if istable(Firing.MaleFasted(n).RMP_APs)
        Firing.MaleFasted(n).RMP_freq = nanmean(Firing.MaleFasted(n).RMP_APs.InstFreqHz)
    else
        Firing.MaleFasted(n).RMP_freq = nan;
    end
end

% IEI of Action Potentials
for n = 1:length(Firing.MaleFasted)
    if istable(Firing.MaleFasted(n).RMP_APs)
        Firing.MaleFasted(n).RMP_IEI = nanmean(Firing.MaleFasted(n).RMP_APs.IntereventIntervalms)
    else
        Firing.MaleFasted(n).RMP_IEI = nan;
    end
end


% Female Control

% Number of Action Potentials
for n = 1:length(Firing.FemaleControl)
    if istable(Firing.FemaleControl(n).RMP_APs)
        s = size(Firing.FemaleControl(n).RMP_APs);
        Firing.FemaleControl(n).RMP_numAP = s(1);
    else
        Firing.FemaleControl(n).RMP_numAP = nan;
    end
end

% Frequency of Action Potentials
for n = 1:length(Firing.FemaleControl)
    if istable(Firing.FemaleControl(n).RMP_APs)
        Firing.FemaleControl(n).RMP_freq = nanmean(Firing.FemaleControl(n).RMP_APs.InstFreqHz)
    else
        Firing.FemaleControl(n).RMP_freq = nan;
    end
end

% IEI of Action Potentials
for n = 1:length(Firing.FemaleControl)
    if istable(Firing.FemaleControl(n).RMP_APs)
        Firing.FemaleControl(n).RMP_IEI = nanmean(Firing.FemaleControl(n).RMP_APs.IntereventIntervalms)
    else
        Firing.FemaleControl(n).RMP_IEI = nan;
    end
end


% Female Fasted

% Number of Action Potentials
for n = 1:length(Firing.FemaleFasted)
    if istable(Firing.FemaleFasted(n).RMP_APs)
        s = size(Firing.FemaleFasted(n).RMP_APs);
        Firing.FemaleFasted(n).RMP_numAP = s(1);
    else
        Firing.FemaleFasted(n).RMP_numAP = nan;
    end
end

% Frequency of Action Potentials
for n = 1:length(Firing.FemaleFasted)
    if istable(Firing.FemaleFasted(n).RMP_APs)
        Firing.FemaleFasted(n).RMP_freq = nanmean(Firing.FemaleFasted(n).RMP_APs.InstFreqHz)
    else
        Firing.FemaleFasted(n).RMP_freq = nan;
    end
end

% IEI of Action Potentials
for n = 1:length(Firing.FemaleFasted)
    if istable(Firing.FemaleFasted(n).RMP_APs)
        Firing.FemaleFasted(n).RMP_IEI = nanmean(Firing.FemaleFasted(n).RMP_APs.IntereventIntervalms)
    else
        Firing.FemaleFasted(n).RMP_IEI = nan;
    end
end

clear n s
%% Creating a table of the number of action potentials

% Male Control
MC_RMP = {};
for n = 1:length(Firing.MaleControl)
    MC_RMP(n,1) = {'Male Control'};
    MC_RMP(n,2) = {Firing.MaleControl(1).tableRange.Tab_Names(n)};
    MC_RMP(n,3) = {Firing.MaleControl(n).RMP};
    MC_RMP(n,4) = {Firing.MaleControl(n).RMP_numAP};
    MC_RMP(n,5) = {Firing.MaleControl(n).RMP_freq};
    MC_RMP(n,6) = {Firing.MaleControl(n).RMP_IEI};
end    


% Male Fasted
MF_RMP = {};
for n = 1:length(Firing.MaleFasted)
    MF_RMP(n,1) = {'Male Fasted'};
    MF_RMP(n,2) = {Firing.MaleFasted(1).tableRange.Tab_Names(n)};
    MF_RMP(n,3) = {Firing.MaleFasted(n).RMP};
    MF_RMP(n,4) = {Firing.MaleFasted(n).RMP_numAP};
    MF_RMP(n,5) = {Firing.MaleFasted(n).RMP_freq};
    MF_RMP(n,6) = {Firing.MaleFasted(n).RMP_IEI};
end    


% Female Control
FC_RMP = {};
for n = 1:length(Firing.FemaleControl)
    FC_RMP(n,1) = {'Female Control'};
    FC_RMP(n,2) = {Firing.FemaleControl(1).tableRange.Tab_Names(n)};
    FC_RMP(n,3) = {Firing.FemaleControl(n).RMP};
    FC_RMP(n,4) = {Firing.FemaleControl(n).RMP_numAP};
    FC_RMP(n,5) = {Firing.FemaleControl(n).RMP_freq};
    FC_RMP(n,6) = {Firing.FemaleControl(n).RMP_IEI};
end    


% Female Fasted
FF_RMP = {};
for n = 1:length(Firing.FemaleFasted)
    FF_RMP(n,1) = {'Female Fasted'};
    FF_RMP(n,2) = {Firing.FemaleFasted(1).tableRange.Tab_Names(n)};
    FF_RMP(n,3) = {Firing.FemaleFasted(n).RMP};
    FF_RMP(n,4) = {Firing.FemaleFasted(n).RMP_numAP};
    FF_RMP(n,5) = {Firing.FemaleFasted(n).RMP_freq};
    FF_RMP(n,6) = {Firing.FemaleFasted(n).RMP_IEI};
end  

RMP_nan = {nan, nan, nan, nan, nan, nan};

RMP_array = [RMP_nan; MC_RMP; RMP_nan; MF_RMP; RMP_nan; FC_RMP; RMP_nan; FF_RMP];

RMP_table = array2table(RMP_array,'VariableNames',{'Group','Cell_Name','RMP','NumAPs','Frequency','IEI'});

clear n RMP_nan MC_RMP MF_RMP FC_RMP FF_RMP RMP_array

%% Save new data to structure

save Firing_LH2VTA
%% Write table to excel

writetable(RMP_table,'Firing_LH2VTA.xlsx','Sheet','RMP','Range','A1');

