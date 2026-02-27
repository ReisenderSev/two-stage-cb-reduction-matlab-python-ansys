%% CB Reduktion
%% VecMain, VecFollow, Mapback, Mmat und Kmat einlesen
VecMainIntern = ReadMatORVek('VecMainIntern.mmf');
VecMainExtern = ReadMatORVek('VecMainExtern.mmf');
VecMainInterTrAd = ReadMatORVek('VecMainTrAd.mmf');
MapbackSub1 = ReadMatORVek('Mapbacksub1.mmf');
MapbackSub2 = ReadMatORVek('Mapbacksub2.mmf');
MapbackSub3 = ReadMatORVek('Mapbacksub3.mmf');
MapbackSub4 = ReadMatORVek('Mapbacksub4.mmf');
MapbackSub5 = ReadMatORVek('Mapbacksub5.mmf');
MapbackSub6 = ReadMatORVek('Mapbacksub6.mmf');
MapbackSub7 = ReadMatORVek('Mapbacksub7.mmf');
MapbackSub8 = ReadMatORVek('Mapbacksub8.mmf');
MapbackSub9 = ReadMatORVek('Mapbacksub9.mmf');
MapbackSub10 = ReadMatORVek('Mapbacksub10.mmf');
MapbackSub11 = ReadMatORVek('Mapbacksub11.mmf');
MapbackSub12 = ReadMatORVek('Mapbacksub12.mmf');
MapbackSub13 = ReadMatORVek('Mapbacksub13.mmf');
M_Sub1 = ReadMatORVek('Msub1.mmf');
M_Sub2 = ReadMatORVek('Msub2.mmf');
M_Sub3 = ReadMatORVek('Msub3.mmf');
M_Sub4 = ReadMatORVek('Msub4.mmf');
M_Sub5 = ReadMatORVek('Msub5.mmf');
M_Sub6 = ReadMatORVek('Msub6.mmf');
M_Sub7 = ReadMatORVek('Msub7.mmf');
M_Sub8 = ReadMatORVek('Msub8.mmf');
M_Sub9 = ReadMatORVek('Msub9.mmf');
M_Sub10 = ReadMatORVek('Msub10.mmf');
M_Sub11 = ReadMatORVek('Msub11.mmf');
M_Sub12 = ReadMatORVek('Msub12.mmf');
M_Sub13 = ReadMatORVek('Msub13.mmf');
K_Sub1 = ReadMatORVek('Ksub1.mmf');
K_Sub2 = ReadMatORVek('Ksub2.mmf');
K_Sub3 = ReadMatORVek('Ksub3.mmf');
K_Sub4 = ReadMatORVek('Ksub4.mmf');
K_Sub5 = ReadMatORVek('Ksub5.mmf');
K_Sub6 = ReadMatORVek('Ksub6.mmf');
K_Sub7 = ReadMatORVek('Ksub7.mmf');
K_Sub8 = ReadMatORVek('Ksub8.mmf');
K_Sub9 = ReadMatORVek('Ksub9.mmf');
K_Sub10 = ReadMatORVek('Ksub10.mmf');
K_Sub11 = ReadMatORVek('Ksub11.mmf');
K_Sub12 = ReadMatORVek('Ksub12.mmf');
K_Sub13 = ReadMatORVek('Ksub13.mmf');
%% Untersuchung der Auswahl Fixed Interface Moden
% SpeicherCellEigFreq1 = cell(1, 4);
% SpeicherCellEigFreq2 = cell(1, 4);
for FreqNow = 1:1
    %%% 1.CB Reduktion durchführen
    % Die gesamte MainVek für erste CB Reduktion bestimmen
    VecMainFirstCB = [VecMainExtern; VecMainIntern];
    % Anzahl von MainDoF
    SumMainDoF = 3*numel(VecMainFirstCB);
    % Zielfrequenzbereich einstellen
    FreqMin = 0;
    FreqMax = 1.5e+5;
    % FreqMax = FreqNow*4e+4;
    %% Funktion TestCBsub aufrufen um Substruktur zu reduzieren
    [KcbSub1, McbSub1, TcbSub1, NumModenSub1] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub1, M_Sub1, MapbackSub1, VecMainFirstCB);
    fprintf('\nfinish with Substruc1\n');
    [KcbSub2, McbSub2, TcbSub2, NumModenSub2] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub2, M_Sub2, MapbackSub2, VecMainFirstCB);
    fprintf('\nfinish with Substruc2\n');
    [KcbSub3, McbSub3, TcbSub3, NumModenSub3] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub3, M_Sub3, MapbackSub3, VecMainFirstCB);
    fprintf('\nfinish with Substruc3\n');
    [KcbSub4, McbSub4, TcbSub4, NumModenSub4] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub4, M_Sub4, MapbackSub4, VecMainFirstCB);
    fprintf('\nfinish with Substruc4\n');
    [KcbSub5, McbSub5, TcbSub5, NumModenSub5] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub5, M_Sub5, MapbackSub5, VecMainFirstCB);
    fprintf('\nfinish with Substruc5\n');
    [KcbSub6, McbSub6, TcbSub6, NumModenSub6] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub6, M_Sub6, MapbackSub6, VecMainFirstCB);
    fprintf('\nfinish with Substruc6\n');
    [KcbSub7, McbSub7, TcbSub7, NumModenSub7] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub7, M_Sub7, MapbackSub7, VecMainFirstCB);
    fprintf('\nfinish with Substruc7\n');
    [KcbSub8, McbSub8, TcbSub8, NumModenSub8] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub8, M_Sub8, MapbackSub8, VecMainFirstCB);
    fprintf('\nfinish with Substruc8\n');
    [KcbSub9, McbSub9, TcbSub9, NumModenSub9] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub9, M_Sub9, MapbackSub9, VecMainFirstCB);
    fprintf('\nfinish with Substruc9\n');
    [KcbSub10, McbSub10, TcbSub10, NumModenSub10] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub10, M_Sub10, MapbackSub10, VecMainFirstCB);
    fprintf('\nfinish with Substruc10\n');
    [KcbSub11, McbSub11, TcbSub11, NumModenSub11] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub11, M_Sub11, MapbackSub11, VecMainFirstCB);
    fprintf('\nfinish with Substruc11\n');
    [KcbSub12, McbSub12, TcbSub12, NumModenSub12] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub12, M_Sub12, MapbackSub12, VecMainFirstCB);
    fprintf('\nfinish with Substruc12\n');
    [KcbSub13, McbSub13, TcbSub13, NumModenSub13] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub13, M_Sub13, MapbackSub13, VecMainFirstCB);
    fprintf('\nfinish with Substruc13\n');
    %% Zusammenbau reduzierten Mat
    [Tges, Mges, Kges] = MatZusammenbau(SumMainDoF, TcbSub1, McbSub1, KcbSub1, TcbSub2, McbSub2, KcbSub2);
    fprintf('\nSubstruc 1 and 2 added\n');
    [Tges, Mges, Kges] = MatZusammenbau(SumMainDoF, Tges, Mges, Kges, TcbSub3, McbSub3, KcbSub3);
    fprintf('\nSubstruc 3 added\n');
    [Tges, Mges, Kges] = MatZusammenbau(SumMainDoF, Tges, Mges, Kges, TcbSub4, McbSub4, KcbSub4);
    fprintf('\nSubstruc 4 added\n');
    [Tges, Mges, Kges] = MatZusammenbau(SumMainDoF, Tges, Mges, Kges, TcbSub5, McbSub5, KcbSub5);
    fprintf('\nSubstruc 5 added\n');
    [Tges, Mges, Kges] = MatZusammenbau(SumMainDoF, Tges, Mges, Kges, TcbSub6, McbSub6, KcbSub6);
    fprintf('\nSubstruc 6 added\n');
    [Tges, Mges, Kges] = MatZusammenbau(SumMainDoF, Tges, Mges, Kges, TcbSub7, McbSub7, KcbSub7);
    fprintf('\nSubstruc 7 added\n');
    [Tges, Mges, Kges] = MatZusammenbau(SumMainDoF, Tges, Mges, Kges, TcbSub8, McbSub8, KcbSub8);
    fprintf('\nSubstruc 8 added\n');
    [Tges, Mges, Kges] = MatZusammenbau(SumMainDoF, Tges, Mges, Kges, TcbSub9, McbSub9, KcbSub9);
    fprintf('\nSubstruc 9 added\n');
    [Tges, Mges, Kges] = MatZusammenbau(SumMainDoF, Tges, Mges, Kges, TcbSub10, McbSub10, KcbSub10);
    fprintf('\nSubstruc 10 added\n');
    [Tges, Mges, Kges] = MatZusammenbau(SumMainDoF, Tges, Mges, Kges, TcbSub11, McbSub11, KcbSub11);
    fprintf('\nSubstruc 11 added\n');
    [Tges, Mges, Kges] = MatZusammenbau(SumMainDoF, Tges, Mges, Kges, TcbSub12, McbSub12, KcbSub12);
    fprintf('\nSubstruc 12 added\n');
    [TgesIntern, MgesIntern, KgesIntern] = MatZusammenbau(SumMainDoF, Tges, Mges, Kges, TcbSub13, McbSub13, KcbSub13);
    fprintf('\nSubstruc 13 added\n');
    %% Modal Analyse mit zusammengebauten Mat durchführen
    NumModen = size(MgesIntern, 1);
    % % Hier wird Matlab eingebaute Funktion eigs(KgesIntern, MgesIntern, k, 'SM')
    % % aufgerufen
    % [EigenVec1, EigenWert1] = eigs(KgesIntern, MgesIntern, NumModen, 'SM');
    % EigenFreq1 = diag(sqrt(EigenWert1)./(2*pi));
    % Hier wird Ansys-Core zur Berechnung aufgerufen 
    Pfade_Ansys = 'C:\Program Files\ANSYS Inc\v251\ansys\bin\winx64\ANSYS251.exe';
    [EigenVec1, EigenWert1] = eigsAnsys(KgesIntern, MgesIntern, NumModen, Pfade_Ansys);
    EigenFreq1 = sqrt(EigenWert1)./(2*pi);
    EigenFreq1 = sort(EigenFreq1);
    % SpeicherCellEigFreq1{1, FreqNow} = EigenFreq1;
end
%% 2.CB Reduktion durchführen
MapbackSub14 = ReadMatORVek('Mapbacksub14.mmf');
MapbackSub15 = ReadMatORVek('Mapbacksub15.mmf');
M_Sub14 = ReadMatORVek('Msub14.mmf');
M_Sub15 = ReadMatORVek('Msub15.mmf');
K_Sub14 = ReadMatORVek('Ksub14.mmf');
K_Sub15 = ReadMatORVek('Ksub15.mmf');
% Die gesamte MainVek für zweite CB Reduktion bestimmen
VecMainSecondCB = [VecMainInterTrAd; VecMainExtern];
% Die Mapping von Reduzierten Plattenteil erstellen
LenFollowFirstRed = size(MgesIntern, 1) - 3*numel(VecMainExtern);
% Die Freiheitsgrade, die nicht zum ExternInterface-Knoten gehören, werden mit einem Nullvektor aufgefüllt.
MappingFollowFirstRed = zeros(LenFollowFirstRed, 1);
% MapbackFirstRed dient als Mapping-Vektor der Grundplattenmatrix nach der Reduktion der ersten Stufe
MapbackFirstRed = [VecMainExtern; MappingFollowFirstRed];
% erneute Anzahl von MainDoF bestimmen
SumMainDoF = 3*numel(VecMainSecondCB);
% Max und Min Freq
FreqMin = 0;
FreqMax = 5e+4;
%% Funktion EinsatzCBsub aufrufen um Substruktur zu reduzieren 
[KcbIntern, McbIntern, TcbIntern, NumModenIntern] = EinsatzCBsubVer2(FreqMin, FreqMax, KgesIntern, MgesIntern, MapbackFirstRed, VecMainSecondCB);
fprintf('\nfinish with Substruc Intern\n');
[KcbSub14, McbSub14, TcbSub14, NumModenSub14] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub14, M_Sub14, MapbackSub14, VecMainSecondCB);
fprintf('\nfinish with Substruc Fensterausschnitt\n');
[KcbSub15, McbSub15, TcbSub15, NumModenSub15] = EinsatzCBsubVer2(FreqMin, FreqMax, K_Sub15, M_Sub15, MapbackSub15, VecMainSecondCB);
fprintf('\nfinish with Substruc Transducer\n');
%% Zusammenbau reduzierten Mat
[Tges, Mges, Kges] = MatZusammenbau(SumMainDoF, TcbIntern, McbIntern, KcbIntern, TcbSub14, McbSub14, KcbSub14);
fprintf('\nSubstruc Intern and Fensterausschnitt added\n');
[Tges, Mges, Kges] = MatZusammenbau(SumMainDoF, Tges, Mges, Kges, TcbSub15, McbSub15, KcbSub15);
fprintf('\nSubstruc Transducer added\n');
%% Modal Analyse mit zusammengebauten Mat durchführen
Mges = sparse(Mges);
Kges = sparse(Kges);
NumModen = size(Mges, 1);
% % Hier wird Matlab eingebaute Funktion eigs(Kges, Mges, k, 'SM')
% % aufgerufen
% [EigenVec2, EigenWert2] = eigs(Kges, Mges, NumModen, 'SM');
% EigenFreq2 = diag(sqrt(EigenWert2)./(2*pi));
% Hier wird Ansys-Core zur Berechnung aufgerufen 
Pfade_Ansys = 'C:\Program Files\ANSYS Inc\v251\ansys\bin\winx64\ANSYS251.exe';
[EigenVec2, EigenWert2] = eigsAnsys(Kges, Mges, NumModen, Pfade_Ansys);
EigenFreq2 = sqrt(EigenWert2)./(2*pi);
EigenFreq2 = sort(EigenFreq2);













