%{
This script was used to calculate the reverse potential from recordings of
optically induced currents at -70 mV, -60 mV, and -40 mV. I didn't find
anything different, and this data did not become part of the publication.
It's also debatable how accurate these results are, seeing as the voltage
holding points that I used were very close together.
%}

%% Add paths
addpath /Users/nathansmac/Documents/MATLAB/MATLAB/
addpath /Users/nathansmac/Documents/MATLAB/MATLAB/Trains_InputStrength/Firing/

%% directory to MATLAB Folder
cd /Users/nathansmac/Documents/MATLAB/MATLAB/Trains_InputStrength/Firing/

%% Load the structre where my data is found (Unless this is the first time)
cd /Users/nathansmac/Desktop/VTA_INPUTS/GABA_Firing/6Jan2021/

load('Firing_LH2VTA.mat')

%% Opto Test Peak
% Getting the current amplitudes that I recorded at -70 mV, -60 mV, and -40
% mV in order to see an I-V curve and calculate a reversal potential. I
% have to do this for the first and second peaks, because this is a
% paired-pulse with a 20 ms interval.

% Male Control

for m = 1:length(Firing.MaleControl)
    Firing.MaleControl(m).pulse1_70mV = Firing.MaleControl(m).OPTOtest.P1Peak(1);   % P1Peak is the first peak
    Firing.MaleControl(m).pulse1_60mV = Firing.MaleControl(m).OPTOtest.P1Peak(2);
    Firing.MaleControl(m).pulse1_40mV = Firing.MaleControl(m).OPTOtest.P1Peak(3);
    
    Firing.MaleControl(m).pulse2_70mV = Firing.MaleControl(m).OPTOtest.P2Peak(1);   % P1Peak is the second peak
    Firing.MaleControl(m).pulse2_60mV = Firing.MaleControl(m).OPTOtest.P2Peak(2);
    Firing.MaleControl(m).pulse2_40mV = Firing.MaleControl(m).OPTOtest.P2Peak(3);
end


% Male Fasted

for m = 1:length(Firing.MaleFasted)
    Firing.MaleFasted(m).pulse1_70mV = Firing.MaleFasted(m).OPTOtest.P1Peak(1);
    Firing.MaleFasted(m).pulse1_60mV = Firing.MaleFasted(m).OPTOtest.P1Peak(2);
    Firing.MaleFasted(m).pulse1_40mV = Firing.MaleFasted(m).OPTOtest.P1Peak(3);
    
    Firing.MaleFasted(m).pulse2_70mV = Firing.MaleFasted(m).OPTOtest.P2Peak(1);
    Firing.MaleFasted(m).pulse2_60mV = Firing.MaleFasted(m).OPTOtest.P2Peak(2);
    Firing.MaleFasted(m).pulse2_40mV = Firing.MaleFasted(m).OPTOtest.P2Peak(3);
end


% Female Control

for m = 1:length(Firing.FemaleControl)
    Firing.FemaleControl(m).pulse1_70mV = Firing.FemaleControl(m).OPTOtest.P1Peak(1);
    Firing.FemaleControl(m).pulse1_60mV = Firing.FemaleControl(m).OPTOtest.P1Peak(2);
    Firing.FemaleControl(m).pulse1_40mV = Firing.FemaleControl(m).OPTOtest.P1Peak(3);
    
    Firing.FemaleControl(m).pulse2_70mV = Firing.FemaleControl(m).OPTOtest.P2Peak(1);
    Firing.FemaleControl(m).pulse2_60mV = Firing.FemaleControl(m).OPTOtest.P2Peak(2);
    Firing.FemaleControl(m).pulse2_40mV = Firing.FemaleControl(m).OPTOtest.P2Peak(3);
end


% Female Fasted

for m = 1:length(Firing.FemaleFasted)
    Firing.FemaleFasted(m).pulse1_70mV = Firing.FemaleFasted(m).OPTOtest.P1Peak(1);
    Firing.FemaleFasted(m).pulse1_60mV = Firing.FemaleFasted(m).OPTOtest.P1Peak(2);
    Firing.FemaleFasted(m).pulse1_40mV = Firing.FemaleFasted(m).OPTOtest.P1Peak(3);
    
    Firing.FemaleFasted(m).pulse2_70mV = Firing.FemaleFasted(m).OPTOtest.P2Peak(1);
    Firing.FemaleFasted(m).pulse2_60mV = Firing.FemaleFasted(m).OPTOtest.P2Peak(2);
    Firing.FemaleFasted(m).pulse2_40mV = Firing.FemaleFasted(m).OPTOtest.P2Peak(3);
end

clear m

%% Finding the reversal potentials of all my cells

% Male Control

x_values = [-70 -60 -40];   % These are my membrane potentials or x-values

for n = 1:length(Firing.MaleControl)
    y_values_P1 = [Firing.MaleControl(n).pulse1_70mV Firing.MaleControl(n).pulse1_60mV Firing.MaleControl(n).pulse1_40mV];
    y_values_P2 = [Firing.MaleControl(n).pulse2_70mV Firing.MaleControl(n).pulse2_60mV Firing.MaleControl(n).pulse2_40mV];
    p_P1 = polyfit(x_values,y_values_P1,1);    % this polynomial is to the order of 1 (linear line that is not horizantal or vertical - requires an equation)
    p_P2 = polyfit(x_values,y_values_P2,1);

    % By rearranging the equation of a linear line I can determine the
    % x-intercept or point when y is equal to 0.
    % y = mx + c
    % x = (y - c)/m
    Firing.MaleControl(n).pulse1_RP = (0 - p_P1(2))/p_P1(1);
    Firing.MaleControl(n).pulse2_RP = (0 - p_P2(2))/p_P2(1);
end


% Male Fasted

x_values = [-70 -60 -40];   % These are my membrane potentials or x-values

for n = 1:length(Firing.MaleFasted)
    y_values_P1 = [Firing.MaleFasted(n).pulse1_70mV Firing.MaleFasted(n).pulse1_60mV Firing.MaleFasted(n).pulse1_40mV];
    y_values_P2 = [Firing.MaleFasted(n).pulse2_70mV Firing.MaleFasted(n).pulse2_60mV Firing.MaleFasted(n).pulse2_40mV];
    p_P1 = polyfit(x_values,y_values_P1,1);    % this polynomial is to the order of 1 (linear line that is not horizantal or vertical - requires an equation)
    p_P2 = polyfit(x_values,y_values_P2,1);

    % By rearranging the equation of a linear line I can determine the
    % x-intercept or point when y is equal to 0.
    % y = mx + c
    % x = (y - c)/m
    Firing.MaleFasted(n).pulse1_RP = (0 - p_P1(2))/p_P1(1);
    Firing.MaleFasted(n).pulse2_RP = (0 - p_P2(2))/p_P2(1);
end


% Female Control

x_values = [-70 -60 -40];   % These are my membrane potentials or x-values

for n = 1:length(Firing.FemaleControl)
    y_values_P1 = [Firing.FemaleControl(n).pulse1_70mV Firing.FemaleControl(n).pulse1_60mV Firing.FemaleControl(n).pulse1_40mV];
    y_values_P2 = [Firing.FemaleControl(n).pulse2_70mV Firing.FemaleControl(n).pulse2_60mV Firing.FemaleControl(n).pulse2_40mV];
    p_P1 = polyfit(x_values,y_values_P1,1);    % this polynomial is to the order of 1 (linear line that is not horizantal or vertical - requires an equation)
    p_P2 = polyfit(x_values,y_values_P2,1);

    % By rearranging the equation of a linear line I can determine the
    % x-intercept or point when y is equal to 0.
    % y = mx + c
    % x = (y - c)/m
    Firing.FemaleControl(n).pulse1_RP = (0 - p_P1(2))/p_P1(1);
    Firing.FemaleControl(n).pulse2_RP = (0 - p_P2(2))/p_P2(1);
end

% Female Fasted

x_values = [-70 -60 -40];   % These are my membrane potentials or x-values

for n = 1:length(Firing.FemaleFasted)
    y_values_P1 = [Firing.FemaleFasted(n).pulse1_70mV Firing.FemaleFasted(n).pulse1_60mV Firing.FemaleFasted(n).pulse1_40mV];
    y_values_P2 = [Firing.FemaleFasted(n).pulse2_70mV Firing.FemaleFasted(n).pulse2_60mV Firing.FemaleFasted(n).pulse2_40mV];
    p_P1 = polyfit(x_values,y_values_P1,1);    % this polynomial is to the order of 1 (linear line that is not horizantal or vertical - requires an equation)
    p_P2 = polyfit(x_values,y_values_P2,1);

    % By rearranging the equation of a linear line I can determine the
    % x-intercept or point when y is equal to 0.
    % y = mx + c
    % x = (y - c)/m
    Firing.FemaleFasted(n).pulse1_RP = (0 - p_P1(2))/p_P1(1);
    Firing.FemaleFasted(n).pulse2_RP = (0 - p_P2(2))/p_P2(1);
end

%{
This is another way to do this. I can actually use the interp1 function to
extrapolate values. An extrapolation is required when the value I am
looking for extends beyond the domain of x. The values that I will get from
doing it this way are slightly different. I think it's better to do it the
other way though, by finding the best fit line and then calcuting the
x-intercept using the line equation.
n = 1;
y_known = 0;
y_values_P1 = [Firing.FemaleFasted(n).pulse1_70mV Firing.FemaleFasted(n).pulse1_60mV Firing.FemaleFasted(n).pulse1_40mV];
x_values = [-70 -60 -40];
x_unknown = interp1(y_values_P1,x_values,y_known,'linear','extrap');
% Important to note that I have to use the 'extrap' input here because a
linear interpolation will not automatically extrapolate. From what I've
read, the linear interpolation is the best option to use for a situation
like this.
%}

clear n x_values y_values_P1 y_values_P2 p_P1 p_P2

%% Table containing the Peak Amplitude of the first and second pulse of the paired-pulse stimulation at -70 mV, -60 mV, and -40 mV
% This table also contains the calculated reversal potential for the both
% the first and second pulses.

% Creating this table with the current amplitudes because then I can
% just export it out as an excel file.

% Male Control
MC_pulse = {};
for n = 1:length(Firing.MaleControl)
    MC_pulse(n,1) = {'Male Control'};
    MC_pulse(n,2) = {Firing.MaleControl(1).tableRange.Tab_Names(n)};
    MC_pulse(n,3) = {Firing.MaleControl(n).pulse1_70mV};
    MC_pulse(n,4) = {Firing.MaleControl(n).pulse1_60mV};
    MC_pulse(n,5) = {Firing.MaleControl(n).pulse1_40mV};
    MC_pulse(n,6) = {Firing.MaleControl(n).pulse1_RP};
    MC_pulse(n,7) = {Firing.MaleControl(n).pulse2_70mV};
    MC_pulse(n,8) = {Firing.MaleControl(n).pulse2_60mV};
    MC_pulse(n,9) = {Firing.MaleControl(n).pulse2_40mV};
    MC_pulse(n,10) = {Firing.MaleControl(n).pulse2_RP};
end    

% Male Fasted
MF_pulse = {};
for n = 1:length(Firing.MaleFasted)
    MF_pulse(n,1) = {'Male Fasted'};
    MF_pulse(n,2) = {Firing.MaleFasted(1).tableRange.Tab_Names(n)};
    MF_pulse(n,3) = {Firing.MaleFasted(n).pulse1_70mV};
    MF_pulse(n,4) = {Firing.MaleFasted(n).pulse1_60mV};
    MF_pulse(n,5) = {Firing.MaleFasted(n).pulse1_40mV};
    MF_pulse(n,6) = {Firing.MaleFasted(n).pulse1_RP};
    MF_pulse(n,7) = {Firing.MaleFasted(n).pulse2_70mV};
    MF_pulse(n,8) = {Firing.MaleFasted(n).pulse2_60mV};
    MF_pulse(n,9) = {Firing.MaleFasted(n).pulse2_40mV};
    MF_pulse(n,10) = {Firing.MaleFasted(n).pulse2_RP};
end   

% Female Control
FC_pulse = {};
for n = 1:length(Firing.FemaleControl)
    FC_pulse(n,1) = {'Female Control'};
    FC_pulse(n,2) = {Firing.FemaleControl(1).tableRange.Tab_Names(n)};
    FC_pulse(n,3) = {Firing.FemaleControl(n).pulse1_70mV};
    FC_pulse(n,4) = {Firing.FemaleControl(n).pulse1_60mV};
    FC_pulse(n,5) = {Firing.FemaleControl(n).pulse1_40mV};
    FC_pulse(n,6) = {Firing.FemaleControl(n).pulse1_RP};
    FC_pulse(n,7) = {Firing.FemaleControl(n).pulse2_70mV};
    FC_pulse(n,8) = {Firing.FemaleControl(n).pulse2_60mV};
    FC_pulse(n,9) = {Firing.FemaleControl(n).pulse2_40mV};
    FC_pulse(n,10) = {Firing.FemaleControl(n).pulse2_RP};
end    

% Female Fasted
FF_pulse = {};
for n = 1:length(Firing.FemaleFasted)
    FF_pulse(n,1) = {'Female Fasted'};
    FF_pulse(n,2) = {Firing.FemaleFasted(1).tableRange.Tab_Names(n)};
    FF_pulse(n,3) = {Firing.FemaleFasted(n).pulse1_70mV};
    FF_pulse(n,4) = {Firing.FemaleFasted(n).pulse1_60mV};
    FF_pulse(n,5) = {Firing.FemaleFasted(n).pulse1_40mV};
    FF_pulse(n,6) = {Firing.FemaleFasted(n).pulse1_RP};
    FF_pulse(n,7) = {Firing.FemaleFasted(n).pulse2_70mV};
    FF_pulse(n,8) = {Firing.FemaleFasted(n).pulse2_60mV};
    FF_pulse(n,9) = {Firing.FemaleFasted(n).pulse2_40mV};
    FF_pulse(n,10) = {Firing.FemaleFasted(n).pulse2_RP};
end  

pulse_nan = {nan, nan, nan, nan, nan, nan, nan, nan, nan, nan};

pulse_array = [pulse_nan; MC_pulse; pulse_nan; MF_pulse; pulse_nan; FC_pulse; pulse_nan; FF_pulse];

Firing.Tables.pulse = array2table(pulse_array,'VariableNames',{'Group','Cell_Name','P1_-70mV', 'P1_-60mV', 'P1_-40mV', 'P1_RP', 'P2_-70mV', 'P2_-60mV', 'P2_-40mV', 'P2_RP'});

clear n MC_pulse MF_pulse FC_pulse FF_pulse pulse_array pulse_nan

save Firing_LH2VTA;

%% Writing Table

writetable(Firing.Tables.pulse,'Firing_LH2VTA.xlsx','Sheet','pulse','Range','A1');

