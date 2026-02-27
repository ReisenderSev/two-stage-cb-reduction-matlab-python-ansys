Speicherordnerpfade
Pfade = 'X:\Studienarbeit\EigenvekVergleich+MAC';
%% Vergleich 8mm und 2.1mm
% Einstellung zum groben Netz
Prefix_grob = 'Gitter_8mm_Eigenvek_';
Knoten_XYZ_grob = 'Gitter_8mm_Knoten_Koordinaten.txt';
Anzahl_grob = 472;
% Einstellung zum feinen Netz
Prefix_fein = 'Gitter_2.1mm_Eigenvek_';
Knoten_XYZ_fein = 'Gitter_2.1mm_Knoten_Koordinaten.txt';
Anzahl_fein = 458;
% Funktion aufrufen
[Eigenvek_grob, Eigenvek_fein, MAC] = EigenvektorVergleich_44(Prefix_grob, Anzahl_grob, Knoten_XYZ_grob, Prefix_fein, Anzahl_fein, Knoten_XYZ_fein);
% Name für die gespeicherten Dateien
Name_1 = 'Eigenvekmatrix_8mm(grob_8mm_fein_2.1mm).mat';
Name_2 = 'Eigenvekmatrix_2.1mm(grob_8mm_fein_2.1mm).mat';
Name_3 = 'MAC_Matrix(grob_8mm_fein_2.1mm)';
Voll_Pfade_1 = fullfile(Pfade, Name_1);
Voll_Pfade_2 = fullfile(Pfade, Name_2);
Voll_Pfade_3 = fullfile(Pfade, Name_3);
% Dateien speichern
save(Voll_Pfade_1, 'Eigenvek_grob', '-v7.3');
save(Voll_Pfade_2, 'Eigenvek_fein', '-v7.3');
save(Voll_Pfade_3, 'MAC');
%% Vergleich 5mm und 2.1mm
% Einstellung zum groben Netz
Prefix_grob = 'Gitter_5mm_Eigenvek_';
Knoten_XYZ_grob = 'Gitter_5mm_Knoten_Koordinaten.txt';
Anzahl_grob = 468;
% Einstellung zum feinen Netz
Prefix_fein = 'Gitter_2.1mm_Eigenvek_';
Knoten_XYZ_fein = 'Gitter_2.1mm_Knoten_Koordinaten.txt';
Anzahl_fein = 458;
% Funktion aufrufen
[Eigenvek_grob, Eigenvek_fein, MAC] = EigenvektorVergleich_44(Prefix_grob, Anzahl_grob, Knoten_XYZ_grob, Prefix_fein, Anzahl_fein, Knoten_XYZ_fein);
% Name für die gespeicherten Dateien
Name_1 = 'Eigenvekmatrix_5mm(grob_5mm_fein_2.1mm).mat';
Name_2 = 'Eigenvekmatrix_2.1mm(grob_5mm_fein_2.1mm).mat';
Name_3 = 'MAC_Matrix(grob_5mm_fein_2.1mm)';
Voll_Pfade_1 = fullfile(Pfade, Name_1);
Voll_Pfade_2 = fullfile(Pfade, Name_2);
Voll_Pfade_3 = fullfile(Pfade, Name_3);
% Dateien speichern
save(Voll_Pfade_1, 'Eigenvek_grob', '-v7.3');
save(Voll_Pfade_2, 'Eigenvek_fein', '-v7.3');
save(Voll_Pfade_3, 'MAC');
%% Vergleich 3mm und 2.1mm
% Einstellung zum groben Netz
Prefix_grob = 'Gitter_3mm_Eigenvek_';
Knoten_XYZ_grob = 'Gitter_3mm_Knoten_Koordinaten.txt';
Anzahl_grob = 466;
% Einstellung zum feinen Netz
Prefix_fein = 'Gitter_2.1mm_Eigenvek_';
Knoten_XYZ_fein = 'Gitter_2.1mm_Knoten_Koordinaten.txt';
Anzahl_fein = 458;
% Funktion aufrufen
[Eigenvek_grob, Eigenvek_fein, MAC] = EigenvektorVergleich_44(Prefix_grob, Anzahl_grob, Knoten_XYZ_grob, Prefix_fein, Anzahl_fein, Knoten_XYZ_fein);
% Name für die gespeicherten Dateien
Name_1 = 'Eigenvekmatrix_3mm(grob_3mm_fein_2.1mm).mat';
Name_2 = 'Eigenvekmatrix_2.1mm(grob_3mm_fein_2.1mm).mat';
Name_3 = 'MAC_Matrix(grob_3mm_fein_2.1mm)';
Voll_Pfade_1 = fullfile(Pfade, Name_1);
Voll_Pfade_2 = fullfile(Pfade, Name_2);
Voll_Pfade_3 = fullfile(Pfade, Name_3);
% Dateien speichern
save(Voll_Pfade_1, 'Eigenvek_grob', '-v7.3');
save(Voll_Pfade_2, 'Eigenvek_fein', '-v7.3');
save(Voll_Pfade_3, 'MAC');
%% Speicherordnerpfade
Pfade = 'X:\Studienarbeit\EigenvekVergleich+MAC';
%% Vergleich 2.5mm und 2.1mm
% Einstellung zum Netzgröße zur Interpolation
Prefix_grob = 'Gitter_2.5mm_Eigenvek_';
Anzahl_grob = 459;
Knoten_XYZ_grob = 'Gitter_2.5mm_Knoten_Koordinaten.txt';
[Eigenvek_grob] = Interpolation8025(Prefix_grob, Anzahl_grob, Knoten_XYZ_grob);
% Name für die gespeicherten Dateien
Name_1 = 'Eigenvekmatrix_2.5mm(grob_8mm_fein_2.5mm).mat';
Voll_Pfade_1 = fullfile(Pfade, Name_1);
% Dateien speichern
save(Voll_Pfade_1, 'Eigenvek_grob', '-v7.3');
%% Vergleich 2.4mm und 2.1mm
% Einstellung zum groben Netz
Prefix_grob = 'Gitter_2.4mm_Eigenvek_';
Anzahl_grob = 458;
% Einstellung zum feinen Netz
% Prefix_fein = 'Gitter_2.1mm_Eigenvek_';
% Knoten_XYZ_fein = 'Gitter_2.1mm_Knoten_Koordinaten.txt';
% Anzahl_fein = 458;
% Funktion aufrufen
% [Eigenvek_grob, Eigenvek_fein, MAC] = EigenvektorVergleich_74(Prefix_grob, Anzahl_grob, Prefix_fein, Anzahl_fein, Knoten_XYZ_fein);
[Eigenvek_grob] = Interpolation8mm(Prefix_grob, Anzahl_grob);
% Name für die gespeicherten Dateien
Name_1 = 'Eigenvekmatrix_2.4mm(grob_8mm_fein_2.4mm).mat';
% Name_2 = 'Eigenvekmatrix_2.1mm(grob_2.4mm_fein_2.1mm).mat';
% Name_3 = 'MAC_Matrix(grob_2.4mm_fein_2.1mm)';
Voll_Pfade_1 = fullfile(Pfade, Name_1);
% Voll_Pfade_2 = fullfile(Pfade, Name_2);
% Voll_Pfade_3 = fullfile(Pfade, Name_3);
% Dateien speichern
save(Voll_Pfade_1, 'Eigenvek_grob', '-v7.3');
% save(Voll_Pfade_2, 'Eigenvek_fein');
% save(Voll_Pfade_3, 'MAC');
%% Vergleich 2.3mm und 2.1mm
% Einstellung zum groben Netz
Prefix_grob = 'Gitter_2.3mm_Eigenvek_';
Anzahl_grob = 458;
% Einstellung zum feinen Netz
% Prefix_fein = 'Gitter_2.1mm_Eigenvek_';
% Knoten_XYZ_fein = 'Gitter_2.1mm_Knoten_Koordinaten.txt';
% Anzahl_fein = 458;
% Funktion aufrufen
% [Eigenvek_grob, Eigenvek_fein, MAC] = EigenvektorVergleich_74(Prefix_grob, Anzahl_grob, Prefix_fein, Anzahl_fein, Knoten_XYZ_fein);
[Eigenvek_grob] = Interpolation8mm(Prefix_grob, Anzahl_grob);
% Name für die gespeicherten Dateien
Name_1 = 'Eigenvekmatrix_2.3mm(grob_8mm_fein_2.3mm).mat';
% Name_2 = 'Eigenvekmatrix_2.1mm(grob_2.3mm_fein_2.1mm).mat';
% Name_3 = 'MAC_Matrix(grob_2.3mm_fein_2.1mm)';
Voll_Pfade_1 = fullfile(Pfade, Name_1);
% Voll_Pfade_2 = fullfile(Pfade, Name_2);
% Voll_Pfade_3 = fullfile(Pfade, Name_3);
% Dateien speichern
save(Voll_Pfade_1, 'Eigenvek_grob', '-v7.3');
% save(Voll_Pfade_2, 'Eigenvek_fein');
% save(Voll_Pfade_3, 'MAC');
%% Vergleich 2.2mm und 2.1mm
% Einstellung zum groben Netz
Prefix_grob = 'Gitter_2.2mm_Eigenvek_';
Anzahl_grob = 458;
% Einstellung zum feinen Netz
% Prefix_fein = 'Gitter_2.1mm_Eigenvek_';
% Knoten_XYZ_fein = 'Gitter_2.1mm_Knoten_Koordinaten.txt';
% Anzahl_fein = 458;
% Funktion aufrufen
% [Eigenvek_grob, Eigenvek_fein, MAC] = EigenvektorVergleich_74(Prefix_grob, Anzahl_grob, Prefix_fein, Anzahl_fein, Knoten_XYZ_fein);
[Eigenvek_grob] = Interpolation8mm(Prefix_grob, Anzahl_grob);
% Name für die gespeicherten Dateien
Name_1 = 'Eigenvekmatrix_2.2mm(grob_8mm_fein_2.2mm).mat';
% Name_2 = 'Eigenvekmatrix_2.1mm(grob_2.2mm_fein_2.1mm).mat';
% Name_3 = 'MAC_Matrix(grob_2.2mm_fein_2.1mm)';
Voll_Pfade_1 = fullfile(Pfade, Name_1);
% Voll_Pfade_2 = fullfile(Pfade, Name_2);
% Voll_Pfade_3 = fullfile(Pfade, Name_3);
% Dateien speichern
save(Voll_Pfade_1, 'Eigenvek_grob', '-v7.3');
% save(Voll_Pfade_2, 'Eigenvek_fein');
% save(Voll_Pfade_3, 'MAC');