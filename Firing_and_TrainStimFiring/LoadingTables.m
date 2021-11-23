%% Add paths
addpath /Users/nathansmac/Documents/MATLAB/MATLAB/
addpath /Users/nathansmac/Documents/MATLAB/MATLAB/Trains_InputStrength/Firing/

%% directory to MATLAB Folder
cd /Users/nathansmac/Documents/MATLAB/MATLAB/Trains_InputStrength/Firing/

%% Load the structre where my data is found (Unless this is the first time)
cd /Users/nathansmac/Desktop/VTA_INPUTS/GABA_Firing/6Jan2021/

load('Firing_LH2VTA.mat')

%% Importing tables containing table ranges

% Need this data so that I can import my excel sheets (which all have a
% different range)

% Add the name of the file to my path
file_path = "tableRange_Firing_100pA_1s.xlsx";
% The cell values here are the range in the excel sheet where the data can
% be found. (A2:AF#). Make sure these are all right and line-up or you will
% have big problems in importing the data.

% Use my function "importRANGE.m": tableRange = importRANGE(workbookFile,
% sheetName, dataLines); dataLines are the row to start on and the row to
% stop on.
Firing.MaleControl(1).tableRange = importRANGE(file_path, "MaleControl",[2,14]);
Firing.MaleFasted(1).tableRange = importRANGE(file_path, "MaleFasted",[2,20]);
Firing.FemaleControl(1).tableRange = importRANGE(file_path, "FemaleControl", [2,22]);
Firing.FemaleFasted(1).tableRange = importRANGE(file_path, "FemaleFasted", [2,21]);

save Firing_LH2VTA;

%% Importing all the firing data and opto test pulses

% Male Control
cd /Users/nathansmac/Desktop/VTA_INPUTS/GABA_Firing/6Jan2021/'Male Control'/   % The name of the folder where the male control data is found
optotest_filepath = "pulsetest_MC.xlsx";  % Name of the file with the the opto-stim data at -70mV, -60mV, and -40mV.
steps25pA_filepath = "25pA_Steps_MC_500ms.xlsx";  % Name of the file with the current steps
s = size(Firing.MaleControl(1).tableRange);
for n = 1:s(1)  % Storing all this data in a structure
    Firing.MaleControl(n).OPTOtest = importOPTOtest(optotest_filepath, Firing.MaleControl(1).tableRange.Tab_Names(n));
    Firing.MaleControl(n).STEPS_25pA = importFIRING(steps25pA_filepath, Firing.MaleControl(1).tableRange.Tab_Names(n), Firing.MaleControl(1).tableRange.StepRange(n));
end

% Male Fasted
cd /Users/nathansmac/Desktop/VTA_INPUTS/GABA_Firing/6Jan2021/'Male Fasted'/
optotest_filepath = "pulsetest_MF.xlsx";
steps25pA_filepath = "25pA_Steps_MF_500ms.xlsx";
s = size(Firing.MaleFasted(1).tableRange);
for n = 1:s(1)
    Firing.MaleFasted(n).OPTOtest = importOPTOtest(optotest_filepath, Firing.MaleFasted(1).tableRange.Tab_Names(n));
    Firing.MaleFasted(n).STEPS_25pA = importFIRING(steps25pA_filepath, Firing.MaleFasted(1).tableRange.Tab_Names(n), Firing.MaleFasted(1).tableRange.StepRange(n));
end

% Female Control
cd /Users/nathansmac/Desktop/VTA_INPUTS/GABA_Firing/6Jan2021/'Female Control'/
optotest_filepath = "pulsetest_FC.xlsx";
steps25pA_filepath = "25pA_Steps_FC_500ms.xlsx";
s = size(Firing.FemaleControl(1).tableRange);
for n = 1:s(1)
    Firing.FemaleControl(n).OPTOtest = importOPTOtest(optotest_filepath, Firing.FemaleControl(1).tableRange.Tab_Names(n));
    Firing.FemaleControl(n).STEPS_25pA = importFIRING(steps25pA_filepath, Firing.FemaleControl(1).tableRange.Tab_Names(n), Firing.FemaleControl(1).tableRange.StepRange(n));
end

% Female Fasted
cd /Users/nathansmac/Desktop/VTA_INPUTS/GABA_Firing/6Jan2021/'Female Fasted'/
optotest_filepath = "pulsetest_FF.xlsx";
steps25pA_filepath = "25pA_Steps_FF_500ms.xlsx";
s = size(Firing.FemaleFasted(1).tableRange);
for n = 1:s(1)
    Firing.FemaleFasted(n).OPTOtest = importOPTOtest(optotest_filepath, Firing.FemaleFasted(1).tableRange.Tab_Names(n));
    Firing.FemaleFasted(n).STEPS_25pA = importFIRING(steps25pA_filepath, Firing.FemaleFasted(1).tableRange.Tab_Names(n), Firing.FemaleFasted(1).tableRange.StepRange(n));
end

clear n s name file_path opto_name optostim_filepath optotest_filepath steps25pA_filepath

save Firing_LH2VTA;