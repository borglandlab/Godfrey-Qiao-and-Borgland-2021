function [Group] = plotephys_20Hz(group);

% Script for loading an 'abf' electrophysiology file of my train recordings and then plotting it
% with the X-axis in seconds. This script will also allow me to create an
% averaged trace.
display([newline 'select 20Hz data for ' group]);

pathname = uigetdir; % Creates a variable with the path where this folder is.
addpath(pathname); % Adds the path so that MatLab can reach into that folder
filename = dir(pathname); % Creates a variable with the directory for the folder that I select. Should be the folder where my file is.
Group.group = group;

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
        
        sweepLength = 5;    % each sweep is 5 seconds long
        samplingFrequency = 20000; % 20000 Hz sampling rate
        pointsSampled = sweepLength * samplingFrequency;    % gives me the number of data points collected in entire sweep
        
        t_vec = linspace(0,size(d,1)/(samplingFrequency),size(d,1));
        %%
        optoStim1 = 1.07825; % first opto stim occurs at 1.07825
        
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
        for m = 1:6;
            basetrace_vector = Cell1(m).trace;
            basetrace_array = [basetrace_array basetrace_vector];
        end
        
        Cell1(1).basetrace = [];
        for ii = 1:length(basetrace_array);
            mean_base = mean(basetrace_array(ii,:));
            Cell1(1).basetrace = [Cell1(1).basetrace; mean_base];
        end
        
        % This is the interval where I find my first stimulation (however for 30Hz
        % and higher this is lacking precision)
        beforeStim1 = optoStim1 + 0.0012; % Add 1.2 ms for when I should start looking for the evoked current
        afterStim1 = beforeStim1 + 0.0120; % Add 12 ms for when the peak should have ended
        
        % Will have to change this for different frequencies
        interval = (1/20);
        l = length(beforeStim1);
        beforeStim = [beforeStim1];
        afterStim = [afterStim1];
        optoStim = [optoStim1];
        while l < 20
            beforeStim = [beforeStim; (beforeStim(end) + interval)];
            afterStim = [afterStim; (afterStim(end) + interval)];
            optoStim = [optoStim; (optoStim(end) + interval)];
            l = length(beforeStim);
        end
        
        beforeStim_time = beforeStim .* samplingFrequency;
        afterStim_time = afterStim .* samplingFrequency;
        optoStim_time = optoStim;
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
        for m = 1:length(beforeStim)
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
        
        for m = 1:length(beforeStim)
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
        Group(o).peakAmplitude = realPeaks;
        Group(o).peakTime = realPeakTimes;
        Group(o).optostimTime = optoStim_time;
        
        %{
figure; hold on;
plot(Group(o).X, Group(o).trace);
plot(Group(o).peakTime, Group(o).peakAmplitude, 'g*');
plot(Group(o).optostimTime, [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0], 'rv');
ylabel('Amplitude (pA)'); xlabel('time (s)');
title(['5Hz' {Group.group} {Group(o).name}]);
hold off;
        %}
    end
end
end
