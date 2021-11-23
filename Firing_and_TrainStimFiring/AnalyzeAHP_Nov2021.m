%{
I used this script to analyze the 100pA 1 second current steps with and
without a 20Hz optogenetic stimulation.
Properties that I analyzed were:
- Action potential peak amplitude (mV)
- Action potential peak time (data points, seconds, relative seconds, and
relative ms)
- Action potential antipeak amplitude (mV)
- Action potential antipeak time (data points, seconds, relative seconds,
and relative ms)
- Action potential event start amplitude (mV) (This was calculated as 3 ms
before the peak - used to calculate the AHP)
- Action potential event start time (data points, seconds, relative
seconds, and relative ms)
- After-hyperpolarization (AHP) of action potentials
- Latency to fire

The action potential number, peak amplitude, antipeak amplitude, and AHP
are binned in 100ms intervals.

The action potential number, peak amplitude, antipeak amplitude, and AHP
are also averaged or summed for the final 300 ms in an attempt to look at
the depolarization block that occured in some cells.

%}

%% directory to MATLAB Folder
cd /Users/nathansmac/Documents/MATLAB/MATLAB/Trains_InputStrength/Firing/

%% Save Structure
save AHP.mat
%% Male Control preOPTO
% Using the GetAHP function to get the peak amplitude (mV), peak location, antipeak amplitude
% (mV), antipeak location, event start (3 ms before the peak), and after-hyperpolarization
% (mV).
directory = '/Users/nathansmac/Desktop/Firing/2020/MaleControl/preOPTO/';
list = dir(directory);
for n = 1 : length(list)
    if ~isdir(list(n).name)
        filename = list(n).name;
        AHP.MaleControl.preOPTO(n) = GetAHP_preOPTO(directory, filename);
    end
end
clear n list directory filename
%% Male Control OPTO
directory = '/Users/nathansmac/Desktop/Firing/2020/MaleControl/OPTO/';
list = dir(directory);
for n = 1 : length(list)
    if ~isdir(list(n).name)
        filename = list(n).name;
        AHP.MaleControl.OPTO(n) = GetAHP_OPTO(directory, filename);
    end
end
clear n list directory filename
%% Male Fasted preOPTO
directory = '/Users/nathansmac/Desktop/Firing/2020/MaleFasted/preOPTO/';
list = dir(directory);
for n = 14%12 : 13%length(list)
    if ~isdir(list(n).name)
        filename = list(n).name;
        AHP.MaleFasted.preOPTO(n) = GetAHP_preOPTO(directory, filename);
    end
end
clear n list directory filename
%% Male Fasted OPTO
directory = '/Users/nathansmac/Desktop/Firing/2020/MaleFasted/OPTO/';
list = dir(directory);
for n = 14%12 : 13%length(list)
    if ~isdir(list(n).name)
        filename = list(n).name;
        AHP.MaleFasted.OPTO(n) = GetAHP_OPTO(directory, filename);
    end
end
clear n list directory filename
%% Female Control preOPTO
directory = '/Users/nathansmac/Desktop/Firing/2020/FemaleControl/preOPTO/';
list = dir(directory);
for n = 15%13 : 14%length(list)
    if ~isdir(list(n).name)
        filename = list(n).name;
        AHP.FemaleControl.preOPTO(n) = GetAHP_preOPTO(directory, filename);
    end
end
clear n list directory filename
%% Female Control OPTO
directory = '/Users/nathansmac/Desktop/Firing/2020/FemaleControl/OPTO/';
list = dir(directory);
for n = 4 : length(list)
    if ~isdir(list(n).name)
        filename = list(n).name;
        AHP.FemaleControl.OPTO(n) = GetAHP_OPTO(directory, filename);
    end
end
clear n list directory filename
%% Female Fasted preOPTO
directory = '/Users/nathansmac/Desktop/Firing/2020/FemaleFasted/preOPTO/';
list = dir(directory);
for n = 12 : length(list)
    if ~isdir(list(n).name)
        filename = list(n).name;
        AHP.FemaleFasted.preOPTO(n) = GetAHP_preOPTO(directory, filename);
    end
end
clear n list directory filename
%% Female Fasted OPTO
directory = '/Users/nathansmac/Desktop/Firing/2020/FemaleFasted/OPTO/';
list = dir(directory);
for n = 12 : length(list)
    if ~isdir(list(n).name)
        filename = list(n).name;
        AHP.FemaleFasted.OPTO(n) = GetAHP_OPTO(directory, filename);
    end
end
clear n list directory filename
%% Deleting the blank fields
AHP.MaleControl.preOPTO(1:2) = [];
AHP.MaleControl.OPTO(1:2) = [];
AHP.MaleFasted.preOPTO(1:2) = [];
AHP.MaleFasted.OPTO(1:2) = [];
AHP.FemaleControl.preOPTO(1:2) = [];
AHP.FemaleControl.OPTO(1:2) = [];
AHP.FemaleFasted.preOPTO(1:2) = [];
AHP.FemaleFasted.OPTO(1:2) = [];

%% Removes negative AHP from first peak in sweeps

% Male Control preOPTO
for n = 1 : length(AHP.MaleControl.preOPTO)
    for m = 1 : length(AHP.MaleControl.preOPTO(n).AHP)
        if AHP.MaleControl.preOPTO(n).AHP(m).mV(1) <= 0
            AHP.MaleControl.preOPTO(n).AHP(m).mV(1) = nan;
            AHP.MaleControl.preOPTO(n).eventstart(m).mV(1) = nan;
            AHP.MaleControl.preOPTO(n).eventstart(m).location.data(1) = nan;
            AHP.MaleControl.preOPTO(n).eventstart(m).location.seconds(1) = nan;
            AHP.MaleControl.preOPTO(n).eventstart(m).location.relativeseconds(1) = nan;
            AHP.MaleControl.preOPTO(n).eventstart(m).location.relativems(1) = nan;
        end
    end
end
clear n m

% Male Control OPTO
for n = 1 : length(AHP.MaleControl.OPTO)
    for m = 1 : length(AHP.MaleControl.OPTO(n).AHP)
        if AHP.MaleControl.OPTO(n).AHP(m).mV(1) <= 0
            AHP.MaleControl.OPTO(n).AHP(m).mV(1) = nan;
            AHP.MaleControl.OPTO(n).eventstart(m).mV(1) = nan;
            AHP.MaleControl.OPTO(n).eventstart(m).location.data(1) = nan;
            AHP.MaleControl.OPTO(n).eventstart(m).location.seconds(1) = nan;
            AHP.MaleControl.OPTO(n).eventstart(m).location.relativeseconds(1) = nan;
            AHP.MaleControl.OPTO(n).eventstart(m).location.relativems(1) = nan;
        end
    end
end
clear n m

% Male Fasted preOPTO
for n = 1 : length(AHP.MaleFasted.preOPTO)
    for m = 1 : length(AHP.MaleFasted.preOPTO(n).AHP)
        if AHP.MaleFasted.preOPTO(n).AHP(m).mV(1) <= 0
            AHP.MaleFasted.preOPTO(n).AHP(m).mV(1) = nan;
            AHP.MaleFasted.preOPTO(n).eventstart(m).mV(1) = nan;
            AHP.MaleFasted.preOPTO(n).eventstart(m).location.data(1) = nan;
            AHP.MaleFasted.preOPTO(n).eventstart(m).location.seconds(1) = nan;
            AHP.MaleFasted.preOPTO(n).eventstart(m).location.relativeseconds(1) = nan;
            AHP.MaleFasted.preOPTO(n).eventstart(m).location.relativems(1) = nan;
        end
    end
end
clear n m

% Male Fasted OPTO
for n = 1 : length(AHP.MaleFasted.OPTO)
    for m = 1 : length(AHP.MaleFasted.OPTO(n).AHP)
        if AHP.MaleFasted.OPTO(n).AHP(m).mV(1) <= 0
            AHP.MaleFasted.OPTO(n).AHP(m).mV(1) = nan;
            AHP.MaleFasted.OPTO(n).eventstart(m).mV(1) = nan;
            AHP.MaleFasted.OPTO(n).eventstart(m).location.data(1) = nan;
            AHP.MaleFasted.OPTO(n).eventstart(m).location.seconds(1) = nan;
            AHP.MaleFasted.OPTO(n).eventstart(m).location.relativeseconds(1) = nan;
            AHP.MaleFasted.OPTO(n).eventstart(m).location.relativems(1) = nan;
        end
    end
end
clear n m

% Female Control preOPTO
for n = 1 : length(AHP.FemaleControl.preOPTO)
    for m = 1 : length(AHP.FemaleControl.preOPTO(n).AHP)
        if AHP.FemaleControl.preOPTO(n).AHP(m).mV(1) <= 0
            AHP.FemaleControl.preOPTO(n).AHP(m).mV(1) = nan;
            AHP.FemaleControl.preOPTO(n).eventstart(m).mV(1) = nan;
            AHP.FemaleControl.preOPTO(n).eventstart(m).location.data(1) = nan;
            AHP.FemaleControl.preOPTO(n).eventstart(m).location.seconds(1) = nan;
            AHP.FemaleControl.preOPTO(n).eventstart(m).location.relativeseconds(1) = nan;
            AHP.FemaleControl.preOPTO(n).eventstart(m).location.relativems(1) = nan;
        end
    end
end
clear n m

% Female Control OPTO
for n = 1 : length(AHP.FemaleControl.OPTO)
    for m = 1 : length(AHP.FemaleControl.OPTO(n).AHP)
        if AHP.FemaleControl.OPTO(n).AHP(m).mV(1) <= 0
            AHP.FemaleControl.OPTO(n).AHP(m).mV(1) = nan;
            AHP.FemaleControl.OPTO(n).eventstart(m).mV(1) = nan;
            AHP.FemaleControl.OPTO(n).eventstart(m).location.data(1) = nan;
            AHP.FemaleControl.OPTO(n).eventstart(m).location.seconds(1) = nan;
            AHP.FemaleControl.OPTO(n).eventstart(m).location.relativeseconds(1) = nan;
            AHP.FemaleControl.OPTO(n).eventstart(m).location.relativems(1) = nan;
        end
    end
end
clear n m

% Female Fasted preOPTO
for n = 1 : length(AHP.FemaleFasted.preOPTO)
    for m = 1 : length(AHP.FemaleFasted.preOPTO(n).AHP)
        if AHP.FemaleFasted.preOPTO(n).AHP(m).mV(1) <= 0
            AHP.FemaleFasted.preOPTO(n).AHP(m).mV(1) = nan;
            AHP.FemaleFasted.preOPTO(n).eventstart(m).mV(1) = nan;
            AHP.FemaleFasted.preOPTO(n).eventstart(m).location.data(1) = nan;
            AHP.FemaleFasted.preOPTO(n).eventstart(m).location.seconds(1) = nan;
            AHP.FemaleFasted.preOPTO(n).eventstart(m).location.relativeseconds(1) = nan;
            AHP.FemaleFasted.preOPTO(n).eventstart(m).location.relativems(1) = nan;
        end
    end
end
clear n m

% Female Fasted OPTO
for n = 1 : length(AHP.FemaleFasted.OPTO)
    for m = 1 : length(AHP.FemaleFasted.OPTO(n).AHP)
        if AHP.FemaleFasted.OPTO(n).AHP(m).mV(1) <= 0
            AHP.FemaleFasted.OPTO(n).AHP(m).mV(1) = nan;
            AHP.FemaleFasted.OPTO(n).eventstart(m).mV(1) = nan;
            AHP.FemaleFasted.OPTO(n).eventstart(m).location.data(1) = nan;
            AHP.FemaleFasted.OPTO(n).eventstart(m).location.seconds(1) = nan;
            AHP.FemaleFasted.OPTO(n).eventstart(m).location.relativeseconds(1) = nan;
            AHP.FemaleFasted.OPTO(n).eventstart(m).location.relativems(1) = nan;
        end
    end
end
clear n m

%% Time of First Peak (Latency to fire)
% Male Control
% Male Control preOPTO
for n = 1 : length(AHP.MaleControl.preOPTO)
    AHP.MaleControl.preOPTO(n).latency2fire = [];
    for m = 1 : length(AHP.MaleControl.preOPTO(n).peaks)
        AHP.MaleControl.preOPTO(n).latency2fire = [AHP.MaleControl.preOPTO(n).latency2fire; AHP.MaleControl.preOPTO(n).peaks(m).location.relativems(1)];
    end
end

% Mean lantency to fire
for n = 1 : length(AHP.MaleControl.preOPTO)
    AHP.MaleControl.preOPTO(n).Mean_latency2fire = nanmean(AHP.MaleControl.preOPTO(n).latency2fire);
end

% Male Control OPTO
for n = 1 : length(AHP.MaleControl.OPTO)
    AHP.MaleControl.OPTO(n).latency2fire = [];
    for m = 1 : length(AHP.MaleControl.OPTO(n).peaks)
        AHP.MaleControl.OPTO(n).latency2fire = [AHP.MaleControl.OPTO(n).latency2fire; AHP.MaleControl.OPTO(n).peaks(m).location.relativems(1)];
    end
end

% Mean lantency to fire
for n = 1 : length(AHP.MaleControl.OPTO)
    AHP.MaleControl.OPTO(n).Mean_latency2fire = nanmean(AHP.MaleControl.OPTO(n).latency2fire);
end


% Male Fasted
% Male Fasted preOPTO
for n = 1 : length(AHP.MaleFasted.preOPTO)
    AHP.MaleFasted.preOPTO(n).latency2fire = [];
    for m = 1 : length(AHP.MaleFasted.preOPTO(n).peaks)
        AHP.MaleFasted.preOPTO(n).latency2fire = [AHP.MaleFasted.preOPTO(n).latency2fire; AHP.MaleFasted.preOPTO(n).peaks(m).location.relativems(1)];
    end
end

% Mean lantency to fire
for n = 1 : length(AHP.MaleFasted.preOPTO)
    AHP.MaleFasted.preOPTO(n).Mean_latency2fire = nanmean(AHP.MaleFasted.preOPTO(n).latency2fire);
end

% Male Fasted OPTO
for n = 1 : length(AHP.MaleFasted.OPTO)
    AHP.MaleFasted.OPTO(n).latency2fire = [];
    for m = 1 : length(AHP.MaleFasted.OPTO(n).peaks)
        AHP.MaleFasted.OPTO(n).latency2fire = [AHP.MaleFasted.OPTO(n).latency2fire; AHP.MaleFasted.OPTO(n).peaks(m).location.relativems(1)];
    end
end

% Mean lantency to fire
for n = 1 : length(AHP.MaleFasted.OPTO)
    AHP.MaleFasted.OPTO(n).Mean_latency2fire = nanmean(AHP.MaleFasted.OPTO(n).latency2fire);
end


% Female Control
% Female Control preOPTO
for n = 1 : length(AHP.FemaleControl.preOPTO)
    AHP.FemaleControl.preOPTO(n).latency2fire = [];
    for m = 1 : length(AHP.FemaleControl.preOPTO(n).peaks)
        AHP.FemaleControl.preOPTO(n).latency2fire = [AHP.FemaleControl.preOPTO(n).latency2fire; AHP.FemaleControl.preOPTO(n).peaks(m).location.relativems(1)];
    end
end

% Mean lantency to fire
for n = 1 : length(AHP.FemaleControl.preOPTO)
    AHP.FemaleControl.preOPTO(n).Mean_latency2fire = nanmean(AHP.FemaleControl.preOPTO(n).latency2fire);
end

% Female Control OPTO
for n = 1 : length(AHP.FemaleControl.OPTO)
    AHP.FemaleControl.OPTO(n).latency2fire = [];
    for m = 1 : length(AHP.FemaleControl.OPTO(n).peaks)
        AHP.FemaleControl.OPTO(n).latency2fire = [AHP.FemaleControl.OPTO(n).latency2fire; AHP.FemaleControl.OPTO(n).peaks(m).location.relativems(1)];
    end
end

% Mean lantency to fire
for n = 1 : length(AHP.FemaleControl.OPTO)
    AHP.FemaleControl.OPTO(n).Mean_latency2fire = nanmean(AHP.FemaleControl.OPTO(n).latency2fire);
end


% Female Fasted
% Female Fasted preOPTO
for n = 1 : length(AHP.FemaleFasted.preOPTO)
    AHP.FemaleFasted.preOPTO(n).latency2fire = [];
    for m = 1 : length(AHP.FemaleFasted.preOPTO(n).peaks)
        AHP.FemaleFasted.preOPTO(n).latency2fire = [AHP.FemaleFasted.preOPTO(n).latency2fire; AHP.FemaleFasted.preOPTO(n).peaks(m).location.relativems(1)];
    end
end

% Mean lantency to fire
for n = 1 : length(AHP.FemaleFasted.preOPTO)
    AHP.FemaleFasted.preOPTO(n).Mean_latency2fire = nanmean(AHP.FemaleFasted.preOPTO(n).latency2fire);
end

% Female Fasted OPTO
for n = 1 : length(AHP.FemaleFasted.OPTO)
    AHP.FemaleFasted.OPTO(n).latency2fire = [];
    for m = 1 : length(AHP.FemaleFasted.OPTO(n).peaks)
        AHP.FemaleFasted.OPTO(n).latency2fire = [AHP.FemaleFasted.OPTO(n).latency2fire; AHP.FemaleFasted.OPTO(n).peaks(m).location.relativems(1)];
    end
end

% Mean lantency to fire
for n = 1 : length(AHP.FemaleFasted.OPTO)
    AHP.FemaleFasted.OPTO(n).Mean_latency2fire = nanmean(AHP.FemaleFasted.OPTO(n).latency2fire);
end

clear n m

%% Binning Peak Amplitudes (mV)

bin = [0 : 100 : 1000];
% Male Control
% Male Control preOPTO
for n = 1 : length(AHP.MaleControl.preOPTO) % number of cells
    for m = 1 : length(bin) - 1 % 10 bins
        for o = 1 : length(AHP.MaleControl.preOPTO(n).peaks)    % 6 sweeps
            AHP.MaleControl.preOPTO(n).bins(m).sweep(o).peaks = [];
            AHP.MaleControl.preOPTO(n).bins(m).sweep(o).AHP = [];
            for p = 1 : length(AHP.MaleControl.preOPTO(n).peaks(o).location.relativems)
                if AHP.MaleControl.preOPTO(n).peaks(o).location.relativems(p) > bin(m) & AHP.MaleControl.preOPTO(n).peaks(o).location.relativems(p) <= bin(m + 1)
                    AHP.MaleControl.preOPTO(n).bins(m).sweep(o).peaks = [AHP.MaleControl.preOPTO(n).bins(m).sweep(o).peaks; AHP.MaleControl.preOPTO(n).peaks(o).mV(p)];
                    AHP.MaleControl.preOPTO(n).bins(m).sweep(o).AHP = [AHP.MaleControl.preOPTO(n).bins(m).sweep(o).AHP; AHP.MaleControl.preOPTO(n).AHP(o).mV(p)];
                end
                AHP.MaleControl.preOPTO(n).bins(m).sweep(o).AP = length(AHP.MaleControl.preOPTO(n).bins(m).sweep(o).peaks);
                AHP.MaleControl.preOPTO(n).bins(m).sweep(o).mean_peak = nanmean([AHP.MaleControl.preOPTO(n).bins(m).sweep(o).peaks]);
                AHP.MaleControl.preOPTO(n).bins(m).sweep(o).mean_AHP = nanmean([AHP.MaleControl.preOPTO(n).bins(m).sweep(o).AHP]);
            end
        end
        AHP.MaleControl.preOPTO(n).bins(m).average.AP = nanmean([AHP.MaleControl.preOPTO(n).bins(m).sweep(1).AP;
                                                                 AHP.MaleControl.preOPTO(n).bins(m).sweep(2).AP;
                                                                 AHP.MaleControl.preOPTO(n).bins(m).sweep(3).AP;
                                                                 AHP.MaleControl.preOPTO(n).bins(m).sweep(4).AP;
                                                                 AHP.MaleControl.preOPTO(n).bins(m).sweep(5).AP;
                                                                 AHP.MaleControl.preOPTO(n).bins(m).sweep(6).AP]);
        AHP.MaleControl.preOPTO(n).bins(m).average.mean_peak = nanmean([AHP.MaleControl.preOPTO(n).bins(m).sweep(1).mean_peak;
                                                                        AHP.MaleControl.preOPTO(n).bins(m).sweep(2).mean_peak;
                                                                        AHP.MaleControl.preOPTO(n).bins(m).sweep(3).mean_peak;
                                                                        AHP.MaleControl.preOPTO(n).bins(m).sweep(4).mean_peak;
                                                                        AHP.MaleControl.preOPTO(n).bins(m).sweep(5).mean_peak;
                                                                        AHP.MaleControl.preOPTO(n).bins(m).sweep(6).mean_peak]);
        AHP.MaleControl.preOPTO(n).bins(m).average.mean_AHP = nanmean([AHP.MaleControl.preOPTO(n).bins(m).sweep(1).mean_AHP;
                                                                       AHP.MaleControl.preOPTO(n).bins(m).sweep(2).mean_AHP;
                                                                       AHP.MaleControl.preOPTO(n).bins(m).sweep(3).mean_AHP;
                                                                       AHP.MaleControl.preOPTO(n).bins(m).sweep(4).mean_AHP;
                                                                       AHP.MaleControl.preOPTO(n).bins(m).sweep(5).mean_AHP;
                                                                       AHP.MaleControl.preOPTO(n).bins(m).sweep(6).mean_AHP]);
    end
end
clear m n o p

% Male Control OPTO
for n = 1 : length(AHP.MaleControl.OPTO) % number of cells
    for m = 1 : length(bin) - 1 % 10 bins
        for o = 1 : length(AHP.MaleControl.OPTO(n).peaks)    % 6 sweeps
            AHP.MaleControl.OPTO(n).bins(m).sweep(o).peaks = [];
            AHP.MaleControl.OPTO(n).bins(m).sweep(o).AHP = [];
            for p = 1 : length(AHP.MaleControl.OPTO(n).peaks(o).location.relativems)
                if AHP.MaleControl.OPTO(n).peaks(o).location.relativems(p) > bin(m) & AHP.MaleControl.OPTO(n).peaks(o).location.relativems(p) <= bin(m + 1)
                    AHP.MaleControl.OPTO(n).bins(m).sweep(o).peaks = [AHP.MaleControl.OPTO(n).bins(m).sweep(o).peaks; AHP.MaleControl.OPTO(n).peaks(o).mV(p)];
                    AHP.MaleControl.OPTO(n).bins(m).sweep(o).AHP = [AHP.MaleControl.OPTO(n).bins(m).sweep(o).AHP; AHP.MaleControl.OPTO(n).AHP(o).mV(p)];
                end
                AHP.MaleControl.OPTO(n).bins(m).sweep(o).AP = length(AHP.MaleControl.OPTO(n).bins(m).sweep(o).peaks);
                AHP.MaleControl.OPTO(n).bins(m).sweep(o).mean_peak = nanmean([AHP.MaleControl.OPTO(n).bins(m).sweep(o).peaks]);
                AHP.MaleControl.OPTO(n).bins(m).sweep(o).mean_AHP = nanmean([AHP.MaleControl.OPTO(n).bins(m).sweep(o).AHP]);
            end
        end
        AHP.MaleControl.OPTO(n).bins(m).average.AP = nanmean([AHP.MaleControl.OPTO(n).bins(m).sweep(1).AP;
                                                                 AHP.MaleControl.OPTO(n).bins(m).sweep(2).AP;
                                                                 AHP.MaleControl.OPTO(n).bins(m).sweep(3).AP;
                                                                 AHP.MaleControl.OPTO(n).bins(m).sweep(4).AP;
                                                                 AHP.MaleControl.OPTO(n).bins(m).sweep(5).AP;
                                                                 AHP.MaleControl.OPTO(n).bins(m).sweep(6).AP]);
        AHP.MaleControl.OPTO(n).bins(m).average.mean_peak = nanmean([AHP.MaleControl.OPTO(n).bins(m).sweep(1).mean_peak;
                                                                        AHP.MaleControl.OPTO(n).bins(m).sweep(2).mean_peak;
                                                                        AHP.MaleControl.OPTO(n).bins(m).sweep(3).mean_peak;
                                                                        AHP.MaleControl.OPTO(n).bins(m).sweep(4).mean_peak;
                                                                        AHP.MaleControl.OPTO(n).bins(m).sweep(5).mean_peak;
                                                                        AHP.MaleControl.OPTO(n).bins(m).sweep(6).mean_peak]);
        AHP.MaleControl.OPTO(n).bins(m).average.mean_AHP = nanmean([AHP.MaleControl.OPTO(n).bins(m).sweep(1).mean_AHP;
                                                                       AHP.MaleControl.OPTO(n).bins(m).sweep(2).mean_AHP;
                                                                       AHP.MaleControl.OPTO(n).bins(m).sweep(3).mean_AHP;
                                                                       AHP.MaleControl.OPTO(n).bins(m).sweep(4).mean_AHP;
                                                                       AHP.MaleControl.OPTO(n).bins(m).sweep(5).mean_AHP;
                                                                       AHP.MaleControl.OPTO(n).bins(m).sweep(6).mean_AHP]);
    end
end
clear m n o p


% Male Fasted
% Male Fasted preOPTO
for n = 1 : length(AHP.MaleFasted.preOPTO) % number of cells
    for m = 1 : length(bin) - 1 % 10 bins
        for o = 1 : length(AHP.MaleFasted.preOPTO(n).peaks)    % 6 sweeps
            AHP.MaleFasted.preOPTO(n).bins(m).sweep(o).peaks = [];
            AHP.MaleFasted.preOPTO(n).bins(m).sweep(o).AHP = [];
            for p = 1 : length(AHP.MaleFasted.preOPTO(n).peaks(o).location.relativems)
                if AHP.MaleFasted.preOPTO(n).peaks(o).location.relativems(p) > bin(m) & AHP.MaleFasted.preOPTO(n).peaks(o).location.relativems(p) <= bin(m + 1)
                    AHP.MaleFasted.preOPTO(n).bins(m).sweep(o).peaks = [AHP.MaleFasted.preOPTO(n).bins(m).sweep(o).peaks; AHP.MaleFasted.preOPTO(n).peaks(o).mV(p)];
                    AHP.MaleFasted.preOPTO(n).bins(m).sweep(o).AHP = [AHP.MaleFasted.preOPTO(n).bins(m).sweep(o).AHP; AHP.MaleFasted.preOPTO(n).AHP(o).mV(p)];
                end
                AHP.MaleFasted.preOPTO(n).bins(m).sweep(o).AP = length(AHP.MaleFasted.preOPTO(n).bins(m).sweep(o).peaks);
                AHP.MaleFasted.preOPTO(n).bins(m).sweep(o).mean_peak = nanmean([AHP.MaleFasted.preOPTO(n).bins(m).sweep(o).peaks]);
                AHP.MaleFasted.preOPTO(n).bins(m).sweep(o).mean_AHP = nanmean([AHP.MaleFasted.preOPTO(n).bins(m).sweep(o).AHP]);
            end
        end
        AHP.MaleFasted.preOPTO(n).bins(m).average.AP = nanmean([AHP.MaleFasted.preOPTO(n).bins(m).sweep(1).AP;
                                                                 AHP.MaleFasted.preOPTO(n).bins(m).sweep(2).AP;
                                                                 AHP.MaleFasted.preOPTO(n).bins(m).sweep(3).AP;
                                                                 AHP.MaleFasted.preOPTO(n).bins(m).sweep(4).AP;
                                                                 AHP.MaleFasted.preOPTO(n).bins(m).sweep(5).AP;
                                                                 AHP.MaleFasted.preOPTO(n).bins(m).sweep(6).AP]);
        AHP.MaleFasted.preOPTO(n).bins(m).average.mean_peak = nanmean([AHP.MaleFasted.preOPTO(n).bins(m).sweep(1).mean_peak;
                                                                        AHP.MaleFasted.preOPTO(n).bins(m).sweep(2).mean_peak;
                                                                        AHP.MaleFasted.preOPTO(n).bins(m).sweep(3).mean_peak;
                                                                        AHP.MaleFasted.preOPTO(n).bins(m).sweep(4).mean_peak;
                                                                        AHP.MaleFasted.preOPTO(n).bins(m).sweep(5).mean_peak;
                                                                        AHP.MaleFasted.preOPTO(n).bins(m).sweep(6).mean_peak]);
        AHP.MaleFasted.preOPTO(n).bins(m).average.mean_AHP = nanmean([AHP.MaleFasted.preOPTO(n).bins(m).sweep(1).mean_AHP;
                                                                       AHP.MaleFasted.preOPTO(n).bins(m).sweep(2).mean_AHP;
                                                                       AHP.MaleFasted.preOPTO(n).bins(m).sweep(3).mean_AHP;
                                                                       AHP.MaleFasted.preOPTO(n).bins(m).sweep(4).mean_AHP;
                                                                       AHP.MaleFasted.preOPTO(n).bins(m).sweep(5).mean_AHP;
                                                                       AHP.MaleFasted.preOPTO(n).bins(m).sweep(6).mean_AHP]);
    end
end
clear m n o p

% Male Fasted OPTO
for n = 1 : length(AHP.MaleFasted.OPTO) % number of cells
    for m = 1 : length(bin) - 1 % 10 bins
        for o = 1 : length(AHP.MaleFasted.OPTO(n).peaks)    % 6 sweeps
            AHP.MaleFasted.OPTO(n).bins(m).sweep(o).peaks = [];
            AHP.MaleFasted.OPTO(n).bins(m).sweep(o).AHP = [];
            for p = 1 : length(AHP.MaleFasted.OPTO(n).peaks(o).location.relativems)
                if AHP.MaleFasted.OPTO(n).peaks(o).location.relativems(p) > bin(m) & AHP.MaleFasted.OPTO(n).peaks(o).location.relativems(p) <= bin(m + 1)
                    AHP.MaleFasted.OPTO(n).bins(m).sweep(o).peaks = [AHP.MaleFasted.OPTO(n).bins(m).sweep(o).peaks; AHP.MaleFasted.OPTO(n).peaks(o).mV(p)];
                    AHP.MaleFasted.OPTO(n).bins(m).sweep(o).AHP = [AHP.MaleFasted.OPTO(n).bins(m).sweep(o).AHP; AHP.MaleFasted.OPTO(n).AHP(o).mV(p)];
                end
                AHP.MaleFasted.OPTO(n).bins(m).sweep(o).AP = length(AHP.MaleFasted.OPTO(n).bins(m).sweep(o).peaks);
                AHP.MaleFasted.OPTO(n).bins(m).sweep(o).mean_peak = nanmean([AHP.MaleFasted.OPTO(n).bins(m).sweep(o).peaks]);
                AHP.MaleFasted.OPTO(n).bins(m).sweep(o).mean_AHP = nanmean([AHP.MaleFasted.OPTO(n).bins(m).sweep(o).AHP]);
            end
        end
        AHP.MaleFasted.OPTO(n).bins(m).average.AP = nanmean([AHP.MaleFasted.OPTO(n).bins(m).sweep(1).AP;
                                                                 AHP.MaleFasted.OPTO(n).bins(m).sweep(2).AP;
                                                                 AHP.MaleFasted.OPTO(n).bins(m).sweep(3).AP;
                                                                 AHP.MaleFasted.OPTO(n).bins(m).sweep(4).AP;
                                                                 AHP.MaleFasted.OPTO(n).bins(m).sweep(5).AP;
                                                                 AHP.MaleFasted.OPTO(n).bins(m).sweep(6).AP]);
        AHP.MaleFasted.OPTO(n).bins(m).average.mean_peak = nanmean([AHP.MaleFasted.OPTO(n).bins(m).sweep(1).mean_peak;
                                                                        AHP.MaleFasted.OPTO(n).bins(m).sweep(2).mean_peak;
                                                                        AHP.MaleFasted.OPTO(n).bins(m).sweep(3).mean_peak;
                                                                        AHP.MaleFasted.OPTO(n).bins(m).sweep(4).mean_peak;
                                                                        AHP.MaleFasted.OPTO(n).bins(m).sweep(5).mean_peak;
                                                                        AHP.MaleFasted.OPTO(n).bins(m).sweep(6).mean_peak]);
        AHP.MaleFasted.OPTO(n).bins(m).average.mean_AHP = nanmean([AHP.MaleFasted.OPTO(n).bins(m).sweep(1).mean_AHP;
                                                                       AHP.MaleFasted.OPTO(n).bins(m).sweep(2).mean_AHP;
                                                                       AHP.MaleFasted.OPTO(n).bins(m).sweep(3).mean_AHP;
                                                                       AHP.MaleFasted.OPTO(n).bins(m).sweep(4).mean_AHP;
                                                                       AHP.MaleFasted.OPTO(n).bins(m).sweep(5).mean_AHP;
                                                                       AHP.MaleFasted.OPTO(n).bins(m).sweep(6).mean_AHP]);
    end
end
clear m n o p


% Female Control
% Female Control preOPTO
for n = 1 : length(AHP.FemaleControl.preOPTO) % number of cells
    for m = 1 : length(bin) - 1 % 10 bins
        for o = 1 : length(AHP.FemaleControl.preOPTO(n).peaks)    % 6 sweeps
            AHP.FemaleControl.preOPTO(n).bins(m).sweep(o).peaks = [];
            AHP.FemaleControl.preOPTO(n).bins(m).sweep(o).AHP = [];
            for p = 1 : length(AHP.FemaleControl.preOPTO(n).peaks(o).location.relativems)
                if AHP.FemaleControl.preOPTO(n).peaks(o).location.relativems(p) > bin(m) & AHP.FemaleControl.preOPTO(n).peaks(o).location.relativems(p) <= bin(m + 1)
                    AHP.FemaleControl.preOPTO(n).bins(m).sweep(o).peaks = [AHP.FemaleControl.preOPTO(n).bins(m).sweep(o).peaks; AHP.FemaleControl.preOPTO(n).peaks(o).mV(p)];
                    AHP.FemaleControl.preOPTO(n).bins(m).sweep(o).AHP = [AHP.FemaleControl.preOPTO(n).bins(m).sweep(o).AHP; AHP.FemaleControl.preOPTO(n).AHP(o).mV(p)];
                end
                AHP.FemaleControl.preOPTO(n).bins(m).sweep(o).AP = length(AHP.FemaleControl.preOPTO(n).bins(m).sweep(o).peaks);
                AHP.FemaleControl.preOPTO(n).bins(m).sweep(o).mean_peak = nanmean([AHP.FemaleControl.preOPTO(n).bins(m).sweep(o).peaks]);
                AHP.FemaleControl.preOPTO(n).bins(m).sweep(o).mean_AHP = nanmean([AHP.FemaleControl.preOPTO(n).bins(m).sweep(o).AHP]);
            end
        end
        AHP.FemaleControl.preOPTO(n).bins(m).average.AP = nanmean([AHP.FemaleControl.preOPTO(n).bins(m).sweep(1).AP;
                                                                 AHP.FemaleControl.preOPTO(n).bins(m).sweep(2).AP;
                                                                 AHP.FemaleControl.preOPTO(n).bins(m).sweep(3).AP;
                                                                 AHP.FemaleControl.preOPTO(n).bins(m).sweep(4).AP;
                                                                 AHP.FemaleControl.preOPTO(n).bins(m).sweep(5).AP;
                                                                 AHP.FemaleControl.preOPTO(n).bins(m).sweep(6).AP]);
        AHP.FemaleControl.preOPTO(n).bins(m).average.mean_peak = nanmean([AHP.FemaleControl.preOPTO(n).bins(m).sweep(1).mean_peak;
                                                                        AHP.FemaleControl.preOPTO(n).bins(m).sweep(2).mean_peak;
                                                                        AHP.FemaleControl.preOPTO(n).bins(m).sweep(3).mean_peak;
                                                                        AHP.FemaleControl.preOPTO(n).bins(m).sweep(4).mean_peak;
                                                                        AHP.FemaleControl.preOPTO(n).bins(m).sweep(5).mean_peak;
                                                                        AHP.FemaleControl.preOPTO(n).bins(m).sweep(6).mean_peak]);
        AHP.FemaleControl.preOPTO(n).bins(m).average.mean_AHP = nanmean([AHP.FemaleControl.preOPTO(n).bins(m).sweep(1).mean_AHP;
                                                                       AHP.FemaleControl.preOPTO(n).bins(m).sweep(2).mean_AHP;
                                                                       AHP.FemaleControl.preOPTO(n).bins(m).sweep(3).mean_AHP;
                                                                       AHP.FemaleControl.preOPTO(n).bins(m).sweep(4).mean_AHP;
                                                                       AHP.FemaleControl.preOPTO(n).bins(m).sweep(5).mean_AHP;
                                                                       AHP.FemaleControl.preOPTO(n).bins(m).sweep(6).mean_AHP]);
    end
end
clear m n o p

% Female Control OPTO
for n = 1 : length(AHP.FemaleControl.OPTO) % number of cells
    for m = 1 : length(bin) - 1 % 10 bins
        for o = 1 : length(AHP.FemaleControl.OPTO(n).peaks)    % 6 sweeps
            AHP.FemaleControl.OPTO(n).bins(m).sweep(o).peaks = [];
            AHP.FemaleControl.OPTO(n).bins(m).sweep(o).AHP = [];
            for p = 1 : length(AHP.FemaleControl.OPTO(n).peaks(o).location.relativems)
                if AHP.FemaleControl.OPTO(n).peaks(o).location.relativems(p) > bin(m) & AHP.FemaleControl.OPTO(n).peaks(o).location.relativems(p) <= bin(m + 1)
                    AHP.FemaleControl.OPTO(n).bins(m).sweep(o).peaks = [AHP.FemaleControl.OPTO(n).bins(m).sweep(o).peaks; AHP.FemaleControl.OPTO(n).peaks(o).mV(p)];
                    AHP.FemaleControl.OPTO(n).bins(m).sweep(o).AHP = [AHP.FemaleControl.OPTO(n).bins(m).sweep(o).AHP; AHP.FemaleControl.OPTO(n).AHP(o).mV(p)];
                end
                AHP.FemaleControl.OPTO(n).bins(m).sweep(o).AP = length(AHP.FemaleControl.OPTO(n).bins(m).sweep(o).peaks);
                AHP.FemaleControl.OPTO(n).bins(m).sweep(o).mean_peak = nanmean([AHP.FemaleControl.OPTO(n).bins(m).sweep(o).peaks]);
                AHP.FemaleControl.OPTO(n).bins(m).sweep(o).mean_AHP = nanmean([AHP.FemaleControl.OPTO(n).bins(m).sweep(o).AHP]);
            end
        end
        AHP.FemaleControl.OPTO(n).bins(m).average.AP = nanmean([AHP.FemaleControl.OPTO(n).bins(m).sweep(1).AP;
                                                                 AHP.FemaleControl.OPTO(n).bins(m).sweep(2).AP;
                                                                 AHP.FemaleControl.OPTO(n).bins(m).sweep(3).AP;
                                                                 AHP.FemaleControl.OPTO(n).bins(m).sweep(4).AP;
                                                                 AHP.FemaleControl.OPTO(n).bins(m).sweep(5).AP;
                                                                 AHP.FemaleControl.OPTO(n).bins(m).sweep(6).AP]);
        AHP.FemaleControl.OPTO(n).bins(m).average.mean_peak = nanmean([AHP.FemaleControl.OPTO(n).bins(m).sweep(1).mean_peak;
                                                                        AHP.FemaleControl.OPTO(n).bins(m).sweep(2).mean_peak;
                                                                        AHP.FemaleControl.OPTO(n).bins(m).sweep(3).mean_peak;
                                                                        AHP.FemaleControl.OPTO(n).bins(m).sweep(4).mean_peak;
                                                                        AHP.FemaleControl.OPTO(n).bins(m).sweep(5).mean_peak;
                                                                        AHP.FemaleControl.OPTO(n).bins(m).sweep(6).mean_peak]);
        AHP.FemaleControl.OPTO(n).bins(m).average.mean_AHP = nanmean([AHP.FemaleControl.OPTO(n).bins(m).sweep(1).mean_AHP;
                                                                       AHP.FemaleControl.OPTO(n).bins(m).sweep(2).mean_AHP;
                                                                       AHP.FemaleControl.OPTO(n).bins(m).sweep(3).mean_AHP;
                                                                       AHP.FemaleControl.OPTO(n).bins(m).sweep(4).mean_AHP;
                                                                       AHP.FemaleControl.OPTO(n).bins(m).sweep(5).mean_AHP;
                                                                       AHP.FemaleControl.OPTO(n).bins(m).sweep(6).mean_AHP]);
    end
end
clear m n o p


% Female Fasted
% Female Fasted preOPTO
for n = 1 : length(AHP.FemaleFasted.preOPTO) % number of cells
    for m = 1 : length(bin) - 1 % 10 bins
        for o = 1 : length(AHP.FemaleFasted.preOPTO(n).peaks)    % 6 sweeps
            AHP.FemaleFasted.preOPTO(n).bins(m).sweep(o).peaks = [];
            AHP.FemaleFasted.preOPTO(n).bins(m).sweep(o).AHP = [];
            for p = 1 : length(AHP.FemaleFasted.preOPTO(n).peaks(o).location.relativems)
                if AHP.FemaleFasted.preOPTO(n).peaks(o).location.relativems(p) > bin(m) & AHP.FemaleFasted.preOPTO(n).peaks(o).location.relativems(p) <= bin(m + 1)
                    AHP.FemaleFasted.preOPTO(n).bins(m).sweep(o).peaks = [AHP.FemaleFasted.preOPTO(n).bins(m).sweep(o).peaks; AHP.FemaleFasted.preOPTO(n).peaks(o).mV(p)];
                    AHP.FemaleFasted.preOPTO(n).bins(m).sweep(o).AHP = [AHP.FemaleFasted.preOPTO(n).bins(m).sweep(o).AHP; AHP.FemaleFasted.preOPTO(n).AHP(o).mV(p)];
                end
                AHP.FemaleFasted.preOPTO(n).bins(m).sweep(o).AP = length(AHP.FemaleFasted.preOPTO(n).bins(m).sweep(o).peaks);
                AHP.FemaleFasted.preOPTO(n).bins(m).sweep(o).mean_peak = nanmean([AHP.FemaleFasted.preOPTO(n).bins(m).sweep(o).peaks]);
                AHP.FemaleFasted.preOPTO(n).bins(m).sweep(o).mean_AHP = nanmean([AHP.FemaleFasted.preOPTO(n).bins(m).sweep(o).AHP]);
            end
        end
        AHP.FemaleFasted.preOPTO(n).bins(m).average.AP = nanmean([AHP.FemaleFasted.preOPTO(n).bins(m).sweep(1).AP;
                                                                 AHP.FemaleFasted.preOPTO(n).bins(m).sweep(2).AP;
                                                                 AHP.FemaleFasted.preOPTO(n).bins(m).sweep(3).AP;
                                                                 AHP.FemaleFasted.preOPTO(n).bins(m).sweep(4).AP;
                                                                 AHP.FemaleFasted.preOPTO(n).bins(m).sweep(5).AP;
                                                                 AHP.FemaleFasted.preOPTO(n).bins(m).sweep(6).AP]);
        AHP.FemaleFasted.preOPTO(n).bins(m).average.mean_peak = nanmean([AHP.FemaleFasted.preOPTO(n).bins(m).sweep(1).mean_peak;
                                                                        AHP.FemaleFasted.preOPTO(n).bins(m).sweep(2).mean_peak;
                                                                        AHP.FemaleFasted.preOPTO(n).bins(m).sweep(3).mean_peak;
                                                                        AHP.FemaleFasted.preOPTO(n).bins(m).sweep(4).mean_peak;
                                                                        AHP.FemaleFasted.preOPTO(n).bins(m).sweep(5).mean_peak;
                                                                        AHP.FemaleFasted.preOPTO(n).bins(m).sweep(6).mean_peak]);
        AHP.FemaleFasted.preOPTO(n).bins(m).average.mean_AHP = nanmean([AHP.FemaleFasted.preOPTO(n).bins(m).sweep(1).mean_AHP;
                                                                       AHP.FemaleFasted.preOPTO(n).bins(m).sweep(2).mean_AHP;
                                                                       AHP.FemaleFasted.preOPTO(n).bins(m).sweep(3).mean_AHP;
                                                                       AHP.FemaleFasted.preOPTO(n).bins(m).sweep(4).mean_AHP;
                                                                       AHP.FemaleFasted.preOPTO(n).bins(m).sweep(5).mean_AHP;
                                                                       AHP.FemaleFasted.preOPTO(n).bins(m).sweep(6).mean_AHP]);
    end
end
clear m n o p

% Female Fasted OPTO
for n = 1 : length(AHP.FemaleFasted.OPTO) % number of cells
    for m = 1 : length(bin) - 1 % 10 bins
        for o = 1 : length(AHP.FemaleFasted.OPTO(n).peaks)    % 6 sweeps
            AHP.FemaleFasted.OPTO(n).bins(m).sweep(o).peaks = [];
            AHP.FemaleFasted.OPTO(n).bins(m).sweep(o).AHP = [];
            for p = 1 : length(AHP.FemaleFasted.OPTO(n).peaks(o).location.relativems)
                if AHP.FemaleFasted.OPTO(n).peaks(o).location.relativems(p) > bin(m) & AHP.FemaleFasted.OPTO(n).peaks(o).location.relativems(p) <= bin(m + 1)
                    AHP.FemaleFasted.OPTO(n).bins(m).sweep(o).peaks = [AHP.FemaleFasted.OPTO(n).bins(m).sweep(o).peaks; AHP.FemaleFasted.OPTO(n).peaks(o).mV(p)];
                    AHP.FemaleFasted.OPTO(n).bins(m).sweep(o).AHP = [AHP.FemaleFasted.OPTO(n).bins(m).sweep(o).AHP; AHP.FemaleFasted.OPTO(n).AHP(o).mV(p)];
                end
                AHP.FemaleFasted.OPTO(n).bins(m).sweep(o).AP = length(AHP.FemaleFasted.OPTO(n).bins(m).sweep(o).peaks);
                AHP.FemaleFasted.OPTO(n).bins(m).sweep(o).mean_peak = nanmean([AHP.FemaleFasted.OPTO(n).bins(m).sweep(o).peaks]);
                AHP.FemaleFasted.OPTO(n).bins(m).sweep(o).mean_AHP = nanmean([AHP.FemaleFasted.OPTO(n).bins(m).sweep(o).AHP]);
            end
        end
        AHP.FemaleFasted.OPTO(n).bins(m).average.AP = nanmean([AHP.FemaleFasted.OPTO(n).bins(m).sweep(1).AP;
                                                                 AHP.FemaleFasted.OPTO(n).bins(m).sweep(2).AP;
                                                                 AHP.FemaleFasted.OPTO(n).bins(m).sweep(3).AP;
                                                                 AHP.FemaleFasted.OPTO(n).bins(m).sweep(4).AP;
                                                                 AHP.FemaleFasted.OPTO(n).bins(m).sweep(5).AP;
                                                                 AHP.FemaleFasted.OPTO(n).bins(m).sweep(6).AP]);
        AHP.FemaleFasted.OPTO(n).bins(m).average.mean_peak = nanmean([AHP.FemaleFasted.OPTO(n).bins(m).sweep(1).mean_peak;
                                                                        AHP.FemaleFasted.OPTO(n).bins(m).sweep(2).mean_peak;
                                                                        AHP.FemaleFasted.OPTO(n).bins(m).sweep(3).mean_peak;
                                                                        AHP.FemaleFasted.OPTO(n).bins(m).sweep(4).mean_peak;
                                                                        AHP.FemaleFasted.OPTO(n).bins(m).sweep(5).mean_peak;
                                                                        AHP.FemaleFasted.OPTO(n).bins(m).sweep(6).mean_peak]);
        AHP.FemaleFasted.OPTO(n).bins(m).average.mean_AHP = nanmean([AHP.FemaleFasted.OPTO(n).bins(m).sweep(1).mean_AHP;
                                                                       AHP.FemaleFasted.OPTO(n).bins(m).sweep(2).mean_AHP;
                                                                       AHP.FemaleFasted.OPTO(n).bins(m).sweep(3).mean_AHP;
                                                                       AHP.FemaleFasted.OPTO(n).bins(m).sweep(4).mean_AHP;
                                                                       AHP.FemaleFasted.OPTO(n).bins(m).sweep(5).mean_AHP;
                                                                       AHP.FemaleFasted.OPTO(n).bins(m).sweep(6).mean_AHP]);
    end
end
clear m n o p bin

%% Creating tables for Latency to fire

% Group array
MC_group = [];
for n = 1 : length(AHP.MaleControl.preOPTO)
    MC_group = [MC_group; "Male_Control"];
end

MF_group = [];
for n = 1 : length(AHP.MaleFasted.preOPTO)
    MF_group = [MF_group; "Male_Fasted"];
end

FC_group = [];
for n = 1 : length(AHP.FemaleControl.preOPTO)
    FC_group = [FC_group; "Female_Control"];
end

FF_group = [];
for n = 1 : length(AHP.FemaleFasted.preOPTO)
    FF_group = [FF_group; "Female Fasted"];
end

Group = [MC_group; nan; MF_group; nan; FC_group; nan; FF_group];
T_Group = array2table(Group);

clear MC_group MF_group FC_group FF_group n Group

% FileName array
MC_filename = [];
for n = 1 : length(AHP.MaleControl.preOPTO)
    MC_filename = [MC_filename; string(AHP.MaleControl.preOPTO(n).filename)];
end

MF_filename = [];
for n = 1 : length(AHP.MaleFasted.preOPTO)
    MF_filename = [MF_filename; string(AHP.MaleFasted.preOPTO(n).filename)];
end

FC_filename = [];
for n = 1 : length(AHP.FemaleControl.preOPTO)
    FC_filename = [FC_filename; string(AHP.FemaleControl.preOPTO(n).filename)];
end

FF_filename = [];
for n = 1 : length(AHP.FemaleFasted.preOPTO)
    FF_filename = [FF_filename; string(AHP.FemaleFasted.preOPTO(n).filename)];
end

FileName = [MC_filename; nan; MF_filename; nan; FC_filename; nan; FF_filename];
T_FileName = array2table(FileName);

clear MC_filename MF_filename FC_filename FF_filename n FileName

% preOPTO array
MC_preOPTO = [];
for n = 1 : length(AHP.MaleControl.preOPTO)
    MC_preOPTO = [MC_preOPTO; AHP.MaleControl.preOPTO(n).Mean_latency2fire];
end

MF_preOPTO = [];
for n = 1 : length(AHP.MaleFasted.preOPTO)
    MF_preOPTO = [MF_preOPTO; AHP.MaleFasted.preOPTO(n).Mean_latency2fire];
end

FC_preOPTO = [];
for n = 1 : length(AHP.FemaleControl.preOPTO)
    FC_preOPTO = [FC_preOPTO; AHP.FemaleControl.preOPTO(n).Mean_latency2fire];
end

FF_preOPTO = [];
for n = 1 : length(AHP.FemaleFasted.preOPTO)
    FF_preOPTO = [FF_preOPTO; AHP.FemaleFasted.preOPTO(n).Mean_latency2fire];
end

preOPTO = [MC_preOPTO; nan; MF_preOPTO; nan; FC_preOPTO; nan; FF_preOPTO];
T_preOPTO = array2table(preOPTO);

clear MC_preOPTO MF_preOPTO FC_preOPTO FF_preOPTO n preOPTO

% OPTO array
MC_OPTO = [];
for n = 1 : length(AHP.MaleControl.OPTO)
    MC_OPTO = [MC_OPTO; AHP.MaleControl.OPTO(n).Mean_latency2fire];
end

MF_OPTO = [];
for n = 1 : length(AHP.MaleFasted.OPTO)
    MF_OPTO = [MF_OPTO; AHP.MaleFasted.OPTO(n).Mean_latency2fire];
end

FC_OPTO = [];
for n = 1 : length(AHP.FemaleControl.OPTO)
    FC_OPTO = [FC_OPTO; AHP.FemaleControl.OPTO(n).Mean_latency2fire];
end

FF_OPTO = [];
for n = 1 : length(AHP.FemaleFasted.OPTO)
    FF_OPTO = [FF_OPTO; AHP.FemaleFasted.OPTO(n).Mean_latency2fire];
end

OPTO = [MC_OPTO; nan; MF_OPTO; nan; FC_OPTO; nan; FF_OPTO];
T_OPTO = array2table(OPTO);

clear MC_OPTO MF_OPTO FC_OPTO FF_OPTO n OPTO

AHP.tables.Latency2Fire = [T_Group T_FileName T_preOPTO T_OPTO];

clear T_Group T_FileName T_preOPTO T_OPTO


%% Creating Male Control tables for binned data (AP, Peaks, and AHP)

% Male Control preOPTO
MC_group_preOPTO = [];
for n = 1 : length(AHP.MaleControl.preOPTO)
    MC_group_preOPTO = [MC_group_preOPTO; "Male_Control"];
end

MC_OPTO_preOPTO = [];
for n = 1 : length(AHP.MaleControl.preOPTO)
    MC_OPTO_preOPTO = [MC_OPTO_preOPTO; "preOPTO"];
end

MC_filename_preOPTO = [];
for n = 1 : length(AHP.MaleControl.preOPTO)
    MC_filename_preOPTO = [MC_filename_preOPTO; string(AHP.MaleControl.preOPTO(n).filename)];
end

for m = 1 : 10
    AP(m).bin = [];
    Peaks(m).bin = [];
    ahp(m).bin = [];
    for n = 1 : length(AHP.MaleControl.preOPTO)
        AP(m).bin = [AP(m).bin; AHP.MaleControl.preOPTO(n).bins(m).average.AP];
        Peaks(m).bin = [Peaks(m).bin; AHP.MaleControl.preOPTO(n).bins(m).average.mean_peak];
        ahp(m).bin = [ahp(m).bin; AHP.MaleControl.preOPTO(n).bins(m).average.mean_AHP];
    end
end

AP_preOPTO_array = [];
for n = 1 : length(AP)
    AP_preOPTO_array = [AP_preOPTO_array AP(n).bin];
end

Peaks_preOPTO_array = [];
for n = 1 : length(Peaks)
    Peaks_preOPTO_array = [Peaks_preOPTO_array Peaks(n).bin];
end

AHP_preOPTO_array = [];
for n = 1 : length(ahp)
    AHP_preOPTO_array = [AHP_preOPTO_array ahp(n).bin];
end

% Male Control OPTO
MC_group_OPTO = [];
for n = 1 : length(AHP.MaleControl.OPTO)
    MC_group_OPTO = [MC_group_OPTO; "Male_Control"];
end

MC_OPTO_OPTO = [];
for n = 1 : length(AHP.MaleControl.OPTO)
    MC_OPTO_OPTO = [MC_OPTO_OPTO; "OPTO"];
end

MC_filename_OPTO = [];
for n = 1 : length(AHP.MaleControl.OPTO)
    MC_filename_OPTO = [MC_filename_OPTO; string(AHP.MaleControl.OPTO(n).filename)];
end

for m = 1 : 10
    AP(m).bin = [];
    Peaks(m).bin = [];
    ahp(m).bin = [];
    for n = 1 : length(AHP.MaleControl.OPTO)
        AP(m).bin = [AP(m).bin; AHP.MaleControl.OPTO(n).bins(m).average.AP];
        Peaks(m).bin = [Peaks(m).bin; AHP.MaleControl.OPTO(n).bins(m).average.mean_peak];
        ahp(m).bin = [ahp(m).bin; AHP.MaleControl.OPTO(n).bins(m).average.mean_AHP];
    end
end

AP_OPTO_array = [];
for n = 1 : length(AP)
    AP_OPTO_array = [AP_OPTO_array AP(n).bin];
end

Peaks_OPTO_array = [];
for n = 1 : length(Peaks)
    Peaks_OPTO_array = [Peaks_OPTO_array Peaks(n).bin];
end

AHP_OPTO_array = [];
for n = 1 : length(ahp)
    AHP_OPTO_array = [AHP_OPTO_array ahp(n).bin];
end

MC_group = [MC_group_preOPTO; nan; MC_group_OPTO];
T_Group = array2table(MC_group);
MC_OPTO = [MC_OPTO_preOPTO; nan; MC_OPTO_OPTO];
T_OPTO = array2table(MC_OPTO);
MC_filename = [MC_filename_preOPTO; nan; MC_filename_OPTO];
T_filename = array2table(MC_filename);
AP_array = [AP_preOPTO_array; nan(1,10); AP_OPTO_array];
T_AP = array2table(AP_array);
Peaks_array = [Peaks_preOPTO_array; nan(1,10); Peaks_OPTO_array];
T_Peaks = array2table(Peaks_array);
AHP_array = [AHP_preOPTO_array; nan(1,10); AHP_OPTO_array];
T_AHP = array2table(AHP_array);

AHP.tables.MaleControl.AP = [T_Group T_OPTO T_filename T_AP];
AHP.tables.MaleControl.Peaks = [T_Group T_OPTO T_filename T_Peaks];
AHP.tables.MaleControl.AHP = [T_Group T_OPTO T_filename T_AHP];

clear m n
clear MC_group_preOPTO MC_OPTO_preOPTO MC_filename_preOPTO
clear MC_group_OPTO MC_OPTO_OPTO MC_filename_OPTO
clear AP Peaks ahp
clear AP_OPTO_array Peaks_OPTO_array AHP_OPTO_array AP_preOPTO_array Peaks_preOPTO_array AHP_preOPTO_array
clear MC_group T_Group MC_OPTO T_OPTO MC_filename T_filename AP_array T_AP Peaks_array T_Peaks AHP_array T_AHP

%% Creating Male Fasted tables for binned data (AP, Peaks, and AHP)

% Male Fasted preOPTO
MF_group_preOPTO = [];
for n = 1 : length(AHP.MaleFasted.preOPTO)
    MF_group_preOPTO = [MF_group_preOPTO; "Male_Fasted"];
end

MF_OPTO_preOPTO = [];
for n = 1 : length(AHP.MaleFasted.preOPTO)
    MF_OPTO_preOPTO = [MF_OPTO_preOPTO; "preOPTO"];
end

MF_filename_preOPTO = [];
for n = 1 : length(AHP.MaleFasted.preOPTO)
    MF_filename_preOPTO = [MF_filename_preOPTO; string(AHP.MaleFasted.preOPTO(n).filename)];
end

for m = 1 : 10
    AP(m).bin = [];
    Peaks(m).bin = [];
    ahp(m).bin = [];
    for n = 1 : length(AHP.MaleFasted.preOPTO)
        AP(m).bin = [AP(m).bin; AHP.MaleFasted.preOPTO(n).bins(m).average.AP];
        Peaks(m).bin = [Peaks(m).bin; AHP.MaleFasted.preOPTO(n).bins(m).average.mean_peak];
        ahp(m).bin = [ahp(m).bin; AHP.MaleFasted.preOPTO(n).bins(m).average.mean_AHP];
    end
end

AP_preOPTO_array = [];
for n = 1 : length(AP)
    AP_preOPTO_array = [AP_preOPTO_array AP(n).bin];
end

Peaks_preOPTO_array = [];
for n = 1 : length(Peaks)
    Peaks_preOPTO_array = [Peaks_preOPTO_array Peaks(n).bin];
end

AHP_preOPTO_array = [];
for n = 1 : length(ahp)
    AHP_preOPTO_array = [AHP_preOPTO_array ahp(n).bin];
end

% Male Fasted OPTO
MF_group_OPTO = [];
for n = 1 : length(AHP.MaleFasted.OPTO)
    MF_group_OPTO = [MF_group_OPTO; "Male_Fasted"];
end

MF_OPTO_OPTO = [];
for n = 1 : length(AHP.MaleFasted.OPTO)
    MF_OPTO_OPTO = [MF_OPTO_OPTO; "OPTO"];
end

MF_filename_OPTO = [];
for n = 1 : length(AHP.MaleFasted.OPTO)
    MF_filename_OPTO = [MF_filename_OPTO; string(AHP.MaleFasted.OPTO(n).filename)];
end

for m = 1 : 10
    AP(m).bin = [];
    Peaks(m).bin = [];
    ahp(m).bin = [];
    for n = 1 : length(AHP.MaleFasted.OPTO)
        AP(m).bin = [AP(m).bin; AHP.MaleFasted.OPTO(n).bins(m).average.AP];
        Peaks(m).bin = [Peaks(m).bin; AHP.MaleFasted.OPTO(n).bins(m).average.mean_peak];
        ahp(m).bin = [ahp(m).bin; AHP.MaleFasted.OPTO(n).bins(m).average.mean_AHP];
    end
end

AP_OPTO_array = [];
for n = 1 : length(AP)
    AP_OPTO_array = [AP_OPTO_array AP(n).bin];
end

Peaks_OPTO_array = [];
for n = 1 : length(Peaks)
    Peaks_OPTO_array = [Peaks_OPTO_array Peaks(n).bin];
end

AHP_OPTO_array = [];
for n = 1 : length(ahp)
    AHP_OPTO_array = [AHP_OPTO_array ahp(n).bin];
end

MF_group = [MF_group_preOPTO; nan; MF_group_OPTO];
T_Group = array2table(MF_group);
MF_OPTO = [MF_OPTO_preOPTO; nan; MF_OPTO_OPTO];
T_OPTO = array2table(MF_OPTO);
MF_filename = [MF_filename_preOPTO; nan; MF_filename_OPTO];
T_filename = array2table(MF_filename);
AP_array = [AP_preOPTO_array; nan(1,10); AP_OPTO_array];
T_AP = array2table(AP_array);
Peaks_array = [Peaks_preOPTO_array; nan(1,10); Peaks_OPTO_array];
T_Peaks = array2table(Peaks_array);
AHP_array = [AHP_preOPTO_array; nan(1,10); AHP_OPTO_array];
T_AHP = array2table(AHP_array);

AHP.tables.MaleFasted.AP = [T_Group T_OPTO T_filename T_AP];
AHP.tables.MaleFasted.Peaks = [T_Group T_OPTO T_filename T_Peaks];
AHP.tables.MaleFasted.AHP = [T_Group T_OPTO T_filename T_AHP];

clear m n
clear MF_group_preOPTO MF_OPTO_preOPTO MF_filename_preOPTO
clear MF_group_OPTO MF_OPTO_OPTO MF_filename_OPTO
clear AP Peaks ahp
clear AP_OPTO_array Peaks_OPTO_array AHP_OPTO_array AP_preOPTO_array Peaks_preOPTO_array AHP_preOPTO_array
clear MF_group T_Group MF_OPTO T_OPTO MF_filename T_filename AP_array T_AP Peaks_array T_Peaks AHP_array T_AHP

%% Creating Female Control tables for binned data (AP, Peaks, and AHP)

% Female Control preOPTO
FC_group_preOPTO = [];
for n = 1 : length(AHP.FemaleControl.preOPTO)
    FC_group_preOPTO = [FC_group_preOPTO; "Female_Control"];
end

FC_OPTO_preOPTO = [];
for n = 1 : length(AHP.FemaleControl.preOPTO)
    FC_OPTO_preOPTO = [FC_OPTO_preOPTO; "preOPTO"];
end

FC_filename_preOPTO = [];
for n = 1 : length(AHP.FemaleControl.preOPTO)
    FC_filename_preOPTO = [FC_filename_preOPTO; string(AHP.FemaleControl.preOPTO(n).filename)];
end

for m = 1 : 10
    AP(m).bin = [];
    Peaks(m).bin = [];
    ahp(m).bin = [];
    for n = 1 : length(AHP.FemaleControl.preOPTO)
        AP(m).bin = [AP(m).bin; AHP.FemaleControl.preOPTO(n).bins(m).average.AP];
        Peaks(m).bin = [Peaks(m).bin; AHP.FemaleControl.preOPTO(n).bins(m).average.mean_peak];
        ahp(m).bin = [ahp(m).bin; AHP.FemaleControl.preOPTO(n).bins(m).average.mean_AHP];
    end
end

AP_preOPTO_array = [];
for n = 1 : length(AP)
    AP_preOPTO_array = [AP_preOPTO_array AP(n).bin];
end

Peaks_preOPTO_array = [];
for n = 1 : length(Peaks)
    Peaks_preOPTO_array = [Peaks_preOPTO_array Peaks(n).bin];
end

AHP_preOPTO_array = [];
for n = 1 : length(ahp)
    AHP_preOPTO_array = [AHP_preOPTO_array ahp(n).bin];
end

% Female Control OPTO
FC_group_OPTO = [];
for n = 1 : length(AHP.FemaleControl.OPTO)
    FC_group_OPTO = [FC_group_OPTO; "Female_Control"];
end

FC_OPTO_OPTO = [];
for n = 1 : length(AHP.FemaleControl.OPTO)
    FC_OPTO_OPTO = [FC_OPTO_OPTO; "OPTO"];
end

FC_filename_OPTO = [];
for n = 1 : length(AHP.FemaleControl.OPTO)
    FC_filename_OPTO = [FC_filename_OPTO; string(AHP.FemaleControl.OPTO(n).filename)];
end

for m = 1 : 10
    AP(m).bin = [];
    Peaks(m).bin = [];
    ahp(m).bin = [];
    for n = 1 : length(AHP.FemaleControl.OPTO)
        AP(m).bin = [AP(m).bin; AHP.FemaleControl.OPTO(n).bins(m).average.AP];
        Peaks(m).bin = [Peaks(m).bin; AHP.FemaleControl.OPTO(n).bins(m).average.mean_peak];
        ahp(m).bin = [ahp(m).bin; AHP.FemaleControl.OPTO(n).bins(m).average.mean_AHP];
    end
end

AP_OPTO_array = [];
for n = 1 : length(AP)
    AP_OPTO_array = [AP_OPTO_array AP(n).bin];
end

Peaks_OPTO_array = [];
for n = 1 : length(Peaks)
    Peaks_OPTO_array = [Peaks_OPTO_array Peaks(n).bin];
end

AHP_OPTO_array = [];
for n = 1 : length(ahp)
    AHP_OPTO_array = [AHP_OPTO_array ahp(n).bin];
end

FC_group = [FC_group_preOPTO; nan; FC_group_OPTO];
T_Group = array2table(FC_group);
FC_OPTO = [FC_OPTO_preOPTO; nan; FC_OPTO_OPTO];
T_OPTO = array2table(FC_OPTO);
FC_filename = [FC_filename_preOPTO; nan; FC_filename_OPTO];
T_filename = array2table(FC_filename);
AP_array = [AP_preOPTO_array; nan(1,10); AP_OPTO_array];
T_AP = array2table(AP_array);
Peaks_array = [Peaks_preOPTO_array; nan(1,10); Peaks_OPTO_array];
T_Peaks = array2table(Peaks_array);
AHP_array = [AHP_preOPTO_array; nan(1,10); AHP_OPTO_array];
T_AHP = array2table(AHP_array);

AHP.tables.FemaleControl.AP = [T_Group T_OPTO T_filename T_AP];
AHP.tables.FemaleControl.Peaks = [T_Group T_OPTO T_filename T_Peaks];
AHP.tables.FemaleControl.AHP = [T_Group T_OPTO T_filename T_AHP];

clear m n
clear FC_group_preOPTO FC_OPTO_preOPTO FC_filename_preOPTO
clear FC_group_OPTO FC_OPTO_OPTO FC_filename_OPTO
clear AP Peaks ahp
clear AP_OPTO_array Peaks_OPTO_array AHP_OPTO_array AP_preOPTO_array Peaks_preOPTO_array AHP_preOPTO_array
clear FC_group T_Group FC_OPTO T_OPTO FC_filename T_filename AP_array T_AP Peaks_array T_Peaks AHP_array T_AHP

%% Creating Female Fasted tables for binned data (AP, Peaks, and AHP)

% Female Fasted preOPTO
FF_group_preOPTO = [];
for n = 1 : length(AHP.FemaleFasted.preOPTO)
    FF_group_preOPTO = [FF_group_preOPTO; "Female_Fasted"];
end

FF_OPTO_preOPTO = [];
for n = 1 : length(AHP.FemaleFasted.preOPTO)
    FF_OPTO_preOPTO = [FF_OPTO_preOPTO; "preOPTO"];
end

FF_filename_preOPTO = [];
for n = 1 : length(AHP.FemaleFasted.preOPTO)
    FF_filename_preOPTO = [FF_filename_preOPTO; string(AHP.FemaleFasted.preOPTO(n).filename)];
end

for m = 1 : 10
    AP(m).bin = [];
    Peaks(m).bin = [];
    ahp(m).bin = [];
    for n = 1 : length(AHP.FemaleFasted.preOPTO)
        AP(m).bin = [AP(m).bin; AHP.FemaleFasted.preOPTO(n).bins(m).average.AP];
        Peaks(m).bin = [Peaks(m).bin; AHP.FemaleFasted.preOPTO(n).bins(m).average.mean_peak];
        ahp(m).bin = [ahp(m).bin; AHP.FemaleFasted.preOPTO(n).bins(m).average.mean_AHP];
    end
end

AP_preOPTO_array = [];
for n = 1 : length(AP)
    AP_preOPTO_array = [AP_preOPTO_array AP(n).bin];
end

Peaks_preOPTO_array = [];
for n = 1 : length(Peaks)
    Peaks_preOPTO_array = [Peaks_preOPTO_array Peaks(n).bin];
end

AHP_preOPTO_array = [];
for n = 1 : length(ahp)
    AHP_preOPTO_array = [AHP_preOPTO_array ahp(n).bin];
end

% Female Fasted OPTO
FF_group_OPTO = [];
for n = 1 : length(AHP.FemaleFasted.OPTO)
    FF_group_OPTO = [FF_group_OPTO; "Female_Fasted"];
end

FF_OPTO_OPTO = [];
for n = 1 : length(AHP.FemaleFasted.OPTO)
    FF_OPTO_OPTO = [FF_OPTO_OPTO; "OPTO"];
end

FF_filename_OPTO = [];
for n = 1 : length(AHP.FemaleFasted.OPTO)
    FF_filename_OPTO = [FF_filename_OPTO; string(AHP.FemaleFasted.OPTO(n).filename)];
end

for m = 1 : 10
    AP(m).bin = [];
    Peaks(m).bin = [];
    ahp(m).bin = [];
    for n = 1 : length(AHP.FemaleFasted.OPTO)
        AP(m).bin = [AP(m).bin; AHP.FemaleFasted.OPTO(n).bins(m).average.AP];
        Peaks(m).bin = [Peaks(m).bin; AHP.FemaleFasted.OPTO(n).bins(m).average.mean_peak];
        ahp(m).bin = [ahp(m).bin; AHP.FemaleFasted.OPTO(n).bins(m).average.mean_AHP];
    end
end

AP_OPTO_array = [];
for n = 1 : length(AP)
    AP_OPTO_array = [AP_OPTO_array AP(n).bin];
end

Peaks_OPTO_array = [];
for n = 1 : length(Peaks)
    Peaks_OPTO_array = [Peaks_OPTO_array Peaks(n).bin];
end

AHP_OPTO_array = [];
for n = 1 : length(ahp)
    AHP_OPTO_array = [AHP_OPTO_array ahp(n).bin];
end

FF_group = [FF_group_preOPTO; nan; FF_group_OPTO];
T_Group = array2table(FF_group);
FF_OPTO = [FF_OPTO_preOPTO; nan; FF_OPTO_OPTO];
T_OPTO = array2table(FF_OPTO);
FF_filename = [FF_filename_preOPTO; nan; FF_filename_OPTO];
T_filename = array2table(FF_filename);
AP_array = [AP_preOPTO_array; nan(1,10); AP_OPTO_array];
T_AP = array2table(AP_array);
Peaks_array = [Peaks_preOPTO_array; nan(1,10); Peaks_OPTO_array];
T_Peaks = array2table(Peaks_array);
AHP_array = [AHP_preOPTO_array; nan(1,10); AHP_OPTO_array];
T_AHP = array2table(AHP_array);

AHP.tables.FemaleFasted.AP = [T_Group T_OPTO T_filename T_AP];
AHP.tables.FemaleFasted.Peaks = [T_Group T_OPTO T_filename T_Peaks];
AHP.tables.FemaleFasted.AHP = [T_Group T_OPTO T_filename T_AHP];

clear m n
clear FF_group_preOPTO FF_OPTO_preOPTO FF_filename_preOPTO
clear FF_group_OPTO FF_OPTO_OPTO FF_filename_OPTO
clear AP Peaks ahp
clear AP_OPTO_array Peaks_OPTO_array AHP_OPTO_array AP_preOPTO_array Peaks_preOPTO_array AHP_preOPTO_array
clear FF_group T_Group FF_OPTO T_OPTO FF_filename T_filename AP_array T_AP Peaks_array T_Peaks AHP_array T_AHP

%% Writing tables to excel

cd /Users/nathansmac/Desktop/VTA_INPUTS/GABA_Firing/

writetable(AHP.tables.Latency2Fire,'Binned_7Oct2021_Firing.xlsx','Sheet','L2F','Range','A1');

writetable(AHP.tables.MaleControl.AP,'Binned_7Oct2021_Firing.xlsx','Sheet','MC_AP','Range','A1');
writetable(AHP.tables.MaleControl.Peaks,'Binned_7Oct2021_Firing.xlsx','Sheet','MC_Peaks','Range','A1');
writetable(AHP.tables.MaleControl.AHP,'Binned_7Oct2021_Firing.xlsx','Sheet','MC_AHP','Range','A1');
writetable(AHP.tables.MaleFasted.AP,'Binned_7Oct2021_Firing.xlsx','Sheet','MF_AP','Range','A1');
writetable(AHP.tables.MaleFasted.Peaks,'Binned_7Oct2021_Firing.xlsx','Sheet','MF_Peaks','Range','A1');
writetable(AHP.tables.MaleFasted.AHP,'Binned_7Oct2021_Firing.xlsx','Sheet','MF_AHP','Range','A1');
writetable(AHP.tables.FemaleControl.AP,'Binned_7Oct2021_Firing.xlsx','Sheet','FC_AP','Range','A1');
writetable(AHP.tables.FemaleControl.Peaks,'Binned_7Oct2021_Firing.xlsx','Sheet','FC_Peaks','Range','A1');
writetable(AHP.tables.FemaleControl.AHP,'Binned_7Oct2021_Firing.xlsx','Sheet','FC_AHP','Range','A1');
writetable(AHP.tables.FemaleFasted.AP,'Binned_7Oct2021_Firing.xlsx','Sheet','FF_AP','Range','A1');
writetable(AHP.tables.FemaleFasted.Peaks,'Binned_7Oct2021_Firing.xlsx','Sheet','FF_Peaks','Range','A1');
writetable(AHP.tables.FemaleFasted.AHP,'Binned_7Oct2021_Firing.xlsx','Sheet','FF_AHP','Range','A1');


%% Get these values for the first 200 ms (first200) of step

bin = [0 200];

% Male Control
% Male Control preOPTO
for n = 1 : length(AHP.MaleControl.preOPTO) % number of cells
    for o = 1 : length(AHP.MaleControl.preOPTO(n).peaks)    % 6 sweeps
        AHP.MaleControl.preOPTO(n).first200.sweep(o).peaks = [];
        AHP.MaleControl.preOPTO(n).first200.sweep(o).AHP = [];
        for p = 1 : length(AHP.MaleControl.preOPTO(n).peaks(o).location.relativems)
            if AHP.MaleControl.preOPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.MaleControl.preOPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.MaleControl.preOPTO(n).first200.sweep(o).peaks = [AHP.MaleControl.preOPTO(n).first200.sweep(o).peaks; AHP.MaleControl.preOPTO(n).peaks(o).mV(p)];
                AHP.MaleControl.preOPTO(n).first200.sweep(o).AHP = [AHP.MaleControl.preOPTO(n).first200.sweep(o).AHP; AHP.MaleControl.preOPTO(n).AHP(o).mV(p)];
            end
            AHP.MaleControl.preOPTO(n).first200.sweep(o).AP = length(AHP.MaleControl.preOPTO(n).first200.sweep(o).peaks);
            AHP.MaleControl.preOPTO(n).first200.sweep(o).mean_peak = nanmean([AHP.MaleControl.preOPTO(n).first200.sweep(o).peaks]);
            AHP.MaleControl.preOPTO(n).first200.sweep(o).mean_AHP = nanmean([AHP.MaleControl.preOPTO(n).first200.sweep(o).AHP]);
        end
    end
    AHP.MaleControl.preOPTO(n).first200.average.AP = nanmean([AHP.MaleControl.preOPTO(n).first200.sweep(1).AP;
        AHP.MaleControl.preOPTO(n).first200.sweep(2).AP;
        AHP.MaleControl.preOPTO(n).first200.sweep(3).AP;
        AHP.MaleControl.preOPTO(n).first200.sweep(4).AP;
        AHP.MaleControl.preOPTO(n).first200.sweep(5).AP;
        AHP.MaleControl.preOPTO(n).first200.sweep(6).AP]);
    AHP.MaleControl.preOPTO(n).first200.average.mean_peak = nanmean([AHP.MaleControl.preOPTO(n).first200.sweep(1).mean_peak;
        AHP.MaleControl.preOPTO(n).first200.sweep(2).mean_peak;
        AHP.MaleControl.preOPTO(n).first200.sweep(3).mean_peak;
        AHP.MaleControl.preOPTO(n).first200.sweep(4).mean_peak;
        AHP.MaleControl.preOPTO(n).first200.sweep(5).mean_peak;
        AHP.MaleControl.preOPTO(n).first200.sweep(6).mean_peak]);
    AHP.MaleControl.preOPTO(n).first200.average.mean_AHP = nanmean([AHP.MaleControl.preOPTO(n).first200.sweep(1).mean_AHP;
        AHP.MaleControl.preOPTO(n).first200.sweep(2).mean_AHP;
        AHP.MaleControl.preOPTO(n).first200.sweep(3).mean_AHP;
        AHP.MaleControl.preOPTO(n).first200.sweep(4).mean_AHP;
        AHP.MaleControl.preOPTO(n).first200.sweep(5).mean_AHP;
        AHP.MaleControl.preOPTO(n).first200.sweep(6).mean_AHP]);
end

clear m n o p

% Male Control OPTO
for n = 1 : length(AHP.MaleControl.OPTO) % number of cells
    for o = 1 : length(AHP.MaleControl.OPTO(n).peaks)    % 6 sweeps
        AHP.MaleControl.OPTO(n).first200.sweep(o).peaks = [];
        AHP.MaleControl.OPTO(n).first200.sweep(o).AHP = [];
        for p = 1 : length(AHP.MaleControl.OPTO(n).peaks(o).location.relativems)
            if AHP.MaleControl.OPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.MaleControl.OPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.MaleControl.OPTO(n).first200.sweep(o).peaks = [AHP.MaleControl.OPTO(n).first200.sweep(o).peaks; AHP.MaleControl.OPTO(n).peaks(o).mV(p)];
                AHP.MaleControl.OPTO(n).first200.sweep(o).AHP = [AHP.MaleControl.OPTO(n).first200.sweep(o).AHP; AHP.MaleControl.OPTO(n).AHP(o).mV(p)];
            end
            AHP.MaleControl.OPTO(n).first200.sweep(o).AP = length(AHP.MaleControl.OPTO(n).first200.sweep(o).peaks);
            AHP.MaleControl.OPTO(n).first200.sweep(o).mean_peak = nanmean([AHP.MaleControl.OPTO(n).first200.sweep(o).peaks]);
            AHP.MaleControl.OPTO(n).first200.sweep(o).mean_AHP = nanmean([AHP.MaleControl.OPTO(n).first200.sweep(o).AHP]);
        end
    end
    AHP.MaleControl.OPTO(n).first200.average.AP = nanmean([AHP.MaleControl.OPTO(n).first200.sweep(1).AP;
        AHP.MaleControl.OPTO(n).first200.sweep(2).AP;
        AHP.MaleControl.OPTO(n).first200.sweep(3).AP;
        AHP.MaleControl.OPTO(n).first200.sweep(4).AP;
        AHP.MaleControl.OPTO(n).first200.sweep(5).AP;
        AHP.MaleControl.OPTO(n).first200.sweep(6).AP]);
    AHP.MaleControl.OPTO(n).first200.average.mean_peak = nanmean([AHP.MaleControl.OPTO(n).first200.sweep(1).mean_peak;
        AHP.MaleControl.OPTO(n).first200.sweep(2).mean_peak;
        AHP.MaleControl.OPTO(n).first200.sweep(3).mean_peak;
        AHP.MaleControl.OPTO(n).first200.sweep(4).mean_peak;
        AHP.MaleControl.OPTO(n).first200.sweep(5).mean_peak;
        AHP.MaleControl.OPTO(n).first200.sweep(6).mean_peak]);
    AHP.MaleControl.OPTO(n).first200.average.mean_AHP = nanmean([AHP.MaleControl.OPTO(n).first200.sweep(1).mean_AHP;
        AHP.MaleControl.OPTO(n).first200.sweep(2).mean_AHP;
        AHP.MaleControl.OPTO(n).first200.sweep(3).mean_AHP;
        AHP.MaleControl.OPTO(n).first200.sweep(4).mean_AHP;
        AHP.MaleControl.OPTO(n).first200.sweep(5).mean_AHP;
        AHP.MaleControl.OPTO(n).first200.sweep(6).mean_AHP]);
end

clear m n o p


% Male Fasted
% Male Fasted preOPTO
for n = 1 : length(AHP.MaleFasted.preOPTO) % number of cells
    for o = 1 : length(AHP.MaleFasted.preOPTO(n).peaks)    % 6 sweeps
        AHP.MaleFasted.preOPTO(n).first200.sweep(o).peaks = [];
        AHP.MaleFasted.preOPTO(n).first200.sweep(o).AHP = [];
        for p = 1 : length(AHP.MaleFasted.preOPTO(n).peaks(o).location.relativems)
            if AHP.MaleFasted.preOPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.MaleFasted.preOPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.MaleFasted.preOPTO(n).first200.sweep(o).peaks = [AHP.MaleFasted.preOPTO(n).first200.sweep(o).peaks; AHP.MaleFasted.preOPTO(n).peaks(o).mV(p)];
                AHP.MaleFasted.preOPTO(n).first200.sweep(o).AHP = [AHP.MaleFasted.preOPTO(n).first200.sweep(o).AHP; AHP.MaleFasted.preOPTO(n).AHP(o).mV(p)];
            end
            AHP.MaleFasted.preOPTO(n).first200.sweep(o).AP = length(AHP.MaleFasted.preOPTO(n).first200.sweep(o).peaks);
            AHP.MaleFasted.preOPTO(n).first200.sweep(o).mean_peak = nanmean([AHP.MaleFasted.preOPTO(n).first200.sweep(o).peaks]);
            AHP.MaleFasted.preOPTO(n).first200.sweep(o).mean_AHP = nanmean([AHP.MaleFasted.preOPTO(n).first200.sweep(o).AHP]);
        end
    end
    AHP.MaleFasted.preOPTO(n).first200.average.AP = nanmean([AHP.MaleFasted.preOPTO(n).first200.sweep(1).AP;
        AHP.MaleFasted.preOPTO(n).first200.sweep(2).AP;
        AHP.MaleFasted.preOPTO(n).first200.sweep(3).AP;
        AHP.MaleFasted.preOPTO(n).first200.sweep(4).AP;
        AHP.MaleFasted.preOPTO(n).first200.sweep(5).AP;
        AHP.MaleFasted.preOPTO(n).first200.sweep(6).AP]);
    AHP.MaleFasted.preOPTO(n).first200.average.mean_peak = nanmean([AHP.MaleFasted.preOPTO(n).first200.sweep(1).mean_peak;
        AHP.MaleFasted.preOPTO(n).first200.sweep(2).mean_peak;
        AHP.MaleFasted.preOPTO(n).first200.sweep(3).mean_peak;
        AHP.MaleFasted.preOPTO(n).first200.sweep(4).mean_peak;
        AHP.MaleFasted.preOPTO(n).first200.sweep(5).mean_peak;
        AHP.MaleFasted.preOPTO(n).first200.sweep(6).mean_peak]);
    AHP.MaleFasted.preOPTO(n).first200.average.mean_AHP = nanmean([AHP.MaleFasted.preOPTO(n).first200.sweep(1).mean_AHP;
        AHP.MaleFasted.preOPTO(n).first200.sweep(2).mean_AHP;
        AHP.MaleFasted.preOPTO(n).first200.sweep(3).mean_AHP;
        AHP.MaleFasted.preOPTO(n).first200.sweep(4).mean_AHP;
        AHP.MaleFasted.preOPTO(n).first200.sweep(5).mean_AHP;
        AHP.MaleFasted.preOPTO(n).first200.sweep(6).mean_AHP]);
end

clear m n o p

% Male Fasted OPTO
for n = 1 : length(AHP.MaleFasted.OPTO) % number of cells
    for o = 1 : length(AHP.MaleFasted.OPTO(n).peaks)    % 6 sweeps
        AHP.MaleFasted.OPTO(n).first200.sweep(o).peaks = [];
        AHP.MaleFasted.OPTO(n).first200.sweep(o).AHP = [];
        for p = 1 : length(AHP.MaleFasted.OPTO(n).peaks(o).location.relativems)
            if AHP.MaleFasted.OPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.MaleFasted.OPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.MaleFasted.OPTO(n).first200.sweep(o).peaks = [AHP.MaleFasted.OPTO(n).first200.sweep(o).peaks; AHP.MaleFasted.OPTO(n).peaks(o).mV(p)];
                AHP.MaleFasted.OPTO(n).first200.sweep(o).AHP = [AHP.MaleFasted.OPTO(n).first200.sweep(o).AHP; AHP.MaleFasted.OPTO(n).AHP(o).mV(p)];
            end
            AHP.MaleFasted.OPTO(n).first200.sweep(o).AP = length(AHP.MaleFasted.OPTO(n).first200.sweep(o).peaks);
            AHP.MaleFasted.OPTO(n).first200.sweep(o).mean_peak = nanmean([AHP.MaleFasted.OPTO(n).first200.sweep(o).peaks]);
            AHP.MaleFasted.OPTO(n).first200.sweep(o).mean_AHP = nanmean([AHP.MaleFasted.OPTO(n).first200.sweep(o).AHP]);
        end
    end
    AHP.MaleFasted.OPTO(n).first200.average.AP = nanmean([AHP.MaleFasted.OPTO(n).first200.sweep(1).AP;
        AHP.MaleFasted.OPTO(n).first200.sweep(2).AP;
        AHP.MaleFasted.OPTO(n).first200.sweep(3).AP;
        AHP.MaleFasted.OPTO(n).first200.sweep(4).AP;
        AHP.MaleFasted.OPTO(n).first200.sweep(5).AP;
        AHP.MaleFasted.OPTO(n).first200.sweep(6).AP]);
    AHP.MaleFasted.OPTO(n).first200.average.mean_peak = nanmean([AHP.MaleFasted.OPTO(n).first200.sweep(1).mean_peak;
        AHP.MaleFasted.OPTO(n).first200.sweep(2).mean_peak;
        AHP.MaleFasted.OPTO(n).first200.sweep(3).mean_peak;
        AHP.MaleFasted.OPTO(n).first200.sweep(4).mean_peak;
        AHP.MaleFasted.OPTO(n).first200.sweep(5).mean_peak;
        AHP.MaleFasted.OPTO(n).first200.sweep(6).mean_peak]);
    AHP.MaleFasted.OPTO(n).first200.average.mean_AHP = nanmean([AHP.MaleFasted.OPTO(n).first200.sweep(1).mean_AHP;
        AHP.MaleFasted.OPTO(n).first200.sweep(2).mean_AHP;
        AHP.MaleFasted.OPTO(n).first200.sweep(3).mean_AHP;
        AHP.MaleFasted.OPTO(n).first200.sweep(4).mean_AHP;
        AHP.MaleFasted.OPTO(n).first200.sweep(5).mean_AHP;
        AHP.MaleFasted.OPTO(n).first200.sweep(6).mean_AHP]);
end

clear m n o p


% Female Control
% Female Control preOPTO
for n = 1 : length(AHP.FemaleControl.preOPTO) % number of cells
    for o = 1 : length(AHP.FemaleControl.preOPTO(n).peaks)    % 6 sweeps
        AHP.FemaleControl.preOPTO(n).first200.sweep(o).peaks = [];
        AHP.FemaleControl.preOPTO(n).first200.sweep(o).AHP = [];
        for p = 1 : length(AHP.FemaleControl.preOPTO(n).peaks(o).location.relativems)
            if AHP.FemaleControl.preOPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.FemaleControl.preOPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.FemaleControl.preOPTO(n).first200.sweep(o).peaks = [AHP.FemaleControl.preOPTO(n).first200.sweep(o).peaks; AHP.FemaleControl.preOPTO(n).peaks(o).mV(p)];
                AHP.FemaleControl.preOPTO(n).first200.sweep(o).AHP = [AHP.FemaleControl.preOPTO(n).first200.sweep(o).AHP; AHP.FemaleControl.preOPTO(n).AHP(o).mV(p)];
            end
            AHP.FemaleControl.preOPTO(n).first200.sweep(o).AP = length(AHP.FemaleControl.preOPTO(n).first200.sweep(o).peaks);
            AHP.FemaleControl.preOPTO(n).first200.sweep(o).mean_peak = nanmean([AHP.FemaleControl.preOPTO(n).first200.sweep(o).peaks]);
            AHP.FemaleControl.preOPTO(n).first200.sweep(o).mean_AHP = nanmean([AHP.FemaleControl.preOPTO(n).first200.sweep(o).AHP]);
        end
    end
    AHP.FemaleControl.preOPTO(n).first200.average.AP = nanmean([AHP.FemaleControl.preOPTO(n).first200.sweep(1).AP;
        AHP.FemaleControl.preOPTO(n).first200.sweep(2).AP;
        AHP.FemaleControl.preOPTO(n).first200.sweep(3).AP;
        AHP.FemaleControl.preOPTO(n).first200.sweep(4).AP;
        AHP.FemaleControl.preOPTO(n).first200.sweep(5).AP;
        AHP.FemaleControl.preOPTO(n).first200.sweep(6).AP]);
    AHP.FemaleControl.preOPTO(n).first200.average.mean_peak = nanmean([AHP.FemaleControl.preOPTO(n).first200.sweep(1).mean_peak;
        AHP.FemaleControl.preOPTO(n).first200.sweep(2).mean_peak;
        AHP.FemaleControl.preOPTO(n).first200.sweep(3).mean_peak;
        AHP.FemaleControl.preOPTO(n).first200.sweep(4).mean_peak;
        AHP.FemaleControl.preOPTO(n).first200.sweep(5).mean_peak;
        AHP.FemaleControl.preOPTO(n).first200.sweep(6).mean_peak]);
    AHP.FemaleControl.preOPTO(n).first200.average.mean_AHP = nanmean([AHP.FemaleControl.preOPTO(n).first200.sweep(1).mean_AHP;
        AHP.FemaleControl.preOPTO(n).first200.sweep(2).mean_AHP;
        AHP.FemaleControl.preOPTO(n).first200.sweep(3).mean_AHP;
        AHP.FemaleControl.preOPTO(n).first200.sweep(4).mean_AHP;
        AHP.FemaleControl.preOPTO(n).first200.sweep(5).mean_AHP;
        AHP.FemaleControl.preOPTO(n).first200.sweep(6).mean_AHP]);
end

clear m n o p

% Female Control OPTO
for n = 1 : length(AHP.FemaleControl.OPTO) % number of cells
    for o = 1 : length(AHP.FemaleControl.OPTO(n).peaks)    % 6 sweeps
        AHP.FemaleControl.OPTO(n).first200.sweep(o).peaks = [];
        AHP.FemaleControl.OPTO(n).first200.sweep(o).AHP = [];
        for p = 1 : length(AHP.FemaleControl.OPTO(n).peaks(o).location.relativems)
            if AHP.FemaleControl.OPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.FemaleControl.OPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.FemaleControl.OPTO(n).first200.sweep(o).peaks = [AHP.FemaleControl.OPTO(n).first200.sweep(o).peaks; AHP.FemaleControl.OPTO(n).peaks(o).mV(p)];
                AHP.FemaleControl.OPTO(n).first200.sweep(o).AHP = [AHP.FemaleControl.OPTO(n).first200.sweep(o).AHP; AHP.FemaleControl.OPTO(n).AHP(o).mV(p)];
            end
            AHP.FemaleControl.OPTO(n).first200.sweep(o).AP = length(AHP.FemaleControl.OPTO(n).first200.sweep(o).peaks);
            AHP.FemaleControl.OPTO(n).first200.sweep(o).mean_peak = nanmean([AHP.FemaleControl.OPTO(n).first200.sweep(o).peaks]);
            AHP.FemaleControl.OPTO(n).first200.sweep(o).mean_AHP = nanmean([AHP.FemaleControl.OPTO(n).first200.sweep(o).AHP]);
        end
    end
    AHP.FemaleControl.OPTO(n).first200.average.AP = nanmean([AHP.FemaleControl.OPTO(n).first200.sweep(1).AP;
        AHP.FemaleControl.OPTO(n).first200.sweep(2).AP;
        AHP.FemaleControl.OPTO(n).first200.sweep(3).AP;
        AHP.FemaleControl.OPTO(n).first200.sweep(4).AP;
        AHP.FemaleControl.OPTO(n).first200.sweep(5).AP;
        AHP.FemaleControl.OPTO(n).first200.sweep(6).AP]);
    AHP.FemaleControl.OPTO(n).first200.average.mean_peak = nanmean([AHP.FemaleControl.OPTO(n).first200.sweep(1).mean_peak;
        AHP.FemaleControl.OPTO(n).first200.sweep(2).mean_peak;
        AHP.FemaleControl.OPTO(n).first200.sweep(3).mean_peak;
        AHP.FemaleControl.OPTO(n).first200.sweep(4).mean_peak;
        AHP.FemaleControl.OPTO(n).first200.sweep(5).mean_peak;
        AHP.FemaleControl.OPTO(n).first200.sweep(6).mean_peak]);
    AHP.FemaleControl.OPTO(n).first200.average.mean_AHP = nanmean([AHP.FemaleControl.OPTO(n).first200.sweep(1).mean_AHP;
        AHP.FemaleControl.OPTO(n).first200.sweep(2).mean_AHP;
        AHP.FemaleControl.OPTO(n).first200.sweep(3).mean_AHP;
        AHP.FemaleControl.OPTO(n).first200.sweep(4).mean_AHP;
        AHP.FemaleControl.OPTO(n).first200.sweep(5).mean_AHP;
        AHP.FemaleControl.OPTO(n).first200.sweep(6).mean_AHP]);
end

clear m n o p


% Female Fasted
% Female Fasted preOPTO
for n = 1 : length(AHP.FemaleFasted.preOPTO) % number of cells
    for o = 1 : length(AHP.FemaleFasted.preOPTO(n).peaks)    % 6 sweeps
        AHP.FemaleFasted.preOPTO(n).first200.sweep(o).peaks = [];
        AHP.FemaleFasted.preOPTO(n).first200.sweep(o).AHP = [];
        for p = 1 : length(AHP.FemaleFasted.preOPTO(n).peaks(o).location.relativems)
            if AHP.FemaleFasted.preOPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.FemaleFasted.preOPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.FemaleFasted.preOPTO(n).first200.sweep(o).peaks = [AHP.FemaleFasted.preOPTO(n).first200.sweep(o).peaks; AHP.FemaleFasted.preOPTO(n).peaks(o).mV(p)];
                AHP.FemaleFasted.preOPTO(n).first200.sweep(o).AHP = [AHP.FemaleFasted.preOPTO(n).first200.sweep(o).AHP; AHP.FemaleFasted.preOPTO(n).AHP(o).mV(p)];
            end
            AHP.FemaleFasted.preOPTO(n).first200.sweep(o).AP = length(AHP.FemaleFasted.preOPTO(n).first200.sweep(o).peaks);
            AHP.FemaleFasted.preOPTO(n).first200.sweep(o).mean_peak = nanmean([AHP.FemaleFasted.preOPTO(n).first200.sweep(o).peaks]);
            AHP.FemaleFasted.preOPTO(n).first200.sweep(o).mean_AHP = nanmean([AHP.FemaleFasted.preOPTO(n).first200.sweep(o).AHP]);
        end
    end
    AHP.FemaleFasted.preOPTO(n).first200.average.AP = nanmean([AHP.FemaleFasted.preOPTO(n).first200.sweep(1).AP;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(2).AP;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(3).AP;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(4).AP;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(5).AP;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(6).AP]);
    AHP.FemaleFasted.preOPTO(n).first200.average.mean_peak = nanmean([AHP.FemaleFasted.preOPTO(n).first200.sweep(1).mean_peak;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(2).mean_peak;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(3).mean_peak;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(4).mean_peak;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(5).mean_peak;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(6).mean_peak]);
    AHP.FemaleFasted.preOPTO(n).first200.average.mean_AHP = nanmean([AHP.FemaleFasted.preOPTO(n).first200.sweep(1).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(2).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(3).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(4).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(5).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).first200.sweep(6).mean_AHP]);
end

clear m n o p

% Female Fasted OPTO
for n = 1 : length(AHP.FemaleFasted.OPTO) % number of cells
    for o = 1 : length(AHP.FemaleFasted.OPTO(n).peaks)    % 6 sweeps
        AHP.FemaleFasted.OPTO(n).first200.sweep(o).peaks = [];
        AHP.FemaleFasted.OPTO(n).first200.sweep(o).AHP = [];
        for p = 1 : length(AHP.FemaleFasted.OPTO(n).peaks(o).location.relativems)
            if AHP.FemaleFasted.OPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.FemaleFasted.OPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.FemaleFasted.OPTO(n).first200.sweep(o).peaks = [AHP.FemaleFasted.OPTO(n).first200.sweep(o).peaks; AHP.FemaleFasted.OPTO(n).peaks(o).mV(p)];
                AHP.FemaleFasted.OPTO(n).first200.sweep(o).AHP = [AHP.FemaleFasted.OPTO(n).first200.sweep(o).AHP; AHP.FemaleFasted.OPTO(n).AHP(o).mV(p)];
            end
            AHP.FemaleFasted.OPTO(n).first200.sweep(o).AP = length(AHP.FemaleFasted.OPTO(n).first200.sweep(o).peaks);
            AHP.FemaleFasted.OPTO(n).first200.sweep(o).mean_peak = nanmean([AHP.FemaleFasted.OPTO(n).first200.sweep(o).peaks]);
            AHP.FemaleFasted.OPTO(n).first200.sweep(o).mean_AHP = nanmean([AHP.FemaleFasted.OPTO(n).first200.sweep(o).AHP]);
        end
    end
    AHP.FemaleFasted.OPTO(n).first200.average.AP = nanmean([AHP.FemaleFasted.OPTO(n).first200.sweep(1).AP;
        AHP.FemaleFasted.OPTO(n).first200.sweep(2).AP;
        AHP.FemaleFasted.OPTO(n).first200.sweep(3).AP;
        AHP.FemaleFasted.OPTO(n).first200.sweep(4).AP;
        AHP.FemaleFasted.OPTO(n).first200.sweep(5).AP;
        AHP.FemaleFasted.OPTO(n).first200.sweep(6).AP]);
    AHP.FemaleFasted.OPTO(n).first200.average.mean_peak = nanmean([AHP.FemaleFasted.OPTO(n).first200.sweep(1).mean_peak;
        AHP.FemaleFasted.OPTO(n).first200.sweep(2).mean_peak;
        AHP.FemaleFasted.OPTO(n).first200.sweep(3).mean_peak;
        AHP.FemaleFasted.OPTO(n).first200.sweep(4).mean_peak;
        AHP.FemaleFasted.OPTO(n).first200.sweep(5).mean_peak;
        AHP.FemaleFasted.OPTO(n).first200.sweep(6).mean_peak]);
    AHP.FemaleFasted.OPTO(n).first200.average.mean_AHP = nanmean([AHP.FemaleFasted.OPTO(n).first200.sweep(1).mean_AHP;
        AHP.FemaleFasted.OPTO(n).first200.sweep(2).mean_AHP;
        AHP.FemaleFasted.OPTO(n).first200.sweep(3).mean_AHP;
        AHP.FemaleFasted.OPTO(n).first200.sweep(4).mean_AHP;
        AHP.FemaleFasted.OPTO(n).first200.sweep(5).mean_AHP;
        AHP.FemaleFasted.OPTO(n).first200.sweep(6).mean_AHP]);
end

clear m n o p

clear bin


%% Making table for the first 200 ms (first200) data

% Male Control
MC_preOPTO = {};
for n = 1:length(AHP.MaleControl.preOPTO)
    MC_preOPTO(n,1) = {'Male_Control'};
    MC_preOPTO(n,2) = {'preOPTO'};
    MC_preOPTO(n,3) = {AHP.MaleControl.preOPTO(n).filename};
    MC_preOPTO(n,4) = {AHP.MaleControl.preOPTO(n).first200.average.AP};
    MC_preOPTO(n,5) = {AHP.MaleControl.preOPTO(n).first200.average.mean_peak};
    MC_preOPTO(n,6) = {AHP.MaleControl.preOPTO(n).first200.average.mean_AHP};
end

MC_OPTO = {};
for n = 1:length(AHP.MaleControl.OPTO)
    MC_OPTO(n,1) = {'Male_Control'};
    MC_OPTO(n,2) = {'OPTO'};
    MC_OPTO(n,3) = {AHP.MaleControl.OPTO(n).filename};
    MC_OPTO(n,4) = {AHP.MaleControl.OPTO(n).first200.average.AP};
    MC_OPTO(n,5) = {AHP.MaleControl.OPTO(n).first200.average.mean_peak};
    MC_OPTO(n,6) = {AHP.MaleControl.OPTO(n).first200.average.mean_AHP};
end


% Male Fasted
MF_preOPTO = {};
for n = 1:length(AHP.MaleFasted.preOPTO)
    MF_preOPTO(n,1) = {'Male_Fasted'};
    MF_preOPTO(n,2) = {'preOPTO'};
    MF_preOPTO(n,3) = {AHP.MaleFasted.preOPTO(n).filename};
    MF_preOPTO(n,4) = {AHP.MaleFasted.preOPTO(n).first200.average.AP};
    MF_preOPTO(n,5) = {AHP.MaleFasted.preOPTO(n).first200.average.mean_peak};
    MF_preOPTO(n,6) = {AHP.MaleFasted.preOPTO(n).first200.average.mean_AHP};
end

MF_OPTO = {};
for n = 1:length(AHP.MaleFasted.OPTO)
    MF_OPTO(n,1) = {'Male_Fasted'};
    MF_OPTO(n,2) = {'OPTO'};
    MF_OPTO(n,3) = {AHP.MaleFasted.OPTO(n).filename};
    MF_OPTO(n,4) = {AHP.MaleFasted.OPTO(n).first200.average.AP};
    MF_OPTO(n,5) = {AHP.MaleFasted.OPTO(n).first200.average.mean_peak};
    MF_OPTO(n,6) = {AHP.MaleFasted.OPTO(n).first200.average.mean_AHP};
end


% Female Control
FC_preOPTO = {};
for n = 1:length(AHP.FemaleControl.preOPTO)
    FC_preOPTO(n,1) = {'Female_Control'};
    FC_preOPTO(n,2) = {'preOPTO'};
    FC_preOPTO(n,3) = {AHP.FemaleControl.preOPTO(n).filename};
    FC_preOPTO(n,4) = {AHP.FemaleControl.preOPTO(n).first200.average.AP};
    FC_preOPTO(n,5) = {AHP.FemaleControl.preOPTO(n).first200.average.mean_peak};
    FC_preOPTO(n,6) = {AHP.FemaleControl.preOPTO(n).first200.average.mean_AHP};
end

FC_OPTO = {};
for n = 1:length(AHP.FemaleControl.OPTO)
    FC_OPTO(n,1) = {'Female_Control'};
    FC_OPTO(n,2) = {'OPTO'};
    FC_OPTO(n,3) = {AHP.FemaleControl.OPTO(n).filename};
    FC_OPTO(n,4) = {AHP.FemaleControl.OPTO(n).first200.average.AP};
    FC_OPTO(n,5) = {AHP.FemaleControl.OPTO(n).first200.average.mean_peak};
    FC_OPTO(n,6) = {AHP.FemaleControl.OPTO(n).first200.average.mean_AHP};
end


% Female Fasted
FF_preOPTO = {};
for n = 1:length(AHP.FemaleFasted.preOPTO)
    FF_preOPTO(n,1) = {'Female_Fasted'};
    FF_preOPTO(n,2) = {'preOPTO'};
    FF_preOPTO(n,3) = {AHP.FemaleFasted.preOPTO(n).filename};
    FF_preOPTO(n,4) = {AHP.FemaleFasted.preOPTO(n).first200.average.AP};
    FF_preOPTO(n,5) = {AHP.FemaleFasted.preOPTO(n).first200.average.mean_peak};
    FF_preOPTO(n,6) = {AHP.FemaleFasted.preOPTO(n).first200.average.mean_AHP};
end

FF_OPTO = {};
for n = 1:length(AHP.FemaleFasted.OPTO)
    FF_OPTO(n,1) = {'Female_Fasted'};
    FF_OPTO(n,2) = {'OPTO'};
    FF_OPTO(n,3) = {AHP.FemaleFasted.OPTO(n).filename};
    FF_OPTO(n,4) = {AHP.FemaleFasted.OPTO(n).first200.average.AP};
    FF_OPTO(n,5) = {AHP.FemaleFasted.OPTO(n).first200.average.mean_peak};
    FF_OPTO(n,6) = {AHP.FemaleFasted.OPTO(n).first200.average.mean_AHP};
end

blank = {'' '' '' '' '' ''};
MC_Array = [MC_preOPTO; blank; MC_OPTO];
MF_Array = [MF_preOPTO; blank; MF_OPTO];
FC_Array = [FC_preOPTO; blank; FC_OPTO];
FF_Array = [FF_preOPTO; blank; FF_OPTO];

AHP.tables.MaleControl.first200 = array2table(MC_Array, 'VariableNames', {'Group', 'OPTO', 'Filename', 'AP', 'mean_peak', 'mean_AHP'});
AHP.tables.MaleFasted.first200 = array2table(MF_Array, 'VariableNames', {'Group', 'OPTO', 'Filename', 'AP', 'mean_peak', 'mean_AHP'});
AHP.tables.FemaleControl.first200 = array2table(FC_Array, 'VariableNames', {'Group', 'OPTO', 'Filename', 'AP', 'mean_peak', 'mean_AHP'});
AHP.tables.FemaleFasted.first200 = array2table(FF_Array, 'VariableNames', {'Group', 'OPTO', 'Filename', 'AP', 'mean_peak', 'mean_AHP'});

clear MC_preOPTO MC_OPTO MF_preOPTO MF_OPTO FC_preOPTO FC_OPTO FF_preOPTO FF_OPTO MC_Array MF_Array FC_Array FF_Array blank n

%% Get these values for the full 1000 ms (full1000) of step

bin = [0 1000];

% Male Control
% Male Control preOPTO
for n = 1 : length(AHP.MaleControl.preOPTO) % number of cells
    for o = 1 : length(AHP.MaleControl.preOPTO(n).peaks)    % 6 sweeps
        AHP.MaleControl.preOPTO(n).full1000.sweep(o).peaks = [];
        AHP.MaleControl.preOPTO(n).full1000.sweep(o).AHP = [];
        for p = 1 : length(AHP.MaleControl.preOPTO(n).peaks(o).location.relativems)
            if AHP.MaleControl.preOPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.MaleControl.preOPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.MaleControl.preOPTO(n).full1000.sweep(o).peaks = [AHP.MaleControl.preOPTO(n).full1000.sweep(o).peaks; AHP.MaleControl.preOPTO(n).peaks(o).mV(p)];
                AHP.MaleControl.preOPTO(n).full1000.sweep(o).AHP = [AHP.MaleControl.preOPTO(n).full1000.sweep(o).AHP; AHP.MaleControl.preOPTO(n).AHP(o).mV(p)];
            end
            AHP.MaleControl.preOPTO(n).full1000.sweep(o).AP = length(AHP.MaleControl.preOPTO(n).full1000.sweep(o).peaks);
            AHP.MaleControl.preOPTO(n).full1000.sweep(o).mean_peak = nanmean([AHP.MaleControl.preOPTO(n).full1000.sweep(o).peaks]);
            AHP.MaleControl.preOPTO(n).full1000.sweep(o).mean_AHP = nanmean([AHP.MaleControl.preOPTO(n).full1000.sweep(o).AHP]);
        end
    end
    AHP.MaleControl.preOPTO(n).full1000.average.AP = nanmean([AHP.MaleControl.preOPTO(n).full1000.sweep(1).AP;
        AHP.MaleControl.preOPTO(n).full1000.sweep(2).AP;
        AHP.MaleControl.preOPTO(n).full1000.sweep(3).AP;
        AHP.MaleControl.preOPTO(n).full1000.sweep(4).AP;
        AHP.MaleControl.preOPTO(n).full1000.sweep(5).AP;
        AHP.MaleControl.preOPTO(n).full1000.sweep(6).AP]);
    AHP.MaleControl.preOPTO(n).full1000.average.mean_peak = nanmean([AHP.MaleControl.preOPTO(n).full1000.sweep(1).mean_peak;
        AHP.MaleControl.preOPTO(n).full1000.sweep(2).mean_peak;
        AHP.MaleControl.preOPTO(n).full1000.sweep(3).mean_peak;
        AHP.MaleControl.preOPTO(n).full1000.sweep(4).mean_peak;
        AHP.MaleControl.preOPTO(n).full1000.sweep(5).mean_peak;
        AHP.MaleControl.preOPTO(n).full1000.sweep(6).mean_peak]);
    AHP.MaleControl.preOPTO(n).full1000.average.mean_AHP = nanmean([AHP.MaleControl.preOPTO(n).full1000.sweep(1).mean_AHP;
        AHP.MaleControl.preOPTO(n).full1000.sweep(2).mean_AHP;
        AHP.MaleControl.preOPTO(n).full1000.sweep(3).mean_AHP;
        AHP.MaleControl.preOPTO(n).full1000.sweep(4).mean_AHP;
        AHP.MaleControl.preOPTO(n).full1000.sweep(5).mean_AHP;
        AHP.MaleControl.preOPTO(n).full1000.sweep(6).mean_AHP]);
end

clear m n o p

% Male Control OPTO
for n = 1 : length(AHP.MaleControl.OPTO) % number of cells
    for o = 1 : length(AHP.MaleControl.OPTO(n).peaks)    % 6 sweeps
        AHP.MaleControl.OPTO(n).full1000.sweep(o).peaks = [];
        AHP.MaleControl.OPTO(n).full1000.sweep(o).AHP = [];
        for p = 1 : length(AHP.MaleControl.OPTO(n).peaks(o).location.relativems)
            if AHP.MaleControl.OPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.MaleControl.OPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.MaleControl.OPTO(n).full1000.sweep(o).peaks = [AHP.MaleControl.OPTO(n).full1000.sweep(o).peaks; AHP.MaleControl.OPTO(n).peaks(o).mV(p)];
                AHP.MaleControl.OPTO(n).full1000.sweep(o).AHP = [AHP.MaleControl.OPTO(n).full1000.sweep(o).AHP; AHP.MaleControl.OPTO(n).AHP(o).mV(p)];
            end
            AHP.MaleControl.OPTO(n).full1000.sweep(o).AP = length(AHP.MaleControl.OPTO(n).full1000.sweep(o).peaks);
            AHP.MaleControl.OPTO(n).full1000.sweep(o).mean_peak = nanmean([AHP.MaleControl.OPTO(n).full1000.sweep(o).peaks]);
            AHP.MaleControl.OPTO(n).full1000.sweep(o).mean_AHP = nanmean([AHP.MaleControl.OPTO(n).full1000.sweep(o).AHP]);
        end
    end
    AHP.MaleControl.OPTO(n).full1000.average.AP = nanmean([AHP.MaleControl.OPTO(n).full1000.sweep(1).AP;
        AHP.MaleControl.OPTO(n).full1000.sweep(2).AP;
        AHP.MaleControl.OPTO(n).full1000.sweep(3).AP;
        AHP.MaleControl.OPTO(n).full1000.sweep(4).AP;
        AHP.MaleControl.OPTO(n).full1000.sweep(5).AP;
        AHP.MaleControl.OPTO(n).full1000.sweep(6).AP]);
    AHP.MaleControl.OPTO(n).full1000.average.mean_peak = nanmean([AHP.MaleControl.OPTO(n).full1000.sweep(1).mean_peak;
        AHP.MaleControl.OPTO(n).full1000.sweep(2).mean_peak;
        AHP.MaleControl.OPTO(n).full1000.sweep(3).mean_peak;
        AHP.MaleControl.OPTO(n).full1000.sweep(4).mean_peak;
        AHP.MaleControl.OPTO(n).full1000.sweep(5).mean_peak;
        AHP.MaleControl.OPTO(n).full1000.sweep(6).mean_peak]);
    AHP.MaleControl.OPTO(n).full1000.average.mean_AHP = nanmean([AHP.MaleControl.OPTO(n).full1000.sweep(1).mean_AHP;
        AHP.MaleControl.OPTO(n).full1000.sweep(2).mean_AHP;
        AHP.MaleControl.OPTO(n).full1000.sweep(3).mean_AHP;
        AHP.MaleControl.OPTO(n).full1000.sweep(4).mean_AHP;
        AHP.MaleControl.OPTO(n).full1000.sweep(5).mean_AHP;
        AHP.MaleControl.OPTO(n).full1000.sweep(6).mean_AHP]);
end

clear m n o p


% Male Fasted
% Male Fasted preOPTO
for n = 1 : length(AHP.MaleFasted.preOPTO) % number of cells
    for o = 1 : length(AHP.MaleFasted.preOPTO(n).peaks)    % 6 sweeps
        AHP.MaleFasted.preOPTO(n).full1000.sweep(o).peaks = [];
        AHP.MaleFasted.preOPTO(n).full1000.sweep(o).AHP = [];
        for p = 1 : length(AHP.MaleFasted.preOPTO(n).peaks(o).location.relativems)
            if AHP.MaleFasted.preOPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.MaleFasted.preOPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.MaleFasted.preOPTO(n).full1000.sweep(o).peaks = [AHP.MaleFasted.preOPTO(n).full1000.sweep(o).peaks; AHP.MaleFasted.preOPTO(n).peaks(o).mV(p)];
                AHP.MaleFasted.preOPTO(n).full1000.sweep(o).AHP = [AHP.MaleFasted.preOPTO(n).full1000.sweep(o).AHP; AHP.MaleFasted.preOPTO(n).AHP(o).mV(p)];
            end
            AHP.MaleFasted.preOPTO(n).full1000.sweep(o).AP = length(AHP.MaleFasted.preOPTO(n).full1000.sweep(o).peaks);
            AHP.MaleFasted.preOPTO(n).full1000.sweep(o).mean_peak = nanmean([AHP.MaleFasted.preOPTO(n).full1000.sweep(o).peaks]);
            AHP.MaleFasted.preOPTO(n).full1000.sweep(o).mean_AHP = nanmean([AHP.MaleFasted.preOPTO(n).full1000.sweep(o).AHP]);
        end
    end
    AHP.MaleFasted.preOPTO(n).full1000.average.AP = nanmean([AHP.MaleFasted.preOPTO(n).full1000.sweep(1).AP;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(2).AP;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(3).AP;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(4).AP;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(5).AP;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(6).AP]);
    AHP.MaleFasted.preOPTO(n).full1000.average.mean_peak = nanmean([AHP.MaleFasted.preOPTO(n).full1000.sweep(1).mean_peak;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(2).mean_peak;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(3).mean_peak;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(4).mean_peak;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(5).mean_peak;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(6).mean_peak]);
    AHP.MaleFasted.preOPTO(n).full1000.average.mean_AHP = nanmean([AHP.MaleFasted.preOPTO(n).full1000.sweep(1).mean_AHP;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(2).mean_AHP;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(3).mean_AHP;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(4).mean_AHP;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(5).mean_AHP;
        AHP.MaleFasted.preOPTO(n).full1000.sweep(6).mean_AHP]);
end

clear m n o p

% Male Fasted OPTO
for n = 1 : length(AHP.MaleFasted.OPTO) % number of cells
    for o = 1 : length(AHP.MaleFasted.OPTO(n).peaks)    % 6 sweeps
        AHP.MaleFasted.OPTO(n).full1000.sweep(o).peaks = [];
        AHP.MaleFasted.OPTO(n).full1000.sweep(o).AHP = [];
        for p = 1 : length(AHP.MaleFasted.OPTO(n).peaks(o).location.relativems)
            if AHP.MaleFasted.OPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.MaleFasted.OPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.MaleFasted.OPTO(n).full1000.sweep(o).peaks = [AHP.MaleFasted.OPTO(n).full1000.sweep(o).peaks; AHP.MaleFasted.OPTO(n).peaks(o).mV(p)];
                AHP.MaleFasted.OPTO(n).full1000.sweep(o).AHP = [AHP.MaleFasted.OPTO(n).full1000.sweep(o).AHP; AHP.MaleFasted.OPTO(n).AHP(o).mV(p)];
            end
            AHP.MaleFasted.OPTO(n).full1000.sweep(o).AP = length(AHP.MaleFasted.OPTO(n).full1000.sweep(o).peaks);
            AHP.MaleFasted.OPTO(n).full1000.sweep(o).mean_peak = nanmean([AHP.MaleFasted.OPTO(n).full1000.sweep(o).peaks]);
            AHP.MaleFasted.OPTO(n).full1000.sweep(o).mean_AHP = nanmean([AHP.MaleFasted.OPTO(n).full1000.sweep(o).AHP]);
        end
    end
    AHP.MaleFasted.OPTO(n).full1000.average.AP = nanmean([AHP.MaleFasted.OPTO(n).full1000.sweep(1).AP;
        AHP.MaleFasted.OPTO(n).full1000.sweep(2).AP;
        AHP.MaleFasted.OPTO(n).full1000.sweep(3).AP;
        AHP.MaleFasted.OPTO(n).full1000.sweep(4).AP;
        AHP.MaleFasted.OPTO(n).full1000.sweep(5).AP;
        AHP.MaleFasted.OPTO(n).full1000.sweep(6).AP]);
    AHP.MaleFasted.OPTO(n).full1000.average.mean_peak = nanmean([AHP.MaleFasted.OPTO(n).full1000.sweep(1).mean_peak;
        AHP.MaleFasted.OPTO(n).full1000.sweep(2).mean_peak;
        AHP.MaleFasted.OPTO(n).full1000.sweep(3).mean_peak;
        AHP.MaleFasted.OPTO(n).full1000.sweep(4).mean_peak;
        AHP.MaleFasted.OPTO(n).full1000.sweep(5).mean_peak;
        AHP.MaleFasted.OPTO(n).full1000.sweep(6).mean_peak]);
    AHP.MaleFasted.OPTO(n).full1000.average.mean_AHP = nanmean([AHP.MaleFasted.OPTO(n).full1000.sweep(1).mean_AHP;
        AHP.MaleFasted.OPTO(n).full1000.sweep(2).mean_AHP;
        AHP.MaleFasted.OPTO(n).full1000.sweep(3).mean_AHP;
        AHP.MaleFasted.OPTO(n).full1000.sweep(4).mean_AHP;
        AHP.MaleFasted.OPTO(n).full1000.sweep(5).mean_AHP;
        AHP.MaleFasted.OPTO(n).full1000.sweep(6).mean_AHP]);
end

clear m n o p


% Female Control
% Female Control preOPTO
for n = 1 : length(AHP.FemaleControl.preOPTO) % number of cells
    for o = 1 : length(AHP.FemaleControl.preOPTO(n).peaks)    % 6 sweeps
        AHP.FemaleControl.preOPTO(n).full1000.sweep(o).peaks = [];
        AHP.FemaleControl.preOPTO(n).full1000.sweep(o).AHP = [];
        for p = 1 : length(AHP.FemaleControl.preOPTO(n).peaks(o).location.relativems)
            if AHP.FemaleControl.preOPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.FemaleControl.preOPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.FemaleControl.preOPTO(n).full1000.sweep(o).peaks = [AHP.FemaleControl.preOPTO(n).full1000.sweep(o).peaks; AHP.FemaleControl.preOPTO(n).peaks(o).mV(p)];
                AHP.FemaleControl.preOPTO(n).full1000.sweep(o).AHP = [AHP.FemaleControl.preOPTO(n).full1000.sweep(o).AHP; AHP.FemaleControl.preOPTO(n).AHP(o).mV(p)];
            end
            AHP.FemaleControl.preOPTO(n).full1000.sweep(o).AP = length(AHP.FemaleControl.preOPTO(n).full1000.sweep(o).peaks);
            AHP.FemaleControl.preOPTO(n).full1000.sweep(o).mean_peak = nanmean([AHP.FemaleControl.preOPTO(n).full1000.sweep(o).peaks]);
            AHP.FemaleControl.preOPTO(n).full1000.sweep(o).mean_AHP = nanmean([AHP.FemaleControl.preOPTO(n).full1000.sweep(o).AHP]);
        end
    end
    AHP.FemaleControl.preOPTO(n).full1000.average.AP = nanmean([AHP.FemaleControl.preOPTO(n).full1000.sweep(1).AP;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(2).AP;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(3).AP;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(4).AP;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(5).AP;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(6).AP]);
    AHP.FemaleControl.preOPTO(n).full1000.average.mean_peak = nanmean([AHP.FemaleControl.preOPTO(n).full1000.sweep(1).mean_peak;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(2).mean_peak;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(3).mean_peak;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(4).mean_peak;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(5).mean_peak;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(6).mean_peak]);
    AHP.FemaleControl.preOPTO(n).full1000.average.mean_AHP = nanmean([AHP.FemaleControl.preOPTO(n).full1000.sweep(1).mean_AHP;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(2).mean_AHP;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(3).mean_AHP;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(4).mean_AHP;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(5).mean_AHP;
        AHP.FemaleControl.preOPTO(n).full1000.sweep(6).mean_AHP]);
end

clear m n o p

% Female Control OPTO
for n = 1 : length(AHP.FemaleControl.OPTO) % number of cells
    for o = 1 : length(AHP.FemaleControl.OPTO(n).peaks)    % 6 sweeps
        AHP.FemaleControl.OPTO(n).full1000.sweep(o).peaks = [];
        AHP.FemaleControl.OPTO(n).full1000.sweep(o).AHP = [];
        for p = 1 : length(AHP.FemaleControl.OPTO(n).peaks(o).location.relativems)
            if AHP.FemaleControl.OPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.FemaleControl.OPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.FemaleControl.OPTO(n).full1000.sweep(o).peaks = [AHP.FemaleControl.OPTO(n).full1000.sweep(o).peaks; AHP.FemaleControl.OPTO(n).peaks(o).mV(p)];
                AHP.FemaleControl.OPTO(n).full1000.sweep(o).AHP = [AHP.FemaleControl.OPTO(n).full1000.sweep(o).AHP; AHP.FemaleControl.OPTO(n).AHP(o).mV(p)];
            end
            AHP.FemaleControl.OPTO(n).full1000.sweep(o).AP = length(AHP.FemaleControl.OPTO(n).full1000.sweep(o).peaks);
            AHP.FemaleControl.OPTO(n).full1000.sweep(o).mean_peak = nanmean([AHP.FemaleControl.OPTO(n).full1000.sweep(o).peaks]);
            AHP.FemaleControl.OPTO(n).full1000.sweep(o).mean_AHP = nanmean([AHP.FemaleControl.OPTO(n).full1000.sweep(o).AHP]);
        end
    end
    AHP.FemaleControl.OPTO(n).full1000.average.AP = nanmean([AHP.FemaleControl.OPTO(n).full1000.sweep(1).AP;
        AHP.FemaleControl.OPTO(n).full1000.sweep(2).AP;
        AHP.FemaleControl.OPTO(n).full1000.sweep(3).AP;
        AHP.FemaleControl.OPTO(n).full1000.sweep(4).AP;
        AHP.FemaleControl.OPTO(n).full1000.sweep(5).AP;
        AHP.FemaleControl.OPTO(n).full1000.sweep(6).AP]);
    AHP.FemaleControl.OPTO(n).full1000.average.mean_peak = nanmean([AHP.FemaleControl.OPTO(n).full1000.sweep(1).mean_peak;
        AHP.FemaleControl.OPTO(n).full1000.sweep(2).mean_peak;
        AHP.FemaleControl.OPTO(n).full1000.sweep(3).mean_peak;
        AHP.FemaleControl.OPTO(n).full1000.sweep(4).mean_peak;
        AHP.FemaleControl.OPTO(n).full1000.sweep(5).mean_peak;
        AHP.FemaleControl.OPTO(n).full1000.sweep(6).mean_peak]);
    AHP.FemaleControl.OPTO(n).full1000.average.mean_AHP = nanmean([AHP.FemaleControl.OPTO(n).full1000.sweep(1).mean_AHP;
        AHP.FemaleControl.OPTO(n).full1000.sweep(2).mean_AHP;
        AHP.FemaleControl.OPTO(n).full1000.sweep(3).mean_AHP;
        AHP.FemaleControl.OPTO(n).full1000.sweep(4).mean_AHP;
        AHP.FemaleControl.OPTO(n).full1000.sweep(5).mean_AHP;
        AHP.FemaleControl.OPTO(n).full1000.sweep(6).mean_AHP]);
end

clear m n o p


% Female Fasted
% Female Fasted preOPTO
for n = 1 : length(AHP.FemaleFasted.preOPTO) % number of cells
    for o = 1 : length(AHP.FemaleFasted.preOPTO(n).peaks)    % 6 sweeps
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(o).peaks = [];
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(o).AHP = [];
        for p = 1 : length(AHP.FemaleFasted.preOPTO(n).peaks(o).location.relativems)
            if AHP.FemaleFasted.preOPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.FemaleFasted.preOPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.FemaleFasted.preOPTO(n).full1000.sweep(o).peaks = [AHP.FemaleFasted.preOPTO(n).full1000.sweep(o).peaks; AHP.FemaleFasted.preOPTO(n).peaks(o).mV(p)];
                AHP.FemaleFasted.preOPTO(n).full1000.sweep(o).AHP = [AHP.FemaleFasted.preOPTO(n).full1000.sweep(o).AHP; AHP.FemaleFasted.preOPTO(n).AHP(o).mV(p)];
            end
            AHP.FemaleFasted.preOPTO(n).full1000.sweep(o).AP = length(AHP.FemaleFasted.preOPTO(n).full1000.sweep(o).peaks);
            AHP.FemaleFasted.preOPTO(n).full1000.sweep(o).mean_peak = nanmean([AHP.FemaleFasted.preOPTO(n).full1000.sweep(o).peaks]);
            AHP.FemaleFasted.preOPTO(n).full1000.sweep(o).mean_AHP = nanmean([AHP.FemaleFasted.preOPTO(n).full1000.sweep(o).AHP]);
        end
    end
    AHP.FemaleFasted.preOPTO(n).full1000.average.AP = nanmean([AHP.FemaleFasted.preOPTO(n).full1000.sweep(1).AP;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(2).AP;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(3).AP;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(4).AP;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(5).AP;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(6).AP]);
    AHP.FemaleFasted.preOPTO(n).full1000.average.mean_peak = nanmean([AHP.FemaleFasted.preOPTO(n).full1000.sweep(1).mean_peak;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(2).mean_peak;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(3).mean_peak;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(4).mean_peak;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(5).mean_peak;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(6).mean_peak]);
    AHP.FemaleFasted.preOPTO(n).full1000.average.mean_AHP = nanmean([AHP.FemaleFasted.preOPTO(n).full1000.sweep(1).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(2).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(3).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(4).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(5).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).full1000.sweep(6).mean_AHP]);
end

clear m n o p

% Female Fasted OPTO
for n = 1 : length(AHP.FemaleFasted.OPTO) % number of cells
    for o = 1 : length(AHP.FemaleFasted.OPTO(n).peaks)    % 6 sweeps
        AHP.FemaleFasted.OPTO(n).full1000.sweep(o).peaks = [];
        AHP.FemaleFasted.OPTO(n).full1000.sweep(o).AHP = [];
        for p = 1 : length(AHP.FemaleFasted.OPTO(n).peaks(o).location.relativems)
            if AHP.FemaleFasted.OPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.FemaleFasted.OPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.FemaleFasted.OPTO(n).full1000.sweep(o).peaks = [AHP.FemaleFasted.OPTO(n).full1000.sweep(o).peaks; AHP.FemaleFasted.OPTO(n).peaks(o).mV(p)];
                AHP.FemaleFasted.OPTO(n).full1000.sweep(o).AHP = [AHP.FemaleFasted.OPTO(n).full1000.sweep(o).AHP; AHP.FemaleFasted.OPTO(n).AHP(o).mV(p)];
            end
            AHP.FemaleFasted.OPTO(n).full1000.sweep(o).AP = length(AHP.FemaleFasted.OPTO(n).full1000.sweep(o).peaks);
            AHP.FemaleFasted.OPTO(n).full1000.sweep(o).mean_peak = nanmean([AHP.FemaleFasted.OPTO(n).full1000.sweep(o).peaks]);
            AHP.FemaleFasted.OPTO(n).full1000.sweep(o).mean_AHP = nanmean([AHP.FemaleFasted.OPTO(n).full1000.sweep(o).AHP]);
        end
    end
    AHP.FemaleFasted.OPTO(n).full1000.average.AP = nanmean([AHP.FemaleFasted.OPTO(n).full1000.sweep(1).AP;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(2).AP;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(3).AP;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(4).AP;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(5).AP;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(6).AP]);
    AHP.FemaleFasted.OPTO(n).full1000.average.mean_peak = nanmean([AHP.FemaleFasted.OPTO(n).full1000.sweep(1).mean_peak;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(2).mean_peak;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(3).mean_peak;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(4).mean_peak;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(5).mean_peak;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(6).mean_peak]);
    AHP.FemaleFasted.OPTO(n).full1000.average.mean_AHP = nanmean([AHP.FemaleFasted.OPTO(n).full1000.sweep(1).mean_AHP;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(2).mean_AHP;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(3).mean_AHP;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(4).mean_AHP;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(5).mean_AHP;
        AHP.FemaleFasted.OPTO(n).full1000.sweep(6).mean_AHP]);
end

clear m n o p

clear bin


%% Making table for the full 1000 ms (full1000) data

% Male Control
MC_preOPTO = {};
for n = 1:length(AHP.MaleControl.preOPTO)
    MC_preOPTO(n,1) = {'Male_Control'};
    MC_preOPTO(n,2) = {'preOPTO'};
    MC_preOPTO(n,3) = {AHP.MaleControl.preOPTO(n).filename};
    MC_preOPTO(n,4) = {AHP.MaleControl.preOPTO(n).full1000.average.AP};
    MC_preOPTO(n,5) = {AHP.MaleControl.preOPTO(n).full1000.average.mean_peak};
    MC_preOPTO(n,6) = {AHP.MaleControl.preOPTO(n).full1000.average.mean_AHP};
end

MC_OPTO = {};
for n = 1:length(AHP.MaleControl.OPTO)
    MC_OPTO(n,1) = {'Male_Control'};
    MC_OPTO(n,2) = {'OPTO'};
    MC_OPTO(n,3) = {AHP.MaleControl.OPTO(n).filename};
    MC_OPTO(n,4) = {AHP.MaleControl.OPTO(n).full1000.average.AP};
    MC_OPTO(n,5) = {AHP.MaleControl.OPTO(n).full1000.average.mean_peak};
    MC_OPTO(n,6) = {AHP.MaleControl.OPTO(n).full1000.average.mean_AHP};
end


% Male Fasted
MF_preOPTO = {};
for n = 1:length(AHP.MaleFasted.preOPTO)
    MF_preOPTO(n,1) = {'Male_Fasted'};
    MF_preOPTO(n,2) = {'preOPTO'};
    MF_preOPTO(n,3) = {AHP.MaleFasted.preOPTO(n).filename};
    MF_preOPTO(n,4) = {AHP.MaleFasted.preOPTO(n).full1000.average.AP};
    MF_preOPTO(n,5) = {AHP.MaleFasted.preOPTO(n).full1000.average.mean_peak};
    MF_preOPTO(n,6) = {AHP.MaleFasted.preOPTO(n).full1000.average.mean_AHP};
end

MF_OPTO = {};
for n = 1:length(AHP.MaleFasted.OPTO)
    MF_OPTO(n,1) = {'Male_Fasted'};
    MF_OPTO(n,2) = {'OPTO'};
    MF_OPTO(n,3) = {AHP.MaleFasted.OPTO(n).filename};
    MF_OPTO(n,4) = {AHP.MaleFasted.OPTO(n).full1000.average.AP};
    MF_OPTO(n,5) = {AHP.MaleFasted.OPTO(n).full1000.average.mean_peak};
    MF_OPTO(n,6) = {AHP.MaleFasted.OPTO(n).full1000.average.mean_AHP};
end


% Female Control
FC_preOPTO = {};
for n = 1:length(AHP.FemaleControl.preOPTO)
    FC_preOPTO(n,1) = {'Female_Control'};
    FC_preOPTO(n,2) = {'preOPTO'};
    FC_preOPTO(n,3) = {AHP.FemaleControl.preOPTO(n).filename};
    FC_preOPTO(n,4) = {AHP.FemaleControl.preOPTO(n).full1000.average.AP};
    FC_preOPTO(n,5) = {AHP.FemaleControl.preOPTO(n).full1000.average.mean_peak};
    FC_preOPTO(n,6) = {AHP.FemaleControl.preOPTO(n).full1000.average.mean_AHP};
end

FC_OPTO = {};
for n = 1:length(AHP.FemaleControl.OPTO)
    FC_OPTO(n,1) = {'Female_Control'};
    FC_OPTO(n,2) = {'OPTO'};
    FC_OPTO(n,3) = {AHP.FemaleControl.OPTO(n).filename};
    FC_OPTO(n,4) = {AHP.FemaleControl.OPTO(n).full1000.average.AP};
    FC_OPTO(n,5) = {AHP.FemaleControl.OPTO(n).full1000.average.mean_peak};
    FC_OPTO(n,6) = {AHP.FemaleControl.OPTO(n).full1000.average.mean_AHP};
end


% Female Fasted
FF_preOPTO = {};
for n = 1:length(AHP.FemaleFasted.preOPTO)
    FF_preOPTO(n,1) = {'Female_Fasted'};
    FF_preOPTO(n,2) = {'preOPTO'};
    FF_preOPTO(n,3) = {AHP.FemaleFasted.preOPTO(n).filename};
    FF_preOPTO(n,4) = {AHP.FemaleFasted.preOPTO(n).full1000.average.AP};
    FF_preOPTO(n,5) = {AHP.FemaleFasted.preOPTO(n).full1000.average.mean_peak};
    FF_preOPTO(n,6) = {AHP.FemaleFasted.preOPTO(n).full1000.average.mean_AHP};
end

FF_OPTO = {};
for n = 1:length(AHP.FemaleFasted.OPTO)
    FF_OPTO(n,1) = {'Female_Fasted'};
    FF_OPTO(n,2) = {'OPTO'};
    FF_OPTO(n,3) = {AHP.FemaleFasted.OPTO(n).filename};
    FF_OPTO(n,4) = {AHP.FemaleFasted.OPTO(n).full1000.average.AP};
    FF_OPTO(n,5) = {AHP.FemaleFasted.OPTO(n).full1000.average.mean_peak};
    FF_OPTO(n,6) = {AHP.FemaleFasted.OPTO(n).full1000.average.mean_AHP};
end

blank = {'' '' '' '' '' ''};
MC_Array = [MC_preOPTO; blank; MC_OPTO];
MF_Array = [MF_preOPTO; blank; MF_OPTO];
FC_Array = [FC_preOPTO; blank; FC_OPTO];
FF_Array = [FF_preOPTO; blank; FF_OPTO];

AHP.tables.MaleControl.full1000 = array2table(MC_Array, 'VariableNames', {'Group', 'OPTO', 'Filename', 'AP', 'mean_peak', 'mean_AHP'});
AHP.tables.MaleFasted.full1000 = array2table(MF_Array, 'VariableNames', {'Group', 'OPTO', 'Filename', 'AP', 'mean_peak', 'mean_AHP'});
AHP.tables.FemaleControl.full1000 = array2table(FC_Array, 'VariableNames', {'Group', 'OPTO', 'Filename', 'AP', 'mean_peak', 'mean_AHP'});
AHP.tables.FemaleFasted.full1000 = array2table(FF_Array, 'VariableNames', {'Group', 'OPTO', 'Filename', 'AP', 'mean_peak', 'mean_AHP'});

clear MC_preOPTO MC_OPTO MF_preOPTO MF_OPTO FC_preOPTO FC_OPTO FF_preOPTO FF_OPTO MC_Array MF_Array FC_Array FF_Array blank n

%% Get these values for the final 200 ms (final200) of step

bin = [800 1000];

% Male Control
% Male Control preOPTO
for n = 1 : length(AHP.MaleControl.preOPTO) % number of cells
    for o = 1 : length(AHP.MaleControl.preOPTO(n).peaks)    % 6 sweeps
        AHP.MaleControl.preOPTO(n).final200.sweep(o).peaks = [];
        AHP.MaleControl.preOPTO(n).final200.sweep(o).AHP = [];
        for p = 1 : length(AHP.MaleControl.preOPTO(n).peaks(o).location.relativems)
            if AHP.MaleControl.preOPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.MaleControl.preOPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.MaleControl.preOPTO(n).final200.sweep(o).peaks = [AHP.MaleControl.preOPTO(n).final200.sweep(o).peaks; AHP.MaleControl.preOPTO(n).peaks(o).mV(p)];
                AHP.MaleControl.preOPTO(n).final200.sweep(o).AHP = [AHP.MaleControl.preOPTO(n).final200.sweep(o).AHP; AHP.MaleControl.preOPTO(n).AHP(o).mV(p)];
            end
            AHP.MaleControl.preOPTO(n).final200.sweep(o).AP = length(AHP.MaleControl.preOPTO(n).final200.sweep(o).peaks);
            AHP.MaleControl.preOPTO(n).final200.sweep(o).mean_peak = nanmean([AHP.MaleControl.preOPTO(n).final200.sweep(o).peaks]);
            AHP.MaleControl.preOPTO(n).final200.sweep(o).mean_AHP = nanmean([AHP.MaleControl.preOPTO(n).final200.sweep(o).AHP]);
        end
    end
    AHP.MaleControl.preOPTO(n).final200.average.AP = nanmean([AHP.MaleControl.preOPTO(n).final200.sweep(1).AP;
        AHP.MaleControl.preOPTO(n).final200.sweep(2).AP;
        AHP.MaleControl.preOPTO(n).final200.sweep(3).AP;
        AHP.MaleControl.preOPTO(n).final200.sweep(4).AP;
        AHP.MaleControl.preOPTO(n).final200.sweep(5).AP;
        AHP.MaleControl.preOPTO(n).final200.sweep(6).AP]);
    AHP.MaleControl.preOPTO(n).final200.average.mean_peak = nanmean([AHP.MaleControl.preOPTO(n).final200.sweep(1).mean_peak;
        AHP.MaleControl.preOPTO(n).final200.sweep(2).mean_peak;
        AHP.MaleControl.preOPTO(n).final200.sweep(3).mean_peak;
        AHP.MaleControl.preOPTO(n).final200.sweep(4).mean_peak;
        AHP.MaleControl.preOPTO(n).final200.sweep(5).mean_peak;
        AHP.MaleControl.preOPTO(n).final200.sweep(6).mean_peak]);
    AHP.MaleControl.preOPTO(n).final200.average.mean_AHP = nanmean([AHP.MaleControl.preOPTO(n).final200.sweep(1).mean_AHP;
        AHP.MaleControl.preOPTO(n).final200.sweep(2).mean_AHP;
        AHP.MaleControl.preOPTO(n).final200.sweep(3).mean_AHP;
        AHP.MaleControl.preOPTO(n).final200.sweep(4).mean_AHP;
        AHP.MaleControl.preOPTO(n).final200.sweep(5).mean_AHP;
        AHP.MaleControl.preOPTO(n).final200.sweep(6).mean_AHP]);
end

clear m n o p

% Male Control OPTO
for n = 1 : length(AHP.MaleControl.OPTO) % number of cells
    for o = 1 : length(AHP.MaleControl.OPTO(n).peaks)    % 6 sweeps
        AHP.MaleControl.OPTO(n).final200.sweep(o).peaks = [];
        AHP.MaleControl.OPTO(n).final200.sweep(o).AHP = [];
        for p = 1 : length(AHP.MaleControl.OPTO(n).peaks(o).location.relativems)
            if AHP.MaleControl.OPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.MaleControl.OPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.MaleControl.OPTO(n).final200.sweep(o).peaks = [AHP.MaleControl.OPTO(n).final200.sweep(o).peaks; AHP.MaleControl.OPTO(n).peaks(o).mV(p)];
                AHP.MaleControl.OPTO(n).final200.sweep(o).AHP = [AHP.MaleControl.OPTO(n).final200.sweep(o).AHP; AHP.MaleControl.OPTO(n).AHP(o).mV(p)];
            end
            AHP.MaleControl.OPTO(n).final200.sweep(o).AP = length(AHP.MaleControl.OPTO(n).final200.sweep(o).peaks);
            AHP.MaleControl.OPTO(n).final200.sweep(o).mean_peak = nanmean([AHP.MaleControl.OPTO(n).final200.sweep(o).peaks]);
            AHP.MaleControl.OPTO(n).final200.sweep(o).mean_AHP = nanmean([AHP.MaleControl.OPTO(n).final200.sweep(o).AHP]);
        end
    end
    AHP.MaleControl.OPTO(n).final200.average.AP = nanmean([AHP.MaleControl.OPTO(n).final200.sweep(1).AP;
        AHP.MaleControl.OPTO(n).final200.sweep(2).AP;
        AHP.MaleControl.OPTO(n).final200.sweep(3).AP;
        AHP.MaleControl.OPTO(n).final200.sweep(4).AP;
        AHP.MaleControl.OPTO(n).final200.sweep(5).AP;
        AHP.MaleControl.OPTO(n).final200.sweep(6).AP]);
    AHP.MaleControl.OPTO(n).final200.average.mean_peak = nanmean([AHP.MaleControl.OPTO(n).final200.sweep(1).mean_peak;
        AHP.MaleControl.OPTO(n).final200.sweep(2).mean_peak;
        AHP.MaleControl.OPTO(n).final200.sweep(3).mean_peak;
        AHP.MaleControl.OPTO(n).final200.sweep(4).mean_peak;
        AHP.MaleControl.OPTO(n).final200.sweep(5).mean_peak;
        AHP.MaleControl.OPTO(n).final200.sweep(6).mean_peak]);
    AHP.MaleControl.OPTO(n).final200.average.mean_AHP = nanmean([AHP.MaleControl.OPTO(n).final200.sweep(1).mean_AHP;
        AHP.MaleControl.OPTO(n).final200.sweep(2).mean_AHP;
        AHP.MaleControl.OPTO(n).final200.sweep(3).mean_AHP;
        AHP.MaleControl.OPTO(n).final200.sweep(4).mean_AHP;
        AHP.MaleControl.OPTO(n).final200.sweep(5).mean_AHP;
        AHP.MaleControl.OPTO(n).final200.sweep(6).mean_AHP]);
end

clear m n o p


% Male Fasted
% Male Fasted preOPTO
for n = 1 : length(AHP.MaleFasted.preOPTO) % number of cells
    for o = 1 : length(AHP.MaleFasted.preOPTO(n).peaks)    % 6 sweeps
        AHP.MaleFasted.preOPTO(n).final200.sweep(o).peaks = [];
        AHP.MaleFasted.preOPTO(n).final200.sweep(o).AHP = [];
        for p = 1 : length(AHP.MaleFasted.preOPTO(n).peaks(o).location.relativems)
            if AHP.MaleFasted.preOPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.MaleFasted.preOPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.MaleFasted.preOPTO(n).final200.sweep(o).peaks = [AHP.MaleFasted.preOPTO(n).final200.sweep(o).peaks; AHP.MaleFasted.preOPTO(n).peaks(o).mV(p)];
                AHP.MaleFasted.preOPTO(n).final200.sweep(o).AHP = [AHP.MaleFasted.preOPTO(n).final200.sweep(o).AHP; AHP.MaleFasted.preOPTO(n).AHP(o).mV(p)];
            end
            AHP.MaleFasted.preOPTO(n).final200.sweep(o).AP = length(AHP.MaleFasted.preOPTO(n).final200.sweep(o).peaks);
            AHP.MaleFasted.preOPTO(n).final200.sweep(o).mean_peak = nanmean([AHP.MaleFasted.preOPTO(n).final200.sweep(o).peaks]);
            AHP.MaleFasted.preOPTO(n).final200.sweep(o).mean_AHP = nanmean([AHP.MaleFasted.preOPTO(n).final200.sweep(o).AHP]);
        end
    end
    AHP.MaleFasted.preOPTO(n).final200.average.AP = nanmean([AHP.MaleFasted.preOPTO(n).final200.sweep(1).AP;
        AHP.MaleFasted.preOPTO(n).final200.sweep(2).AP;
        AHP.MaleFasted.preOPTO(n).final200.sweep(3).AP;
        AHP.MaleFasted.preOPTO(n).final200.sweep(4).AP;
        AHP.MaleFasted.preOPTO(n).final200.sweep(5).AP;
        AHP.MaleFasted.preOPTO(n).final200.sweep(6).AP]);
    AHP.MaleFasted.preOPTO(n).final200.average.mean_peak = nanmean([AHP.MaleFasted.preOPTO(n).final200.sweep(1).mean_peak;
        AHP.MaleFasted.preOPTO(n).final200.sweep(2).mean_peak;
        AHP.MaleFasted.preOPTO(n).final200.sweep(3).mean_peak;
        AHP.MaleFasted.preOPTO(n).final200.sweep(4).mean_peak;
        AHP.MaleFasted.preOPTO(n).final200.sweep(5).mean_peak;
        AHP.MaleFasted.preOPTO(n).final200.sweep(6).mean_peak]);
    AHP.MaleFasted.preOPTO(n).final200.average.mean_AHP = nanmean([AHP.MaleFasted.preOPTO(n).final200.sweep(1).mean_AHP;
        AHP.MaleFasted.preOPTO(n).final200.sweep(2).mean_AHP;
        AHP.MaleFasted.preOPTO(n).final200.sweep(3).mean_AHP;
        AHP.MaleFasted.preOPTO(n).final200.sweep(4).mean_AHP;
        AHP.MaleFasted.preOPTO(n).final200.sweep(5).mean_AHP;
        AHP.MaleFasted.preOPTO(n).final200.sweep(6).mean_AHP]);
end

clear m n o p

% Male Fasted OPTO
for n = 1 : length(AHP.MaleFasted.OPTO) % number of cells
    for o = 1 : length(AHP.MaleFasted.OPTO(n).peaks)    % 6 sweeps
        AHP.MaleFasted.OPTO(n).final200.sweep(o).peaks = [];
        AHP.MaleFasted.OPTO(n).final200.sweep(o).AHP = [];
        for p = 1 : length(AHP.MaleFasted.OPTO(n).peaks(o).location.relativems)
            if AHP.MaleFasted.OPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.MaleFasted.OPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.MaleFasted.OPTO(n).final200.sweep(o).peaks = [AHP.MaleFasted.OPTO(n).final200.sweep(o).peaks; AHP.MaleFasted.OPTO(n).peaks(o).mV(p)];
                AHP.MaleFasted.OPTO(n).final200.sweep(o).AHP = [AHP.MaleFasted.OPTO(n).final200.sweep(o).AHP; AHP.MaleFasted.OPTO(n).AHP(o).mV(p)];
            end
            AHP.MaleFasted.OPTO(n).final200.sweep(o).AP = length(AHP.MaleFasted.OPTO(n).final200.sweep(o).peaks);
            AHP.MaleFasted.OPTO(n).final200.sweep(o).mean_peak = nanmean([AHP.MaleFasted.OPTO(n).final200.sweep(o).peaks]);
            AHP.MaleFasted.OPTO(n).final200.sweep(o).mean_AHP = nanmean([AHP.MaleFasted.OPTO(n).final200.sweep(o).AHP]);
        end
    end
    AHP.MaleFasted.OPTO(n).final200.average.AP = nanmean([AHP.MaleFasted.OPTO(n).final200.sweep(1).AP;
        AHP.MaleFasted.OPTO(n).final200.sweep(2).AP;
        AHP.MaleFasted.OPTO(n).final200.sweep(3).AP;
        AHP.MaleFasted.OPTO(n).final200.sweep(4).AP;
        AHP.MaleFasted.OPTO(n).final200.sweep(5).AP;
        AHP.MaleFasted.OPTO(n).final200.sweep(6).AP]);
    AHP.MaleFasted.OPTO(n).final200.average.mean_peak = nanmean([AHP.MaleFasted.OPTO(n).final200.sweep(1).mean_peak;
        AHP.MaleFasted.OPTO(n).final200.sweep(2).mean_peak;
        AHP.MaleFasted.OPTO(n).final200.sweep(3).mean_peak;
        AHP.MaleFasted.OPTO(n).final200.sweep(4).mean_peak;
        AHP.MaleFasted.OPTO(n).final200.sweep(5).mean_peak;
        AHP.MaleFasted.OPTO(n).final200.sweep(6).mean_peak]);
    AHP.MaleFasted.OPTO(n).final200.average.mean_AHP = nanmean([AHP.MaleFasted.OPTO(n).final200.sweep(1).mean_AHP;
        AHP.MaleFasted.OPTO(n).final200.sweep(2).mean_AHP;
        AHP.MaleFasted.OPTO(n).final200.sweep(3).mean_AHP;
        AHP.MaleFasted.OPTO(n).final200.sweep(4).mean_AHP;
        AHP.MaleFasted.OPTO(n).final200.sweep(5).mean_AHP;
        AHP.MaleFasted.OPTO(n).final200.sweep(6).mean_AHP]);
end

clear m n o p


% Female Control
% Female Control preOPTO
for n = 1 : length(AHP.FemaleControl.preOPTO) % number of cells
    for o = 1 : length(AHP.FemaleControl.preOPTO(n).peaks)    % 6 sweeps
        AHP.FemaleControl.preOPTO(n).final200.sweep(o).peaks = [];
        AHP.FemaleControl.preOPTO(n).final200.sweep(o).AHP = [];
        for p = 1 : length(AHP.FemaleControl.preOPTO(n).peaks(o).location.relativems)
            if AHP.FemaleControl.preOPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.FemaleControl.preOPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.FemaleControl.preOPTO(n).final200.sweep(o).peaks = [AHP.FemaleControl.preOPTO(n).final200.sweep(o).peaks; AHP.FemaleControl.preOPTO(n).peaks(o).mV(p)];
                AHP.FemaleControl.preOPTO(n).final200.sweep(o).AHP = [AHP.FemaleControl.preOPTO(n).final200.sweep(o).AHP; AHP.FemaleControl.preOPTO(n).AHP(o).mV(p)];
            end
            AHP.FemaleControl.preOPTO(n).final200.sweep(o).AP = length(AHP.FemaleControl.preOPTO(n).final200.sweep(o).peaks);
            AHP.FemaleControl.preOPTO(n).final200.sweep(o).mean_peak = nanmean([AHP.FemaleControl.preOPTO(n).final200.sweep(o).peaks]);
            AHP.FemaleControl.preOPTO(n).final200.sweep(o).mean_AHP = nanmean([AHP.FemaleControl.preOPTO(n).final200.sweep(o).AHP]);
        end
    end
    AHP.FemaleControl.preOPTO(n).final200.average.AP = nanmean([AHP.FemaleControl.preOPTO(n).final200.sweep(1).AP;
        AHP.FemaleControl.preOPTO(n).final200.sweep(2).AP;
        AHP.FemaleControl.preOPTO(n).final200.sweep(3).AP;
        AHP.FemaleControl.preOPTO(n).final200.sweep(4).AP;
        AHP.FemaleControl.preOPTO(n).final200.sweep(5).AP;
        AHP.FemaleControl.preOPTO(n).final200.sweep(6).AP]);
    AHP.FemaleControl.preOPTO(n).final200.average.mean_peak = nanmean([AHP.FemaleControl.preOPTO(n).final200.sweep(1).mean_peak;
        AHP.FemaleControl.preOPTO(n).final200.sweep(2).mean_peak;
        AHP.FemaleControl.preOPTO(n).final200.sweep(3).mean_peak;
        AHP.FemaleControl.preOPTO(n).final200.sweep(4).mean_peak;
        AHP.FemaleControl.preOPTO(n).final200.sweep(5).mean_peak;
        AHP.FemaleControl.preOPTO(n).final200.sweep(6).mean_peak]);
    AHP.FemaleControl.preOPTO(n).final200.average.mean_AHP = nanmean([AHP.FemaleControl.preOPTO(n).final200.sweep(1).mean_AHP;
        AHP.FemaleControl.preOPTO(n).final200.sweep(2).mean_AHP;
        AHP.FemaleControl.preOPTO(n).final200.sweep(3).mean_AHP;
        AHP.FemaleControl.preOPTO(n).final200.sweep(4).mean_AHP;
        AHP.FemaleControl.preOPTO(n).final200.sweep(5).mean_AHP;
        AHP.FemaleControl.preOPTO(n).final200.sweep(6).mean_AHP]);
end

clear m n o p

% Female Control OPTO
for n = 1 : length(AHP.FemaleControl.OPTO) % number of cells
    for o = 1 : length(AHP.FemaleControl.OPTO(n).peaks)    % 6 sweeps
        AHP.FemaleControl.OPTO(n).final200.sweep(o).peaks = [];
        AHP.FemaleControl.OPTO(n).final200.sweep(o).AHP = [];
        for p = 1 : length(AHP.FemaleControl.OPTO(n).peaks(o).location.relativems)
            if AHP.FemaleControl.OPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.FemaleControl.OPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.FemaleControl.OPTO(n).final200.sweep(o).peaks = [AHP.FemaleControl.OPTO(n).final200.sweep(o).peaks; AHP.FemaleControl.OPTO(n).peaks(o).mV(p)];
                AHP.FemaleControl.OPTO(n).final200.sweep(o).AHP = [AHP.FemaleControl.OPTO(n).final200.sweep(o).AHP; AHP.FemaleControl.OPTO(n).AHP(o).mV(p)];
            end
            AHP.FemaleControl.OPTO(n).final200.sweep(o).AP = length(AHP.FemaleControl.OPTO(n).final200.sweep(o).peaks);
            AHP.FemaleControl.OPTO(n).final200.sweep(o).mean_peak = nanmean([AHP.FemaleControl.OPTO(n).final200.sweep(o).peaks]);
            AHP.FemaleControl.OPTO(n).final200.sweep(o).mean_AHP = nanmean([AHP.FemaleControl.OPTO(n).final200.sweep(o).AHP]);
        end
    end
    AHP.FemaleControl.OPTO(n).final200.average.AP = nanmean([AHP.FemaleControl.OPTO(n).final200.sweep(1).AP;
        AHP.FemaleControl.OPTO(n).final200.sweep(2).AP;
        AHP.FemaleControl.OPTO(n).final200.sweep(3).AP;
        AHP.FemaleControl.OPTO(n).final200.sweep(4).AP;
        AHP.FemaleControl.OPTO(n).final200.sweep(5).AP;
        AHP.FemaleControl.OPTO(n).final200.sweep(6).AP]);
    AHP.FemaleControl.OPTO(n).final200.average.mean_peak = nanmean([AHP.FemaleControl.OPTO(n).final200.sweep(1).mean_peak;
        AHP.FemaleControl.OPTO(n).final200.sweep(2).mean_peak;
        AHP.FemaleControl.OPTO(n).final200.sweep(3).mean_peak;
        AHP.FemaleControl.OPTO(n).final200.sweep(4).mean_peak;
        AHP.FemaleControl.OPTO(n).final200.sweep(5).mean_peak;
        AHP.FemaleControl.OPTO(n).final200.sweep(6).mean_peak]);
    AHP.FemaleControl.OPTO(n).final200.average.mean_AHP = nanmean([AHP.FemaleControl.OPTO(n).final200.sweep(1).mean_AHP;
        AHP.FemaleControl.OPTO(n).final200.sweep(2).mean_AHP;
        AHP.FemaleControl.OPTO(n).final200.sweep(3).mean_AHP;
        AHP.FemaleControl.OPTO(n).final200.sweep(4).mean_AHP;
        AHP.FemaleControl.OPTO(n).final200.sweep(5).mean_AHP;
        AHP.FemaleControl.OPTO(n).final200.sweep(6).mean_AHP]);
end

clear m n o p


% Female Fasted
% Female Fasted preOPTO
for n = 1 : length(AHP.FemaleFasted.preOPTO) % number of cells
    for o = 1 : length(AHP.FemaleFasted.preOPTO(n).peaks)    % 6 sweeps
        AHP.FemaleFasted.preOPTO(n).final200.sweep(o).peaks = [];
        AHP.FemaleFasted.preOPTO(n).final200.sweep(o).AHP = [];
        for p = 1 : length(AHP.FemaleFasted.preOPTO(n).peaks(o).location.relativems)
            if AHP.FemaleFasted.preOPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.FemaleFasted.preOPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.FemaleFasted.preOPTO(n).final200.sweep(o).peaks = [AHP.FemaleFasted.preOPTO(n).final200.sweep(o).peaks; AHP.FemaleFasted.preOPTO(n).peaks(o).mV(p)];
                AHP.FemaleFasted.preOPTO(n).final200.sweep(o).AHP = [AHP.FemaleFasted.preOPTO(n).final200.sweep(o).AHP; AHP.FemaleFasted.preOPTO(n).AHP(o).mV(p)];
            end
            AHP.FemaleFasted.preOPTO(n).final200.sweep(o).AP = length(AHP.FemaleFasted.preOPTO(n).final200.sweep(o).peaks);
            AHP.FemaleFasted.preOPTO(n).final200.sweep(o).mean_peak = nanmean([AHP.FemaleFasted.preOPTO(n).final200.sweep(o).peaks]);
            AHP.FemaleFasted.preOPTO(n).final200.sweep(o).mean_AHP = nanmean([AHP.FemaleFasted.preOPTO(n).final200.sweep(o).AHP]);
        end
    end
    AHP.FemaleFasted.preOPTO(n).final200.average.AP = nanmean([AHP.FemaleFasted.preOPTO(n).final200.sweep(1).AP;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(2).AP;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(3).AP;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(4).AP;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(5).AP;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(6).AP]);
    AHP.FemaleFasted.preOPTO(n).final200.average.mean_peak = nanmean([AHP.FemaleFasted.preOPTO(n).final200.sweep(1).mean_peak;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(2).mean_peak;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(3).mean_peak;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(4).mean_peak;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(5).mean_peak;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(6).mean_peak]);
    AHP.FemaleFasted.preOPTO(n).final200.average.mean_AHP = nanmean([AHP.FemaleFasted.preOPTO(n).final200.sweep(1).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(2).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(3).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(4).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(5).mean_AHP;
        AHP.FemaleFasted.preOPTO(n).final200.sweep(6).mean_AHP]);
end

clear m n o p

% Female Fasted OPTO
for n = 1 : length(AHP.FemaleFasted.OPTO) % number of cells
    for o = 1 : length(AHP.FemaleFasted.OPTO(n).peaks)    % 6 sweeps
        AHP.FemaleFasted.OPTO(n).final200.sweep(o).peaks = [];
        AHP.FemaleFasted.OPTO(n).final200.sweep(o).AHP = [];
        for p = 1 : length(AHP.FemaleFasted.OPTO(n).peaks(o).location.relativems)
            if AHP.FemaleFasted.OPTO(n).peaks(o).location.relativems(p) > bin(1) & AHP.FemaleFasted.OPTO(n).peaks(o).location.relativems(p) <= bin(2)
                AHP.FemaleFasted.OPTO(n).final200.sweep(o).peaks = [AHP.FemaleFasted.OPTO(n).final200.sweep(o).peaks; AHP.FemaleFasted.OPTO(n).peaks(o).mV(p)];
                AHP.FemaleFasted.OPTO(n).final200.sweep(o).AHP = [AHP.FemaleFasted.OPTO(n).final200.sweep(o).AHP; AHP.FemaleFasted.OPTO(n).AHP(o).mV(p)];
            end
            AHP.FemaleFasted.OPTO(n).final200.sweep(o).AP = length(AHP.FemaleFasted.OPTO(n).final200.sweep(o).peaks);
            AHP.FemaleFasted.OPTO(n).final200.sweep(o).mean_peak = nanmean([AHP.FemaleFasted.OPTO(n).final200.sweep(o).peaks]);
            AHP.FemaleFasted.OPTO(n).final200.sweep(o).mean_AHP = nanmean([AHP.FemaleFasted.OPTO(n).final200.sweep(o).AHP]);
        end
    end
    AHP.FemaleFasted.OPTO(n).final200.average.AP = nanmean([AHP.FemaleFasted.OPTO(n).final200.sweep(1).AP;
        AHP.FemaleFasted.OPTO(n).final200.sweep(2).AP;
        AHP.FemaleFasted.OPTO(n).final200.sweep(3).AP;
        AHP.FemaleFasted.OPTO(n).final200.sweep(4).AP;
        AHP.FemaleFasted.OPTO(n).final200.sweep(5).AP;
        AHP.FemaleFasted.OPTO(n).final200.sweep(6).AP]);
    AHP.FemaleFasted.OPTO(n).final200.average.mean_peak = nanmean([AHP.FemaleFasted.OPTO(n).final200.sweep(1).mean_peak;
        AHP.FemaleFasted.OPTO(n).final200.sweep(2).mean_peak;
        AHP.FemaleFasted.OPTO(n).final200.sweep(3).mean_peak;
        AHP.FemaleFasted.OPTO(n).final200.sweep(4).mean_peak;
        AHP.FemaleFasted.OPTO(n).final200.sweep(5).mean_peak;
        AHP.FemaleFasted.OPTO(n).final200.sweep(6).mean_peak]);
    AHP.FemaleFasted.OPTO(n).final200.average.mean_AHP = nanmean([AHP.FemaleFasted.OPTO(n).final200.sweep(1).mean_AHP;
        AHP.FemaleFasted.OPTO(n).final200.sweep(2).mean_AHP;
        AHP.FemaleFasted.OPTO(n).final200.sweep(3).mean_AHP;
        AHP.FemaleFasted.OPTO(n).final200.sweep(4).mean_AHP;
        AHP.FemaleFasted.OPTO(n).final200.sweep(5).mean_AHP;
        AHP.FemaleFasted.OPTO(n).final200.sweep(6).mean_AHP]);
end

clear m n o p

clear bin


%% Making table for the final 500 ms (final200) data

% Male Control
MC_preOPTO = {};
for n = 1:length(AHP.MaleControl.preOPTO)
    MC_preOPTO(n,1) = {'Male_Control'};
    MC_preOPTO(n,2) = {'preOPTO'};
    MC_preOPTO(n,3) = {AHP.MaleControl.preOPTO(n).filename};
    MC_preOPTO(n,4) = {AHP.MaleControl.preOPTO(n).final200.average.AP};
    MC_preOPTO(n,5) = {AHP.MaleControl.preOPTO(n).final200.average.mean_peak};
    MC_preOPTO(n,6) = {AHP.MaleControl.preOPTO(n).final200.average.mean_AHP};
end

MC_OPTO = {};
for n = 1:length(AHP.MaleControl.OPTO)
    MC_OPTO(n,1) = {'Male_Control'};
    MC_OPTO(n,2) = {'OPTO'};
    MC_OPTO(n,3) = {AHP.MaleControl.OPTO(n).filename};
    MC_OPTO(n,4) = {AHP.MaleControl.OPTO(n).final200.average.AP};
    MC_OPTO(n,5) = {AHP.MaleControl.OPTO(n).final200.average.mean_peak};
    MC_OPTO(n,6) = {AHP.MaleControl.OPTO(n).final200.average.mean_AHP};
end


% Male Fasted
MF_preOPTO = {};
for n = 1:length(AHP.MaleFasted.preOPTO)
    MF_preOPTO(n,1) = {'Male_Fasted'};
    MF_preOPTO(n,2) = {'preOPTO'};
    MF_preOPTO(n,3) = {AHP.MaleFasted.preOPTO(n).filename};
    MF_preOPTO(n,4) = {AHP.MaleFasted.preOPTO(n).final200.average.AP};
    MF_preOPTO(n,5) = {AHP.MaleFasted.preOPTO(n).final200.average.mean_peak};
    MF_preOPTO(n,6) = {AHP.MaleFasted.preOPTO(n).final200.average.mean_AHP};
end

MF_OPTO = {};
for n = 1:length(AHP.MaleFasted.OPTO)
    MF_OPTO(n,1) = {'Male_Fasted'};
    MF_OPTO(n,2) = {'OPTO'};
    MF_OPTO(n,3) = {AHP.MaleFasted.OPTO(n).filename};
    MF_OPTO(n,4) = {AHP.MaleFasted.OPTO(n).final200.average.AP};
    MF_OPTO(n,5) = {AHP.MaleFasted.OPTO(n).final200.average.mean_peak};
    MF_OPTO(n,6) = {AHP.MaleFasted.OPTO(n).final200.average.mean_AHP};
end


% Female Control
FC_preOPTO = {};
for n = 1:length(AHP.FemaleControl.preOPTO)
    FC_preOPTO(n,1) = {'Female_Control'};
    FC_preOPTO(n,2) = {'preOPTO'};
    FC_preOPTO(n,3) = {AHP.FemaleControl.preOPTO(n).filename};
    FC_preOPTO(n,4) = {AHP.FemaleControl.preOPTO(n).final200.average.AP};
    FC_preOPTO(n,5) = {AHP.FemaleControl.preOPTO(n).final200.average.mean_peak};
    FC_preOPTO(n,6) = {AHP.FemaleControl.preOPTO(n).final200.average.mean_AHP};
end

FC_OPTO = {};
for n = 1:length(AHP.FemaleControl.OPTO)
    FC_OPTO(n,1) = {'Female_Control'};
    FC_OPTO(n,2) = {'OPTO'};
    FC_OPTO(n,3) = {AHP.FemaleControl.OPTO(n).filename};
    FC_OPTO(n,4) = {AHP.FemaleControl.OPTO(n).final200.average.AP};
    FC_OPTO(n,5) = {AHP.FemaleControl.OPTO(n).final200.average.mean_peak};
    FC_OPTO(n,6) = {AHP.FemaleControl.OPTO(n).final200.average.mean_AHP};
end


% Female Fasted
FF_preOPTO = {};
for n = 1:length(AHP.FemaleFasted.preOPTO)
    FF_preOPTO(n,1) = {'Female_Fasted'};
    FF_preOPTO(n,2) = {'preOPTO'};
    FF_preOPTO(n,3) = {AHP.FemaleFasted.preOPTO(n).filename};
    FF_preOPTO(n,4) = {AHP.FemaleFasted.preOPTO(n).final200.average.AP};
    FF_preOPTO(n,5) = {AHP.FemaleFasted.preOPTO(n).final200.average.mean_peak};
    FF_preOPTO(n,6) = {AHP.FemaleFasted.preOPTO(n).final200.average.mean_AHP};
end

FF_OPTO = {};
for n = 1:length(AHP.FemaleFasted.OPTO)
    FF_OPTO(n,1) = {'Female_Fasted'};
    FF_OPTO(n,2) = {'OPTO'};
    FF_OPTO(n,3) = {AHP.FemaleFasted.OPTO(n).filename};
    FF_OPTO(n,4) = {AHP.FemaleFasted.OPTO(n).final200.average.AP};
    FF_OPTO(n,5) = {AHP.FemaleFasted.OPTO(n).final200.average.mean_peak};
    FF_OPTO(n,6) = {AHP.FemaleFasted.OPTO(n).final200.average.mean_AHP};
end

blank = {'' '' '' '' '' ''};
MC_Array = [MC_preOPTO; blank; MC_OPTO];
MF_Array = [MF_preOPTO; blank; MF_OPTO];
FC_Array = [FC_preOPTO; blank; FC_OPTO];
FF_Array = [FF_preOPTO; blank; FF_OPTO];

AHP.tables.MaleControl.final200 = array2table(MC_Array, 'VariableNames', {'Group', 'OPTO', 'Filename', 'AP', 'mean_peak', 'mean_AHP'});
AHP.tables.MaleFasted.final200 = array2table(MF_Array, 'VariableNames', {'Group', 'OPTO', 'Filename', 'AP', 'mean_peak', 'mean_AHP'});
AHP.tables.FemaleControl.final200 = array2table(FC_Array, 'VariableNames', {'Group', 'OPTO', 'Filename', 'AP', 'mean_peak', 'mean_AHP'});
AHP.tables.FemaleFasted.final200 = array2table(FF_Array, 'VariableNames', {'Group', 'OPTO', 'Filename', 'AP', 'mean_peak', 'mean_AHP'});

clear MC_preOPTO MC_OPTO MF_preOPTO MF_OPTO FC_preOPTO FC_OPTO FF_preOPTO FF_OPTO MC_Array MF_Array FC_Array FF_Array blank n

%% Write table of final and first 500 ms to excel

cd /Users/nathansmac/Desktop/VTA_INPUTS/GABA_Firing/

writetable(AHP.tables.MaleControl.first200,'Binned_7Oct2021_Firing.xlsx','Sheet','MC_first200','Range','A1');
writetable(AHP.tables.MaleFasted.first200,'Binned_7Oct2021_Firing.xlsx','Sheet','MF_first200','Range','A1');
writetable(AHP.tables.FemaleControl.first200,'Binned_7Oct2021_Firing.xlsx','Sheet','FC_first200','Range','A1');
writetable(AHP.tables.FemaleFasted.first200,'Binned_7Oct2021_Firing.xlsx','Sheet','FF_first200','Range','A1');

writetable(AHP.tables.MaleControl.full1000,'Binned_8Oct2021_Firing.xlsx','Sheet','MC_full1000','Range','A1');
writetable(AHP.tables.MaleFasted.full1000,'Binned_8Oct2021_Firing.xlsx','Sheet','MF_full1000','Range','A1');
writetable(AHP.tables.FemaleControl.full1000,'Binned_8Oct2021_Firing.xlsx','Sheet','FC_full1000','Range','A1');
writetable(AHP.tables.FemaleFasted.full1000,'Binned_8Oct2021_Firing.xlsx','Sheet','FF_full1000','Range','A1');

writetable(AHP.tables.MaleControl.final200,'Binned_8Oct2021_Firing.xlsx','Sheet','MC_final200','Range','A1');
writetable(AHP.tables.MaleFasted.final200,'Binned_8Oct2021_Firing.xlsx','Sheet','MF_final200','Range','A1');
writetable(AHP.tables.FemaleControl.final200,'Binned_8Oct2021_Firing.xlsx','Sheet','FC_final200','Range','A1');
writetable(AHP.tables.FemaleFasted.final200,'Binned_8Oct2021_Firing.xlsx','Sheet','FF_final200','Range','A1');

