clear
clc

%% Einlesen MAC_Matrizen

load("MAC_Matrix(grob_2.2mm_fein_2.1mm).mat")
load("MAC_Matrix(grob_2.3mm_fein_2.1mm).mat")
load("MAC_Matrix(grob_2.4mm_fein_2.1mm).mat")
load('MAC_Matrix(grob_2.5mm_fein_2.1mm).mat')
load("MAC_Matrix(grob_3mm_fein_2.1mm).mat")
MAC_3_21 = MAC;
load("MAC_Matrix(grob_5mm_fein_2.1mm).mat")
MAC_5_21 = MAC;
load("MAC_Matrix(grob_8mm_fein_2.1mm).mat")
MAC_8_21 = MAC;

clear MAC

%% Best {bereinstimmung finde und lokalisieren

[max_22,pos_max_22] = max(MAC_22_21,[],2);
[max_23,pos_max_23] = max(MAC_23_21,[],2);
[max_24,pos_max_24] = max(MAC_24_21,[],2);
[max_3,pos_max_3]   = max(MAC_3_21,[],2);
[max_5,pos_max_5]   = max(MAC_5_21,[],2);
[max_8,pos_max_8]   = max(MAC_8_21,[],2);

%% Eigenwerten einlesen und speichern

[num, txt, raw] = xlsread('Eigenfrequenzen_Yuqi.xlsx');
Eigenfrequenz_25 = num(4:end, 2);
lastValid = find(~isnan(Eigenfrequenz_25), 1, 'last'); 
Eigenfrequenz_25 = Eigenfrequenz_25(1:lastValid);     
Eigenfrequenz_24 = num(4:end, 3);
lastValid = find(~isnan(Eigenfrequenz_24), 1, 'last'); 
Eigenfrequenz_24 = Eigenfrequenz_24(1:lastValid);  
Eigenfrequenz_23 = num(4:end, 4);
lastValid = find(~isnan(Eigenfrequenz_23), 1, 'last'); 
Eigenfrequenz_23 = Eigenfrequenz_23(1:lastValid);
Eigenfrequenz_22 = num(4:end, 5);
lastValid = find(~isnan(Eigenfrequenz_22), 1, 'last'); 
Eigenfrequenz_22 = Eigenfrequenz_22(1:lastValid);  
Eigenfrequenz_21 = num(4:end, 6);
lastValid = find(~isnan(Eigenfrequenz_21), 1, 'last'); 
Eigenfrequenz_21 = Eigenfrequenz_21(1:lastValid);  
Eigenfrequenz_3 = num(4:end, 7);
lastValid = find(~isnan(Eigenfrequenz_3), 1, 'last'); 
Eigenfrequenz_3 = Eigenfrequenz_3(1:lastValid);  
Eigenfrequenz_5 = num(4:end, 8);
lastValid = find(~isnan(Eigenfrequenz_5), 1, 'last'); 
Eigenfrequenz_5 = Eigenfrequenz_5(1:lastValid);  
Eigenfrequenz_8 = num(4:end, 9);
lastValid = find(~isnan(Eigenfrequenz_8), 1, 'last'); 
Eigenfrequenz_8 = Eigenfrequenz_8(1:lastValid);  
clear lastValid

%%
[numGr22, diff_pos_22_21] = Differenzberechnung(MAC_22_21, Eigenfrequenz_22, Eigenfrequenz_21);
[numGr23, diff_pos_23_21] = Differenzberechnung(MAC_23_21, Eigenfrequenz_23, Eigenfrequenz_21);
[numGr24, diff_pos_24_21] = Differenzberechnung(MAC_24_21, Eigenfrequenz_24, Eigenfrequenz_21);
[numGr25, diff_pos_25_21] = Differenzberechnung(MAC_25_21, Eigenfrequenz_25, Eigenfrequenz_21);
[numGr3, diff_pos_3_21] = Differenzberechnung(MAC_3_21, Eigenfrequenz_3, Eigenfrequenz_21);
[numGr5, diff_pos_5_21] = Differenzberechnung(MAC_5_21, Eigenfrequenz_5, Eigenfrequenz_21);
[numGr8, diff_pos_8_21] = Differenzberechnung(MAC_8_21, Eigenfrequenz_8, Eigenfrequenz_21);

%%
figure
plot(diff_pos_22_21(1, :), diff_pos_22_21(2, :), '+', 'Color', '#0072BD');
hold on
plot(diff_pos_23_21(1, :), diff_pos_23_21(2, :), 'x', 'Color', '#D95319');
hold on
plot(diff_pos_24_21(1, :), diff_pos_24_21(2, :), '*', 'Color', '#EDB120');
hold on
plot(diff_pos_25_21(1, :), diff_pos_25_21(2, :), '+', 'Color', '#7E2F8E');
hold on
plot(diff_pos_3_21(1, :), diff_pos_3_21(2, :), 's', 'Color', '#77AC30');
hold on
plot(diff_pos_5_21(1, :), diff_pos_5_21(2, :), 'v', 'Color', '#4DBEEE');
hold on
plot(diff_pos_8_21(1, :), diff_pos_8_21(2, :), 'o', 'Color', '#A2142F');
grid on
xlabel('Modenzahl FE-Netz 2.1mm');
ylabel('Frequenzdifferenz in hz');
legend('Differenz 2.2mm<->2.1mm', 'Differenz 2.3mm<->2.1mm', 'Differenz 2.4mm<->2.1mm', 'Differenz 2.5mm<->2.1mm', 'Differenz 3mm<->2.1mm', 'Differenz 5mm<->2.1mm', 'Differenz 7mm<->2.1mm');
title('Differenzverlauf(Übereinstimmung>=80%)');
