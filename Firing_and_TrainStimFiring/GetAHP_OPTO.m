function Group = GetAHP_OPTO(directory, filename)
% This function will take an abf file of a firing (with 6 sweeps) and
% return the peak amplitude (mV), peak location, antipeak amplitude
% (mV), antipeak location, event start (3 ms before the peak), and after-hyperpolarization
% (mV).

%For debugging:
%directory = '/Users/nathansmac/Desktop/Firing/2020/FemaleFasted/preOPTO/';
%filename = '201217_0007.abf'

cd(directory)
Group.filename = filename;
trace = abfload(Group.filename);

StartStep = 131.2;  % Start of Step: 131.2 ms
EndStep = StartStep + 1000;  % End of Step: 1131.2ms
sampling_frequency = 20000; % data sampled at 20 kHz

for n = 1 : 6
    Group.recording(n).sweep = n;
end

for n = 1 : length(Group.recording)
    Group.recording(n).mV = trace(:,1,Group.recording(n).sweep);
end
clear n s

sweep_length_data = length(Group.recording(1).mV);
sweep_length_s = length(Group.recording(1).mV) / sampling_frequency;  % gives me my answer in seconds
Group.t_vec_s = linspace(0,sweep_length_s,sweep_length_data);

for n = 1 : length(Group.recording)
    Group.recording(n).adjusted = Group.recording(n).mV + 70;
end
clear n

for n = 1 : length(Group.recording)
    if any(Group.recording(n).adjusted(:) >= 50)
        [Group.peaks(n).mV,Group.peaks(n).location.data] = findpeaks2(Group.recording(n).adjusted,'MinPeakHeight',50,'MinPeakDistance',[(1/1000) * sampling_frequency]);    %threshold is normally 50
        
        % Peaks
        Group.peaks(n).location.seconds = Group.peaks(n).location.data / sampling_frequency;
        Group.peaks(n).location.relativeseconds = Group.peaks(n).location.seconds - ((StartStep)/1000);
        Group.peaks(n).location.relativems = Group.peaks(n).location.relativeseconds .* 1000;
        
        % AntiPeaks (detect minimum value 15 ms following the peak)
        for m = 2 : length(Group.peaks(n).location.data)
            if Group.peaks(n).location.data(m) - Group.peaks(n).location.data(m-1) <= (0.015 * sampling_frequency)
                [M, I] = min(Group.recording(n).adjusted([Group.peaks(n).location.data(m-1)]:[Group.peaks(n).location.data(m)]));
            else
                [M, I] = min(Group.recording(n).adjusted([Group.peaks(n).location.data(m-1)]:[Group.peaks(n).location.data(m-1) + (0.015 * sampling_frequency)]));
            end
            Group.antipeaks(n).mV(m-1) = M;
            Group.antipeaks(n).location.data(m-1) = I + Group.peaks(n).location.data(m-1);
        end
        [M, I] = min(Group.recording(n).adjusted([Group.peaks(n).location.data(end)]:[Group.peaks(n).location.data(end) + (0.015 * sampling_frequency)]));
        Group.antipeaks(n).mV(length(Group.peaks(n).location.data)) = M;
        Group.antipeaks(n).location.data(length(Group.peaks(n).location.data)) = I' + Group.peaks(n).location.data(end);
        Group.antipeaks(n).mV = Group.antipeaks(n).mV';
        Group.antipeaks(n).location.data = Group.antipeaks(n).location.data';
        clear m M I
        
        Group.antipeaks(n).location.seconds = Group.antipeaks(n).location.data / sampling_frequency;
        Group.antipeaks(n).location.relativeseconds = Group.antipeaks(n).location.seconds - ((StartStep)/1000);
        Group.antipeaks(n).location.relativems = Group.antipeaks(n).location.relativeseconds .* 1000;
        if Group.antipeaks(n).location.relativems(end) >= 1000
            Group.antipeaks(n).mV(end) = nan;
            Group.antipeaks(n).location.data(end) = nan;
            Group.antipeaks(n).location.seconds(end) = nan;
            Group.antipeaks(n).location.relativeseconds(end) = nan;
            Group.antipeaks(n).location.relativems(end) = nan;
        end
            
        % Event Start
        Group.eventstart(n).location.data = Group.peaks(n).location.data - ((3/1000) * sampling_frequency); % Not sure if this should be 2 or 3. Will require some testing
        Group.eventstart(n).location.seconds = Group.eventstart(n).location.data / sampling_frequency;
        Group.eventstart(n).location.relativeseconds = Group.eventstart(n).location.seconds - ((StartStep)/1000);
        Group.eventstart(n).location.relativems = Group.eventstart(n).location.relativeseconds .* 1000;
        Group.eventstart(n).mV = Group.recording(n).adjusted(Group.eventstart(n).location.data);
        
        Group.AHP(n).mV = Group.eventstart(n).mV(1:length(Group.antipeaks(n).mV)) - Group.antipeaks(n).mV;
        
    else
        Group.peaks(n).mV = nan;
        Group.peaks(n).location.data = nan;
        Group.peaks(n).location.seconds = nan;
        Group.peaks(n).location.relativeseconds = nan;
        Group.peaks(n).location.relativems = nan;
        Group.antipeaks(n).mV = nan;
        Group.antipeaks(n).location.data = nan;
        Group.antipeaks(n).location.seconds = nan;
        Group.antipeaks(n).location.relativeseconds = nan;
        Group.antipeaks(n).location.relativems = nan;
        Group.eventstart(n).location.data = nan;
        Group.eventstart(n).location.seconds = nan;
        Group.eventstart(n).location.relativeseconds = nan;
        Group.eventstart(n).location.relativems = nan;
        Group.eventstart(n).mV = nan;
        Group.AHP(n).mV = nan;
    end
%{
    figure; hold on;
    plot(Group.t_vec_s, Group.recording(n).adjusted)
    plot([Group.peaks(n).location.seconds], [Group.peaks(n).mV], 'r*')
    plot([Group.antipeaks(n).location.seconds], [Group.antipeaks(n).mV], 'g*')
    plot([Group.eventstart(n).location.seconds], [Group.eventstart(n).mV], 'b*')
    title(char([Group.filename ' - sweep # ' string(n)]))
    xlabel('time (s)')
    ylabel('membrane potential (mV)')
%}
end
clear n
end