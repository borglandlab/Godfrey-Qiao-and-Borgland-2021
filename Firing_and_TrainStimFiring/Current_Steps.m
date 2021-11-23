%{
This script was used to analyze a series of 25 pA current steps. In
September and October, there were 14 steps, from -25 pA to 300 pA. After
October there were 16 current steps, form -75 pA to 300 pA. Later in
graphpad prism, I removed all steps past 200 pA, since most cells were
hitting some sort of depolarization block by then.

Properties that I analyzed/calculated were:
- number of action potentials
- frequency of action potentials
- interevent interval (IEI) of action potentials
- latency to fire of the first action potential in the script

The data was not binned, but rather each step was analyzed as a whole.
%}

%% Add paths
addpath /Users/nathansmac/Documents/MATLAB/MATLAB/
addpath /Users/nathansmac/Documents/MATLAB/MATLAB/Trains_InputStrength/Firing/

%% directory to MATLAB Folder
cd /Users/nathansmac/Documents/MATLAB/MATLAB/Trains_InputStrength/Firing/

%% Load the structre where my data is found (Unless this is the first time)
cd /Users/nathansmac/Desktop/VTA_INPUTS/GABA_Firing/6Jan2021/

load('Firing_LH2VTA.mat')

%% Counting Action Potentials, frequency, interevent interval, and latency to fire

pattern = {'Sep','Oct'};

StartStep = 56.2;  % Start of Step: 56.2 ms

% Male Control

% Counting the number of action potentials
for m = 1 : length(Firing.MaleControl)
    if istable(Firing.MaleControl(m).STEPS_25pA)
        if contains(Firing.MaleControl(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.MaleControl(m).STEPS_25pA);
            Firing.MaleControl(m).STEPS_25pA_AP = zeros(1,steps_14);
            d = 1;
            while d < (steps_14+1)
                AP = [];
                for n = 1:s(1)
                    if Firing.MaleControl(m).STEPS_25pA.Trace(n) == d
                        Firing.MaleControl(m).STEPS_25pA_AP(d) = Firing.MaleControl(m).STEPS_25pA_AP(d) + 1;
                    end
                end
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -25pA)
            s = size(Firing.MaleControl(m).STEPS_25pA);
            Firing.MaleControl(m).STEPS_25pA_AP = zeros(1,steps_16);
            d = 1;
            while d < (steps_16+1)
                AP = [];
                for n = 1:s(1)
                    if Firing.MaleControl(m).STEPS_25pA.Trace(n) == d
                        Firing.MaleControl(m).STEPS_25pA_AP(d) = Firing.MaleControl(m).STEPS_25pA_AP(d) + 1;
                    end
                end
                d = d + 1;
            end
        end
    else
        Firing.MaleControl(m).STEPS_25pA_AP = nan;
    end
end

% Finding the average frequency
for m = 1 : length(Firing.MaleControl)
    if istable(Firing.MaleControl(m).STEPS_25pA)
        if contains(Firing.MaleControl(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.MaleControl(m).STEPS_25pA);
            d = 1;
            while d < (steps_14+1)
                Frequency = [];
                for n = 1:s(1)
                    if Firing.MaleControl(m).STEPS_25pA.Trace(n) == d
                        Frequency = [Frequency Firing.MaleControl(m).STEPS_25pA.InstFreqHz(n)];
                    end
                end
                Firing.MaleControl(m).STEPS_25pA_Frequency(d) = mean(Frequency,'omitnan');
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -25pA)
            s = size(Firing.MaleControl(m).STEPS_25pA);
            d = 1;
            while d < (steps_16+1)
                Frequency = [];
                for n = 1:s(1)
                    if Firing.MaleControl(m).STEPS_25pA.Trace(n) == d
                        Frequency = [Frequency Firing.MaleControl(m).STEPS_25pA.InstFreqHz(n)];
                    end
                end
                Firing.MaleControl(m).STEPS_25pA_Frequency(d) = mean(Frequency,'omitnan');
                d = d + 1;
            end
        end
    else
        Firing.MaleControl(m).STEPS_25pA_Frequency = nan;
    end
end

% Finding the average interevent interval (IEI)
for m = 1 : length(Firing.MaleControl)
    if istable(Firing.MaleControl(m).STEPS_25pA)
        if contains(Firing.MaleControl(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.MaleControl(m).STEPS_25pA);
            d = 1;
            while d < (steps_14+1)
                IEI = [];
                for n = 1:s(1)
                    if Firing.MaleControl(m).STEPS_25pA.Trace(n) == d
                        IEI = [IEI Firing.MaleControl(m).STEPS_25pA.IntereventIntervalms(n)];
                    end
                end
                Firing.MaleControl(m).STEPS_25pA_IEI(d) = mean(IEI,'omitnan');
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -25pA)
            s = size(Firing.MaleControl(m).STEPS_25pA);
            d = 1;
            while d < (steps_16+1)
                IEI = [];
                for n = 1:s(1)
                    if Firing.MaleControl(m).STEPS_25pA.Trace(n) == d
                        IEI = [IEI Firing.MaleControl(m).STEPS_25pA.IntereventIntervalms(n)];
                    end
                end
                Firing.MaleControl(m).STEPS_25pA_IEI(d) = mean(IEI,'omitnan');
                d = d + 1;
            end
        end
    else
        Firing.MaleControl(m).STEPS_25pA_IEI = nan;
    end
end

% Finding the latency to fire
for m = 1 : length(Firing.MaleControl)
    if istable(Firing.MaleControl(m).STEPS_25pA)
        if contains(Firing.MaleControl(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.MaleControl(m).STEPS_25pA);
            d = 1;
            while d < (steps_14+1)
                L2F = [];
                for n = 1:s(1)
                    if Firing.MaleControl(m).STEPS_25pA.Trace(n) == d
                        L2F = [L2F Firing.MaleControl(m).STEPS_25pA.EventStartTimems(n)];
                    end
                end
                if length(L2F) > 0
                    Firing.MaleControl(m).STEPS_25pA_L2F(d) = L2F(1) - StartStep;
                else
                    Firing.MaleControl(m).STEPS_25pA_L2F(d) = nan;
                end
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -75pA)
            s = size(Firing.MaleControl(m).STEPS_25pA);
            d = 1;
            while d < (steps_16+1)
                L2F = [];
                for n = 1:s(1)
                    if Firing.MaleControl(m).STEPS_25pA.Trace(n) == d
                        L2F = [L2F Firing.MaleControl(m).STEPS_25pA.EventStartTimems(n)];
                    end
                end
                if length(L2F) > 0
                    Firing.MaleControl(m).STEPS_25pA_L2F(d) = L2F(1) - StartStep;
                else
                    Firing.MaleControl(m).STEPS_25pA_L2F(d) = nan;
                end
                d = d + 1;
            end
        end
    else
        Firing.MaleControl(m).STEPS_25pA_L2F = nan;
    end
end


% Male Fasted

% Counting the number of action potentials
for m = 1 : length(Firing.MaleFasted)
    if istable(Firing.MaleFasted(m).STEPS_25pA)
        if contains(Firing.MaleFasted(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.MaleFasted(m).STEPS_25pA);
            Firing.MaleFasted(m).STEPS_25pA_AP = zeros(1,steps_14);
            d = 1;
            while d < (steps_14+1)
                AP = [];
                for n = 1:s(1)
                    if Firing.MaleFasted(m).STEPS_25pA.Trace(n) == d
                        Firing.MaleFasted(m).STEPS_25pA_AP(d) = Firing.MaleFasted(m).STEPS_25pA_AP(d) + 1;
                    end
                end
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -25pA)
            s = size(Firing.MaleFasted(m).STEPS_25pA);
            Firing.MaleFasted(m).STEPS_25pA_AP = zeros(1,steps_16);
            d = 1;
            while d < (steps_16+1)
                AP = [];
                for n = 1:s(1)
                    if Firing.MaleFasted(m).STEPS_25pA.Trace(n) == d
                        Firing.MaleFasted(m).STEPS_25pA_AP(d) = Firing.MaleFasted(m).STEPS_25pA_AP(d) + 1;
                    end
                end
                d = d + 1;
            end
        end
    else
        Firing.MaleFasted(m).STEPS_25pA_AP = nan;
    end
end

% Finding the average frequency
for m = 1 : length(Firing.MaleFasted)
    if istable(Firing.MaleFasted(m).STEPS_25pA)
        if contains(Firing.MaleFasted(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.MaleFasted(m).STEPS_25pA);
            d = 1;
            while d < (steps_14+1)
                Frequency = [];
                for n = 1:s(1)
                    if Firing.MaleFasted(m).STEPS_25pA.Trace(n) == d
                        Frequency = [Frequency Firing.MaleFasted(m).STEPS_25pA.InstFreqHz(n)];
                    end
                end
                Firing.MaleFasted(m).STEPS_25pA_Frequency(d) = mean(Frequency,'omitnan');
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -25pA)
            s = size(Firing.MaleFasted(m).STEPS_25pA);
            d = 1;
            while d < (steps_16+1)
                Frequency = [];
                for n = 1:s(1)
                    if Firing.MaleFasted(m).STEPS_25pA.Trace(n) == d
                        Frequency = [Frequency Firing.MaleFasted(m).STEPS_25pA.InstFreqHz(n)];
                    end
                end
                Firing.MaleFasted(m).STEPS_25pA_Frequency(d) = mean(Frequency,'omitnan');
                d = d + 1;
            end
        end
    else
        Firing.MaleFasted(m).STEPS_25pA_Frequency = nan;
    end
end

% Finding the average interevent interval (IEI)
for m = 1 : length(Firing.MaleFasted)
    if istable(Firing.MaleFasted(m).STEPS_25pA)
        if contains(Firing.MaleFasted(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.MaleFasted(m).STEPS_25pA);
            d = 1;
            while d < (steps_14+1)
                IEI = [];
                for n = 1:s(1)
                    if Firing.MaleFasted(m).STEPS_25pA.Trace(n) == d
                        IEI = [IEI Firing.MaleFasted(m).STEPS_25pA.IntereventIntervalms(n)];
                    end
                end
                Firing.MaleFasted(m).STEPS_25pA_IEI(d) = mean(IEI,'omitnan');
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -25pA)
            s = size(Firing.MaleFasted(m).STEPS_25pA);
            d = 1;
            while d < (steps_16+1)
                IEI = [];
                for n = 1:s(1)
                    if Firing.MaleFasted(m).STEPS_25pA.Trace(n) == d
                        IEI = [IEI Firing.MaleFasted(m).STEPS_25pA.IntereventIntervalms(n)];
                    end
                end
                Firing.MaleFasted(m).STEPS_25pA_IEI(d) = mean(IEI,'omitnan');
                d = d + 1;
            end
        end
    else
        Firing.MaleFasted(m).STEPS_25pA_IEI = nan;
    end
end

% Finding the latency to fire
for m = 1 : length(Firing.MaleFasted)
    if istable(Firing.MaleFasted(m).STEPS_25pA)
        if contains(Firing.MaleFasted(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.MaleFasted(m).STEPS_25pA);
            d = 1;
            while d < (steps_14+1)
                L2F = [];
                for n = 1:s(1)
                    if Firing.MaleFasted(m).STEPS_25pA.Trace(n) == d
                        L2F = [L2F Firing.MaleFasted(m).STEPS_25pA.EventStartTimems(n)];
                    end
                end
                if length(L2F) > 0
                    Firing.MaleFasted(m).STEPS_25pA_L2F(d) = L2F(1) - StartStep;
                else
                    Firing.MaleFasted(m).STEPS_25pA_L2F(d) = nan;
                end
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -75pA)
            s = size(Firing.MaleFasted(m).STEPS_25pA);
            d = 1;
            while d < (steps_16+1)
                L2F = [];
                for n = 1:s(1)
                    if Firing.MaleFasted(m).STEPS_25pA.Trace(n) == d
                        L2F = [L2F Firing.MaleFasted(m).STEPS_25pA.EventStartTimems(n)];
                    end
                end
                if length(L2F) > 0
                    Firing.MaleFasted(m).STEPS_25pA_L2F(d) = L2F(1) - StartStep;
                else
                    Firing.MaleFasted(m).STEPS_25pA_L2F(d) = nan;
                end
                d = d + 1;
            end
        end
    else
        Firing.MaleFasted(m).STEPS_25pA_L2F = nan;
    end
end

% Female Control

% Counting the number of action potentials
for m = 1 : length(Firing.FemaleControl)
    if istable(Firing.FemaleControl(m).STEPS_25pA)
        if contains(Firing.FemaleControl(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.FemaleControl(m).STEPS_25pA);
            Firing.FemaleControl(m).STEPS_25pA_AP = zeros(1,steps_14);
            d = 1;
            while d < (steps_14+1)
                AP = [];
                for n = 1:s(1)
                    if Firing.FemaleControl(m).STEPS_25pA.Trace(n) == d
                        Firing.FemaleControl(m).STEPS_25pA_AP(d) = Firing.FemaleControl(m).STEPS_25pA_AP(d) + 1;
                    end
                end
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -25pA)
            s = size(Firing.FemaleControl(m).STEPS_25pA);
            Firing.FemaleControl(m).STEPS_25pA_AP = zeros(1,steps_16);
            d = 1;
            while d < (steps_16+1)
                AP = [];
                for n = 1:s(1)
                    if Firing.FemaleControl(m).STEPS_25pA.Trace(n) == d
                        Firing.FemaleControl(m).STEPS_25pA_AP(d) = Firing.FemaleControl(m).STEPS_25pA_AP(d) + 1;
                    end
                end
                d = d + 1;
            end
        end
    else
        Firing.FemaleControl(m).STEPS_25pA_AP = nan;
    end
end

% Finding the average frequency
for m = 1 : length(Firing.FemaleControl)
    if istable(Firing.FemaleControl(m).STEPS_25pA)
        if contains(Firing.FemaleControl(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.FemaleControl(m).STEPS_25pA);
            d = 1;
            while d < (steps_14+1)
                Frequency = [];
                for n = 1:s(1)
                    if Firing.FemaleControl(m).STEPS_25pA.Trace(n) == d
                        Frequency = [Frequency Firing.FemaleControl(m).STEPS_25pA.InstFreqHz(n)];
                    end
                end
                Firing.FemaleControl(m).STEPS_25pA_Frequency(d) = mean(Frequency,'omitnan');
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -25pA)
            s = size(Firing.FemaleControl(m).STEPS_25pA);
            d = 1;
            while d < (steps_16+1)
                Frequency = [];
                for n = 1:s(1)
                    if Firing.FemaleControl(m).STEPS_25pA.Trace(n) == d
                        Frequency = [Frequency Firing.FemaleControl(m).STEPS_25pA.InstFreqHz(n)];
                    end
                end
                Firing.FemaleControl(m).STEPS_25pA_Frequency(d) = mean(Frequency,'omitnan');
                d = d + 1;
            end
        end
    else
        Firing.FemaleControl(m).STEPS_25pA_Frequency = nan;
    end
end

% Finding the average interevent interval (IEI)
for m = 1 : length(Firing.FemaleControl)
    if istable(Firing.FemaleControl(m).STEPS_25pA)
        if contains(Firing.FemaleControl(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.FemaleControl(m).STEPS_25pA);
            d = 1;
            while d < (steps_14+1)
                IEI = [];
                for n = 1:s(1)
                    if Firing.FemaleControl(m).STEPS_25pA.Trace(n) == d
                        IEI = [IEI Firing.FemaleControl(m).STEPS_25pA.IntereventIntervalms(n)];
                    end
                end
                Firing.FemaleControl(m).STEPS_25pA_IEI(d) = mean(IEI,'omitnan');
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -25pA)
            s = size(Firing.FemaleControl(m).STEPS_25pA);
            d = 1;
            while d < (steps_16+1)
                IEI = [];
                for n = 1:s(1)
                    if Firing.FemaleControl(m).STEPS_25pA.Trace(n) == d
                        IEI = [IEI Firing.FemaleControl(m).STEPS_25pA.IntereventIntervalms(n)];
                    end
                end
                Firing.FemaleControl(m).STEPS_25pA_IEI(d) = mean(IEI,'omitnan');
                d = d + 1;
            end
        end
    else
        Firing.FemaleControl(m).STEPS_25pA_IEI = nan;
    end
end

% Finding the latency to fire
for m = 1 : length(Firing.FemaleControl)
    if istable(Firing.FemaleControl(m).STEPS_25pA)
        if contains(Firing.FemaleControl(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.FemaleControl(m).STEPS_25pA);
            d = 1;
            while d < (steps_14+1)
                L2F = [];
                for n = 1:s(1)
                    if Firing.FemaleControl(m).STEPS_25pA.Trace(n) == d
                        L2F = [L2F Firing.FemaleControl(m).STEPS_25pA.EventStartTimems(n)];
                    end
                end
                if length(L2F) > 0
                    Firing.FemaleControl(m).STEPS_25pA_L2F(d) = L2F(1) - StartStep;
                else
                    Firing.FemaleControl(m).STEPS_25pA_L2F(d) = nan;
                end
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -75pA)
            s = size(Firing.FemaleControl(m).STEPS_25pA);
            d = 1;
            while d < (steps_16+1)
                L2F = [];
                for n = 1:s(1)
                    if Firing.FemaleControl(m).STEPS_25pA.Trace(n) == d
                        L2F = [L2F Firing.FemaleControl(m).STEPS_25pA.EventStartTimems(n)];
                    end
                end
                if length(L2F) > 0
                    Firing.FemaleControl(m).STEPS_25pA_L2F(d) = L2F(1) - StartStep;
                else
                    Firing.FemaleControl(m).STEPS_25pA_L2F(d) = nan;
                end
                d = d + 1;
            end
        end
    else
        Firing.FemaleControl(m).STEPS_25pA_L2F = nan;
    end
end

% Female Fasted

% Counting the number of action potentials
for m = 1 : length(Firing.FemaleFasted)
    if istable(Firing.FemaleFasted(m).STEPS_25pA)
        if contains(Firing.FemaleFasted(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.FemaleFasted(m).STEPS_25pA);
            Firing.FemaleFasted(m).STEPS_25pA_AP = zeros(1,steps_14);
            d = 1;
            while d < (steps_14+1)
                AP = [];
                for n = 1:s(1)
                    if Firing.FemaleFasted(m).STEPS_25pA.Trace(n) == d
                        Firing.FemaleFasted(m).STEPS_25pA_AP(d) = Firing.FemaleFasted(m).STEPS_25pA_AP(d) + 1;
                    end
                end
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -25pA)
            s = size(Firing.FemaleFasted(m).STEPS_25pA);
            Firing.FemaleFasted(m).STEPS_25pA_AP = zeros(1,steps_16);
            d = 1;
            while d < (steps_16+1)
                AP = [];
                for n = 1:s(1)
                    if Firing.FemaleFasted(m).STEPS_25pA.Trace(n) == d
                        Firing.FemaleFasted(m).STEPS_25pA_AP(d) = Firing.FemaleFasted(m).STEPS_25pA_AP(d) + 1;
                    end
                end
                d = d + 1;
            end
        end
    else
        Firing.FemaleFasted(m).STEPS_25pA_AP = nan;
    end
end

% Finding the average frequency
for m = 1 : length(Firing.FemaleFasted)
    if istable(Firing.FemaleFasted(m).STEPS_25pA)
        if contains(Firing.FemaleFasted(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.FemaleFasted(m).STEPS_25pA);
            d = 1;
            while d < (steps_14+1)
                Frequency = [];
                for n = 1:s(1)
                    if Firing.FemaleFasted(m).STEPS_25pA.Trace(n) == d
                        Frequency = [Frequency Firing.FemaleFasted(m).STEPS_25pA.InstFreqHz(n)];
                    end
                end
                Firing.FemaleFasted(m).STEPS_25pA_Frequency(d) = mean(Frequency,'omitnan');
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -25pA)
            s = size(Firing.FemaleFasted(m).STEPS_25pA);
            d = 1;
            while d < (steps_16+1)
                Frequency = [];
                for n = 1:s(1)
                    if Firing.FemaleFasted(m).STEPS_25pA.Trace(n) == d
                        Frequency = [Frequency Firing.FemaleFasted(m).STEPS_25pA.InstFreqHz(n)];
                    end
                end
                Firing.FemaleFasted(m).STEPS_25pA_Frequency(d) = mean(Frequency,'omitnan');
                d = d + 1;
            end
        end
    else
        Firing.FemaleFasted(m).STEPS_25pA_Frequency = nan;
    end
end

% Finding the average interevent interval (IEI)
for m = 1 : length(Firing.FemaleFasted)
    if istable(Firing.FemaleFasted(m).STEPS_25pA)
        if contains(Firing.FemaleFasted(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.FemaleFasted(m).STEPS_25pA);
            d = 1;
            while d < (steps_14+1)
                IEI = [];
                for n = 1:s(1)
                    if Firing.FemaleFasted(m).STEPS_25pA.Trace(n) == d
                        IEI = [IEI Firing.FemaleFasted(m).STEPS_25pA.IntereventIntervalms(n)];
                    end
                end
                Firing.FemaleFasted(m).STEPS_25pA_IEI(d) = mean(IEI,'omitnan');
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -25pA)
            s = size(Firing.FemaleFasted(m).STEPS_25pA);
            d = 1;
            while d < (steps_16+1)
                IEI = [];
                for n = 1:s(1)
                    if Firing.FemaleFasted(m).STEPS_25pA.Trace(n) == d
                        IEI = [IEI Firing.FemaleFasted(m).STEPS_25pA.IntereventIntervalms(n)];
                    end
                end
                Firing.FemaleFasted(m).STEPS_25pA_IEI(d) = mean(IEI,'omitnan');
                d = d + 1;
            end
        end
    else
        Firing.FemaleFasted(m).STEPS_25pA_IEI = nan;
    end
end

% Finding the latency to fire
for m = 1 : length(Firing.FemaleFasted)
    if istable(Firing.FemaleFasted(m).STEPS_25pA)
        if contains(Firing.FemaleFasted(1).tableRange.Tab_Names(m),pattern)
            steps_14 = 14;     % The step protocol in Sep and Oct only had 14 steps (starting at -25pA)
            s = size(Firing.FemaleFasted(m).STEPS_25pA);
            d = 1;
            while d < (steps_14+1)
                L2F = [];
                for n = 1:s(1)
                    if Firing.FemaleFasted(m).STEPS_25pA.Trace(n) == d
                        L2F = [L2F Firing.FemaleFasted(m).STEPS_25pA.EventStartTimems(n)];
                    end
                end
                if length(L2F) > 0
                    Firing.FemaleFasted(m).STEPS_25pA_L2F(d) = L2F(1) - StartStep;
                else
                    Firing.FemaleFasted(m).STEPS_25pA_L2F(d) = nan;
                end
                d = d + 1;
            end
        else
            steps_16 = 16;     % The step protocol after Oct had 16 steps (starting at -75pA)
            s = size(Firing.FemaleFasted(m).STEPS_25pA);
            d = 1;
            while d < (steps_16+1)
                L2F = [];
                for n = 1:s(1)
                    if Firing.FemaleFasted(m).STEPS_25pA.Trace(n) == d
                        L2F = [L2F Firing.FemaleFasted(m).STEPS_25pA.EventStartTimems(n)];
                    end
                end
                if length(L2F) > 0
                    Firing.FemaleFasted(m).STEPS_25pA_L2F(d) = L2F(1) - StartStep;
                else
                    Firing.FemaleFasted(m).STEPS_25pA_L2F(d) = nan;
                end
                d = d + 1;
            end
        end
    else
        Firing.FemaleFasted(m).STEPS_25pA_L2F = nan;
    end
end

clear d m n s steps_14 steps_16 Frequency IEI AP pattern L2F StartStep

%% Defining Variables for Tables

steps_16_num = [1:16]';         % There are 16 steps
steps_16_pA = [-75:25:300]';	% These steps are in 25 pA increments from -75 pA to 300 pA

%% Creating Tables - Male Control

% Creating variable names
variable_names = {};
for n = 1:length(Firing.MaleControl)
    variable = ['name_' char(Firing.MaleControl(1).tableRange.Tab_Names(n))];
    variable_names{1,n} = variable;
end
variable_names = ["step_num" "pA" string(variable_names)];

% Number of Action Potentials

% Creating matrix with the number of action potentials
nAP = [];
for n = 1:length(Firing.MaleControl)
    if ~isnan(Firing.MaleControl(n).STEPS_25pA_AP(1))
        if length(Firing.MaleControl(n).STEPS_25pA_AP) < 16
            ADJUSTED = [nan nan Firing.MaleControl(n).STEPS_25pA_AP];
        else
            ADJUSTED = [Firing.MaleControl(n).STEPS_25pA_AP];
        end
    else
        ADJUSTED = nan(1,16);
    end
    nAP = [nAP ADJUSTED'];
end

nAP = [steps_16_num steps_16_pA nAP];

% Creating table with the number of action potentials
Firing.Tables.MC_nAP_25pA = array2table(nAP,'VariableNames',variable_names);


% Creating matrix with average Frequency
FREQ = [];
for n = 1:length(Firing.MaleControl)
    if ~isnan(Firing.MaleControl(n).STEPS_25pA_AP(1))
        if length(Firing.MaleControl(n).STEPS_25pA_Frequency) < 16
            ADJUSTED = [nan nan Firing.MaleControl(n).STEPS_25pA_Frequency];
        else
            ADJUSTED = [Firing.MaleControl(n).STEPS_25pA_Frequency];
        end
    else
        ADJUSTED = nan(1,16);
    end
    FREQ = [FREQ ADJUSTED'];
end

FREQ = [steps_16_num steps_16_pA FREQ];

% Creating table
Firing.Tables.MC_FREQ_25pA = array2table(FREQ,'VariableNames',variable_names);


% Creating matrix with average IEI
IEI = [];
for n = 1:length(Firing.MaleControl)
    if ~isnan(Firing.MaleControl(n).STEPS_25pA_AP(1))
        if length(Firing.MaleControl(n).STEPS_25pA_IEI) < 16
            ADJUSTED = [nan nan Firing.MaleControl(n).STEPS_25pA_IEI];
        else
            ADJUSTED = [Firing.MaleControl(n).STEPS_25pA_IEI];
        end
    else
        ADJUSTED = nan(1,16);
    end
    IEI = [IEI ADJUSTED'];
end

IEI = [steps_16_num steps_16_pA IEI];

% Creating table
Firing.Tables.MC_IEI_25pA = array2table(IEI,'VariableNames',variable_names);


% Creating matrix with average Latency to Fire
L2F = [];
for n = 1:length(Firing.MaleControl)
    if ~isnan(Firing.MaleControl(n).STEPS_25pA_AP(1))
        if length(Firing.MaleControl(n).STEPS_25pA_L2F) < 16
            ADJUSTED = [nan nan Firing.MaleControl(n).STEPS_25pA_L2F];
        else
            ADJUSTED = [Firing.MaleControl(n).STEPS_25pA_L2F];
        end
    else
        ADJUSTED = nan(1,16);
    end
    L2F = [L2F ADJUSTED'];
end

L2F = [steps_16_num steps_16_pA L2F];

% Creating table
Firing.Tables.MC_L2F_25pA = array2table(L2F,'VariableNames',variable_names);

clear n nAP FREQ IEI L2F variable_names ADJUSTED variable

%% Creating Tables - Male Fasted

% Creating variable names
variable_names = {};
for n = 1:length(Firing.MaleFasted)
    variable = ['name_' char(Firing.MaleFasted(1).tableRange.Tab_Names(n))];
    variable_names{1,n} = variable;
end
variable_names = ["step_num" "pA" string(variable_names)];

% Number of Action Potentials

% Creating matrix with the number of action potentials
nAP = [];
for n = 1:length(Firing.MaleFasted)
    if ~isnan(Firing.MaleFasted(n).STEPS_25pA_AP(1))
        if length(Firing.MaleFasted(n).STEPS_25pA_AP) < 16
            ADJUSTED = [nan nan Firing.MaleFasted(n).STEPS_25pA_AP];
        else
            ADJUSTED = [Firing.MaleFasted(n).STEPS_25pA_AP];
        end
    else
        ADJUSTED = nan(1,16);
    end
    nAP = [nAP ADJUSTED'];
end

nAP = [steps_16_num steps_16_pA nAP];

% Creating table with the number of action potentials
Firing.Tables.MF_nAP_25pA = array2table(nAP,'VariableNames',variable_names);


% Creating matrix with average Frequency
FREQ = [];
for n = 1:length(Firing.MaleFasted)
    if ~isnan(Firing.MaleFasted(n).STEPS_25pA_AP(1))
        if length(Firing.MaleFasted(n).STEPS_25pA_Frequency) < 16
            ADJUSTED = [nan nan Firing.MaleFasted(n).STEPS_25pA_Frequency];
        else
            ADJUSTED = [Firing.MaleFasted(n).STEPS_25pA_Frequency];
        end
    else
        ADJUSTED = nan(1,16);
    end
    FREQ = [FREQ ADJUSTED'];
end

FREQ = [steps_16_num steps_16_pA FREQ];

% Creating table
Firing.Tables.MF_FREQ_25pA = array2table(FREQ,'VariableNames',variable_names);


% Creating matrix with average IEI
IEI = [];
for n = 1:length(Firing.MaleFasted)
    if ~isnan(Firing.MaleFasted(n).STEPS_25pA_AP(1))
        if length(Firing.MaleFasted(n).STEPS_25pA_IEI) < 16
            ADJUSTED = [nan nan Firing.MaleFasted(n).STEPS_25pA_IEI];
        else
            ADJUSTED = [Firing.MaleFasted(n).STEPS_25pA_IEI];
        end
    else
        ADJUSTED = nan(1,16);
    end
    IEI = [IEI ADJUSTED'];
end

IEI = [steps_16_num steps_16_pA IEI];

% Creating table
Firing.Tables.MF_IEI_25pA = array2table(IEI,'VariableNames',variable_names);


% Creating matrix with average Latency to Fire
L2F = [];
for n = 1:length(Firing.MaleFasted)
    if ~isnan(Firing.MaleFasted(n).STEPS_25pA_AP(1))
        if length(Firing.MaleFasted(n).STEPS_25pA_L2F) < 16
            ADJUSTED = [nan nan Firing.MaleFasted(n).STEPS_25pA_L2F];
        else
            ADJUSTED = [Firing.MaleFasted(n).STEPS_25pA_L2F];
        end
    else
        ADJUSTED = nan(1,16);
    end
    L2F = [L2F ADJUSTED'];
end

L2F = [steps_16_num steps_16_pA L2F];

% Creating table
Firing.Tables.MF_L2F_25pA = array2table(L2F,'VariableNames',variable_names);

clear n nAP FREQ IEI L2F variable_names ADJUSTED variable

%% Creating Tables - Female Control

% Creating variable names
variable_names = {};
for n = 1:length(Firing.FemaleControl)
    variable = ['name_' char(Firing.FemaleControl(1).tableRange.Tab_Names(n))];
    variable_names{1,n} = variable;
end
variable_names = ["step_num" "pA" string(variable_names)];

% Number of Action Potentials

% Creating matrix with the number of action potentials
nAP = [];
for n = 1:length(Firing.FemaleControl)
    if ~isnan(Firing.FemaleControl(n).STEPS_25pA_AP(1))
        if length(Firing.FemaleControl(n).STEPS_25pA_AP) < 16
            ADJUSTED = [nan nan Firing.FemaleControl(n).STEPS_25pA_AP];
        else
            ADJUSTED = [Firing.FemaleControl(n).STEPS_25pA_AP];
        end
    else
        ADJUSTED = nan(1,16);
    end
    nAP = [nAP ADJUSTED'];
end

nAP = [steps_16_num steps_16_pA nAP];

% Creating table with the number of action potentials
Firing.Tables.FC_nAP_25pA = array2table(nAP,'VariableNames',variable_names);


% Creating matrix with average Frequency
FREQ = [];
for n = 1:length(Firing.FemaleControl)
    if ~isnan(Firing.FemaleControl(n).STEPS_25pA_AP(1))
        if length(Firing.FemaleControl(n).STEPS_25pA_Frequency) < 16
            ADJUSTED = [nan nan Firing.FemaleControl(n).STEPS_25pA_Frequency];
        else
            ADJUSTED = [Firing.FemaleControl(n).STEPS_25pA_Frequency];
        end
    else
        ADJUSTED = nan(1,16);
    end
    FREQ = [FREQ ADJUSTED'];
end

FREQ = [steps_16_num steps_16_pA FREQ];

% Creating table
Firing.Tables.FC_FREQ_25pA = array2table(FREQ,'VariableNames',variable_names);


% Creating matrix with average IEI
IEI = [];
for n = 1:length(Firing.FemaleControl)
    if ~isnan(Firing.FemaleControl(n).STEPS_25pA_AP(1))
        if length(Firing.FemaleControl(n).STEPS_25pA_IEI) < 16
            ADJUSTED = [nan nan Firing.FemaleControl(n).STEPS_25pA_IEI];
        else
            ADJUSTED = [Firing.FemaleControl(n).STEPS_25pA_IEI];
        end
    else
        ADJUSTED = nan(1,16);
    end
    IEI = [IEI ADJUSTED'];
end

IEI = [steps_16_num steps_16_pA IEI];

% Creating table
Firing.Tables.FC_IEI_25pA = array2table(IEI,'VariableNames',variable_names);


% Creating matrix with average Latency to Fire
L2F = [];
for n = 1:length(Firing.FemaleControl)
    if ~isnan(Firing.FemaleControl(n).STEPS_25pA_AP(1))
        if length(Firing.FemaleControl(n).STEPS_25pA_L2F) < 16
            ADJUSTED = [nan nan Firing.FemaleControl(n).STEPS_25pA_L2F];
        else
            ADJUSTED = [Firing.FemaleControl(n).STEPS_25pA_L2F];
        end
    else
        ADJUSTED = nan(1,16);
    end
    L2F = [L2F ADJUSTED'];
end

L2F = [steps_16_num steps_16_pA L2F];

% Creating table
Firing.Tables.FC_L2F_25pA = array2table(L2F,'VariableNames',variable_names);

clear n nAP FREQ IEI L2F variable_names ADJUSTED variable

%% Creating Tables - Female Fasted

% Creating variable names
variable_names = {};
for n = 1:length(Firing.FemaleFasted)
    variable = ['name_' char(Firing.FemaleFasted(1).tableRange.Tab_Names(n))];
    variable_names{1,n} = variable;
end
variable_names = ["step_num" "pA" string(variable_names)];

% Number of Action Potentials

% Creating matrix with the number of action potentials
nAP = [];
for n = 1:length(Firing.FemaleFasted)
    if ~isnan(Firing.FemaleFasted(n).STEPS_25pA_AP(1))
        if length(Firing.FemaleFasted(n).STEPS_25pA_AP) < 16
            ADJUSTED = [nan nan Firing.FemaleFasted(n).STEPS_25pA_AP];
        else
            ADJUSTED = [Firing.FemaleFasted(n).STEPS_25pA_AP];
        end
    else
        ADJUSTED = nan(1,16);
    end
    nAP = [nAP ADJUSTED'];
end

nAP = [steps_16_num steps_16_pA nAP];

% Creating table with the number of action potentials
Firing.Tables.FF_nAP_25pA = array2table(nAP,'VariableNames',variable_names);


% Creating matrix with average Frequency
FREQ = [];
for n = 1:length(Firing.FemaleFasted)
    if ~isnan(Firing.FemaleFasted(n).STEPS_25pA_AP(1))
        if length(Firing.FemaleFasted(n).STEPS_25pA_Frequency) < 16
            ADJUSTED = [nan nan Firing.FemaleFasted(n).STEPS_25pA_Frequency];
        else
            ADJUSTED = [Firing.FemaleFasted(n).STEPS_25pA_Frequency];
        end
    else
        ADJUSTED = nan(1,16);
    end
    FREQ = [FREQ ADJUSTED'];
end

FREQ = [steps_16_num steps_16_pA FREQ];

% Creating table
Firing.Tables.FF_FREQ_25pA = array2table(FREQ,'VariableNames',variable_names);


% Creating matrix with average IEI
IEI = [];
for n = 1:length(Firing.FemaleFasted)
    if ~isnan(Firing.FemaleFasted(n).STEPS_25pA_AP(1))
        if length(Firing.FemaleFasted(n).STEPS_25pA_IEI) < 16
            ADJUSTED = [nan nan Firing.FemaleFasted(n).STEPS_25pA_IEI];
        else
            ADJUSTED = [Firing.FemaleFasted(n).STEPS_25pA_IEI];
        end
    else
        ADJUSTED = nan(1,16);
    end
    IEI = [IEI ADJUSTED'];
end

IEI = [steps_16_num steps_16_pA IEI];

% Creating table
Firing.Tables.FF_IEI_25pA = array2table(IEI,'VariableNames',variable_names);


% Creating matrix with average Latency to Fire
L2F = [];
for n = 1:length(Firing.FemaleFasted)
    if ~isnan(Firing.FemaleFasted(n).STEPS_25pA_AP(1))
        if length(Firing.FemaleFasted(n).STEPS_25pA_L2F) < 16
            ADJUSTED = [nan nan Firing.FemaleFasted(n).STEPS_25pA_L2F];
        else
            ADJUSTED = [Firing.FemaleFasted(n).STEPS_25pA_L2F];
        end
    else
        ADJUSTED = nan(1,16);
    end
    L2F = [L2F ADJUSTED'];
end

L2F = [steps_16_num steps_16_pA L2F];

% Creating table
Firing.Tables.FF_L2F_25pA = array2table(L2F,'VariableNames',variable_names);

clear n nAP FREQ IEI L2F variable_names ADJUSTED variable steps_16_num steps_16_pA

%% Getting average peak amplitude for each step

% Male Control
for m = 1 : length(Firing.MaleControl)
    if length(Firing.MaleControl(m).STEPS_25pA_AP) == 14
        Firing.MaleControl(m).STEPS_25pA_mV = nan(1,14);
        if istable(Firing.MaleControl(m).STEPS_25pA)
            for n = 1 : 14  %14 steps
                mV_step = [];
                for o = 1 : length(Firing.MaleControl(m).STEPS_25pA.Trace);
                    if Firing.MaleControl(m).STEPS_25pA.Trace(o) == n
                        mV_step = [mV_step; Firing.MaleControl(m).STEPS_25pA.PeakAmpmV(o)];
                    end
                    Firing.MaleControl(m).STEPS_25pA_mV(n) = mean(mV_step);
                end
            end
        end
    else
        Firing.MaleControl(m).STEPS_25pA_mV = nan(1,16);
        if istable(Firing.MaleControl(m).STEPS_25pA)
            for n = 1 : 16  %16 steps
                mV_step = [];
                for o = 1 : length(Firing.MaleControl(m).STEPS_25pA.Trace);
                    if Firing.MaleControl(m).STEPS_25pA.Trace(o) == n
                        mV_step = [mV_step; Firing.MaleControl(m).STEPS_25pA.PeakAmpmV(o)];
                    end
                    Firing.MaleControl(m).STEPS_25pA_mV(n) = mean(mV_step);
                end
            end
        end
    end
end
        

% Male Fasted
for m = 1 : length(Firing.MaleFasted)
    if length(Firing.MaleFasted(m).STEPS_25pA_AP) == 14
        Firing.MaleFasted(m).STEPS_25pA_mV = nan(1,14);
        if istable(Firing.MaleFasted(m).STEPS_25pA)
            for n = 1 : 14  %14 steps
                mV_step = [];
                for o = 1 : length(Firing.MaleFasted(m).STEPS_25pA.Trace);
                    if Firing.MaleFasted(m).STEPS_25pA.Trace(o) == n
                        mV_step = [mV_step; Firing.MaleFasted(m).STEPS_25pA.PeakAmpmV(o)];
                    end
                    Firing.MaleFasted(m).STEPS_25pA_mV(n) = mean(mV_step);
                end
            end
        end
    else
        Firing.MaleFasted(m).STEPS_25pA_mV = nan(1,16);
        if istable(Firing.MaleFasted(m).STEPS_25pA)
            for n = 1 : 16  %16 steps
                mV_step = [];
                for o = 1 : length(Firing.MaleFasted(m).STEPS_25pA.Trace);
                    if Firing.MaleFasted(m).STEPS_25pA.Trace(o) == n
                        mV_step = [mV_step; Firing.MaleFasted(m).STEPS_25pA.PeakAmpmV(o)];
                    end
                    Firing.MaleFasted(m).STEPS_25pA_mV(n) = mean(mV_step);
                end
            end
        end
    end
end


% Female Control
for m = 1 : length(Firing.FemaleControl)
    if length(Firing.FemaleControl(m).STEPS_25pA_AP) == 14
        Firing.FemaleControl(m).STEPS_25pA_mV = nan(1,14);
        if istable(Firing.FemaleControl(m).STEPS_25pA)
            for n = 1 : 14  %14 steps
                mV_step = [];
                for o = 1 : length(Firing.FemaleControl(m).STEPS_25pA.Trace);
                    if Firing.FemaleControl(m).STEPS_25pA.Trace(o) == n
                        mV_step = [mV_step; Firing.FemaleControl(m).STEPS_25pA.PeakAmpmV(o)];
                    end
                    Firing.FemaleControl(m).STEPS_25pA_mV(n) = mean(mV_step);
                end
            end
        end
    else
        Firing.FemaleControl(m).STEPS_25pA_mV = nan(1,16);
        if istable(Firing.FemaleControl(m).STEPS_25pA)
            for n = 1 : 16  %16 steps
                mV_step = [];
                for o = 1 : length(Firing.FemaleControl(m).STEPS_25pA.Trace);
                    if Firing.FemaleControl(m).STEPS_25pA.Trace(o) == n
                        mV_step = [mV_step; Firing.FemaleControl(m).STEPS_25pA.PeakAmpmV(o)];
                    end
                    Firing.FemaleControl(m).STEPS_25pA_mV(n) = mean(mV_step);
                end
            end
        end
    end
end
        

% Female Fasted
for m = 1 : length(Firing.FemaleFasted)
    if length(Firing.FemaleFasted(m).STEPS_25pA_AP) == 14
        Firing.FemaleFasted(m).STEPS_25pA_mV = nan(1,14);
        if istable(Firing.FemaleFasted(m).STEPS_25pA)
            for n = 1 : 14  %14 steps
                mV_step = [];
                for o = 1 : length(Firing.FemaleFasted(m).STEPS_25pA.Trace);
                    if Firing.FemaleFasted(m).STEPS_25pA.Trace(o) == n
                        mV_step = [mV_step; Firing.FemaleFasted(m).STEPS_25pA.PeakAmpmV(o)];
                    end
                    Firing.FemaleFasted(m).STEPS_25pA_mV(n) = mean(mV_step);
                end
            end
        end
    else
        Firing.FemaleFasted(m).STEPS_25pA_mV = nan(1,16);
        if istable(Firing.FemaleFasted(m).STEPS_25pA)
            for n = 1 : 16  %16 steps
                mV_step = [];
                for o = 1 : length(Firing.FemaleFasted(m).STEPS_25pA.Trace);
                    if Firing.FemaleFasted(m).STEPS_25pA.Trace(o) == n
                        mV_step = [mV_step; Firing.FemaleFasted(m).STEPS_25pA.PeakAmpmV(o)];
                    end
                    Firing.FemaleFasted(m).STEPS_25pA_mV(n) = mean(mV_step);
                end
            end
        end
    end
end

clear mV_step m n o

%% Putting the average peak amplitude into a table

% Male Control
MC_mV = {};
for n = 1:length(Firing.MaleControl)
    MC_mV(n,1) = {'Male Control'};
    MC_mV(n,2) = {Firing.MaleControl(1).tableRange.Tab_Names(n)};
    if length(Firing.MaleControl(n).STEPS_25pA_mV) == 14
        MC_mV(n,3) = {14};
        MC_mV(n,4) = {nan};
        MC_mV(n,5) = {nan};
        for m = 1:14
            MC_mV(n, m+5) = {Firing.MaleControl(n).STEPS_25pA_mV(m)};
        end
    else
        MC_mV(n,3) = {16};
        for m = 1:16
            MC_mV(n, m+3) = {Firing.MaleControl(n).STEPS_25pA_mV(m)};
        end
    end
end


% Male Fasted
MF_mV = {};
for n = 1:length(Firing.MaleFasted)
    MF_mV(n,1) = {'Male Fasted'};
    MF_mV(n,2) = {Firing.MaleFasted(1).tableRange.Tab_Names(n)};
    if length(Firing.MaleFasted(n).STEPS_25pA_mV) == 14
        MF_mV(n,3) = {14};
        MF_mV(n,4) = {nan};
        MF_mV(n,5) = {nan};
        for m = 1:14
            MF_mV(n, m+5) = {Firing.MaleFasted(n).STEPS_25pA_mV(m)};
        end
    else
        MF_mV(n,3) = {16};
        for m = 1:16
            MF_mV(n, m+3) = {Firing.MaleFasted(n).STEPS_25pA_mV(m)};
        end
    end
end


% Female Control
FC_mV = {};
for n = 1:length(Firing.FemaleControl)
    FC_mV(n,1) = {'Female Control'};
    FC_mV(n,2) = {Firing.FemaleControl(1).tableRange.Tab_Names(n)};
    if length(Firing.FemaleControl(n).STEPS_25pA_mV) == 14
        FC_mV(n,3) = {14};
        FC_mV(n,4) = {nan};
        FC_mV(n,5) = {nan};
        for m = 1:14
            FC_mV(n, m+5) = {Firing.FemaleControl(n).STEPS_25pA_mV(m)};
        end
    else
        FC_mV(n,3) = {16};
        for m = 1:16
            FC_mV(n, m+3) = {Firing.FemaleControl(n).STEPS_25pA_mV(m)};
        end
    end
end


% Female Fasted
FF_mV = {};
for n = 1:length(Firing.FemaleFasted)
    FF_mV(n,1) = {'Female Fasted'};
    FF_mV(n,2) = {Firing.FemaleFasted(1).tableRange.Tab_Names(n)};
    if length(Firing.FemaleFasted(n).STEPS_25pA_mV) == 14
        FF_mV(n,3) = {14};
        FF_mV(n,4) = {nan};
        FF_mV(n,5) = {nan};
        for m = 1:14
            FF_mV(n, m+5) = {Firing.FemaleFasted(n).STEPS_25pA_mV(m)};
        end
    else
        FF_mV(n,3) = {16};
        for m = 1:16
            FF_mV(n, m+3) = {Firing.FemaleFasted(n).STEPS_25pA_mV(m)};
        end
    end
end

clear n m

blank = {'' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' ''};

ARRAY = [MC_mV; blank; MF_mV; blank; FC_mV; blank; FF_mV];

Firing.Tables.peakmV_25pA = array2table(ARRAY, 'VariableNames',{'Group', 'Cell', 'step_#', 'step_-75', 'step_-50', 'step_-25', 'step_0', 'step_25', 'step_50', 'step_75', 'step_100', 'step_125', 'step_150', 'step_175', 'step_200', 'step_225', 'step_250', 'step_275', 'step_300'});

clear ARRAY blank MC_mV MF_mV FC_mV FF_mV

%% Writing Table

save Firing_LH2VTA

writetable(Firing.Tables.MC_nAP_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','MC_nAP','Range','A1');
writetable(Firing.Tables.MC_FREQ_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','MC_Freq','Range','A1');
writetable(Firing.Tables.MC_IEI_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','MC_IEI','Range','A1');
writetable(Firing.Tables.MC_L2F_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','MC_L2F','Range','A1');

writetable(Firing.Tables.MF_nAP_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','MF_nAP','Range','A1');
writetable(Firing.Tables.MF_FREQ_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','MF_Freq','Range','A1');
writetable(Firing.Tables.MF_IEI_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','MF_IEI','Range','A1');
writetable(Firing.Tables.MF_L2F_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','MF_L2F','Range','A1');

writetable(Firing.Tables.FC_nAP_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','FC_nAP','Range','A1');
writetable(Firing.Tables.FC_FREQ_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','FC_Freq','Range','A1');
writetable(Firing.Tables.FC_IEI_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','FC_IEI','Range','A1');
writetable(Firing.Tables.FC_L2F_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','FC_L2F','Range','A1');

writetable(Firing.Tables.FF_nAP_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','FF_nAP','Range','A1');
writetable(Firing.Tables.FF_FREQ_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','FF_Freq','Range','A1');
writetable(Firing.Tables.FF_IEI_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','FF_IEI','Range','A1');
writetable(Firing.Tables.FF_L2F_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','FF_L2F','Range','A1');

writetable(Firing.Tables.peakmV_25pA,'Firing_LH2VTA_25pASTEPS.xlsx','Sheet','peakmV_25pA','Range','A1');
