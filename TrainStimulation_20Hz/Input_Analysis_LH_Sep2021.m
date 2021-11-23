%{
This script was used to analyze the PPR data with intervals of 25ms, 50ms,
100ms, 200ms, 500ms, 1s, and 5s; and the TRAIN data of 5Hz, 10Hz, and 20Hz
stimulations (1 second in duration).

Originaly the PPR and TRAIN analysis were in separate MatLab scripts, but
it became more straightforward to merge them into one analysis. The reason
for this is that any cell with a peak current amplitude, in the first
peak, greater than -50pA (i.e. -51 and greater) in either the 25ms interval
PPR stimulation or the 5Hz TRAIN stimulation was excluded from the final
table and analysis. In order to do this, I need to go back and forth
between the PPR and TRAIN data, hence it was easier to converge the
analysis. However, these analyses can be viewed separately as
Analyze_PPR_25msto5s.m and Analyze_train_5to20Hz.m.

Only the 20Hz train stimulation data was in the publication. I saw a
similar effect at all three frequencies, but 20Hz seemed to be more
consistent with protocols that other labs use.
%}

%% Select directory and name input
addpath('/Users/nathansmac/Documents/MATLAB/MATLAB/');
addpath('/Users/nathansmac/Documents/MATLAB/MATLAB/Trains_InputStrength/')

cd /Users/nathansmac/Documents/MATLAB/MATLAB/Trains_InputStrength/  % Take me to the directory of my matlab scripts and functions

neural_input = 'LH'; % I've already specified them here
foldername = [neural_input '_input'];
filename = [neural_input '_input.mat'];
file_path = ['/Users/nathansmac/Desktop/VTA_INPUTS/TRAIN_PPR/' foldername];

cd(file_path);

%% For finding peaks and calculting the PPR for intervals of 25ms, 50ms, 100ms, 200ms, 500ms, 1s, and 5s. Stores data in structures.
% Male Control
[LH.MaleControl.PPR.twentyfivems] = plotephys_PPR_25ms('Male Control');
[LH.MaleControl.PPR.fiftyms] = plotephys_PPR_50ms('Male Control');
[LH.MaleControl.PPR.onehundredms] = plotephys_PPR_100ms('Male Control');
[LH.MaleControl.PPR.twohundredms] = plotephys_PPR_200ms('Male Control');
[LH.MaleControl.PPR.fivehundredms] = plotephys_PPR_500ms('Male Control');
[LH.MaleControl.PPR.ones] = plotephys_PPR_1s('Male Control');
[LH.MaleControl.PPR.fives] = plotephys_PPR_5s('Male Control');
save (filename, '-v7.3') 

% Male Fasted
[LH.MaleFasted.PPR.twentyfivems] = plotephys_PPR_25ms('Male Fasted');
[LH.MaleFasted.PPR.fiftyms] = plotephys_PPR_50ms('Male Fasted');
[LH.MaleFasted.PPR.onehundredms] = plotephys_PPR_100ms('Male Fasted');
[LH.MaleFasted.PPR.twohundredms] = plotephys_PPR_200ms('Male Fasted');
[LH.MaleFasted.PPR.fivehundredms] = plotephys_PPR_500ms('Male Fasted');
[LH.MaleFasted.PPR.ones] = plotephys_PPR_1s('Male Fasted');
[LH.MaleFasted.PPR.fives] = plotephys_PPR_5s('Male Fasted');
save (filename, '-v7.3') 

% Female Control
[LH.FemaleControl.PPR.twentyfivems] = plotephys_PPR_25ms('Female Control');
[LH.FemaleControl.PPR.fiftyms] = plotephys_PPR_50ms('Female Control');
[LH.FemaleControl.PPR.onehundredms] = plotephys_PPR_100ms('Female Control');
[LH.FemaleControl.PPR.twohundredms] = plotephys_PPR_200ms('Female Control');
[LH.FemaleControl.PPR.fivehundredms] = plotephys_PPR_500ms('Female Control');
[LH.FemaleControl.PPR.ones] = plotephys_PPR_1s('Female Control');
[LH.FemaleControl.PPR.fives] = plotephys_PPR_5s('Female Control');
save (filename, '-v7.3') 

% Female Fasted
[LH.FemaleFasted.PPR.twentyfivems] = plotephys_PPR_25ms('Female Fasted');
[LH.FemaleFasted.PPR.fiftyms] = plotephys_PPR_50ms('Female Fasted');
[LH.FemaleFasted.PPR.onehundredms] = plotephys_PPR_100ms('Female Fasted');
[LH.FemaleFasted.PPR.twohundredms] = plotephys_PPR_200ms('Female Fasted');
[LH.FemaleFasted.PPR.fivehundredms] = plotephys_PPR_500ms('Female Fasted');
[LH.FemaleFasted.PPR.ones] = plotephys_PPR_1s('Female Fasted');
[LH.FemaleFasted.PPR.fives] = plotephys_PPR_5s('Female Fasted');
save (filename, '-v7.3') 

%% For finding peak amplitudes of train stimulation data
% All compared to the same baseline

% Male Control
[LH.MaleControl.TRAIN.fiveHz] = plotephys_5Hz('Male Control');
[LH.MaleControl.TRAIN.tenHz] = plotephys_10Hz('Male Control');
[LH.MaleControl.TRAIN.twentyHz] = plotephys_20Hz('Male Control');
save (filename, '-v7.3') 

% Male Fasted
[LH.MaleFasted.TRAIN.fiveHz] = plotephys_5Hz('Male Fasted');
[LH.MaleFasted.TRAIN.tenHz] = plotephys_10Hz('Male Fasted');
[LH.MaleFasted.TRAIN.twentyHz] = plotephys_20Hz('Male Fasted');
save (filename, '-v7.3') 

% Female Control
[LH.FemaleControl.TRAIN.fiveHz] = plotephys_5Hz('Female Control');
[LH.FemaleControl.TRAIN.tenHz] = plotephys_10Hz('Female Control');
[LH.FemaleControl.TRAIN.twentyHz] = plotephys_20Hz('Female Control');
save (filename, '-v7.3') 

% Female Fasted
[LH.FemaleFasted.TRAIN.fiveHz] = plotephys_5Hz('Female Fasted');
[LH.FemaleFasted.TRAIN.tenHz] = plotephys_10Hz('Female Fasted');
[LH.FemaleFasted.TRAIN.twentyHz] = plotephys_20Hz('Female Fasted');
save (filename, '-v7.3')


%% Calculate the PPR from TRAIN data

% Male Control
[LH.MaleControl.TRAIN.fiveHz] = PPR_train(LH.MaleControl.TRAIN.fiveHz,'5Hz');
[LH.MaleControl.TRAIN.tenHz] = PPR_train(LH.MaleControl.TRAIN.tenHz,'10Hz');
[LH.MaleControl.TRAIN.twentyHz] = PPR_train(LH.MaleControl.TRAIN.twentyHz,'20Hz');

% Male Fasted
[LH.MaleFasted.TRAIN.fiveHz] = PPR_train(LH.MaleFasted.TRAIN.fiveHz,'5Hz');
[LH.MaleFasted.TRAIN.tenHz] = PPR_train(LH.MaleFasted.TRAIN.tenHz,'10Hz');
[LH.MaleFasted.TRAIN.twentyHz] = PPR_train(LH.MaleFasted.TRAIN.twentyHz,'20Hz');

% Female Control
[LH.FemaleControl.TRAIN.fiveHz] = PPR_train(LH.FemaleControl.TRAIN.fiveHz,'5Hz');
[LH.FemaleControl.TRAIN.tenHz] = PPR_train(LH.FemaleControl.TRAIN.tenHz,'10Hz');
[LH.FemaleControl.TRAIN.twentyHz] = PPR_train(LH.FemaleControl.TRAIN.twentyHz,'20Hz');

% Female Fasted
[LH.FemaleFasted.TRAIN.fiveHz] = PPR_train(LH.FemaleFasted.TRAIN.fiveHz,'5Hz');
[LH.FemaleFasted.TRAIN.tenHz] = PPR_train(LH.FemaleFasted.TRAIN.tenHz,'10Hz');
[LH.FemaleFasted.TRAIN.twentyHz] = PPR_train(LH.FemaleFasted.TRAIN.twentyHz,'20Hz');

save (filename, '-v7.3') 
%% Name cells
% These cell names are copy and pasted from the excel file called
% For the LH I just wrote them straight in here.
% Inventory.xlsx

% Naming PPR data

MaleControl_names = {'C1S1R'; 'C1S1L'; 'C2S1L'; 'C1S2R'; 'C2S2R'; 'C1S1L';
    'C2S1L'; 'C3S1L'; 'C4S1L'; 'C2S1R'; 'C1S2L'; 'C1S2L'; 'C2S2L'; 'C3S2L';
    'C1S1R'; 'C2S1R'; 'C3S1R'; 'C4S1R'; 'C2S1L'; 'C4S1L'; 'C1S1R'; 'C2S1R';
    'C1S2L'; 'C2S2L'; 'C3S2L'; 'C1S2R'; 'C2S2R'};
for n = 1:length(LH.MaleControl.PPR.twentyfivems)
    LH.MaleControl.PPR.twentyfivems(n).acq = LH.MaleControl.PPR.fiftyms(n).name;
    LH.MaleControl.PPR.twentyfivems(n).name = MaleControl_names(n);    
    
    LH.MaleControl.PPR.fiftyms(n).acq = LH.MaleControl.PPR.fiftyms(n).name;
    LH.MaleControl.PPR.fiftyms(n).name = MaleControl_names(n);
    
    LH.MaleControl.PPR.onehundredms(n).acq = LH.MaleControl.PPR.onehundredms(n).name;
    LH.MaleControl.PPR.onehundredms(n).name = MaleControl_names(n);
    
    LH.MaleControl.PPR.twohundredms(n).acq = LH.MaleControl.PPR.twohundredms(n).name;
    LH.MaleControl.PPR.twohundredms(n).name = MaleControl_names(n);
    
    LH.MaleControl.PPR.fivehundredms(n).acq = LH.MaleControl.PPR.fivehundredms(n).name;
    LH.MaleControl.PPR.fivehundredms(n).name = MaleControl_names(n);
    
    LH.MaleControl.PPR.ones(n).acq = LH.MaleControl.PPR.ones(n).name;
    LH.MaleControl.PPR.ones(n).name = MaleControl_names(n);
    
    LH.MaleControl.PPR.fives(n).acq = LH.MaleControl.PPR.fives(n).name;
    LH.MaleControl.PPR.fives(n).name = MaleControl_names(n);
end

MaleFasted_names = {'C1S1L'; 'C2S1L'; 'C3S1L'; 'C4S1L'; 'C1S1R'; 'C1S2R';
    'C2S2R'; 'C1S2L'; 'C2S2L'; 'C3S2L'; 'C1S2R'; 'C3S2R'; 'C4S2R'; 'C1S1L';
    'C3S1L'; 'C1S1R'; 'C2S1R'; 'C3S1R'; 'C4S1R'; 'C1S2L'; 'C2S2L'; 'C1S1L';
    'C1S1R'; 'C1S1L'; 'C2S1L'; 'C3S1L'; 'C4S1L'; 'C5S1L'; 'C2S1L'};
for n = 1:length(LH.MaleFasted.PPR.twentyfivems)
    LH.MaleFasted.PPR.twentyfivems(n).acq = LH.MaleFasted.PPR.fiftyms(n).name;
    LH.MaleFasted.PPR.twentyfivems(n).name = MaleFasted_names(n);    

    LH.MaleFasted.PPR.fiftyms(n).acq = LH.MaleFasted.PPR.fiftyms(n).name;
    LH.MaleFasted.PPR.fiftyms(n).name = MaleFasted_names(n);
    
    LH.MaleFasted.PPR.onehundredms(n).acq = LH.MaleFasted.PPR.onehundredms(n).name;
    LH.MaleFasted.PPR.onehundredms(n).name = MaleFasted_names(n);
    
    LH.MaleFasted.PPR.twohundredms(n).acq = LH.MaleFasted.PPR.twohundredms(n).name;
    LH.MaleFasted.PPR.twohundredms(n).name = MaleFasted_names(n);
    
    LH.MaleFasted.PPR.fivehundredms(n).acq = LH.MaleFasted.PPR.fivehundredms(n).name;
    LH.MaleFasted.PPR.fivehundredms(n).name = MaleFasted_names(n);
    
    LH.MaleFasted.PPR.ones(n).acq = LH.MaleFasted.PPR.ones(n).name;
    LH.MaleFasted.PPR.ones(n).name = MaleFasted_names(n);
    
    LH.MaleFasted.PPR.fives(n).acq = LH.MaleFasted.PPR.fives(n).name;
    LH.MaleFasted.PPR.fives(n).name = MaleFasted_names(n);
end

FemaleControl_names = {'C1S1L'; 'C1S1R'; 'C2S1R'; 'C3S1R'; 'C5S1R'; 'C6S1R';
    'C3S1L'; 'C4S1L'; 'C2S1R'; 'C3S1R'; 'C4S1R'; 'C5S1R'; 'C1S1R'; 'C2S1R';
    'C3S1R'; 'C4S1R'; 'C1S1R'; 'C2S1R'; 'C3S1R'; 'C2S1L'; 'C2S2L'; 'C3S2L';
    'C5S2L'; 'C2S2R'; 'C1S1L'};
for n = 1:length(LH.FemaleControl.PPR.twentyfivems)
    LH.FemaleControl.PPR.twentyfivems(n).acq = LH.FemaleControl.PPR.fiftyms(n).name;
    LH.FemaleControl.PPR.twentyfivems(n).name = FemaleControl_names(n);

    LH.FemaleControl.PPR.fiftyms(n).acq = LH.FemaleControl.PPR.fiftyms(n).name;
    LH.FemaleControl.PPR.fiftyms(n).name = FemaleControl_names(n);
    
    LH.FemaleControl.PPR.onehundredms(n).acq = LH.FemaleControl.PPR.onehundredms(n).name;
    LH.FemaleControl.PPR.onehundredms(n).name = FemaleControl_names(n);
    
    LH.FemaleControl.PPR.twohundredms(n).acq = LH.FemaleControl.PPR.twohundredms(n).name;
    LH.FemaleControl.PPR.twohundredms(n).name = FemaleControl_names(n);
    
    LH.FemaleControl.PPR.fivehundredms(n).acq = LH.FemaleControl.PPR.fivehundredms(n).name;
    LH.FemaleControl.PPR.fivehundredms(n).name = FemaleControl_names(n);
    
    LH.FemaleControl.PPR.ones(n).acq = LH.FemaleControl.PPR.ones(n).name;
    LH.FemaleControl.PPR.ones(n).name = FemaleControl_names(n);
    
    LH.FemaleControl.PPR.fives(n).acq = LH.FemaleControl.PPR.fives(n).name;
    LH.FemaleControl.PPR.fives(n).name = FemaleControl_names(n);
end

FemaleFasted_names = {'C3S2L'; 'C1S1L'; 'C2S1L'; 'C3S1L'; 'C4S1L'; 'C1S1L';
    'C2S1L'; 'C3S1L'; 'C4S1L'; 'C1S2R'; 'C2S2R'; 'C1S2L'; 'C1S1R'; 'C2S1R';
    'C3S1R'; 'C1S1L'; 'C1S2R'; 'C2S2R'; 'C1S1L'; 'C3S1L'; 'C4S1L'; 'C5S1L';
    'C2S1R'; 'C4S1R'; 'C1S2R'; 'C3S2R'; 'C1S2L'; 'C1S1L'; 'C2S1R'; 'C3S1R'};
for n = 1:length(LH.FemaleFasted.PPR.twentyfivems)
    LH.FemaleFasted.PPR.twentyfivems(n).acq = LH.FemaleFasted.PPR.fiftyms(n).name;
    LH.FemaleFasted.PPR.twentyfivems(n).name = FemaleFasted_names(n);

    LH.FemaleFasted.PPR.fiftyms(n).acq = LH.FemaleFasted.PPR.fiftyms(n).name;
    LH.FemaleFasted.PPR.fiftyms(n).name = FemaleFasted_names(n);
    
    LH.FemaleFasted.PPR.onehundredms(n).acq = LH.FemaleFasted.PPR.onehundredms(n).name;
    LH.FemaleFasted.PPR.onehundredms(n).name = FemaleFasted_names(n);
    
    LH.FemaleFasted.PPR.twohundredms(n).acq = LH.FemaleFasted.PPR.twohundredms(n).name;
    LH.FemaleFasted.PPR.twohundredms(n).name = FemaleFasted_names(n);
    
    LH.FemaleFasted.PPR.fivehundredms(n).acq = LH.FemaleFasted.PPR.fivehundredms(n).name;
    LH.FemaleFasted.PPR.fivehundredms(n).name = FemaleFasted_names(n);
    
    LH.FemaleFasted.PPR.ones(n).acq = LH.FemaleFasted.PPR.ones(n).name;
    LH.FemaleFasted.PPR.ones(n).name = FemaleFasted_names(n);
    
    LH.FemaleFasted.PPR.fives(n).acq = LH.FemaleFasted.PPR.fives(n).name;
    LH.FemaleFasted.PPR.fives(n).name = FemaleFasted_names(n);
end


% Naming Train data

% Male Control
for n = 1:length(LH.MaleControl.TRAIN.fiveHz)
    LH.MaleControl.TRAIN.fiveHz(n).acq = LH.MaleControl.TRAIN.fiveHz(n).name;
    LH.MaleControl.TRAIN.fiveHz(n).name = MaleControl_names(n);
    LH.MaleControl.TRAIN.tenHz(n).acq = LH.MaleControl.TRAIN.tenHz(n).name;
    LH.MaleControl.TRAIN.twentyHz(n).acq = LH.MaleControl.TRAIN.twentyHz(n).name;
    LH.MaleControl.TRAIN.tenHz(n).name = MaleControl_names(n);
    LH.MaleControl.TRAIN.twentyHz(n).name = MaleControl_names(n);
end

% Male Fasted
for n = 1:length(LH.MaleFasted.TRAIN.fiveHz)
    LH.MaleFasted.TRAIN.fiveHz(n).acq = LH.MaleFasted.TRAIN.fiveHz(n).name;
    LH.MaleFasted.TRAIN.fiveHz(n).name = MaleFasted_names(n);
    LH.MaleFasted.TRAIN.tenHz(n).acq = LH.MaleFasted.TRAIN.tenHz(n).name;
    LH.MaleFasted.TRAIN.twentyHz(n).acq = LH.MaleFasted.TRAIN.twentyHz(n).name;
    LH.MaleFasted.TRAIN.tenHz(n).name = MaleFasted_names(n);
    LH.MaleFasted.TRAIN.twentyHz(n).name = MaleFasted_names(n);
end

% Female Control
for n = 1:length(LH.FemaleControl.TRAIN.fiveHz)
    LH.FemaleControl.TRAIN.fiveHz(n).acq = LH.FemaleControl.TRAIN.fiveHz(n).name;
    LH.FemaleControl.TRAIN.fiveHz(n).name = FemaleControl_names(n);
    LH.FemaleControl.TRAIN.tenHz(n).acq = LH.FemaleControl.TRAIN.tenHz(n).name;
    LH.FemaleControl.TRAIN.twentyHz(n).acq = LH.FemaleControl.TRAIN.twentyHz(n).name;
    LH.FemaleControl.TRAIN.tenHz(n).name = FemaleControl_names(n);
    LH.FemaleControl.TRAIN.twentyHz(n).name = FemaleControl_names(n);
end

% Female Fasted
for n = 1:length(LH.FemaleFasted.TRAIN.fiveHz)
    LH.FemaleFasted.TRAIN.fiveHz(n).acq = LH.FemaleFasted.TRAIN.fiveHz(n).name;
    LH.FemaleFasted.TRAIN.fiveHz(n).name = FemaleFasted_names(n);
    LH.FemaleFasted.TRAIN.tenHz(n).acq = LH.FemaleFasted.TRAIN.tenHz(n).name;
    LH.FemaleFasted.TRAIN.twentyHz(n).acq = LH.FemaleFasted.TRAIN.twentyHz(n).name;
    LH.FemaleFasted.TRAIN.tenHz(n).name = FemaleFasted_names(n);
    LH.FemaleFasted.TRAIN.twentyHz(n).name = FemaleFasted_names(n);
end

clear MaleControl_names MaleFasted_names FemaleControl_names FemaleFasted_names n; 

save (filename, '-v7.3') 
%% Creating logical arrays for greater than -50 pA

% Male Control
Greater_50_PPR = [];
Greater_50_TRAIN = [];
for n = 1:length(LH.MaleControl.PPR.twentyfivems)
    Greater_50_PPR = [Greater_50_PPR; LH.MaleControl.PPR.twentyfivems(n).peakAmplitude(1) < -50];
    Greater_50_TRAIN = [Greater_50_TRAIN; LH.MaleControl.TRAIN.fiveHz(n).peakAmplitude(1) < -50];
end

LH.MaleControl.greater50 = Greater_50_PPR == logical(1) & Greater_50_TRAIN == logical(1);

% Male Fasted
Greater_50_PPR = [];
Greater_50_TRAIN = [];
for n = 1:length(LH.MaleFasted.PPR.twentyfivems)
    Greater_50_PPR = [Greater_50_PPR; LH.MaleFasted.PPR.twentyfivems(n).peakAmplitude(1) < -50];
    Greater_50_TRAIN = [Greater_50_TRAIN; LH.MaleFasted.TRAIN.fiveHz(n).peakAmplitude(1) < -50];
end

LH.MaleFasted.greater50 = Greater_50_PPR == logical(1) & Greater_50_TRAIN == logical(1);

% Female Control
Greater_50_PPR = [];
Greater_50_TRAIN = [];
for n = 1:length(LH.FemaleControl.PPR.twentyfivems)
    Greater_50_PPR = [Greater_50_PPR; LH.FemaleControl.PPR.twentyfivems(n).peakAmplitude(1) < -50];
    Greater_50_TRAIN = [Greater_50_TRAIN; LH.FemaleControl.TRAIN.fiveHz(n).peakAmplitude(1) < -50];
end

LH.FemaleControl.greater50 = Greater_50_PPR == logical(1) & Greater_50_TRAIN == logical(1);

% Female Fasted
Greater_50_PPR = [];
Greater_50_TRAIN = [];
for n = 1:length(LH.FemaleFasted.PPR.twentyfivems)
    Greater_50_PPR = [Greater_50_PPR; LH.FemaleFasted.PPR.twentyfivems(n).peakAmplitude(1) < -50];
    Greater_50_TRAIN = [Greater_50_TRAIN; LH.FemaleFasted.TRAIN.fiveHz(n).peakAmplitude(1) < -50];
end

LH.FemaleFasted.greater50 = Greater_50_PPR == logical(1) & Greater_50_TRAIN == logical(1);

clear n Greater_50_PPR Greater_50_TRAIN
save (filename, '-v7.3') 

%% Creating matrix of PPR data to be converted to table
% Use greater50 logical array to do this.

% Male Control
MC_PPR_PPR = {};
for n = 1:length(LH.MaleControl.TRAIN.fiveHz)
    MC_PPR_PPR(n,1) = {'Male Control'};
    MC_PPR_PPR(n,2) = {LH.MaleControl.TRAIN.fiveHz(n).name};
    MC_PPR_PPR(n,3) = {LH.MaleControl.TRAIN.fiveHz(n).acq};
    MC_PPR_PPR(n,4) = {LH.MaleControl.PPR.twentyfivems(n).PPR};
    MC_PPR_PPR(n,5) = {LH.MaleControl.PPR.fiftyms(n).PPR};
    MC_PPR_PPR(n,6) = {LH.MaleControl.PPR.onehundredms(n).PPR};
    MC_PPR_PPR(n,7) = {LH.MaleControl.PPR.twohundredms(n).PPR};
    MC_PPR_PPR(n,8) = {LH.MaleControl.PPR.fivehundredms(n).PPR};
    MC_PPR_PPR(n,9) = {LH.MaleControl.PPR.ones(n).PPR};
    MC_PPR_PPR(n,10) = {LH.MaleControl.PPR.fives(n).PPR};
end
MC_PPR_PPR = MC_PPR_PPR(LH.MaleControl.greater50,:);

% Male Fasted
MF_PPR_PPR = {};
for n = 1:length(LH.MaleFasted.TRAIN.fiveHz)
    MF_PPR_PPR(n,1) = {'Male Fasted'};
    MF_PPR_PPR(n,2) = {LH.MaleFasted.TRAIN.fiveHz(n).name};
    MF_PPR_PPR(n,3) = {LH.MaleFasted.TRAIN.fiveHz(n).acq};
    MF_PPR_PPR(n,4) = {LH.MaleFasted.PPR.twentyfivems(n).PPR};
    MF_PPR_PPR(n,5) = {LH.MaleFasted.PPR.fiftyms(n).PPR};
    MF_PPR_PPR(n,6) = {LH.MaleFasted.PPR.onehundredms(n).PPR};
    MF_PPR_PPR(n,7) = {LH.MaleFasted.PPR.twohundredms(n).PPR};
    MF_PPR_PPR(n,8) = {LH.MaleFasted.PPR.fivehundredms(n).PPR};
    MF_PPR_PPR(n,9) = {LH.MaleFasted.PPR.ones(n).PPR};
    MF_PPR_PPR(n,10) = {LH.MaleFasted.PPR.fives(n).PPR};
end
MF_PPR_PPR = MF_PPR_PPR(LH.MaleFasted.greater50,:);

% Female Control
FC_PPR_PPR = {};
for n = 1:length(LH.FemaleControl.TRAIN.fiveHz)
    FC_PPR_PPR(n,1) = {'Female Control'};
    FC_PPR_PPR(n,2) = {LH.FemaleControl.TRAIN.fiveHz(n).name};
    FC_PPR_PPR(n,3) = {LH.FemaleControl.TRAIN.fiveHz(n).acq};
    FC_PPR_PPR(n,4) = {LH.FemaleControl.PPR.twentyfivems(n).PPR};
    FC_PPR_PPR(n,5) = {LH.FemaleControl.PPR.fiftyms(n).PPR};
    FC_PPR_PPR(n,6) = {LH.FemaleControl.PPR.onehundredms(n).PPR};
    FC_PPR_PPR(n,7) = {LH.FemaleControl.PPR.twohundredms(n).PPR};
    FC_PPR_PPR(n,8) = {LH.FemaleControl.PPR.fivehundredms(n).PPR};
    FC_PPR_PPR(n,9) = {LH.FemaleControl.PPR.ones(n).PPR};
    FC_PPR_PPR(n,10) = {LH.FemaleControl.PPR.fives(n).PPR};
end
FC_PPR_PPR = FC_PPR_PPR(LH.FemaleControl.greater50,:);

% Female Fasted
FF_PPR_PPR = {};
for n = 1:length(LH.FemaleFasted.TRAIN.fiveHz)
    FF_PPR_PPR(n,1) = {'Female Fasted'};
    FF_PPR_PPR(n,2) = {LH.FemaleFasted.TRAIN.fiveHz(n).name};
    FF_PPR_PPR(n,3) = {LH.FemaleFasted.TRAIN.fiveHz(n).acq};
    FF_PPR_PPR(n,4) = {LH.FemaleFasted.PPR.twentyfivems(n).PPR};
    FF_PPR_PPR(n,5) = {LH.FemaleFasted.PPR.fiftyms(n).PPR};
    FF_PPR_PPR(n,6) = {LH.FemaleFasted.PPR.onehundredms(n).PPR};
    FF_PPR_PPR(n,7) = {LH.FemaleFasted.PPR.twohundredms(n).PPR};
    FF_PPR_PPR(n,8) = {LH.FemaleFasted.PPR.fivehundredms(n).PPR};
    FF_PPR_PPR(n,9) = {LH.FemaleFasted.PPR.ones(n).PPR};
    FF_PPR_PPR(n,10) = {LH.FemaleFasted.PPR.fives(n).PPR};
end
FF_PPR_PPR = FF_PPR_PPR(LH.FemaleFasted.greater50,:);
%% Creating matrix of TRAIN data to be converted to table
% Use greater50 logical array to do this.

% Male Control
MC_5Hz_PPR = {};
for n = 1:length(LH.MaleControl.TRAIN.fiveHz)
    MC_5Hz_PPR(n,1) = {'Male Control'};
    MC_5Hz_PPR(n,2) = {'5 Hz'};
    MC_5Hz_PPR(n,3) = {LH.MaleControl.TRAIN.fiveHz(n).name};
    MC_5Hz_PPR(n,4) = {LH.MaleControl.TRAIN.fiveHz(n).acq};
    for m = 1:length(LH.MaleControl.TRAIN.fiveHz(n).PPR) - 1
        MC_5Hz_PPR(n,4+m) = {LH.MaleControl.TRAIN.fiveHz(n).PPR(m + 1)}; % Will be from 4 to 7
    end
end
MC_5Hz_PPR = MC_5Hz_PPR(LH.MaleControl.greater50,:);

MC_10Hz_PPR = {};
for n = 1:length(LH.MaleControl.TRAIN.tenHz)
    MC_10Hz_PPR(n,1) = {'Male Control'};
    MC_10Hz_PPR(n,2) = {'10 Hz'};
    MC_10Hz_PPR(n,3) = {LH.MaleControl.TRAIN.tenHz(n).name};
    MC_10Hz_PPR(n,4) = {LH.MaleControl.TRAIN.tenHz(n).acq};
    for m = 1:length(LH.MaleControl.TRAIN.tenHz(n).PPR) - 1
        MC_10Hz_PPR(n,4+m) = {LH.MaleControl.TRAIN.tenHz(n).PPR(m + 1)}; % Will be from 4 to 7
    end
end
MC_10Hz_PPR = MC_10Hz_PPR(LH.MaleControl.greater50,:);

MC_20Hz_PPR = {};
for n = 1:length(LH.MaleControl.TRAIN.twentyHz)
    MC_20Hz_PPR(n,1) = {'Male Control'};
    MC_20Hz_PPR(n,2) = {'20 Hz'};
    MC_20Hz_PPR(n,3) = {LH.MaleControl.TRAIN.twentyHz(n).name};
    MC_20Hz_PPR(n,4) = {LH.MaleControl.TRAIN.twentyHz(n).acq};
    for m = 1:length(LH.MaleControl.TRAIN.twentyHz(n).PPR) - 1
        MC_20Hz_PPR(n,4+m) = {LH.MaleControl.TRAIN.twentyHz(n).PPR(m + 1)}; % Will be from 4 to 7
    end
end
MC_20Hz_PPR = MC_20Hz_PPR(LH.MaleControl.greater50,:);


% Male Fasted
MF_5Hz_PPR = {};
for n = 1:length(LH.MaleFasted.TRAIN.fiveHz)
    MF_5Hz_PPR(n,1) = {'Male Fasted'};
    MF_5Hz_PPR(n,2) = {'5 Hz'};
    MF_5Hz_PPR(n,3) = {LH.MaleFasted.TRAIN.fiveHz(n).name};
    MF_5Hz_PPR(n,4) = {LH.MaleFasted.TRAIN.fiveHz(n).acq};
    for m = 1:length(LH.MaleFasted.TRAIN.fiveHz(n).PPR) - 1
        MF_5Hz_PPR(n,4+m) = {LH.MaleFasted.TRAIN.fiveHz(n).PPR(m + 1)}; % Will be from 4 to 7
    end
end
MF_5Hz_PPR = MF_5Hz_PPR(LH.MaleFasted.greater50,:);

MF_10Hz_PPR = {};
for n = 1:length(LH.MaleFasted.TRAIN.tenHz)
    MF_10Hz_PPR(n,1) = {'Male Fasted'};
    MF_10Hz_PPR(n,2) = {'10 Hz'};
    MF_10Hz_PPR(n,3) = {LH.MaleFasted.TRAIN.tenHz(n).name};
    MF_10Hz_PPR(n,4) = {LH.MaleFasted.TRAIN.tenHz(n).acq};
    for m = 1:length(LH.MaleFasted.TRAIN.tenHz(n).PPR) - 1
        MF_10Hz_PPR(n,4+m) = {LH.MaleFasted.TRAIN.tenHz(n).PPR(m + 1)}; % Will be from 4 to 7
    end
end
MF_10Hz_PPR = MF_10Hz_PPR(LH.MaleFasted.greater50,:);

MF_20Hz_PPR = {};
for n = 1:length(LH.MaleFasted.TRAIN.twentyHz)
    MF_20Hz_PPR(n,1) = {'Male Fasted'};
    MF_20Hz_PPR(n,2) = {'20 Hz'};
    MF_20Hz_PPR(n,3) = {LH.MaleFasted.TRAIN.twentyHz(n).name};
    MF_20Hz_PPR(n,4) = {LH.MaleFasted.TRAIN.twentyHz(n).acq};
    for m = 1:length(LH.MaleFasted.TRAIN.twentyHz(n).PPR) - 1
        MF_20Hz_PPR(n,4+m) = {LH.MaleFasted.TRAIN.twentyHz(n).PPR(m + 1)}; % Will be from 4 to 7
    end
end
MF_20Hz_PPR = MF_20Hz_PPR(LH.MaleFasted.greater50,:);


% Female Control
FC_5Hz_PPR = {};
for n = 1:length(LH.FemaleControl.TRAIN.fiveHz)
    FC_5Hz_PPR(n,1) = {'Female Control'};
    FC_5Hz_PPR(n,2) = {'5 Hz'};
    FC_5Hz_PPR(n,3) = {LH.FemaleControl.TRAIN.fiveHz(n).name};
    FC_5Hz_PPR(n,4) = {LH.FemaleControl.TRAIN.fiveHz(n).acq};
    for m = 1:length(LH.FemaleControl.TRAIN.fiveHz(n).PPR) - 1
        FC_5Hz_PPR(n,4+m) = {LH.FemaleControl.TRAIN.fiveHz(n).PPR(m + 1)}; % Will be from 4 to 7
    end
end
FC_5Hz_PPR = FC_5Hz_PPR(LH.FemaleControl.greater50,:);

FC_10Hz_PPR = {};
for n = 1:length(LH.FemaleControl.TRAIN.tenHz)
    FC_10Hz_PPR(n,1) = {'Female Control'};
    FC_10Hz_PPR(n,2) = {'10 Hz'};
    FC_10Hz_PPR(n,3) = {LH.FemaleControl.TRAIN.tenHz(n).name};
    FC_10Hz_PPR(n,4) = {LH.FemaleControl.TRAIN.tenHz(n).acq};
    for m = 1:length(LH.FemaleControl.TRAIN.tenHz(n).PPR) - 1
        FC_10Hz_PPR(n,4+m) = {LH.FemaleControl.TRAIN.tenHz(n).PPR(m + 1)}; % Will be from 4 to 7
    end
end
FC_10Hz_PPR = FC_10Hz_PPR(LH.FemaleControl.greater50,:);

FC_20Hz_PPR = {};
for n = 1:length(LH.FemaleControl.TRAIN.twentyHz)
    FC_20Hz_PPR(n,1) = {'Female Control'};
    FC_20Hz_PPR(n,2) = {'20 Hz'};
    FC_20Hz_PPR(n,3) = {LH.FemaleControl.TRAIN.twentyHz(n).name};
    FC_20Hz_PPR(n,4) = {LH.FemaleControl.TRAIN.twentyHz(n).acq};
    for m = 1:length(LH.FemaleControl.TRAIN.twentyHz(n).PPR) - 1
        FC_20Hz_PPR(n,4+m) = {LH.FemaleControl.TRAIN.twentyHz(n).PPR(m + 1)}; % Will be from 4 to 7
    end
end
FC_20Hz_PPR = FC_20Hz_PPR(LH.FemaleControl.greater50,:);


% Female Fasted
FF_5Hz_PPR = {};
for n = 1:length(LH.FemaleFasted.TRAIN.fiveHz)
    FF_5Hz_PPR(n,1) = {'Female Fasted'};
    FF_5Hz_PPR(n,2) = {'5 Hz'};
    FF_5Hz_PPR(n,3) = {LH.FemaleFasted.TRAIN.fiveHz(n).name};
    FF_5Hz_PPR(n,4) = {LH.FemaleFasted.TRAIN.fiveHz(n).acq};
    for m = 1:length(LH.FemaleFasted.TRAIN.fiveHz(n).PPR) - 1
        FF_5Hz_PPR(n,4+m) = {LH.FemaleFasted.TRAIN.fiveHz(n).PPR(m + 1)}; % Will be from 4 to 7
    end
end
FF_5Hz_PPR = FF_5Hz_PPR(LH.FemaleFasted.greater50,:);

FF_10Hz_PPR = {};
for n = 1:length(LH.FemaleFasted.TRAIN.tenHz)
    FF_10Hz_PPR(n,1) = {'Female Fasted'};
    FF_10Hz_PPR(n,2) = {'10 Hz'};
    FF_10Hz_PPR(n,3) = {LH.FemaleFasted.TRAIN.tenHz(n).name};
    FF_10Hz_PPR(n,4) = {LH.FemaleFasted.TRAIN.tenHz(n).acq};
    for m = 1:length(LH.FemaleFasted.TRAIN.tenHz(n).PPR) - 1
        FF_10Hz_PPR(n,4+m) = {LH.FemaleFasted.TRAIN.tenHz(n).PPR(m + 1)}; % Will be from 4 to 7
    end
end
FF_10Hz_PPR = FF_10Hz_PPR(LH.FemaleFasted.greater50,:);

FF_20Hz_PPR = {};
for n = 1:length(LH.FemaleFasted.TRAIN.twentyHz)
    FF_20Hz_PPR(n,1) = {'Female Fasted'};
    FF_20Hz_PPR(n,2) = {'20 Hz'};
    FF_20Hz_PPR(n,3) = {LH.FemaleFasted.TRAIN.twentyHz(n).name};
    FF_20Hz_PPR(n,4) = {LH.FemaleFasted.TRAIN.twentyHz(n).acq};
    for m = 1:length(LH.FemaleFasted.TRAIN.twentyHz(n).PPR) - 1
        FF_20Hz_PPR(n,4+m) = {LH.FemaleFasted.TRAIN.twentyHz(n).PPR(m + 1)}; % Will be from 4 to 7
    end
end
FF_20Hz_PPR = FF_20Hz_PPR(LH.FemaleFasted.greater50,:);

%% Making a matrix containing the amptlitude of the first point on of the 5 Hz stim

% Male Control
MC_5Hz_AMP = {};
for n = 1:length(LH.MaleControl.TRAIN.fiveHz)
    MC_5Hz_AMP(n,1) = {'Male Control'};
    MC_5Hz_AMP(n,2) = {'5 Hz'};
    MC_5Hz_AMP(n,3) = {LH.MaleControl.TRAIN.fiveHz(n).name};
    MC_5Hz_AMP(n,4) = {LH.MaleControl.TRAIN.fiveHz(n).acq};
    for m = 1:length(LH.MaleControl.TRAIN.fiveHz(n).peakAmplitude)
        MC_5Hz_AMP(n,4+m) = {LH.MaleControl.TRAIN.fiveHz(n).peakAmplitude(m)};
    end
end
MC_5Hz_AMP = MC_5Hz_AMP(LH.MaleControl.greater50,:);

% Male Fasted
MF_5Hz_AMP = {};
for n = 1:length(LH.MaleFasted.TRAIN.fiveHz)
    MF_5Hz_AMP(n,1) = {'Male Fasted'};
    MF_5Hz_AMP(n,2) = {'5 Hz'};
    MF_5Hz_AMP(n,3) = {LH.MaleFasted.TRAIN.fiveHz(n).name};
    MF_5Hz_AMP(n,4) = {LH.MaleFasted.TRAIN.fiveHz(n).acq};
    for m = 1:length(LH.MaleFasted.TRAIN.fiveHz(n).peakAmplitude)
        MF_5Hz_AMP(n,4+m) = {LH.MaleFasted.TRAIN.fiveHz(n).peakAmplitude(m)};
    end
end
MF_5Hz_AMP = MF_5Hz_AMP(LH.MaleFasted.greater50,:);

% Female Control
FC_5Hz_AMP = {};
for n = 1:length(LH.FemaleControl.TRAIN.fiveHz)
    FC_5Hz_AMP(n,1) = {'Female Control'};
    FC_5Hz_AMP(n,2) = {'5 Hz'};
    FC_5Hz_AMP(n,3) = {LH.FemaleControl.TRAIN.fiveHz(n).name};
    FC_5Hz_AMP(n,4) = {LH.FemaleControl.TRAIN.fiveHz(n).acq};
    for m = 1:length(LH.FemaleControl.TRAIN.fiveHz(n).peakAmplitude)
        FC_5Hz_AMP(n,4+m) = {LH.FemaleControl.TRAIN.fiveHz(n).peakAmplitude(m)};
    end
end
FC_5Hz_AMP = FC_5Hz_AMP(LH.FemaleControl.greater50,:);

% Female Fasted
FF_5Hz_AMP = {};
for n = 1:length(LH.FemaleFasted.TRAIN.fiveHz)
    FF_5Hz_AMP(n,1) = {'Female Fasted'};
    FF_5Hz_AMP(n,2) = {'5 Hz'};
    FF_5Hz_AMP(n,3) = {LH.FemaleFasted.TRAIN.fiveHz(n).name};
    FF_5Hz_AMP(n,4) = {LH.FemaleFasted.TRAIN.fiveHz(n).acq};
    for m = 1:length(LH.FemaleFasted.TRAIN.fiveHz(n).peakAmplitude)
        FF_5Hz_AMP(n,4+m) = {LH.FemaleFasted.TRAIN.fiveHz(n).peakAmplitude(m)};
    end
end
FF_5Hz_AMP = FF_5Hz_AMP(LH.FemaleFasted.greater50,:);

%% Making a matrix containing the amptlitude of the first point on of the 10 Hz stim

% Male Control
MC_10Hz_AMP = {};
for n = 1:length(LH.MaleControl.TRAIN.tenHz)
    MC_10Hz_AMP(n,1) = {'Male Control'};
    MC_10Hz_AMP(n,2) = {'10 Hz'};
    MC_10Hz_AMP(n,3) = {LH.MaleControl.TRAIN.tenHz(n).name};
    MC_10Hz_AMP(n,4) = {LH.MaleControl.TRAIN.tenHz(n).acq};
    for m = 1:length(LH.MaleControl.TRAIN.tenHz(n).peakAmplitude)
        MC_10Hz_AMP(n,4+m) = {LH.MaleControl.TRAIN.tenHz(n).peakAmplitude(m)};
    end
end
MC_10Hz_AMP = MC_10Hz_AMP(LH.MaleControl.greater50,:);

% Male Fasted
MF_10Hz_AMP = {};
for n = 1:length(LH.MaleFasted.TRAIN.tenHz)
    MF_10Hz_AMP(n,1) = {'Male Fasted'};
    MF_10Hz_AMP(n,2) = {'10 Hz'};
    MF_10Hz_AMP(n,3) = {LH.MaleFasted.TRAIN.tenHz(n).name};
    MF_10Hz_AMP(n,4) = {LH.MaleFasted.TRAIN.tenHz(n).acq};
    for m = 1:length(LH.MaleFasted.TRAIN.tenHz(n).peakAmplitude)
        MF_10Hz_AMP(n,4+m) = {LH.MaleFasted.TRAIN.tenHz(n).peakAmplitude(m)};
    end
end
MF_10Hz_AMP = MF_10Hz_AMP(LH.MaleFasted.greater50,:);

% Female Control
FC_10Hz_AMP = {};
for n = 1:length(LH.FemaleControl.TRAIN.tenHz)
    FC_10Hz_AMP(n,1) = {'Female Control'};
    FC_10Hz_AMP(n,2) = {'10 Hz'};
    FC_10Hz_AMP(n,3) = {LH.FemaleControl.TRAIN.tenHz(n).name};
    FC_10Hz_AMP(n,4) = {LH.FemaleControl.TRAIN.tenHz(n).acq};
    for m = 1:length(LH.FemaleControl.TRAIN.tenHz(n).peakAmplitude)
        FC_10Hz_AMP(n,4+m) = {LH.FemaleControl.TRAIN.tenHz(n).peakAmplitude(m)};
    end
end
FC_10Hz_AMP = FC_10Hz_AMP(LH.FemaleControl.greater50,:);

% Female Fasted
FF_10Hz_AMP = {};
for n = 1:length(LH.FemaleFasted.TRAIN.tenHz)
    FF_10Hz_AMP(n,1) = {'Female Fasted'};
    FF_10Hz_AMP(n,2) = {'10 Hz'};
    FF_10Hz_AMP(n,3) = {LH.FemaleFasted.TRAIN.tenHz(n).name};
    FF_10Hz_AMP(n,4) = {LH.FemaleFasted.TRAIN.tenHz(n).acq};
    for m = 1:length(LH.FemaleFasted.TRAIN.tenHz(n).peakAmplitude)
        FF_10Hz_AMP(n,4+m) = {LH.FemaleFasted.TRAIN.tenHz(n).peakAmplitude(m)};
    end
end
FF_10Hz_AMP = FF_10Hz_AMP(LH.FemaleFasted.greater50,:);

%% Making a matrix containing the amptlitude of the first point on of the 20 Hz stim

% Male Control
MC_20Hz_AMP = {};
for n = 1:length(LH.MaleControl.TRAIN.twentyHz)
        MC_20Hz_AMP(n,1) = {'Male Control'};
        MC_20Hz_AMP(n,2) = {'20 Hz'};
        MC_20Hz_AMP(n,3) = {LH.MaleControl.TRAIN.twentyHz(n).name};
        MC_20Hz_AMP(n,4) = {LH.MaleControl.TRAIN.twentyHz(n).acq};
    for m = 1:length(LH.MaleControl.TRAIN.twentyHz(n).peakAmplitude)
        MC_20Hz_AMP(n,4+m) = {LH.MaleControl.TRAIN.twentyHz(n).peakAmplitude(m)};
    end
end
MC_20Hz_AMP = MC_20Hz_AMP(LH.MaleControl.greater50,:);

% Male Fasted
MF_20Hz_AMP = {};
for n = 1:length(LH.MaleFasted.TRAIN.twentyHz)
        MF_20Hz_AMP(n,1) = {'Male Fasted'};
        MF_20Hz_AMP(n,2) = {'20 Hz'};
        MF_20Hz_AMP(n,3) = {LH.MaleFasted.TRAIN.twentyHz(n).name};
        MF_20Hz_AMP(n,4) = {LH.MaleFasted.TRAIN.twentyHz(n).acq};
    for m = 1:length(LH.MaleFasted.TRAIN.twentyHz(n).peakAmplitude)
        MF_20Hz_AMP(n,4+m) = {LH.MaleFasted.TRAIN.twentyHz(n).peakAmplitude(m)};
    end
end
MF_20Hz_AMP = MF_20Hz_AMP(LH.MaleFasted.greater50,:);

% Female Control
FC_20Hz_AMP = {};
for n = 1:length(LH.FemaleControl.TRAIN.twentyHz)
        FC_20Hz_AMP(n,1) = {'Female Control'};
        FC_20Hz_AMP(n,2) = {'20 Hz'};
        FC_20Hz_AMP(n,3) = {LH.FemaleControl.TRAIN.twentyHz(n).name};
        FC_20Hz_AMP(n,4) = {LH.FemaleControl.TRAIN.twentyHz(n).acq};
    for m = 1:length(LH.FemaleControl.TRAIN.twentyHz(n).peakAmplitude)
        FC_20Hz_AMP(n,4+m) = {LH.FemaleControl.TRAIN.twentyHz(n).peakAmplitude(m)};
    end
end
FC_20Hz_AMP = FC_20Hz_AMP(LH.FemaleControl.greater50,:);

% Female Fasted
FF_20Hz_AMP = {};
for n = 1:length(LH.FemaleFasted.TRAIN.twentyHz)
        FF_20Hz_AMP(n,1) = {'Female Fasted'};
        FF_20Hz_AMP(n,2) = {'20 Hz'};
        FF_20Hz_AMP(n,3) = {LH.FemaleFasted.TRAIN.twentyHz(n).name};
        FF_20Hz_AMP(n,4) = {LH.FemaleFasted.TRAIN.twentyHz(n).acq};
    for m = 1:length(LH.FemaleFasted.TRAIN.twentyHz(n).peakAmplitude)
        FF_20Hz_AMP(n,4+m) = {LH.FemaleFasted.TRAIN.twentyHz(n).peakAmplitude(m)};
    end
end
FF_20Hz_AMP = FF_20Hz_AMP(LH.FemaleFasted.greater50,:);

clear m n
%% Combining my Arrays and creating Tables

% PPR of PPR table
PPR_PPR_nan = num2cell(nan(1,width(MC_PPR_PPR)));
PPR_PPR_array = [MC_PPR_PPR; PPR_PPR_nan; MF_PPR_PPR; PPR_PPR_nan; FC_PPR_PPR; PPR_PPR_nan; FF_PPR_PPR];

LH.tables.PPR_PPR = array2table(PPR_PPR_array,'VariableNames',{'Group','Cell_Name','Acq','I_25ms','I_50ms','I_100ms','I_200ms','I_500ms','I_1000ms','I_5000ms'});

clear MC_PPR_PPR MF_PPR_PPR FC_PPR_PPR FF_PPR_PPR PPR_PPR_nan PPR_PPR_array


% TRAIN table

fiveHz_PPR_nan = num2cell(nan(1,width(MC_5Hz_PPR)));
tenHz_PPR_nan = num2cell(nan(1,width(MC_10Hz_PPR)));
twentyHz_PPR_nan = num2cell(nan(1,width(MC_20Hz_PPR)));

fiveHz_PPR_array = [MC_5Hz_PPR; fiveHz_PPR_nan; MF_5Hz_PPR; fiveHz_PPR_nan; FC_5Hz_PPR; fiveHz_PPR_nan; FF_5Hz_PPR];
tenHz_PPR_array = [MC_10Hz_PPR; tenHz_PPR_nan; MF_10Hz_PPR; tenHz_PPR_nan; FC_10Hz_PPR; tenHz_PPR_nan; FF_10Hz_PPR];
twentyHz_PPR_array = [MC_20Hz_PPR; twentyHz_PPR_nan; MF_20Hz_PPR; twentyHz_PPR_nan; FC_20Hz_PPR; twentyHz_PPR_nan; FF_20Hz_PPR];

LH.tables.fiveHz_PPR = array2table(fiveHz_PPR_array,'VariableNames',{'Group','Frequency','Cell_Name','Acq','P2','P3','P4','P5'});
LH.tables.tenHz_PPR = array2table(tenHz_PPR_array,'VariableNames',{'Group','Frequency','Cell_Name','Acq','P2','P3','P4','P5','P6','P7','P8','P9','P10'});
LH.tables.twentyHz_PPR = array2table(twentyHz_PPR_array,'VariableNames',{'Group','Frequency' 'Cell_Name','Acq','P2','P3','P4','P5','P6','P7','P8','P9','P10','P11','P12','P13','P14','P15','P16','P17','P18','P19','P20'});

clear MC_5Hz_PPR MF_5Hz_PPR FC_5Hz_PPR FF_5Hz_PPR MC_10Hz_PPR MF_10Hz_PPR FC_10Hz_PPR FF_10Hz_PPR MC_20Hz_PPR MF_20Hz_PPR FC_20Hz_PPR FF_20Hz_PPR
clear fiveHz_PPR_nan tenHz_PPR_nan twentyHz_PPR_nan fiveHz_PPR_array tenHz_PPR_array twentyHz_PPR_array

% AMP 5Hz table
fiveHz_AMP_nan = num2cell(nan(1,width(MC_5Hz_AMP)));
fiveHz_AMP_array = [MC_5Hz_AMP; fiveHz_AMP_nan; MF_5Hz_AMP; fiveHz_AMP_nan; FC_5Hz_AMP; fiveHz_AMP_nan; FF_5Hz_AMP];
LH.tables.fiveHz_AMP = array2table(fiveHz_AMP_array, 'VariableNames',{'Group','Frequency','Cell_Name','Acq','P1','P2','P3','P4','P5'});

% AMP 10Hz table
tenHz_AMP_nan = num2cell(nan(1,width(MC_10Hz_AMP)));
tenHz_AMP_array = [MC_10Hz_AMP; tenHz_AMP_nan; MF_10Hz_AMP; tenHz_AMP_nan; FC_10Hz_AMP; tenHz_AMP_nan; FF_10Hz_AMP];
LH.tables.tenHz_AMP = array2table(tenHz_AMP_array, 'VariableNames',{'Group','Frequency','Cell_Name','Acq','P1','P2','P3','P4','P5','P6','P7','P8','P9','P10'});

% AMP 20Hz table
twentyHz_AMP_nan = num2cell(nan(1,width(MC_20Hz_AMP)));
twentyHz_AMP_array = [MC_20Hz_AMP; twentyHz_AMP_nan; MF_20Hz_AMP; twentyHz_AMP_nan; FC_20Hz_AMP; twentyHz_AMP_nan; FF_20Hz_AMP];
LH.tables.twentyHz_AMP = array2table(twentyHz_AMP_array, 'VariableNames',{'Group','Frequency','Cell_Name','Acq','P1','P2','P3','P4','P5','P6','P7','P8','P9','P10','P11','P12','P13','P14','P15','P16','P17','P18','P19','P20'});

clear MC_5Hz_AMP MF_5Hz_AMP FC_5Hz_AMP FF_5Hz_AMP fiveHz_AMP_array fiveHz_AMP_nan
clear MC_10Hz_AMP MF_10Hz_AMP FC_10Hz_AMP FF_10Hz_AMP tenHz_AMP_array tenHz_AMP_nan
clear MC_20Hz_AMP MF_20Hz_AMP FC_20Hz_AMP FF_20Hz_AMP twentyHz_AMP_array twentyHz_AMP_nan

cd(file_path);
save (filename, '-v7.3') 

%% Writing table to excel

writetable(LH.tables.PPR_PPR,'LH.xlsx','Sheet','PPR_PPR','Range','A1');
writetable(LH.tables.fiveHz_PPR,'LH.xlsx','Sheet','5Hz_PPR','Range','A1');
writetable(LH.tables.tenHz_PPR,'LH.xlsx','Sheet','10Hz_PPR','Range','A1');
writetable(LH.tables.twentyHz_PPR,'LH.xlsx','Sheet','20Hz_PPR','Range','A1');
writetable(LH.tables.fiveHz_AMP, 'LH.xlsx','Sheet','5Hz_Amplitude','Range','A1');
writetable(LH.tables.tenHz_AMP, 'LH.xlsx','Sheet','10Hz_Amplitude','Range','A1');
writetable(LH.tables.twentyHz_AMP, 'LH.xlsx','Sheet','20Hz_Amplitude','Range','A1');


%% Making table of the amplitudes in the PPR with a 25ms interval

% Male Control
MC_25ms_AMP = {};
for n = 1:length(LH.MaleControl.TRAIN.twentyHz)
        MC_25ms_AMP(n,1) = {'Male Control'};
        MC_25ms_AMP(n,2) = {'25 ms'};
        MC_25ms_AMP(n,3) = {LH.MaleControl.TRAIN.twentyHz(n).name};
        MC_25ms_AMP(n,4) = {LH.MaleControl.TRAIN.twentyHz(n).acq};
        MC_25ms_AMP(n,5) = {LH.MaleControl.PPR.twentyfivems(n).peakAmplitude(1)};
        MC_25ms_AMP(n,6) = {LH.MaleControl.PPR.twentyfivems(n).peakAmplitude(2)};
end
MC_25ms_AMP = MC_25ms_AMP(LH.MaleControl.greater50,:);

% Male Fasted
MF_25ms_AMP = {};
for n = 1:length(LH.MaleFasted.TRAIN.twentyHz)
        MF_25ms_AMP(n,1) = {'Male Fasted'};
        MF_25ms_AMP(n,2) = {'25 ms'};
        MF_25ms_AMP(n,3) = {LH.MaleFasted.TRAIN.twentyHz(n).name};
        MF_25ms_AMP(n,4) = {LH.MaleFasted.TRAIN.twentyHz(n).acq};
        MF_25ms_AMP(n,5) = {LH.MaleFasted.PPR.twentyfivems(n).peakAmplitude(1)};
        MF_25ms_AMP(n,6) = {LH.MaleFasted.PPR.twentyfivems(n).peakAmplitude(2)};
end
MF_25ms_AMP = MF_25ms_AMP(LH.MaleFasted.greater50,:);

% Female Control
FC_25ms_AMP = {};
for n = 1:length(LH.FemaleControl.TRAIN.twentyHz)
        FC_25ms_AMP(n,1) = {'Female Control'};
        FC_25ms_AMP(n,2) = {'25 ms'};
        FC_25ms_AMP(n,3) = {LH.FemaleControl.TRAIN.twentyHz(n).name};
        FC_25ms_AMP(n,4) = {LH.FemaleControl.TRAIN.twentyHz(n).acq};
        FC_25ms_AMP(n,5) = {LH.FemaleControl.PPR.twentyfivems(n).peakAmplitude(1)};
        FC_25ms_AMP(n,6) = {LH.FemaleControl.PPR.twentyfivems(n).peakAmplitude(2)};
end
FC_25ms_AMP = FC_25ms_AMP(LH.FemaleControl.greater50,:);

% Female Fasted
FF_25ms_AMP = {};
for n = 1:length(LH.FemaleFasted.TRAIN.twentyHz)
        FF_25ms_AMP(n,1) = {'Female Fasted'};
        FF_25ms_AMP(n,2) = {'25 ms'};
        FF_25ms_AMP(n,3) = {LH.FemaleFasted.TRAIN.twentyHz(n).name};
        FF_25ms_AMP(n,4) = {LH.FemaleFasted.TRAIN.twentyHz(n).acq};
        FF_25ms_AMP(n,5) = {LH.FemaleFasted.PPR.twentyfivems(n).peakAmplitude(1)};
        FF_25ms_AMP(n,6) = {LH.FemaleFasted.PPR.twentyfivems(n).peakAmplitude(2)};
end
FF_25ms_AMP = FF_25ms_AMP(LH.FemaleFasted.greater50,:);

PPR_nan = num2cell(nan(1,width(MC_25ms_AMP)));

twentyfive_AMP_array = [MC_25ms_AMP; PPR_nan; MF_25ms_AMP; PPR_nan; FC_25ms_AMP; PPR_nan; FF_25ms_AMP];

LH.tables.twentyfive_AMP = array2table(twentyfive_AMP_array,'VariableNames',{'Group','Frequency','Cell_Name','Acq','P1','P2'});

clear n MC_25ms_AMP MF_25ms_AMP FC_25ms_AMP FF_25ms_AMP PPR_nan twentyfive_AMP_array

%% Making table of the amplitudes in the PPR with a 50ms interval

% Male Control
MC_50ms_AMP = {};
for n = 1:length(LH.MaleControl.TRAIN.twentyHz)
        MC_50ms_AMP(n,1) = {'Male Control'};
        MC_50ms_AMP(n,2) = {'50 ms'};
        MC_50ms_AMP(n,3) = {LH.MaleControl.TRAIN.twentyHz(n).name};
        MC_50ms_AMP(n,4) = {LH.MaleControl.TRAIN.twentyHz(n).acq};
        MC_50ms_AMP(n,5) = {LH.MaleControl.PPR.fiftyms(n).peakAmplitude(1)};
        MC_50ms_AMP(n,6) = {LH.MaleControl.PPR.fiftyms(n).peakAmplitude(2)};
end
MC_50ms_AMP = MC_50ms_AMP(LH.MaleControl.greater50,:);

% Male Fasted
MF_50ms_AMP = {};
for n = 1:length(LH.MaleFasted.TRAIN.twentyHz)
        MF_50ms_AMP(n,1) = {'Male Fasted'};
        MF_50ms_AMP(n,2) = {'50 ms'};
        MF_50ms_AMP(n,3) = {LH.MaleFasted.TRAIN.twentyHz(n).name};
        MF_50ms_AMP(n,4) = {LH.MaleFasted.TRAIN.twentyHz(n).acq};
        MF_50ms_AMP(n,5) = {LH.MaleFasted.PPR.fiftyms(n).peakAmplitude(1)};
        MF_50ms_AMP(n,6) = {LH.MaleFasted.PPR.fiftyms(n).peakAmplitude(2)};
end
MF_50ms_AMP = MF_50ms_AMP(LH.MaleFasted.greater50,:);

% Female Control
FC_50ms_AMP = {};
for n = 1:length(LH.FemaleControl.TRAIN.twentyHz)
        FC_50ms_AMP(n,1) = {'Female Control'};
        FC_50ms_AMP(n,2) = {'50 ms'};
        FC_50ms_AMP(n,3) = {LH.FemaleControl.TRAIN.twentyHz(n).name};
        FC_50ms_AMP(n,4) = {LH.FemaleControl.TRAIN.twentyHz(n).acq};
        FC_50ms_AMP(n,5) = {LH.FemaleControl.PPR.fiftyms(n).peakAmplitude(1)};
        FC_50ms_AMP(n,6) = {LH.FemaleControl.PPR.fiftyms(n).peakAmplitude(2)};
end
FC_50ms_AMP = FC_50ms_AMP(LH.FemaleControl.greater50,:);

% Female Fasted
FF_50ms_AMP = {};
for n = 1:length(LH.FemaleFasted.TRAIN.twentyHz)
        FF_50ms_AMP(n,1) = {'Female Fasted'};
        FF_50ms_AMP(n,2) = {'50 ms'};
        FF_50ms_AMP(n,3) = {LH.FemaleFasted.TRAIN.twentyHz(n).name};
        FF_50ms_AMP(n,4) = {LH.FemaleFasted.TRAIN.twentyHz(n).acq};
        FF_50ms_AMP(n,5) = {LH.FemaleFasted.PPR.fiftyms(n).peakAmplitude(1)};
        FF_50ms_AMP(n,6) = {LH.FemaleFasted.PPR.fiftyms(n).peakAmplitude(2)};
end
FF_50ms_AMP = FF_50ms_AMP(LH.FemaleFasted.greater50,:);

PPR_nan = num2cell(nan(1,width(MC_50ms_AMP)));

fifty_AMP_array = [MC_50ms_AMP; PPR_nan; MF_50ms_AMP; PPR_nan; FC_50ms_AMP; PPR_nan; FF_50ms_AMP];

LH.tables.fifty_AMP = array2table(fifty_AMP_array,'VariableNames',{'Group','Frequency','Cell_Name','Acq','P1','P2'});

clear n MC_50ms_AMP MF_50ms_AMP FC_50ms_AMP FF_50ms_AMP PPR_nan fifty_AMP_array


%% Making table of the amplitudes in the PPR with a 100ms interval

% Male Control
MC_100ms_AMP = {};
for n = 1:length(LH.MaleControl.TRAIN.twentyHz)
        MC_100ms_AMP(n,1) = {'Male Control'};
        MC_100ms_AMP(n,2) = {'100 ms'};
        MC_100ms_AMP(n,3) = {LH.MaleControl.TRAIN.twentyHz(n).name};
        MC_100ms_AMP(n,4) = {LH.MaleControl.TRAIN.twentyHz(n).acq};
        MC_100ms_AMP(n,5) = {LH.MaleControl.PPR.onehundredms(n).peakAmplitude(1)};
        MC_100ms_AMP(n,6) = {LH.MaleControl.PPR.onehundredms(n).peakAmplitude(2)};
end
MC_100ms_AMP = MC_100ms_AMP(LH.MaleControl.greater50,:);

% Male Fasted
MF_100ms_AMP = {};
for n = 1:length(LH.MaleFasted.TRAIN.twentyHz)
        MF_100ms_AMP(n,1) = {'Male Fasted'};
        MF_100ms_AMP(n,2) = {'100 ms'};
        MF_100ms_AMP(n,3) = {LH.MaleFasted.TRAIN.twentyHz(n).name};
        MF_100ms_AMP(n,4) = {LH.MaleFasted.TRAIN.twentyHz(n).acq};
        MF_100ms_AMP(n,5) = {LH.MaleFasted.PPR.onehundredms(n).peakAmplitude(1)};
        MF_100ms_AMP(n,6) = {LH.MaleFasted.PPR.onehundredms(n).peakAmplitude(2)};
end
MF_100ms_AMP = MF_100ms_AMP(LH.MaleFasted.greater50,:);

% Female Control
FC_100ms_AMP = {};
for n = 1:length(LH.FemaleControl.TRAIN.twentyHz)
        FC_100ms_AMP(n,1) = {'Female Control'};
        FC_100ms_AMP(n,2) = {'100 ms'};
        FC_100ms_AMP(n,3) = {LH.FemaleControl.TRAIN.twentyHz(n).name};
        FC_100ms_AMP(n,4) = {LH.FemaleControl.TRAIN.twentyHz(n).acq};
        FC_100ms_AMP(n,5) = {LH.FemaleControl.PPR.onehundredms(n).peakAmplitude(1)};
        FC_100ms_AMP(n,6) = {LH.FemaleControl.PPR.onehundredms(n).peakAmplitude(2)};
end
FC_100ms_AMP = FC_100ms_AMP(LH.FemaleControl.greater50,:);

% Female Fasted
FF_100ms_AMP = {};
for n = 1:length(LH.FemaleFasted.TRAIN.twentyHz)
        FF_100ms_AMP(n,1) = {'Female Fasted'};
        FF_100ms_AMP(n,2) = {'100 ms'};
        FF_100ms_AMP(n,3) = {LH.FemaleFasted.TRAIN.twentyHz(n).name};
        FF_100ms_AMP(n,4) = {LH.FemaleFasted.TRAIN.twentyHz(n).acq};
        FF_100ms_AMP(n,5) = {LH.FemaleFasted.PPR.onehundredms(n).peakAmplitude(1)};
        FF_100ms_AMP(n,6) = {LH.FemaleFasted.PPR.onehundredms(n).peakAmplitude(2)};
end
FF_100ms_AMP = FF_100ms_AMP(LH.FemaleFasted.greater50,:);

PPR_nan = num2cell(nan(1,width(MC_100ms_AMP)));

onehundred_AMP_array = [MC_100ms_AMP; PPR_nan; MF_100ms_AMP; PPR_nan; FC_100ms_AMP; PPR_nan; FF_100ms_AMP];

LH.tables.onehundred_AMP = array2table(onehundred_AMP_array,'VariableNames',{'Group','Frequency','Cell_Name','Acq','P1','P2'});

clear n MC_100ms_AMP MF_100ms_AMP FC_100ms_AMP FF_100ms_AMP PPR_nan onehundred_AMP_array

%% Making table of the amplitudes in the PPR with a 200ms interval

% Male Control
MC_200ms_AMP = {};
for n = 1:length(LH.MaleControl.TRAIN.twentyHz)
        MC_200ms_AMP(n,1) = {'Male Control'};
        MC_200ms_AMP(n,2) = {'200 ms'};
        MC_200ms_AMP(n,3) = {LH.MaleControl.TRAIN.twentyHz(n).name};
        MC_200ms_AMP(n,4) = {LH.MaleControl.TRAIN.twentyHz(n).acq};
        MC_200ms_AMP(n,5) = {LH.MaleControl.PPR.twohundredms(n).peakAmplitude(1)};
        MC_200ms_AMP(n,6) = {LH.MaleControl.PPR.twohundredms(n).peakAmplitude(2)};
end
MC_200ms_AMP = MC_200ms_AMP(LH.MaleControl.greater50,:);

% Male Fasted
MF_200ms_AMP = {};
for n = 1:length(LH.MaleFasted.TRAIN.twentyHz)
        MF_200ms_AMP(n,1) = {'Male Fasted'};
        MF_200ms_AMP(n,2) = {'200 ms'};
        MF_200ms_AMP(n,3) = {LH.MaleFasted.TRAIN.twentyHz(n).name};
        MF_200ms_AMP(n,4) = {LH.MaleFasted.TRAIN.twentyHz(n).acq};
        MF_200ms_AMP(n,5) = {LH.MaleFasted.PPR.twohundredms(n).peakAmplitude(1)};
        MF_200ms_AMP(n,6) = {LH.MaleFasted.PPR.twohundredms(n).peakAmplitude(2)};
end
MF_200ms_AMP = MF_200ms_AMP(LH.MaleFasted.greater50,:);

% Female Control
FC_200ms_AMP = {};
for n = 1:length(LH.FemaleControl.TRAIN.twentyHz)
        FC_200ms_AMP(n,1) = {'Female Control'};
        FC_200ms_AMP(n,2) = {'200 ms'};
        FC_200ms_AMP(n,3) = {LH.FemaleControl.TRAIN.twentyHz(n).name};
        FC_200ms_AMP(n,4) = {LH.FemaleControl.TRAIN.twentyHz(n).acq};
        FC_200ms_AMP(n,5) = {LH.FemaleControl.PPR.twohundredms(n).peakAmplitude(1)};
        FC_200ms_AMP(n,6) = {LH.FemaleControl.PPR.twohundredms(n).peakAmplitude(2)};
end
FC_200ms_AMP = FC_200ms_AMP(LH.FemaleControl.greater50,:);

% Female Fasted
FF_200ms_AMP = {};
for n = 1:length(LH.FemaleFasted.TRAIN.twentyHz)
        FF_200ms_AMP(n,1) = {'Female Fasted'};
        FF_200ms_AMP(n,2) = {'200 ms'};
        FF_200ms_AMP(n,3) = {LH.FemaleFasted.TRAIN.twentyHz(n).name};
        FF_200ms_AMP(n,4) = {LH.FemaleFasted.TRAIN.twentyHz(n).acq};
        FF_200ms_AMP(n,5) = {LH.FemaleFasted.PPR.twohundredms(n).peakAmplitude(1)};
        FF_200ms_AMP(n,6) = {LH.FemaleFasted.PPR.twohundredms(n).peakAmplitude(2)};
end
FF_200ms_AMP = FF_200ms_AMP(LH.FemaleFasted.greater50,:);

PPR_nan = num2cell(nan(1,width(MC_200ms_AMP)));

twohundred_AMP_array = [MC_200ms_AMP; PPR_nan; MF_200ms_AMP; PPR_nan; FC_200ms_AMP; PPR_nan; FF_200ms_AMP];

LH.tables.twohundred_AMP = array2table(twohundred_AMP_array,'VariableNames',{'Group','Frequency','Cell_Name','Acq','P1','P2'});

clear n MC_200ms_AMP MF_200ms_AMP FC_200ms_AMP FF_200ms_AMP PPR_nan twohundred_AMP_array

%% Making table of the amplitudes in the PPR with a 500ms interval

% Male Control
MC_500ms_AMP = {};
for n = 1:length(LH.MaleControl.TRAIN.twentyHz)
        MC_500ms_AMP(n,1) = {'Male Control'};
        MC_500ms_AMP(n,2) = {'500 ms'};
        MC_500ms_AMP(n,3) = {LH.MaleControl.TRAIN.twentyHz(n).name};
        MC_500ms_AMP(n,4) = {LH.MaleControl.TRAIN.twentyHz(n).acq};
        MC_500ms_AMP(n,5) = {LH.MaleControl.PPR.fivehundredms(n).peakAmplitude(1)};
        MC_500ms_AMP(n,6) = {LH.MaleControl.PPR.fivehundredms(n).peakAmplitude(2)};
end
MC_500ms_AMP = MC_500ms_AMP(LH.MaleControl.greater50,:);

% Male Fasted
MF_500ms_AMP = {};
for n = 1:length(LH.MaleFasted.TRAIN.twentyHz)
        MF_500ms_AMP(n,1) = {'Male Fasted'};
        MF_500ms_AMP(n,2) = {'500 ms'};
        MF_500ms_AMP(n,3) = {LH.MaleFasted.TRAIN.twentyHz(n).name};
        MF_500ms_AMP(n,4) = {LH.MaleFasted.TRAIN.twentyHz(n).acq};
        MF_500ms_AMP(n,5) = {LH.MaleFasted.PPR.fivehundredms(n).peakAmplitude(1)};
        MF_500ms_AMP(n,6) = {LH.MaleFasted.PPR.fivehundredms(n).peakAmplitude(2)};
end
MF_500ms_AMP = MF_500ms_AMP(LH.MaleFasted.greater50,:);

% Female Control
FC_500ms_AMP = {};
for n = 1:length(LH.FemaleControl.TRAIN.twentyHz)
        FC_500ms_AMP(n,1) = {'Female Control'};
        FC_500ms_AMP(n,2) = {'500 ms'};
        FC_500ms_AMP(n,3) = {LH.FemaleControl.TRAIN.twentyHz(n).name};
        FC_500ms_AMP(n,4) = {LH.FemaleControl.TRAIN.twentyHz(n).acq};
        FC_500ms_AMP(n,5) = {LH.FemaleControl.PPR.fivehundredms(n).peakAmplitude(1)};
        FC_500ms_AMP(n,6) = {LH.FemaleControl.PPR.fivehundredms(n).peakAmplitude(2)};
end
FC_500ms_AMP = FC_500ms_AMP(LH.FemaleControl.greater50,:);

% Female Fasted
FF_500ms_AMP = {};
for n = 1:length(LH.FemaleFasted.TRAIN.twentyHz)
        FF_500ms_AMP(n,1) = {'Female Fasted'};
        FF_500ms_AMP(n,2) = {'500 ms'};
        FF_500ms_AMP(n,3) = {LH.FemaleFasted.TRAIN.twentyHz(n).name};
        FF_500ms_AMP(n,4) = {LH.FemaleFasted.TRAIN.twentyHz(n).acq};
        FF_500ms_AMP(n,5) = {LH.FemaleFasted.PPR.fivehundredms(n).peakAmplitude(1)};
        FF_500ms_AMP(n,6) = {LH.FemaleFasted.PPR.fivehundredms(n).peakAmplitude(2)};
end
FF_500ms_AMP = FF_500ms_AMP(LH.FemaleFasted.greater50,:);

PPR_nan = num2cell(nan(1,width(MC_500ms_AMP)));

fivehundred_AMP_array = [MC_500ms_AMP; PPR_nan; MF_500ms_AMP; PPR_nan; FC_500ms_AMP; PPR_nan; FF_500ms_AMP];

LH.tables.fivehundred_AMP = array2table(fivehundred_AMP_array,'VariableNames',{'Group','Frequency','Cell_Name','Acq','P1','P2'});

clear n MC_500ms_AMP MF_500ms_AMP FC_500ms_AMP FF_500ms_AMP PPR_nan fivehundred_AMP_array

%% Making table of the amplitudes in the PPR with a 1000ms interval

% Male Control
MC_1000ms_AMP = {};
for n = 1:length(LH.MaleControl.TRAIN.twentyHz)
        MC_1000ms_AMP(n,1) = {'Male Control'};
        MC_1000ms_AMP(n,2) = {'1000 ms'};
        MC_1000ms_AMP(n,3) = {LH.MaleControl.TRAIN.twentyHz(n).name};
        MC_1000ms_AMP(n,4) = {LH.MaleControl.TRAIN.twentyHz(n).acq};
        MC_1000ms_AMP(n,5) = {LH.MaleControl.PPR.ones(n).peakAmplitude(1)};
        MC_1000ms_AMP(n,6) = {LH.MaleControl.PPR.ones(n).peakAmplitude(2)};
end
MC_1000ms_AMP = MC_1000ms_AMP(LH.MaleControl.greater50,:);

% Male Fasted
MF_1000ms_AMP = {};
for n = 1:length(LH.MaleFasted.TRAIN.twentyHz)
        MF_1000ms_AMP(n,1) = {'Male Fasted'};
        MF_1000ms_AMP(n,2) = {'1000 ms'};
        MF_1000ms_AMP(n,3) = {LH.MaleFasted.TRAIN.twentyHz(n).name};
        MF_1000ms_AMP(n,4) = {LH.MaleFasted.TRAIN.twentyHz(n).acq};
        MF_1000ms_AMP(n,5) = {LH.MaleFasted.PPR.ones(n).peakAmplitude(1)};
        MF_1000ms_AMP(n,6) = {LH.MaleFasted.PPR.ones(n).peakAmplitude(2)};
end
MF_1000ms_AMP = MF_1000ms_AMP(LH.MaleFasted.greater50,:);

% Female Control
FC_1000ms_AMP = {};
for n = 1:length(LH.FemaleControl.TRAIN.twentyHz)
        FC_1000ms_AMP(n,1) = {'Female Control'};
        FC_1000ms_AMP(n,2) = {'1000 ms'};
        FC_1000ms_AMP(n,3) = {LH.FemaleControl.TRAIN.twentyHz(n).name};
        FC_1000ms_AMP(n,4) = {LH.FemaleControl.TRAIN.twentyHz(n).acq};
        FC_1000ms_AMP(n,5) = {LH.FemaleControl.PPR.ones(n).peakAmplitude(1)};
        FC_1000ms_AMP(n,6) = {LH.FemaleControl.PPR.ones(n).peakAmplitude(2)};
end
FC_1000ms_AMP = FC_1000ms_AMP(LH.FemaleControl.greater50,:);

% Female Fasted
FF_1000ms_AMP = {};
for n = 1:length(LH.FemaleFasted.TRAIN.twentyHz)
        FF_1000ms_AMP(n,1) = {'Female Fasted'};
        FF_1000ms_AMP(n,2) = {'1000 ms'};
        FF_1000ms_AMP(n,3) = {LH.FemaleFasted.TRAIN.twentyHz(n).name};
        FF_1000ms_AMP(n,4) = {LH.FemaleFasted.TRAIN.twentyHz(n).acq};
        FF_1000ms_AMP(n,5) = {LH.FemaleFasted.PPR.ones(n).peakAmplitude(1)};
        FF_1000ms_AMP(n,6) = {LH.FemaleFasted.PPR.ones(n).peakAmplitude(2)};
end
FF_1000ms_AMP = FF_1000ms_AMP(LH.FemaleFasted.greater50,:);

PPR_nan = num2cell(nan(1,width(MC_1000ms_AMP)));

one_AMP_array = [MC_1000ms_AMP; PPR_nan; MF_1000ms_AMP; PPR_nan; FC_1000ms_AMP; PPR_nan; FF_1000ms_AMP];

LH.tables.one_AMP = array2table(one_AMP_array,'VariableNames',{'Group','Frequency','Cell_Name','Acq','P1','P2'});

clear n MC_1000ms_AMP MF_1000ms_AMP FC_1000ms_AMP FF_1000ms_AMP PPR_nan one_AMP_array

%% Making table of the amplitudes in the PPR with a 5000ms interval

% Male Control
MC_5000ms_AMP = {};
for n = 1:length(LH.MaleControl.TRAIN.twentyHz)
        MC_5000ms_AMP(n,1) = {'Male Control'};
        MC_5000ms_AMP(n,2) = {'5000 ms'};
        MC_5000ms_AMP(n,3) = {LH.MaleControl.TRAIN.twentyHz(n).name};
        MC_5000ms_AMP(n,4) = {LH.MaleControl.TRAIN.twentyHz(n).acq};
        MC_5000ms_AMP(n,5) = {LH.MaleControl.PPR.fives(n).peakAmplitude(1)};
        MC_5000ms_AMP(n,6) = {LH.MaleControl.PPR.fives(n).peakAmplitude(2)};
end
MC_5000ms_AMP = MC_5000ms_AMP(LH.MaleControl.greater50,:);

% Male Fasted
MF_5000ms_AMP = {};
for n = 1:length(LH.MaleFasted.TRAIN.twentyHz)
        MF_5000ms_AMP(n,1) = {'Male Fasted'};
        MF_5000ms_AMP(n,2) = {'5000 ms'};
        MF_5000ms_AMP(n,3) = {LH.MaleFasted.TRAIN.twentyHz(n).name};
        MF_5000ms_AMP(n,4) = {LH.MaleFasted.TRAIN.twentyHz(n).acq};
        MF_5000ms_AMP(n,5) = {LH.MaleFasted.PPR.fives(n).peakAmplitude(1)};
        MF_5000ms_AMP(n,6) = {LH.MaleFasted.PPR.fives(n).peakAmplitude(2)};
end
MF_5000ms_AMP = MF_5000ms_AMP(LH.MaleFasted.greater50,:);

% Female Control
FC_5000ms_AMP = {};
for n = 1:length(LH.FemaleControl.TRAIN.twentyHz)
        FC_5000ms_AMP(n,1) = {'Female Control'};
        FC_5000ms_AMP(n,2) = {'5000 ms'};
        FC_5000ms_AMP(n,3) = {LH.FemaleControl.TRAIN.twentyHz(n).name};
        FC_5000ms_AMP(n,4) = {LH.FemaleControl.TRAIN.twentyHz(n).acq};
        FC_5000ms_AMP(n,5) = {LH.FemaleControl.PPR.fives(n).peakAmplitude(1)};
        FC_5000ms_AMP(n,6) = {LH.FemaleControl.PPR.fives(n).peakAmplitude(2)};
end
FC_5000ms_AMP = FC_5000ms_AMP(LH.FemaleControl.greater50,:);

% Female Fasted
FF_5000ms_AMP = {};
for n = 1:length(LH.FemaleFasted.TRAIN.twentyHz)
        FF_5000ms_AMP(n,1) = {'Female Fasted'};
        FF_5000ms_AMP(n,2) = {'5000 ms'};
        FF_5000ms_AMP(n,3) = {LH.FemaleFasted.TRAIN.twentyHz(n).name};
        FF_5000ms_AMP(n,4) = {LH.FemaleFasted.TRAIN.twentyHz(n).acq};
        FF_5000ms_AMP(n,5) = {LH.FemaleFasted.PPR.fives(n).peakAmplitude(1)};
        FF_5000ms_AMP(n,6) = {LH.FemaleFasted.PPR.fives(n).peakAmplitude(2)};
end
FF_5000ms_AMP = FF_5000ms_AMP(LH.FemaleFasted.greater50,:);

PPR_nan = num2cell(nan(1,width(MC_5000ms_AMP)));

five_AMP_array = [MC_5000ms_AMP; PPR_nan; MF_5000ms_AMP; PPR_nan; FC_5000ms_AMP; PPR_nan; FF_5000ms_AMP];

LH.tables.five_AMP = array2table(five_AMP_array,'VariableNames',{'Group','Frequency','Cell_Name','Acq','P1','P2'});

clear n MC_5000ms_AMP MF_5000ms_AMP FC_5000ms_AMP FF_5000ms_AMP PPR_nan five_AMP_array

%% Save file
cd(file_path);
save (filename, '-v7.3') 

%% Writing table to excel

writetable(LH.tables.twentyfive_AMP,'LH.xlsx','Sheet','AMP_25','Range','A1');
writetable(LH.tables.fifty_AMP,'LH.xlsx','Sheet','AMP_50','Range','A1');
writetable(LH.tables.onehundred_AMP,'LH.xlsx','Sheet','AMP_100','Range','A1');
writetable(LH.tables.twohundred_AMP,'LH.xlsx','Sheet','AMP_200','Range','A1');
writetable(LH.tables.fivehundred_AMP,'LH.xlsx','Sheet','AMP_500','Range','A1');
writetable(LH.tables.one_AMP,'LH.xlsx','Sheet','AMP_1000','Range','A1');
writetable(LH.tables.five_AMP,'LH.xlsx','Sheet','AMP_5000','Range','A1');

%% Enveloppe Current
%{
This is the residual current between the peaks of each pulse.
%}

samplingFrequency = 20000; % 20000 Hz sampling rate

% Male Control

% 5 Hz
for m = 1 : length(LH.MaleControl.TRAIN.fiveHz)
    LH.MaleControl.TRAIN.fiveHz(m).envelope = [];
    for n = 2 : length(LH.MaleControl.TRAIN.fiveHz(m).peakTime)
        [LH.MaleControl.TRAIN.fiveHz(m).envelope(n-1).mV, LH.MaleControl.TRAIN.fiveHz(m).envelope(n-1).index] = max(LH.MaleControl.TRAIN.fiveHz(m).trace((LH.MaleControl.TRAIN.fiveHz(m).peakTime(n-1))*samplingFrequency : (LH.MaleControl.TRAIN.fiveHz(m).peakTime(n))*samplingFrequency));
        LH.MaleControl.TRAIN.fiveHz(m).envelope(n-1).times = LH.MaleControl.TRAIN.fiveHz(m).peakTime(n-1) + (LH.MaleControl.TRAIN.fiveHz(m).envelope(n-1).index/samplingFrequency);
    end
end
clear m n

% 10 Hz
for m = 1 : length(LH.MaleControl.TRAIN.tenHz)
    LH.MaleControl.TRAIN.tenHz(m).envelope = [];
    for n = 2 : length(LH.MaleControl.TRAIN.tenHz(m).peakTime)
        [LH.MaleControl.TRAIN.tenHz(m).envelope(n-1).mV, LH.MaleControl.TRAIN.tenHz(m).envelope(n-1).index] = max(LH.MaleControl.TRAIN.tenHz(m).trace((LH.MaleControl.TRAIN.tenHz(m).peakTime(n-1))*samplingFrequency : (LH.MaleControl.TRAIN.tenHz(m).peakTime(n))*samplingFrequency));
        LH.MaleControl.TRAIN.tenHz(m).envelope(n-1).times = LH.MaleControl.TRAIN.tenHz(m).peakTime(n-1) + (LH.MaleControl.TRAIN.tenHz(m).envelope(n-1).index/samplingFrequency);
    end
end
clear m n

% 20 Hz
for m = 1 : length(LH.MaleControl.TRAIN.twentyHz)
    LH.MaleControl.TRAIN.twentyHz(m).envelope = [];
    for n = 2 : length(LH.MaleControl.TRAIN.twentyHz(m).peakTime)
        [LH.MaleControl.TRAIN.twentyHz(m).envelope(n-1).mV, LH.MaleControl.TRAIN.twentyHz(m).envelope(n-1).index] = max(LH.MaleControl.TRAIN.twentyHz(m).trace((LH.MaleControl.TRAIN.twentyHz(m).peakTime(n-1))*samplingFrequency : (LH.MaleControl.TRAIN.twentyHz(m).peakTime(n))*samplingFrequency));
        LH.MaleControl.TRAIN.twentyHz(m).envelope(n-1).times = LH.MaleControl.TRAIN.twentyHz(m).peakTime(n-1) + (LH.MaleControl.TRAIN.twentyHz(m).envelope(n-1).index/samplingFrequency);
    end
end
clear m n


% Male Fasted

% 5 Hz
for m = 1 : length(LH.MaleFasted.TRAIN.fiveHz)
    LH.MaleFasted.TRAIN.fiveHz(m).envelope = [];
    for n = 2 : length(LH.MaleFasted.TRAIN.fiveHz(m).peakTime)
        [LH.MaleFasted.TRAIN.fiveHz(m).envelope(n-1).mV, LH.MaleFasted.TRAIN.fiveHz(m).envelope(n-1).index] = max(LH.MaleFasted.TRAIN.fiveHz(m).trace((LH.MaleFasted.TRAIN.fiveHz(m).peakTime(n-1))*samplingFrequency : (LH.MaleFasted.TRAIN.fiveHz(m).peakTime(n))*samplingFrequency));
        LH.MaleFasted.TRAIN.fiveHz(m).envelope(n-1).times = LH.MaleFasted.TRAIN.fiveHz(m).peakTime(n-1) + (LH.MaleFasted.TRAIN.fiveHz(m).envelope(n-1).index/samplingFrequency);
    end
end
clear m n

% 10 Hz
for m = 1 : length(LH.MaleFasted.TRAIN.tenHz)
    LH.MaleFasted.TRAIN.tenHz(m).envelope = [];
    for n = 2 : length(LH.MaleFasted.TRAIN.tenHz(m).peakTime)
        [LH.MaleFasted.TRAIN.tenHz(m).envelope(n-1).mV, LH.MaleFasted.TRAIN.tenHz(m).envelope(n-1).index] = max(LH.MaleFasted.TRAIN.tenHz(m).trace((LH.MaleFasted.TRAIN.tenHz(m).peakTime(n-1))*samplingFrequency : (LH.MaleFasted.TRAIN.tenHz(m).peakTime(n))*samplingFrequency));
        LH.MaleFasted.TRAIN.tenHz(m).envelope(n-1).times = LH.MaleFasted.TRAIN.tenHz(m).peakTime(n-1) + (LH.MaleFasted.TRAIN.tenHz(m).envelope(n-1).index/samplingFrequency);
    end
end
clear m n

% 20 Hz
for m = 1 : length(LH.MaleFasted.TRAIN.twentyHz)
    LH.MaleFasted.TRAIN.twentyHz(m).envelope = [];
    for n = 2 : length(LH.MaleFasted.TRAIN.twentyHz(m).peakTime)
        [LH.MaleFasted.TRAIN.twentyHz(m).envelope(n-1).mV, LH.MaleFasted.TRAIN.twentyHz(m).envelope(n-1).index] = max(LH.MaleFasted.TRAIN.twentyHz(m).trace((LH.MaleFasted.TRAIN.twentyHz(m).peakTime(n-1))*samplingFrequency : (LH.MaleFasted.TRAIN.twentyHz(m).peakTime(n))*samplingFrequency));
        LH.MaleFasted.TRAIN.twentyHz(m).envelope(n-1).times = LH.MaleFasted.TRAIN.twentyHz(m).peakTime(n-1) + (LH.MaleFasted.TRAIN.twentyHz(m).envelope(n-1).index/samplingFrequency);
    end
end
clear m n


% Female Control

% 5 Hz
for m = 1 : length(LH.FemaleControl.TRAIN.fiveHz)
    LH.FemaleControl.TRAIN.fiveHz(m).envelope = [];
    for n = 2 : length(LH.FemaleControl.TRAIN.fiveHz(m).peakTime)
        [LH.FemaleControl.TRAIN.fiveHz(m).envelope(n-1).mV, LH.FemaleControl.TRAIN.fiveHz(m).envelope(n-1).index] = max(LH.FemaleControl.TRAIN.fiveHz(m).trace((LH.FemaleControl.TRAIN.fiveHz(m).peakTime(n-1))*samplingFrequency : (LH.FemaleControl.TRAIN.fiveHz(m).peakTime(n))*samplingFrequency));
        LH.FemaleControl.TRAIN.fiveHz(m).envelope(n-1).times = LH.FemaleControl.TRAIN.fiveHz(m).peakTime(n-1) + (LH.FemaleControl.TRAIN.fiveHz(m).envelope(n-1).index/samplingFrequency);
    end
end
clear m n

% 10 Hz
for m = 1 : length(LH.FemaleControl.TRAIN.tenHz)
    LH.FemaleControl.TRAIN.tenHz(m).envelope = [];
    for n = 2 : length(LH.FemaleControl.TRAIN.tenHz(m).peakTime)
        [LH.FemaleControl.TRAIN.tenHz(m).envelope(n-1).mV, LH.FemaleControl.TRAIN.tenHz(m).envelope(n-1).index] = max(LH.FemaleControl.TRAIN.tenHz(m).trace((LH.FemaleControl.TRAIN.tenHz(m).peakTime(n-1))*samplingFrequency : (LH.FemaleControl.TRAIN.tenHz(m).peakTime(n))*samplingFrequency));
        LH.FemaleControl.TRAIN.tenHz(m).envelope(n-1).times = LH.FemaleControl.TRAIN.tenHz(m).peakTime(n-1) + (LH.FemaleControl.TRAIN.tenHz(m).envelope(n-1).index/samplingFrequency);
    end
end
clear m n

% 20 Hz
for m = 1 : length(LH.FemaleControl.TRAIN.twentyHz)
    LH.FemaleControl.TRAIN.twentyHz(m).envelope = [];
    for n = 2 : length(LH.FemaleControl.TRAIN.twentyHz(m).peakTime)
        [LH.FemaleControl.TRAIN.twentyHz(m).envelope(n-1).mV, LH.FemaleControl.TRAIN.twentyHz(m).envelope(n-1).index] = max(LH.FemaleControl.TRAIN.twentyHz(m).trace((LH.FemaleControl.TRAIN.twentyHz(m).peakTime(n-1))*samplingFrequency : (LH.FemaleControl.TRAIN.twentyHz(m).peakTime(n))*samplingFrequency));
        LH.FemaleControl.TRAIN.twentyHz(m).envelope(n-1).times = LH.FemaleControl.TRAIN.twentyHz(m).peakTime(n-1) + (LH.FemaleControl.TRAIN.twentyHz(m).envelope(n-1).index/samplingFrequency);
    end
end
clear m n


% Female Fasted

% 5 Hz
for m = 1 : length(LH.FemaleFasted.TRAIN.fiveHz)
    LH.FemaleFasted.TRAIN.fiveHz(m).envelope = [];
    for n = 2 : length(LH.FemaleFasted.TRAIN.fiveHz(m).peakTime)
        [LH.FemaleFasted.TRAIN.fiveHz(m).envelope(n-1).mV, LH.FemaleFasted.TRAIN.fiveHz(m).envelope(n-1).index] = max(LH.FemaleFasted.TRAIN.fiveHz(m).trace((LH.FemaleFasted.TRAIN.fiveHz(m).peakTime(n-1))*samplingFrequency : (LH.FemaleFasted.TRAIN.fiveHz(m).peakTime(n))*samplingFrequency));
        LH.FemaleFasted.TRAIN.fiveHz(m).envelope(n-1).times = LH.FemaleFasted.TRAIN.fiveHz(m).peakTime(n-1) + (LH.FemaleFasted.TRAIN.fiveHz(m).envelope(n-1).index/samplingFrequency);
    end
end
clear m n

% 10 Hz
for m = 1 : length(LH.FemaleFasted.TRAIN.tenHz)
    LH.FemaleFasted.TRAIN.tenHz(m).envelope = [];
    for n = 2 : length(LH.FemaleFasted.TRAIN.tenHz(m).peakTime)
        [LH.FemaleFasted.TRAIN.tenHz(m).envelope(n-1).mV, LH.FemaleFasted.TRAIN.tenHz(m).envelope(n-1).index] = max(LH.FemaleFasted.TRAIN.tenHz(m).trace((LH.FemaleFasted.TRAIN.tenHz(m).peakTime(n-1))*samplingFrequency : (LH.FemaleFasted.TRAIN.tenHz(m).peakTime(n))*samplingFrequency));
        LH.FemaleFasted.TRAIN.tenHz(m).envelope(n-1).times = LH.FemaleFasted.TRAIN.tenHz(m).peakTime(n-1) + (LH.FemaleFasted.TRAIN.tenHz(m).envelope(n-1).index/samplingFrequency);
    end
end
clear m n

% 20 Hz
for m = 1 : length(LH.FemaleFasted.TRAIN.twentyHz)
    LH.FemaleFasted.TRAIN.twentyHz(m).envelope = [];
    for n = 2 : length(LH.FemaleFasted.TRAIN.twentyHz(m).peakTime)
        [LH.FemaleFasted.TRAIN.twentyHz(m).envelope(n-1).mV, LH.FemaleFasted.TRAIN.twentyHz(m).envelope(n-1).index] = max(LH.FemaleFasted.TRAIN.twentyHz(m).trace((LH.FemaleFasted.TRAIN.twentyHz(m).peakTime(n-1))*samplingFrequency : (LH.FemaleFasted.TRAIN.twentyHz(m).peakTime(n))*samplingFrequency));
        LH.FemaleFasted.TRAIN.twentyHz(m).envelope(n-1).times = LH.FemaleFasted.TRAIN.twentyHz(m).peakTime(n-1) + (LH.FemaleFasted.TRAIN.twentyHz(m).envelope(n-1).index/samplingFrequency);
    end
end
clear m n


%% Creating table for envelope currents

% Male Control
MC_5Hz = {};
for n = 1:length(LH.MaleControl.TRAIN.fiveHz)
    if LH.MaleControl.greater50(n) == 1
        MC_5Hz(n,1) = {'Male Control'};
        MC_5Hz(n,2) = {'5 Hz'};
        MC_5Hz(n,3) = {LH.MaleControl.TRAIN.fiveHz(n).name};
        MC_5Hz(n,4) = {LH.MaleControl.TRAIN.fiveHz(n).acq};
        for m = 1:length(LH.MaleControl.TRAIN.fiveHz(n).envelope)
            MC_5Hz(n,4+m) = {LH.MaleControl.TRAIN.fiveHz(n).envelope(m).mV}; % Will be from 4 to 7
        end
    end
    MC_5Hz_logic(n,1) = LH.MaleControl.greater50(n);
end

MC_5Hz = MC_5Hz(MC_5Hz_logic,:);

clear MC_5Hz_logic m n

MC_10Hz = {};
for n = 1:length(LH.MaleControl.TRAIN.tenHz)
    if LH.MaleControl.greater50(n) == 1
        MC_10Hz(n,1) = {'Male Control'};
        MC_10Hz(n,2) = {'10 Hz'};
        MC_10Hz(n,3) = {LH.MaleControl.TRAIN.tenHz(n).name};
        MC_10Hz(n,4) = {LH.MaleControl.TRAIN.tenHz(n).acq};
        for m = 1:length(LH.MaleControl.TRAIN.tenHz(n).envelope)
            MC_10Hz(n,4+m) = {LH.MaleControl.TRAIN.tenHz(n).envelope(m).mV}; % Will be from 4 to 7
        end
    end
    MC_10Hz_logic(n,1) = LH.MaleControl.greater50(n);
end

MC_10Hz = MC_10Hz(MC_10Hz_logic,:);

clear MC_10Hz_logic m n

MC_20Hz = {};
for n = 1:length(LH.MaleControl.TRAIN.twentyHz)
    if LH.MaleControl.greater50(n) == 1
        MC_20Hz(n,1) = {'Male Control'};
        MC_20Hz(n,2) = {'20 Hz'};
        MC_20Hz(n,3) = {LH.MaleControl.TRAIN.twentyHz(n).name};
        MC_20Hz(n,4) = {LH.MaleControl.TRAIN.twentyHz(n).acq};
        for m = 1:length(LH.MaleControl.TRAIN.twentyHz(n).envelope)
            MC_20Hz(n,4+m) = {LH.MaleControl.TRAIN.twentyHz(n).envelope(m).mV}; % Will be from 4 to 7
        end
    end
    MC_20Hz_logic(n,1) = LH.MaleControl.greater50(n);
end

MC_20Hz = MC_20Hz(MC_20Hz_logic,:);

clear MC_20Hz_logic m n


% Male Fasted
MF_5Hz = {};
for n = 1:length(LH.MaleFasted.TRAIN.fiveHz)
    if LH.MaleFasted.greater50(n) == 1
        MF_5Hz(n,1) = {'Male Fasted'};
        MF_5Hz(n,2) = {'5 Hz'};
        MF_5Hz(n,3) = {LH.MaleFasted.TRAIN.fiveHz(n).name};
        MF_5Hz(n,4) = {LH.MaleFasted.TRAIN.fiveHz(n).acq};
        for m = 1:length(LH.MaleFasted.TRAIN.fiveHz(n).envelope)
            MF_5Hz(n,4+m) = {LH.MaleFasted.TRAIN.fiveHz(n).envelope(m).mV}; % Will be from 4 to 7
        end
    end
    MF_5Hz_logic(n,1) = LH.MaleFasted.greater50(n);
end

MF_5Hz = MF_5Hz(MF_5Hz_logic,:);

clear MF_5Hz_logic m n

MF_10Hz = {};
for n = 1:length(LH.MaleFasted.TRAIN.tenHz)
    if LH.MaleFasted.greater50(n) == 1
        MF_10Hz(n,1) = {'Male Fasted'};
        MF_10Hz(n,2) = {'10 Hz'};
        MF_10Hz(n,3) = {LH.MaleFasted.TRAIN.tenHz(n).name};
        MF_10Hz(n,4) = {LH.MaleFasted.TRAIN.tenHz(n).acq};
        for m = 1:length(LH.MaleFasted.TRAIN.tenHz(n).envelope)
            MF_10Hz(n,4+m) = {LH.MaleFasted.TRAIN.tenHz(n).envelope(m).mV}; % Will be from 4 to 7
        end
    end
    MF_10Hz_logic(n,1) = LH.MaleFasted.greater50(n);
end

MF_10Hz = MF_10Hz(MF_10Hz_logic,:);

clear MF_10Hz_logic m n

MF_20Hz = {};
for n = 1:length(LH.MaleFasted.TRAIN.twentyHz)
    if LH.MaleFasted.greater50(n) == 1
        MF_20Hz(n,1) = {'Male Fasted'};
        MF_20Hz(n,2) = {'20 Hz'};
        MF_20Hz(n,3) = {LH.MaleFasted.TRAIN.twentyHz(n).name};
        MF_20Hz(n,4) = {LH.MaleFasted.TRAIN.twentyHz(n).acq};
        for m = 1:length(LH.MaleFasted.TRAIN.twentyHz(n).envelope)
            MF_20Hz(n,4+m) = {LH.MaleFasted.TRAIN.twentyHz(n).envelope(m).mV}; % Will be from 4 to 7
        end
    end
    MF_20Hz_logic(n,1) = LH.MaleFasted.greater50(n);
end

MF_20Hz = MF_20Hz(MF_20Hz_logic,:);

clear MF_20Hz_logic m n


% Female Control
FC_5Hz = {};
for n = 1:length(LH.FemaleControl.TRAIN.fiveHz)
    if LH.FemaleControl.greater50(n) == 1
        FC_5Hz(n,1) = {'Female Control'};
        FC_5Hz(n,2) = {'5 Hz'};
        FC_5Hz(n,3) = {LH.FemaleControl.TRAIN.fiveHz(n).name};
        FC_5Hz(n,4) = {LH.FemaleControl.TRAIN.fiveHz(n).acq};
        for m = 1:length(LH.FemaleControl.TRAIN.fiveHz(n).envelope)
            FC_5Hz(n,4+m) = {LH.FemaleControl.TRAIN.fiveHz(n).envelope(m).mV}; % Will be from 4 to 7
        end
    end
    FC_5Hz_logic(n,1) = LH.FemaleControl.greater50(n);
end

FC_5Hz = FC_5Hz(FC_5Hz_logic,:);

clear FC_5Hz_logic m n

FC_10Hz = {};
for n = 1:length(LH.FemaleControl.TRAIN.tenHz)
    if LH.FemaleControl.greater50(n) == 1
        FC_10Hz(n,1) = {'Female Control'};
        FC_10Hz(n,2) = {'10 Hz'};
        FC_10Hz(n,3) = {LH.FemaleControl.TRAIN.tenHz(n).name};
        FC_10Hz(n,4) = {LH.FemaleControl.TRAIN.tenHz(n).acq};
        for m = 1:length(LH.FemaleControl.TRAIN.tenHz(n).envelope)
            FC_10Hz(n,4+m) = {LH.FemaleControl.TRAIN.tenHz(n).envelope(m).mV}; % Will be from 4 to 7
        end
    end
    FC_10Hz_logic(n,1) = LH.FemaleControl.greater50(n);
end

FC_10Hz = FC_10Hz(FC_10Hz_logic,:);

clear FC_10Hz_logic m n

FC_20Hz = {};
for n = 1:length(LH.FemaleControl.TRAIN.twentyHz)
    if LH.FemaleControl.greater50(n) == 1
        FC_20Hz(n,1) = {'Female Control'};
        FC_20Hz(n,2) = {'20 Hz'};
        FC_20Hz(n,3) = {LH.FemaleControl.TRAIN.twentyHz(n).name};
        FC_20Hz(n,4) = {LH.FemaleControl.TRAIN.twentyHz(n).acq};
        for m = 1:length(LH.FemaleControl.TRAIN.twentyHz(n).envelope)
            FC_20Hz(n,4+m) = {LH.FemaleControl.TRAIN.twentyHz(n).envelope(m).mV}; % Will be from 4 to 7
        end
    end
    FC_20Hz_logic(n,1) = LH.FemaleControl.greater50(n);
end

FC_20Hz = FC_20Hz(FC_20Hz_logic,:);

clear FC_20Hz_logic m n


% Female Fasted
FF_5Hz = {};
for n = 1:length(LH.FemaleFasted.TRAIN.fiveHz)
    if LH.FemaleFasted.greater50(n) == 1
        FF_5Hz(n,1) = {'Female Fasted'};
        FF_5Hz(n,2) = {'5 Hz'};
        FF_5Hz(n,3) = {LH.FemaleFasted.TRAIN.fiveHz(n).name};
        FF_5Hz(n,4) = {LH.FemaleFasted.TRAIN.fiveHz(n).acq};
        for m = 1:length(LH.FemaleFasted.TRAIN.fiveHz(n).envelope)
            FF_5Hz(n,4+m) = {LH.FemaleFasted.TRAIN.fiveHz(n).envelope(m).mV}; % Will be from 4 to 7
        end
    end
    FF_5Hz_logic(n,1) = LH.FemaleFasted.greater50(n);
end

FF_5Hz = FF_5Hz(FF_5Hz_logic,:);

clear FF_5Hz_logic m n

FF_10Hz = {};
for n = 1:length(LH.FemaleFasted.TRAIN.tenHz)
    if LH.FemaleFasted.greater50(n) == 1
        FF_10Hz(n,1) = {'Female Fasted'};
        FF_10Hz(n,2) = {'10 Hz'};
        FF_10Hz(n,3) = {LH.FemaleFasted.TRAIN.tenHz(n).name};
        FF_10Hz(n,4) = {LH.FemaleFasted.TRAIN.tenHz(n).acq};
        for m = 1:length(LH.FemaleFasted.TRAIN.tenHz(n).envelope)
            FF_10Hz(n,4+m) = {LH.FemaleFasted.TRAIN.tenHz(n).envelope(m).mV}; % Will be from 4 to 7
        end
    end
    FF_10Hz_logic(n,1) = LH.FemaleFasted.greater50(n);
end

FF_10Hz = FF_10Hz(FF_10Hz_logic,:);

clear FF_10Hz_logic m n

FF_20Hz = {};
for n = 1:length(LH.FemaleFasted.TRAIN.twentyHz)
    if LH.FemaleFasted.greater50(n) == 1
        FF_20Hz(n,1) = {'Female Fasted'};
        FF_20Hz(n,2) = {'20 Hz'};
        FF_20Hz(n,3) = {LH.FemaleFasted.TRAIN.twentyHz(n).name};
        FF_20Hz(n,4) = {LH.FemaleFasted.TRAIN.twentyHz(n).acq};
        for m = 1:length(LH.FemaleFasted.TRAIN.twentyHz(n).envelope)
            FF_20Hz(n,4+m) = {LH.FemaleFasted.TRAIN.twentyHz(n).envelope(m).mV}; % Will be from 4 to 7
        end
    end
    FF_20Hz_logic(n,1) = LH.FemaleFasted.greater50(n);
end

FF_20Hz = FF_20Hz(FF_20Hz_logic,:);

clear FF_20Hz_logic m n

N_5Hz = [{''} {''} {''} {''} {nan} {nan} {nan} {nan}];
fiveHz_array = [MC_5Hz; N_5Hz; MF_5Hz; N_5Hz; FC_5Hz; N_5Hz; FF_5Hz];

N_10Hz = [{''} {''} {''} {''} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan}];
tenHz_array = [MC_10Hz; N_10Hz; MF_10Hz; N_10Hz; FC_10Hz; N_10Hz; FF_10Hz];

N_20Hz = [{''} {''} {''} {''} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan} {nan}];
twentyHz_array = [MC_20Hz; N_20Hz; MF_20Hz; N_20Hz; FC_20Hz; N_20Hz; FF_20Hz];

clear MC_5Hz MF_5Hz FC_5Hz FF_5Hz N_5Hz
clear MC_10Hz MF_10Hz FC_10Hz FF_10Hz N_10Hz
clear MC_20Hz MF_20Hz FC_20Hz FF_20Hz N_20Hz

LH.tables.fiveHz_envelope = array2table(fiveHz_array, 'VariableNames', {'Group', 'Frequency', 'Cell', 'Recording', 'Pulse_1', 'Pulse_2', 'Pulse_3', 'Pulse_4'});
LH.tables.tenHz_envelope = array2table(tenHz_array, 'VariableNames', {'Group', 'Frequency', 'Cell', 'Recording', 'Pulse_1', 'Pulse_2', 'Pulse_3', 'Pulse_4', 'Pulse_5', 'Pulse_6', 'Pulse_7', 'Pulse_8', 'Pulse_9'});
LH.tables.twentyHz_envelope = array2table(twentyHz_array, 'VariableNames', {'Group', 'Frequency', 'Cell', 'Recording', 'Pulse_1', 'Pulse_2', 'Pulse_3', 'Pulse_4', 'Pulse_5', 'Pulse_6', 'Pulse_7', 'Pulse_8', 'Pulse_9', 'Pulse_10', 'Pulse_11', 'Pulse_12', 'Pulse_13', 'Pulse_14', 'Pulse_15', 'Pulse_16', 'Pulse_17', 'Pulse_18' 'Pulse_19'});

clear fiveHz_array tenHz_array twentyHz_array

%% Save file
cd(file_path);
save (filename, '-v7.3') 
%% Write table for envelope current

writetable(LH.tables.fiveHz_envelope,'LHinput_envelope.xlsx','Sheet','fiveHz','Range','A1');
writetable(LH.tables.tenHz_envelope,'LHinput_envelope.xlsx','Sheet','tenHz','Range','A1');
writetable(LH.tables.twentyHz_envelope,'LHinput_envelope.xlsx','Sheet','twentyHz','Range','A1');



%% Test

figure
hold on
plot(LH.FemaleFasted.TRAIN.fiveHz(2).X, LH.FemaleFasted.TRAIN.fiveHz(2).trace)
plot([LH.FemaleFasted.TRAIN.fiveHz(2).peakTime], [LH.FemaleFasted.TRAIN.fiveHz(2).peakAmplitude], 'r*')
plot([LH.FemaleFasted.TRAIN.fiveHz(2).envelope.times], [LH.FemaleFasted.TRAIN.fiveHz(2).envelope.mV], 'g*')






