%{
This script is for binning my strontium data (IPSC number and amplitude) in
100 ms intervals for 1000 ms following the optically induced current.
%}


% I imported the Strontium_Directory as a one-time import

%{
To create my directory, that I manually import here, I used a script that I
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

% Load the other strontium file with just averages.
load Strontium
Strontium = rmfield(Strontium, 'excluded30');

%% Importing my data

for n = 1:length(Strontium)
    Strontium(n).data = importStrontiumData('/Users/nathansmac/Desktop/VTA_INPUTS/Strontium/Strontium.xlsx', Strontium(n).tabname, [4, Strontium(n).length]);
end
clear n

%% Saving my opto stim as structure with time and length in milli seconds

OPTO.time_ms = 1.0468 * 1000;
OPTO.length_ms = 3;
OPTO.sweep_ms = 3 * 1000;   % 3 second long sweep (3000 ms)

%% Establishing my detection parameters
%{
Binning my data into 100 ms intervals
%}

Detection(1).sweep = 'sweep_1';
Detection(1).start = [OPTO.time_ms + 0; OPTO.time_ms + 50; OPTO.time_ms + 100;
                      OPTO.time_ms + 150; OPTO.time_ms + 200; OPTO.time_ms + 250;
                      OPTO.time_ms + 300; OPTO.time_ms + 350; OPTO.time_ms + 400;
                      OPTO.time_ms + 450; OPTO.time_ms + 500; OPTO.time_ms + 550;
                      OPTO.time_ms + 600; OPTO.time_ms + 650; OPTO.time_ms + 700;
                      OPTO.time_ms + 750; OPTO.time_ms + 800; OPTO.time_ms + 850;
                      OPTO.time_ms + 900; OPTO.time_ms + 950];
Detection(1).stop = [OPTO.time_ms + 50; OPTO.time_ms + 100; OPTO.time_ms + 150;
                     OPTO.time_ms + 200; OPTO.time_ms + 250; OPTO.time_ms + 300;
                     OPTO.time_ms + 350; OPTO.time_ms + 400; OPTO.time_ms + 450;
                     OPTO.time_ms + 500; OPTO.time_ms + 550; OPTO.time_ms + 600;
                     OPTO.time_ms + 650; OPTO.time_ms + 700; OPTO.time_ms + 750;
                     OPTO.time_ms + 800; OPTO.time_ms + 850; OPTO.time_ms + 900;
                     OPTO.time_ms + 950; OPTO.time_ms + 1000];

for n = 1:11
    Detection(n+1).sweep = ['sweep_' int2str(n+1)];
    Detection(n+1).start = Detection(n).start + OPTO.sweep_ms;
    Detection(n+1).stop = Detection(n).stop + OPTO.sweep_ms;
end
clear n

% Getting amplitude and event number per bin in each sweep
for k = 1 : length(Strontium)
    for n = 1 : length(Detection)
        for m = 1 : length(Detection(n).start)
            Strontium(k).Bin(m).Sweep(n).Amplitude = [];
            for l = 1 : height(Strontium(k).data)
                if Strontium(k).data.Time_ms_(l) > Detection(n).start(m) & Strontium(k).data.Time_ms_(l) <= Detection(n).stop(m)
                    Strontium(k).Bin(m).Sweep(n).Amplitude = [Strontium(k).Bin(m).Sweep(n).Amplitude Strontium(k).data.Amplitude(l)];
                end
            end
            Strontium(k).Bin(m).Sweep(n).meanAmplitude = mean(Strontium(k).Bin(m).Sweep(n).Amplitude);
            Strontium(k).Bin(m).Sweep(n).Events = length(Strontium(k).Bin(m).Sweep(n).Amplitude);
        end
    end
end
clear k n m l

% Getting the average amplitude and event number per bin across the 12
% sweeps
for k = 1 : length(Strontium)
    for n = 1 : length(Strontium(k).Bin)
        Strontium(k).Bin(n).MEANAmplitude = nanmean([Strontium(k).Bin(n).Sweep(1).meanAmplitude;
                                                 Strontium(k).Bin(n).Sweep(2).meanAmplitude;
                                                 Strontium(k).Bin(n).Sweep(3).meanAmplitude;
                                                 Strontium(k).Bin(n).Sweep(4).meanAmplitude;
                                                 Strontium(k).Bin(n).Sweep(5).meanAmplitude;
                                                 Strontium(k).Bin(n).Sweep(6).meanAmplitude;
                                                 Strontium(k).Bin(n).Sweep(7).meanAmplitude;
                                                 Strontium(k).Bin(n).Sweep(8).meanAmplitude;
                                                 Strontium(k).Bin(n).Sweep(9).meanAmplitude;
                                                 Strontium(k).Bin(n).Sweep(10).meanAmplitude;
                                                 Strontium(k).Bin(n).Sweep(11).meanAmplitude;
                                                 Strontium(k).Bin(n).Sweep(12).meanAmplitude]);
        Strontium(k).Bin(n).MEANEvents = mean([Strontium(k).Bin(n).Sweep(1).Events;
                                               Strontium(k).Bin(n).Sweep(2).Events;
                                               Strontium(k).Bin(n).Sweep(3).Events;
                                               Strontium(k).Bin(n).Sweep(4).Events;
                                               Strontium(k).Bin(n).Sweep(5).Events;
                                               Strontium(k).Bin(n).Sweep(6).Events;
                                               Strontium(k).Bin(n).Sweep(7).Events;
                                               Strontium(k).Bin(n).Sweep(8).Events;
                                               Strontium(k).Bin(n).Sweep(9).Events;
                                               Strontium(k).Bin(n).Sweep(10).Events;
                                               Strontium(k).Bin(n).Sweep(11).Events;
                                               Strontium(k).Bin(n).Sweep(12).Events]);
    end
end
clear k n

% Give a different name than the other strontium file with just averages.
save Strontium_Bin

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
%% Creating tables with the data arranged (peak amplitudes)

% all the data
MC_all = []; MF_all = []; FC_all = []; FF_all = [];
MC_all_name = []; MF_all_name = []; FC_all_name = []; FF_all_name = [];
for n = 1 : length(Strontium)
    if Strontium(n).group == "Male_Control"
        MC_all = [MC_all [Strontium(n).Bin.MEANAmplitude]'];
        c = char(Strontium(n).cellname);
        MC_all_name = [MC_all_name string(c(1:end-11))];
    elseif Strontium(n).group == "Male_Fasted"
        MF_all = [MF_all [Strontium(n).Bin.MEANAmplitude]'];
        c = char(Strontium(n).cellname);
        MF_all_name = [MF_all_name string(c(1:end-11))];
    elseif Strontium(n).group == "Female_Control"
        FC_all = [FC_all [Strontium(n).Bin.MEANAmplitude]'];
        c = char(Strontium(n).cellname);
        FC_all_name = [FC_all_name string(c(1:end-11))];
    elseif Strontium(n).group == "Female_Fasted"
        FF_all = [FF_all [Strontium(n).Bin.MEANAmplitude]'];
        c = char(Strontium(n).cellname);
        FF_all_name = [FF_all_name string(c(1:end-11))];
    end
end
clear n c

Strontium(1).tables.bin.MC.Amplitude.all = array2table(MC_all, 'VariableNames', MC_all_name);
Strontium(1).tables.bin.MF.Amplitude.all = array2table(MF_all, 'VariableNames', MF_all_name);
Strontium(1).tables.bin.FC.Amplitude.all = array2table(FC_all, 'VariableNames', FC_all_name);
Strontium(1).tables.bin.FF.Amplitude.all = array2table(FF_all, 'VariableNames', FF_all_name);

clear MC_all MF_all FC_all FF_all MC_all_name MF_all_name FC_all_name FF_all_name

% greater than 30 pA
MC_30 = []; MF_30 = []; FC_30 = []; FF_30 = [];
MC_30_name = []; MF_30_name = []; FC_30_name = []; FF_30_name = [];
for n = 1 : length(Strontium(1).excluded30)
    if Strontium(1).excluded30(n).group == "Male_Control"
        MC_30 = [MC_30 [Strontium(1).excluded30(n).Bin.MEANAmplitude]'];
        c = char(Strontium(1).excluded30(n).cellname);
        MC_30_name = [MC_30_name string(c(1:end-11))];
    elseif Strontium(1).excluded30(n).group == "Male_Fasted"
        MF_30 = [MF_30 [Strontium(1).excluded30(n).Bin.MEANAmplitude]'];
        c = char(Strontium(1).excluded30(n).cellname);
        MF_30_name = [MF_30_name string(c(1:end-11))];
    elseif Strontium(1).excluded30(n).group == "Female_Control"
        FC_30 = [FC_30 [Strontium(1).excluded30(n).Bin.MEANAmplitude]'];
        c = char(Strontium(1).excluded30(n).cellname);
        FC_30_name = [FC_30_name string(c(1:end-11))];
    elseif Strontium(1).excluded30(n).group == "Female_Fasted"
        FF_30 = [FF_30 [Strontium(1).excluded30(n).Bin.MEANAmplitude]'];
        c = char(Strontium(1).excluded30(n).cellname);
        FF_30_name = [FF_30_name string(c(1:end-11))];
    end
end
clear n c

Strontium(1).tables.bin.MC.Amplitude.thirty = array2table(MC_30, 'VariableNames', MC_30_name);
Strontium(1).tables.bin.MF.Amplitude.thirty = array2table(MF_30, 'VariableNames', MF_30_name);
Strontium(1).tables.bin.FC.Amplitude.thirty = array2table(FC_30, 'VariableNames', FC_30_name);
Strontium(1).tables.bin.FF.Amplitude.thirty = array2table(FF_30, 'VariableNames', FF_30_name);

clear MC_30 MF_30 FC_30 FF_30 MC_30_name MF_30_name FC_30_name FF_30_name

save Strontium_Bin


%% Creating tables with the data arranged (peak amplitudes)

% all the data
MC_all = []; MF_all = []; FC_all = []; FF_all = [];
MC_all_name = []; MF_all_name = []; FC_all_name = []; FF_all_name = [];
for n = 1 : length(Strontium)
    if Strontium(n).group == "Male_Control"
        MC_all = [MC_all [Strontium(n).Bin.MEANEvents]'];
        c = char(Strontium(n).cellname);
        MC_all_name = [MC_all_name string(c(1:end-11))];
    elseif Strontium(n).group == "Male_Fasted"
        MF_all = [MF_all [Strontium(n).Bin.MEANEvents]'];
        c = char(Strontium(n).cellname);
        MF_all_name = [MF_all_name string(c(1:end-11))];
    elseif Strontium(n).group == "Female_Control"
        FC_all = [FC_all [Strontium(n).Bin.MEANEvents]'];
        c = char(Strontium(n).cellname);
        FC_all_name = [FC_all_name string(c(1:end-11))];
    elseif Strontium(n).group == "Female_Fasted"
        FF_all = [FF_all [Strontium(n).Bin.MEANEvents]'];
        c = char(Strontium(n).cellname);
        FF_all_name = [FF_all_name string(c(1:end-11))];
    end
end
clear n c

Strontium(1).tables.bin.MC.Events.all = array2table(MC_all, 'VariableNames', MC_all_name);
Strontium(1).tables.bin.MF.Events.all = array2table(MF_all, 'VariableNames', MF_all_name);
Strontium(1).tables.bin.FC.Events.all = array2table(FC_all, 'VariableNames', FC_all_name);
Strontium(1).tables.bin.FF.Events.all = array2table(FF_all, 'VariableNames', FF_all_name);

clear MC_all MF_all FC_all FF_all MC_all_name MF_all_name FC_all_name FF_all_name

% greater than 30 pA
MC_30 = []; MF_30 = []; FC_30 = []; FF_30 = [];
MC_30_name = []; MF_30_name = []; FC_30_name = []; FF_30_name = [];
for n = 1 : length(Strontium(1).excluded30)
    if Strontium(1).excluded30(n).group == "Male_Control"
        MC_30 = [MC_30 [Strontium(1).excluded30(n).Bin.MEANEvents]'];
        c = char(Strontium(1).excluded30(n).cellname);
        MC_30_name = [MC_30_name string(c(1:end-11))];
    elseif Strontium(1).excluded30(n).group == "Male_Fasted"
        MF_30 = [MF_30 [Strontium(1).excluded30(n).Bin.MEANEvents]'];
        c = char(Strontium(1).excluded30(n).cellname);
        MF_30_name = [MF_30_name string(c(1:end-11))];
    elseif Strontium(1).excluded30(n).group == "Female_Control"
        FC_30 = [FC_30 [Strontium(1).excluded30(n).Bin.MEANEvents]'];
        c = char(Strontium(1).excluded30(n).cellname);
        FC_30_name = [FC_30_name string(c(1:end-11))];
    elseif Strontium(1).excluded30(n).group == "Female_Fasted"
        FF_30 = [FF_30 [Strontium(1).excluded30(n).Bin.MEANEvents]'];
        c = char(Strontium(1).excluded30(n).cellname);
        FF_30_name = [FF_30_name string(c(1:end-11))];
    end
end
clear n c

Strontium(1).tables.bin.MC.Events.thirty = array2table(MC_30, 'VariableNames', MC_30_name);
Strontium(1).tables.bin.MF.Events.thirty = array2table(MF_30, 'VariableNames', MF_30_name);
Strontium(1).tables.bin.FC.Events.thirty = array2table(FC_30, 'VariableNames', FC_30_name);
Strontium(1).tables.bin.FF.Events.thirty = array2table(FF_30, 'VariableNames', FF_30_name);

clear MC_30 MF_30 FC_30 FF_30 MC_30_name MF_30_name FC_30_name FF_30_name

save Strontium_Bin
%% Write tables to excel file

cd /Users/nathansmac/Desktop/VTA_INPUTS/Strontium/
save Strontium_Bin

% Amplitude
writetable(Strontium(1).tables.bin.MC.Amplitude.all,'Strontium_bin_amplitude.xlsx','Sheet','MC_all','Range','A1');
writetable(Strontium(1).tables.bin.MF.Amplitude.all,'Strontium_bin_amplitude.xlsx','Sheet','MF_all','Range','A1');
writetable(Strontium(1).tables.bin.FC.Amplitude.all,'Strontium_bin_amplitude.xlsx','Sheet','FC_all','Range','A1');
writetable(Strontium(1).tables.bin.FF.Amplitude.all,'Strontium_bin_amplitude.xlsx','Sheet','FF_all','Range','A1');

writetable(Strontium(1).tables.bin.MC.Amplitude.thirty,'Strontium_bin_amplitude.xlsx','Sheet','MC_30','Range','A1');
writetable(Strontium(1).tables.bin.MF.Amplitude.thirty,'Strontium_bin_amplitude.xlsx','Sheet','MF_30','Range','A1');
writetable(Strontium(1).tables.bin.FC.Amplitude.thirty,'Strontium_bin_amplitude.xlsx','Sheet','FC_30','Range','A1');
writetable(Strontium(1).tables.bin.FF.Amplitude.thirty,'Strontium_bin_amplitude.xlsx','Sheet','FF_30','Range','A1');

% Events
writetable(Strontium(1).tables.bin.MC.Events.all,'Strontium_bin_events.xlsx','Sheet','MC_all','Range','A1');
writetable(Strontium(1).tables.bin.MF.Events.all,'Strontium_bin_events.xlsx','Sheet','MF_all','Range','A1');
writetable(Strontium(1).tables.bin.FC.Events.all,'Strontium_bin_events.xlsx','Sheet','FC_all','Range','A1');
writetable(Strontium(1).tables.bin.FF.Events.all,'Strontium_bin_events.xlsx','Sheet','FF_all','Range','A1');

writetable(Strontium(1).tables.bin.MC.Events.thirty,'Strontium_bin_events.xlsx','Sheet','MC_30','Range','A1');
writetable(Strontium(1).tables.bin.MF.Events.thirty,'Strontium_bin_events.xlsx','Sheet','MF_30','Range','A1');
writetable(Strontium(1).tables.bin.FC.Events.thirty,'Strontium_bin_events.xlsx','Sheet','FC_30','Range','A1');
writetable(Strontium(1).tables.bin.FF.Events.thirty,'Strontium_bin_events.xlsx','Sheet','FF_30','Range','A1');





