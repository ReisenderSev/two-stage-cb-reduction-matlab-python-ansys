function [MatVoll, NumRow, NumCol] = ReadMatORVek(Filename)
%% Read Mat or Vec from File
fid = fopen(Filename, 'r');
Line = fgetl(fid);
FirstLine = strsplit(strtrim(Line));
% FileEigenschaft bestimmen: array oder coordinate
FileEigenschaft = lower(FirstLine{3});
Countline = 1;
% Alle Zeilen mit Anfang von % überspringen
while startsWith(strtrim(Line), '%')
    Countline = Countline + 1;
    Line = fgetl(fid);
end
% MatDimension bestimmen
MatEigenschaft = strsplit(strtrim(Line));
NumRow = str2double(MatEigenschaft{1});
NumCol = str2double(MatEigenschaft{2});
% Datein mit readtable() einlesen
T = readtable(Filename, 'FileType', 'text', 'ReadVariableNames', false, 'HeaderLines', Countline);
if strcmp(FileEigenschaft, 'array')
    % Rückgabe Mat entspricht Form Vek
    MatVoll = table2array(T);
elseif strcmp(FileEigenschaft, 'coordinate')
    % Rückgabe Mat entspricht Form Mat
    Data = table2array(T);
    Mat = sparse(Data(:, 1), Data(:, 2), Data(:, 3), NumRow, NumCol);
    if istriu(Mat)
        MatVoll = triu(Mat) + triu(Mat, 1).';
    elseif istril(Mat)
        MatVoll = tril(Mat) + tril(Mat, -1).';
    else
        MatVoll = Mat;
    end
end
end

