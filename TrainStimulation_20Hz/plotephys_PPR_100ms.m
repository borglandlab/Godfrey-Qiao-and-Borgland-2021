function [Group] = plotephys_PPR_100ms(groupName)

% Script for loading an 'abf' electrophysiology file of my train recordings and then plotting it
% with the X-axis in seconds. This script will also allow me to create an
% averaged trace.
display([newline 'select 100ms data for ' groupName]);

pathname = uigetdir; % Creates a variable with the path where this folder is.
addpath(pathname); % Adds the path so that MatLab can reach into that folder
filename = dir(pathname); % Creates a variable with the directory for the folder that I select. Should be the folder where my file is.
Group.group = groupName;

for n = 1:length(filename)
    if contains(filename(n).name,'abf') % I have to do this so that I'm not picking up .DS_Store files or anything other than .abf files
        if isfield(Group,'name') % Determine if the name field already exists
            o = length({Group.name}) + 1;  % If not first name entry (name field already exists)
        else
            o = 1;  % If first name entry (name field doesn't already exist)
        end
        
        % For debugging purposes:
        %display(['name field exists: ' char(string((isfield(Group,'name')))) ', while n = ' char(string(n)) ' and o = ' char(string(o))]);
        
        Group(o).name = filename(n).name; % Creates a variable 'name' corresponding with 'n'
        %Group.name = filename(3).name
        
        addpath('/Users/nathansmac/Documents/MATLAB/MATLAB/abfload'); % adds the path to get abload
        %[d,si,h] = abfload(Group.name);
        [d,~,~] = abfload(Group(o).name);
        %d will actually have 3 components: N1xN2xN3
        %N1 = all of my data points over time
        %N2 = my channels (I have two channels on here; one was for my test pulse)
        %the first channel is where my data is
        %N3 = all the different sweeps that I have
        
        sweepLength = 4;    % each sweep is 4 seconds long
        samplingFrequency = 20000; % 20000 Hz sampling rate
        pointsSampled = sweepLength * samplingFrequency;    % gives me the number of data points collected in entire sweep
        ISI = 0.100;     % interstimulus interval is 25 ms
        
        t_vec = linspace(0,size(d,1)/(samplingFrequency),size(d,1));
        %%
        % This shifts all my traces to start at 0 so that I can average them
        
        optoStim1 = 1.062425; % opto stim occurs at 1.062425 seconds
        
        % My baseline is 200 ms and ends 50 ms before the first opto stim
        
        B2 = optoStim1 - 0.050;
        B1 = (B2 - 0.200) * samplingFrequency;
        B2 = B2 * samplingFrequency;
        
        s = size(d);
        l = s(3);
        for m = 1:l;
            Baseline = d(B1:B2,1,m);
            Distance_Zero = mean(Baseline);
            Cell1(m).trace = d(:,1,m) - Distance_Zero;
        end
        
        basetrace_array = [];
        for m = 1:6;    % 1 through 6 because there are 6 sweeps in each acquisition to average
            basetrace_vector = Cell1(m).trace;
            basetrace_array = [basetrace_array basetrace_vector];   % Creating an array of all 6 sweeps
        end
        
        Cell1(1).basetrace = [];
        for ii = 1:length(basetrace_array);
            mean_base = mean(basetrace_array(ii,:));
            Cell1(1).basetrace = [Cell1(1).basetrace; mean_base];   % Averaging all 6 sweeps in array
        end
        
        % This is the interval where I find my first stimulation (however for 30Hz
        % and higher this is lacking precision)
        
        % Will have to change this for different frequencies
        interval = ISI + 0.003; % 25 ms interval plus 3 ms pulse length
        
        optoStim2 = optoStim1 + interval; % adding time of interval to get second optostim
        optoStim = [optoStim1 optoStim2];
        
        beforeStim1 = optoStim1 + 0.0012; % Add 1.2 ms for when I should start looking for the evoked current
        afterStim1 = beforeStim1 + 0.0120; % Add 12 ms for when the peak should have ended
        
        beforeStim2 = beforeStim1 + interval;
        afterStim2 = afterStim1 + interval;
        
        beforeStim = [beforeStim1; beforeStim2];
        afterStim = [afterStim1; afterStim2];
        
        beforeStim_time = beforeStim .* samplingFrequency;
        afterStim_time = afterStim .* samplingFrequency;
        %%
        [Peaks,PeakTimes] = findpeaks2(-Cell1(1).basetrace);     % Gives me any inflection that could be considered a peak
        
        PeakTime_Index = [];
        for m = 1:length(beforeStim)    % Do this to create an index, but will still need to make it logical before using it
            Index = (beforeStim_time(m) < PeakTimes) & (afterStim_time(m) > PeakTimes);
            PeakTime_Index = [PeakTime_Index Index];
        end
        PeakTime_Index = PeakTime_Index == 1;   % Do this to create a logical array for indexing
        
        peakVector = [];
        peaktimeVector = [];
        for m = 1:2     % This number has to be the frequency
            Peaks_vector = Peaks(PeakTime_Index(:,m));
            l = length(Peaks_vector);
            remainingZeros = zeros((500-l),1);  % Have to add these zeros so that my vectors are all the same length
            Peaks_vector = [Peaks_vector; remainingZeros];
            peakVector = [peakVector Peaks_vector]; % Creates a vector where each column is a different peak
            
            PeakTimes_vector = PeakTimes(PeakTime_Index(:,m));
            l = length(PeakTimes_vector);
            remainingZeros = zeros((500-l),1);
            PeakTimes_vector = [PeakTimes_vector; remainingZeros];
            peaktimeVector = [peaktimeVector PeakTimes_vector];
        end
        
        realPeaks = [];
        
        for m = 1:2
            realPeak = min(-peakVector(:,m));
            realPeaks = [realPeaks realPeak];
        end
        
        realPeaksIndex = -peakVector == realPeaks;
        realPeakTimes = (peaktimeVector(realPeaksIndex)')/samplingFrequency;
        
        % The purpose of this is to remove points where the peak may have spanned
        % more than one time point
        TimePeak_Vector = [realPeakTimes(1,1)];
        for m = 2:length(realPeakTimes)
            if realPeakTimes(1,m) - realPeakTimes(1,m-1) > 0.02
                TimePeak = realPeakTimes(1,m);
            else TimePeak = [];
            end
            TimePeak_Vector = [TimePeak_Vector TimePeak];
        end
        realPeakTimes = TimePeak_Vector;
        
        Group(o).trace = Cell1(1).basetrace;
        Group(o).X = t_vec;
        Group(o).optostimTime = optoStim;
        Group(o).peakAmplitude = realPeaks;
        Group(o).peakTime = realPeakTimes;
        Group(o).PPR = realPeaks(2)/realPeaks(1);
        
        %{
figure; hold on;
plot(Group(o).X, Group(o).trace);
plot(Group(o).peakTime, Group(o).peakAmplitude, 'g*');
plot(Group(o).optostimTime, [0 0], 'rv');
ylabel('Amplitude (pA)'); xlabel('time (s)');
title(['PPR 100ms interval' {Group.group} {Group(o).name}]);
hold off;
        %}
    end
end
end
