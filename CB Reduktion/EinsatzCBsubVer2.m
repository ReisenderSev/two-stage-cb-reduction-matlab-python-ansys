function [KcbSub, McbSub, Tsub, NumModen] = EinsatzCBsubVer2(EigenFreqMin, EigenFreqMax, WBKSub, WBMSub, MapbackSub, VecMainInter)
% Funktion für CB Reduktion auf einzelne Substruktur
% Die Funktion wird aus 3 Teilen gebaut
% Teil1: Vektorbearbeitung um endlich einen PermutationsVektor für einzelne Substruktur zu erstellen
% Teil2: Massen- und SteifMat einzelner Substruktur zu expandieren und
% umsortieren
% Teil3: Craig-Bampton Reduktion an die Substrukturen durchzuführen
%% Vektorbearbeitung
% MainKnotenID-Vektor einzelner Substruktur bestimmen
VecMainSub = intersect(MapbackSub, VecMainInter);
% nicht zu Substruk gehörten MainKnotenIDs bestimmen
VecMainExtra = setdiff(VecMainInter, VecMainSub);
% FollowerKnotenID-Vektor einzelner Substruktur bestimmen
VecFollowSub = setdiff(MapbackSub, VecMainSub);
if all(VecFollowSub == 0)
    % Zweige für die Platten nach 1. CB Reduktion
    LengthFollowDoF = numel(MapbackSub) - numel(VecMainSub);
    LengthPermDoFVec = 3*numel(VecMainInter) + LengthFollowDoF;
    PermDoFSub = 1:LengthPermDoFVec;
else
    % Extension von MapbackSub durchführen
    MapbackSubExten = [VecMainExtra; MapbackSub];
    % Zielvektor für Reihenfolgen KnotenID nach Main und Follower bestimmen
    TargetVec = [VecMainInter; VecFollowSub];
    % PermutationsVek im Bezug auf KnotenID
    [~, PermNodeSub] = ismember(TargetVec, MapbackSubExten);
    % PermutationsVek bezüglich auf Freiheitsgraden erstellen
    PermNodeSub = PermNodeSub.';
    PermDoFSub = reshape([PermNodeSub*3-2; PermNodeSub*3-1; PermNodeSub*3], 1, []);
end
%% Expansion und Umsortierung der Matrizen
% Expansionsvorgang
if all(VecFollowSub == 0)
    DimSub = 3*numel(VecMainInter) + LengthFollowDoF;
    DimSubWB = 3*numel(VecMainSub) + LengthFollowDoF;
else
    DimSub = 3*numel(TargetVec);
    DimSubWB = 3*numel(MapbackSub);
end
LengthDifference = DimSub - DimSubWB;
FillMatPart1 = zeros(LengthDifference);
FillMatPart2 = zeros(LengthDifference, DimSubWB);
WBExpandMSub = [FillMatPart1, FillMatPart2; FillMatPart2.', WBMSub];
WBExpandKSub = [FillMatPart1, FillMatPart2; FillMatPart2.', WBKSub];
% Freiheitsgraden nach Main-Follow sortieren
MsortSub = WBExpandMSub(PermDoFSub, PermDoFSub);
KsortSub = WBExpandKSub(PermDoFSub, PermDoFSub);
%% Craig-Bampton Vorgang
% benötigten TeilMat von VollMat extrahieren
VecFollowDoF = (3*numel(VecMainInter) + 1):DimSub;
VecMainDoF = 1:3*numel(VecMainInter);
Mff = MsortSub(VecFollowDoF, VecFollowDoF);
Kff = KsortSub(VecFollowDoF, VecFollowDoF);
Kfm = KsortSub(VecFollowDoF, VecMainDoF);
% Statische Moden
Psi = Kff\((-1)*Kfm);
% Fixed Interface Moden
SparseMff = sparse(Mff);
SparseKff = sparse(Kff);
if all(VecFollowSub == 0)
    NumModen = LengthFollowDoF;
else
    NumModen = 3*numel(VecFollowSub);
end
% Hier wird Ansys-Core zur Berechnung aufgerufen 
Pfade_Ansys = 'C:\Program Files\ANSYS Inc\v251\ansys\bin\winx64\ANSYS251.exe';
[EigenVec, EigenWert] = eigsAnsys(SparseKff, SparseMff, NumModen, Pfade_Ansys);
EigenFreq = sqrt(EigenWert)./(2*pi);
% % Hier wird Matlab eingebaute Funktion eigs(Ksparse, Msparse, k, 'SM')
% % aufgerufen
% [EigenVec, EigenWert] = eigs(SparseKff, SparseMff, NumModen, 'SM');
% EigenFreq = diag(sqrt(EigenWert)./(2*pi));
% Sortierung Eigenvektoren nach aufsteigenden Eigenfrequenzen
[EigenFreqSorted, IdxSort] = sort(EigenFreq);
EigenVecSorted = EigenVec(:, IdxSort);
% Auswahl der Eigenvektoren für FI-Moden
Idx = (EigenFreqSorted >= EigenFreqMin) & (EigenFreqSorted <= EigenFreqMax);
Phi = EigenVecSorted(:, Idx);
NumModen = nnz(Idx);
% ReduktionsMat zusammenbauen
PartEye = eye(numel(VecMainDoF));
PartZeros = zeros(numel(VecMainDoF), NumModen);
Tsub = [PartEye, PartZeros; Psi, Phi];
% MassMat und SteifMat reduzieren
McbSub = Tsub.'*MsortSub*Tsub;
KcbSub = Tsub.'*KsortSub*Tsub;
McbSub = (1/2).*McbSub.'+(1/2).*McbSub;
KcbSub = (1/2).*KcbSub.'+(1/2).*KcbSub;
end

