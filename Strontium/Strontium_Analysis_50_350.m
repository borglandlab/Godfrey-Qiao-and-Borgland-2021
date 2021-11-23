%{
This script is for analyzing from 50 to 350 ms after the optically
stimulation pulse (3 ms). This is the time period when the events will be
dominated by LH input.
%}

% I imported the Strontium_Directory as a manual import

%{
Too create my directory, that I manually import here, I used a script that I
wrote in python called Strontium.py. I then mannually added the groups,
cellname and group,using my blinded data file (made from a function that I wrote in python
called FileBlinder.py. I then sorted the data in excel by the cell name. I
then imported it to matlab. The directory is the final sheet of the
Strontium.xlsx file. The variables are: TabName(text), Trial(number),
Blinded(number), Name(text), and Group(text), Length(number), and Notes(text).
I also changed the name to Strontium_Directory.
%}

%{
My structure consists of the following fields:
tabname
cohort
blinded
cellname
group
length
notes
data
Time_ms
Amplitude_pA
frequency
mean_amplitude
frequency_table
mean_amplitude_table
%}

% save and load data:
cd /Users/nathansmac/Desktop/VTA_INPUTS/Strontium/

cd /Users/nathansmac/Documents/MATLAB/MATLAB/Strontium/
addpath('/Users/nathansmac/Documents/MATLAB/MATLAB/')
addpath('/Users/nathansmac/Documents/MATLAB/MATLAB/Strontium/')

for n = 1:height(Strontium_Directory)
    Strontium(n).tabname = Strontium_Directory.TabName(n);
    Strontium(n).cohort = Strontium_Directory.Trial(n);
    Strontium(n).blinded = Strontium_Directory.Blinded(n);
    Strontium(n).cellname = Strontium_Directory.Name(n);
    Strontium(n).group = Strontium_Directory.Group(n);
    Strontium(n).length = Strontium_Directory.Length(n);
    Strontium(n).notes = Strontium_Directory.Notes(n);
end
clear n

%% Importing my data

for n = 1:length(Strontium)
    Strontium(n).data = importStrontiumData('/Users/nathansmac/Desktop/VTA_INPUTS/Strontium/Strontium.xlsx', Strontium(n).tabname, [4, Strontium(n).length]);
end
clear n

%% Saving my opto stim as structure with time and length in milli seconds

OPTO.time_ms = 1.0468 * 1000;
OPTO.length_ms = 3;
OPTO.sweep_ms = 3 * 1000;   % 3 second long sweep (3000 ms)

%% Detecting what events are within the range I am interested in

%% Establishing my detection parameters
%{
I am interested in events that are between 50 to 350 ms following the
optical stimulation occurs. I am also going to identify which events are
from each sweep. There are 12 sweeps, each being 3 seconds long.
%}

Detection(1).sweep = 'sweep_1';
Detection(1).start = OPTO.time_ms + 50;
Detection(1).stop = OPTO.time_ms + 350;

for n = 1:11
    Detection(n+1).sweep = ['sweep_' int2str(n+1)];
    Detection(n+1).start = Detection(1).start + (OPTO.sweep_ms*n);
    Detection(n+1).stop = Detection(1).stop + (OPTO.sweep_ms*n);
end
clear n
%% If this is the first time running it (just imported the data)

for n = 1:length(Strontium)
    for m = 1:length(Detection)
        Strontium(n).data.sweep = Strontium(n).data.Time_ms_ > Detection(m).start & Strontium(n).data.Time_ms_ < Detection(m).stop;
        Strontium(n).data = renamevars(Strontium(n).data, ['sweep'], [Detection(m).sweep]);
    end
end
clear n m sweep

%% If I've already run everything through and am just modifying the parameters, then use the following instead:
for n = 1:length(Strontium)
    for m = 1:length(Detection)
        Strontium(n).data.(Detection(m).sweep) = Strontium(n).data.Time_ms_ > Detection(m).start & Strontium(n).data.Time_ms_ < Detection(m).stop;
    end
end
clear n m sweep

%% Finding time and frequency

% For the time in ms
for n = 1:length(Strontium)
    time_all = Strontium(n).data.Time_ms_(Strontium(n).data.(Detection(1).sweep));
    for m = 2:length(Detection)
        time = Strontium(n).data.Time_ms_(Strontium(n).data.(Detection(m).sweep));
        l_new = length(time);
        l_old = length(time_all(:,m-1));
        if l_new > l_old
            time_all = [time_all; nan(l_new-l_old,m-1)];
        end
        if l_old > l_new
            time = [time; nan(l_old-l_new,1)];
        end
        time_all = [time_all time];
    end
    Strontium(n).Time_ms = array2table(time_all);
    clear time time_all l_new l_old m
    for m = 1:length(Detection)
        Strontium(n).Time_ms.Properties.VariableNames{m} = Detection(m).sweep;
    end
    clear m
end
clear n

% For the amplitude in pA
for n = 1:length(Strontium)
    amplitude_all = Strontium(n).data.Amplitude(Strontium(n).data.(Detection(1).sweep));
    for m = 2:length(Detection)
        amplitude = Strontium(n).data.Amplitude(Strontium(n).data.(Detection(m).sweep));
        l_new = length(amplitude);
        l_old = length(amplitude_all(:,m-1));
        if l_new > l_old
            amplitude_all = [amplitude_all; nan(l_new-l_old,m-1)];
        end
        if l_old > l_new
            amplitude = [amplitude; nan(l_old-l_new,1)];
        end
        amplitude_all = [amplitude_all amplitude];
    end
    Strontium(n).Amplitude_pA = array2table(amplitude_all);
    clear amplitude amplitude_all l_new l_old m
    for m = 1:length(Detection)
        Strontium(n).Amplitude_pA.Properties.VariableNames{m} = Detection(m).sweep;
    end
    clear m
end
clear n

%% Determine the frequency

for n = 1:length(Strontium)
    values = [];
    for m = 1:length(Detection)
        values = [values; table2array(Strontium(n).Time_ms(:,m))];
    end
    index = ~isnan(values);
    values = values(index);
    Strontium(n).frequency = length(values)/(((Detection(1).stop - Detection(1).start)/1000).*12);
end
clear m n values index

%% Determine the average amplitude
for n = 1:length(Strontium)
    values = [];
    for m = 1:length(Detection)
        values = [values; table2array(Strontium(n).Amplitude_pA(:,m))];
    end
    index = ~isnan(values);
    values = values(index);
    Strontium(n).mean_amplitude = mean(values);
end
clear m n values index

%% Creating Average Traces

[Strontium(1).AverageTrace] = plotephys_Strontium_average('All_data')

for n = 1:length(Strontium(1).AverageTrace)
    Strontium(1).AverageTrace(n).greater30 = logical(Strontium(1).AverageTrace(n).peakAmplitude < -30);  % -30 because the currents are negative
end
clear n

for n = 1:length(Strontium)
    Strontium(n).AverageTrace_peak = Strontium(1).AverageTrace(n).peakAmplitude;
end
clear n
%% Excluding cells with average amplitude less than 30 pA

Strontium(1).excluded30 = Strontium;
Strontium(1).excluded30 = rmfield(Strontium(1).excluded30, 'AverageTrace');
for n = 1:length(Strontium)
    m = length(Strontium) - n + 1;
    if Strontium(1).AverageTrace(m).greater30 == logical(1)
        Strontium(1).excluded30(m) = Strontium(1).excluded30(m);
    else
        Strontium(1).excluded30(m) = [];
    end
end
clear m n
%% Creating tables with the data arranged (with exclusions) (30pA)

MC_index = [];
for n = 1:length(Strontium(1).excluded30)
    mc_index = Strontium(1).excluded30(n).group == 'Male_Control';
    MC_index = [MC_index; mc_index];
end
MC_index = logical(MC_index);
clear n mc_index

MF_index = [];
for n = 1:length(Strontium(1).excluded30)
    mf_index = Strontium(1).excluded30(n).group == 'Male_Fasted';
    MF_index = [MF_index; mf_index];
end
MF_index = logical(MF_index);
clear n mf_index
    
FC_index = [];
for n = 1:length(Strontium(1).excluded30)
    fc_index = Strontium(1).excluded30(n).group == 'Female_Control';
    FC_index = [FC_index; fc_index];
end
FC_index = logical(FC_index);
clear n fc_index

FF_index = [];
for n = 1:length(Strontium(1).excluded30)
    ff_index = Strontium(1).excluded30(n).group == 'Female_Fasted';
    FF_index = [FF_index; ff_index];
end
FF_index = logical(FF_index);
clear n ff_index

F = [Strontium(1).excluded30.frequency]';
frequency_array = nan(30,4);
frequency_array(1:length(F(MC_index)),1) = F(MC_index);
frequency_array(1:length(F(MF_index)),2) = F(MF_index);
frequency_array(1:length(F(FC_index)),3) = F(FC_index);
frequency_array(1:length(F(FF_index)),4) = F(FF_index);
Strontium(1).excluded30(1).frequency_table = array2table(frequency_array);
Strontium(1).excluded30(1).frequency_table.Properties.VariableNames{1} = ['Male_Control'];
Strontium(1).excluded30(1).frequency_table.Properties.VariableNames{2} = ['Male_Fasted'];
Strontium(1).excluded30(1).frequency_table.Properties.VariableNames{3} = ['Female_Control'];
Strontium(1).excluded30(1).frequency_table.Properties.VariableNames{4} = ['Female_Fasted'];

A = [Strontium(1).excluded30.mean_amplitude]';
mean_amplitude_array = nan(30,4);
mean_amplitude_array(1:length(A(MC_index)),1) = A(MC_index);
mean_amplitude_array(1:length(A(MF_index)),2) = A(MF_index);
mean_amplitude_array(1:length(A(FC_index)),3) = A(FC_index);
mean_amplitude_array(1:length(A(FF_index)),4) = A(FF_index);
Strontium(1).excluded30(1).mean_amplitude_table = array2table(mean_amplitude_array);
Strontium(1).excluded30(1).mean_amplitude_table.Properties.VariableNames{1} = ['Male_Control'];
Strontium(1).excluded30(1).mean_amplitude_table.Properties.VariableNames{2} = ['Male_Fasted'];
Strontium(1).excluded30(1).mean_amplitude_table.Properties.VariableNames{3} = ['Female_Control'];
Strontium(1).excluded30(1).mean_amplitude_table.Properties.VariableNames{4} = ['Female_Fasted'];

M = [Strontium(1).excluded30.AverageTrace_peak]';
average_peak_array = nan(30,4);
average_peak_array(1:length(M(MC_index)),1) = M(MC_index);
average_peak_array(1:length(M(MF_index)),2) = M(MF_index);
average_peak_array(1:length(M(FC_index)),3) = M(FC_index);
average_peak_array(1:length(M(FF_index)),4) = M(FF_index);
Strontium(1).excluded30(1).AverageTrace_peak_table = array2table(average_peak_array);
Strontium(1).excluded30(1).AverageTrace_peak_table.Properties.VariableNames{1} = ['Male_Control'];
Strontium(1).excluded30(1).AverageTrace_peak_table.Properties.VariableNames{2} = ['Male_Fasted'];
Strontium(1).excluded30(1).AverageTrace_peak_table.Properties.VariableNames{3} = ['Female_Control'];
Strontium(1).excluded30(1).AverageTrace_peak_table.Properties.VariableNames{4} = ['Female_Fasted'];

clear MC_index MF_index FC_index FF_index F frequency_array A mean_amplitude_array average_peak_array M

%% Creating tables with the data arranged (with exclusions) (50pA)

MC_index = [];
for n = 1:length(Strontium(1).excluded50)
    mc_index = Strontium(1).excluded50(n).group == 'Male_Control';
    MC_index = [MC_index; mc_index];
end
MC_index = logical(MC_index);
clear n mc_index

MF_index = [];
for n = 1:length(Strontium(1).excluded50)
    mf_index = Strontium(1).excluded50(n).group == 'Male_Fasted';
    MF_index = [MF_index; mf_index];
end
MF_index = logical(MF_index);
clear n mf_index
    
FC_index = [];
for n = 1:length(Strontium(1).excluded50)
    fc_index = Strontium(1).excluded50(n).group == 'Female_Control';
    FC_index = [FC_index; fc_index];
end
FC_index = logical(FC_index);
clear n fc_index

FF_index = [];
for n = 1:length(Strontium(1).excluded50)
    ff_index = Strontium(1).excluded50(n).group == 'Female_Fasted';
    FF_index = [FF_index; ff_index];
end
FF_index = logical(FF_index);
clear n ff_index

F = [Strontium(1).excluded50.frequency]';
frequency_array = nan(30,4);
frequency_array(1:length(F(MC_index)),1) = F(MC_index);
frequency_array(1:length(F(MF_index)),2) = F(MF_index);
frequency_array(1:length(F(FC_index)),3) = F(FC_index);
frequency_array(1:length(F(FF_index)),4) = F(FF_index);
Strontium(1).excluded50(1).frequency_table = array2table(frequency_array);
Strontium(1).excluded50(1).frequency_table.Properties.VariableNames{1} = ['Male_Control'];
Strontium(1).excluded50(1).frequency_table.Properties.VariableNames{2} = ['Male_Fasted'];
Strontium(1).excluded50(1).frequency_table.Properties.VariableNames{3} = ['Female_Control'];
Strontium(1).excluded50(1).frequency_table.Properties.VariableNames{4} = ['Female_Fasted'];

A = [Strontium(1).excluded50.mean_amplitude]';
mean_amplitude_array = nan(30,4);
mean_amplitude_array(1:length(A(MC_index)),1) = A(MC_index);
mean_amplitude_array(1:length(A(MF_index)),2) = A(MF_index);
mean_amplitude_array(1:length(A(FC_index)),3) = A(FC_index);
mean_amplitude_array(1:length(A(FF_index)),4) = A(FF_index);
Strontium(1).excluded50(1).mean_amplitude_table = array2table(mean_amplitude_array);
Strontium(1).excluded50(1).mean_amplitude_table.Properties.VariableNames{1} = ['Male_Control'];
Strontium(1).excluded50(1).mean_amplitude_table.Properties.VariableNames{2} = ['Male_Fasted'];
Strontium(1).excluded50(1).mean_amplitude_table.Properties.VariableNames{3} = ['Female_Control'];
Strontium(1).excluded50(1).mean_amplitude_table.Properties.VariableNames{4} = ['Female_Fasted'];

M = [Strontium(1).excluded50.AverageTrace_peak]';
average_peak_array = nan(30,4);
average_peak_array(1:length(M(MC_index)),1) = M(MC_index);
average_peak_array(1:length(M(MF_index)),2) = M(MF_index);
average_peak_array(1:length(M(FC_index)),3) = M(FC_index);
average_peak_array(1:length(M(FF_index)),4) = M(FF_index);
Strontium(1).excluded50(1).AverageTrace_peak_table = array2table(average_peak_array);
Strontium(1).excluded50(1).AverageTrace_peak_table.Properties.VariableNames{1} = ['Male_Control'];
Strontium(1).excluded50(1).AverageTrace_peak_table.Properties.VariableNames{2} = ['Male_Fasted'];
Strontium(1).excluded50(1).AverageTrace_peak_table.Properties.VariableNames{3} = ['Female_Control'];
Strontium(1).excluded50(1).AverageTrace_peak_table.Properties.VariableNames{4} = ['Female_Fasted'];

clear MC_index MF_index FC_index FF_index F frequency_array A mean_amplitude_array average_peak_array M

%% Creating tables with the data arranged (without exclusions)

MC_index = [];
for n = 1:length(Strontium)
    mc_index = Strontium(n).group == 'Male_Control';
    MC_index = [MC_index; mc_index];
end
MC_index = logical(MC_index);
clear n mc_index

MF_index = [];
for n = 1:length(Strontium)
    mf_index = Strontium(n).group == 'Male_Fasted';
    MF_index = [MF_index; mf_index];
end
MF_index = logical(MF_index);
clear n mf_index
    
FC_index = [];
for n = 1:length(Strontium)
    fc_index = Strontium(n).group == 'Female_Control';
    FC_index = [FC_index; fc_index];
end
FC_index = logical(FC_index);
clear n fc_index

FF_index = [];
for n = 1:length(Strontium)
    ff_index = Strontium(n).group == 'Female_Fasted';
    FF_index = [FF_index; ff_index];
end
FF_index = logical(FF_index);
clear n ff_index

F = [Strontium.frequency]';
frequency_array = nan(30,4);
frequency_array(1:length(F(MC_index)),1) = F(MC_index);
frequency_array(1:length(F(MF_index)),2) = F(MF_index);
frequency_array(1:length(F(FC_index)),3) = F(FC_index);
frequency_array(1:length(F(FF_index)),4) = F(FF_index);
Strontium(1).frequency_table = array2table(frequency_array);
Strontium(1).frequency_table.Properties.VariableNames{1} = ['Male_Control'];
Strontium(1).frequency_table.Properties.VariableNames{2} = ['Male_Fasted'];
Strontium(1).frequency_table.Properties.VariableNames{3} = ['Female_Control'];
Strontium(1).frequency_table.Properties.VariableNames{4} = ['Female_Fasted'];

A = [Strontium.mean_amplitude]';
mean_amplitude_array = nan(30,4);
mean_amplitude_array(1:length(A(MC_index)),1) = A(MC_index);
mean_amplitude_array(1:length(A(MF_index)),2) = A(MF_index);
mean_amplitude_array(1:length(A(FC_index)),3) = A(FC_index);
mean_amplitude_array(1:length(A(FF_index)),4) = A(FF_index);
Strontium(1).mean_amplitude_table = array2table(mean_amplitude_array);
Strontium(1).mean_amplitude_table.Properties.VariableNames{1} = ['Male_Control'];
Strontium(1).mean_amplitude_table.Properties.VariableNames{2} = ['Male_Fasted'];
Strontium(1).mean_amplitude_table.Properties.VariableNames{3} = ['Female_Control'];
Strontium(1).mean_amplitude_table.Properties.VariableNames{4} = ['Female_Fasted'];

M = [Strontium.AverageTrace_peak]';
average_peak_array = nan(30,4);
average_peak_array(1:length(M(MC_index)),1) = M(MC_index);
average_peak_array(1:length(M(MF_index)),2) = M(MF_index);
average_peak_array(1:length(M(FC_index)),3) = M(FC_index);
average_peak_array(1:length(M(FF_index)),4) = M(FF_index);
Strontium(1).AverageTrace_peak_table = array2table(average_peak_array);
Strontium(1).AverageTrace_peak_table.Properties.VariableNames{1} = ['Male_Control'];
Strontium(1).AverageTrace_peak_table.Properties.VariableNames{2} = ['Male_Fasted'];
Strontium(1).AverageTrace_peak_table.Properties.VariableNames{3} = ['Female_Control'];
Strontium(1).AverageTrace_peak_table.Properties.VariableNames{4} = ['Female_Fasted'];

clear MC_index MF_index FC_index FF_index F frequency_array A mean_amplitude_array average_peak_array M

save Strontium_data_700_1000

%% Write tables to excel file
cd('/Users/nathansmac/Desktop/VTA_INPUTS/Strontium')
%save Strontium_data_50_350

% Table with no exclusions
writetable(Strontium(1).frequency_table,'Strontium_analyzed_50_350.xlsx','Sheet','frequency','Range','A1');
writetable(Strontium(1).mean_amplitude_table,'Strontium_analyzed_50_350.xlsx','Sheet','amplitude','Range','A1');
writetable(Strontium(1).AverageTrace_peak_table,'Strontium_analyzed_50_350.xlsx','Sheet','averagetrace_peak','Range','A1');

% Table for exclusions (30pA)
writetable(Strontium(1).excluded30(1).frequency_table,'Strontium_analyzed_50_350.xlsx','Sheet','frequency_exclusions30','Range','A1');
writetable(Strontium(1).excluded30(1).mean_amplitude_table,'Strontium_analyzed_50_350.xlsx','Sheet','amplitude_exclusions30','Range','A1');
writetable(Strontium(1).excluded30(1).AverageTrace_peak_table,'Strontium_analyzed_50_350.xlsx','Sheet','averagetrace_peak_exclusions30','Range','A1');