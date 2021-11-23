function pAStepsMC = importFIRING(workbookFile, sheetName, dataRange)
%IMPORTFILE Import data from a spreadsheet
%
%  PASTEPSMC = IMPORTFIRING(FILE, SHEET, DATARANGE) reads from the
%  specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  pAStepsMC = importFIRING("/Users/nathansmac/Desktop/LH2VTA/GABA_Firing/25pA_Steps_MC.xlsx", "11Sep2020_C1S1L", "A2:AF1690");
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 15-Sep-2020 11:46:12
%% Skip if dataRange is NAN - means that there is no data here
if dataRange == 'NA'
    pAStepsMC = NaN;
    %% Setup the Import Options
else
    opts = spreadsheetImportOptions("NumVariables", 32);

    % Specify sheet and range
    opts.Sheet = sheetName;
    opts.DataRange = dataRange

    % Specify column names and types
    opts.VariableNames = ["Trace", "Search", "Category", "State", "EventStartTimems", "EventEndTimems", "BaselinemV", "PeakAmpmV", "TimetoPeakms", "TimeofPeakms", "AntipeakAmpmV", "TimetoAntipeakmV", "TimeofAntipeakms", "Halfwidthms", "HalfamplitudemV", "TimetoRiseHalfamplitudems", "TimetoDecayHalfamplitudems", "RiseTaums", "DecayTaums", "MaxRiseSlopemVms", "TimetoMaxRiseSlopms", "MaxDecaySlopemVms", "TimetoMaxDecaySlopems", "RiseSlope10to90mVms", "RiseTime10to90ms", "DecaySlope90to10mVms", "DecayTime90to10ms", "AreamVms", "InstFreqHz", "IntereventIntervalms", "SDofFit", "TemplateMatch"];
    opts.SelectedVariableNames = ["Trace", "Search", "Category", "State", "EventStartTimems", "EventEndTimems", "BaselinemV", "PeakAmpmV", "TimetoPeakms", "TimeofPeakms", "AntipeakAmpmV", "TimetoAntipeakmV", "TimeofAntipeakms", "Halfwidthms", "HalfamplitudemV", "TimetoRiseHalfamplitudems", "TimetoDecayHalfamplitudems", "RiseTaums", "DecayTaums", "MaxRiseSlopemVms", "TimetoMaxRiseSlopms", "MaxDecaySlopemVms", "TimetoMaxDecaySlopems", "RiseSlope10to90mVms", "RiseTime10to90ms", "DecaySlope90to10mVms", "DecayTime90to10ms", "AreamVms", "InstFreqHz", "IntereventIntervalms", "SDofFit", "TemplateMatch"];
    opts.VariableTypes = ["double", "categorical", "categorical", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "categorical", "categorical"];
    opts = setvaropts(opts, [1:32], "EmptyFieldRule", "auto");

    % Import the data
    pAStepsMC = readtable(workbookFile, opts, "UseExcel", false);
end
end