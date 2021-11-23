function Resistance = importInputRes(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  RESISTANCE = IMPORTINPUTRES(FILE) reads data from the first
%  worksheet in the Microsoft Excel spreadsheet file named FILE.
%  Returns the data as a table.
%
%  RESISTANCE = IMPORTINPUTRES(FILE, SHEET) reads from the specified
%  worksheet.
%
%  RESISTANCE = IMPORTINPUTRES(FILE, SHEET, DATALINES) reads from the
%  specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  Resistance = importInputRes("/Users/nathansmac/Desktop/LH2VTA/GABA_Firing/100pA_1s/Male Control/Resistance_MC_500ms.xlsx", "6Oct2020_C1S1R", [2, 15]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 26-Nov-2020 09:51:56

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
pattern = {'Sep','Oct'};

if contains(sheetName,pattern)
    if nargin <= 2
        dataLines = [2, 15];
    end
else
    if nargin <= 2
        dataLines = [2, 17];
    end
end

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 5);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "A" + dataLines(1, 1) + ":E" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["FileName", "Trace", "TraceStart", "Peak", "FilePath"];
opts.VariableTypes = ["categorical", "double", "double", "double", "categorical"];

% Specify variable properties
opts = setvaropts(opts, ["FileName", "FilePath"], "EmptyFieldRule", "auto");

% Import the data
Resistance = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":E" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    Resistance = [Resistance; tb]; %#ok<AGROW>
end

end