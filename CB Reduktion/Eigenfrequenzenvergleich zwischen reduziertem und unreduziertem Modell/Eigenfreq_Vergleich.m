%% Eigenfreqvergleich unred vs red
filename = 'FreqUnredSub1_13.txt';
dataUnred1zu13 = readmatrix(filename, 'NumHeaderLines', 1);
Modenumber1zu13 = dataUnred1zu13(:, 2);
EigenfreqUnred1zu13 = dataUnred1zu13(:, 3);
filename = 'FreqUnredFullpart.txt';
dataFull = readmatrix(filename, 'NumHeaderLines', 1);
Modenumberfull = dataFull(:, 1);
Eigenfreqfull = dataFull(:, 2);
EigenfreqRed1 = load('Eigenfreq_Red1.mat').EigenFreq1;
EigenfreqRed2 = load('Eigenfreq_Red2.mat').EigenFreq2;
DiffRed1 = abs(EigenfreqRed1(1:320) - EigenfreqUnred1zu13(1:320))./(EigenfreqUnred1zu13(1:320))*100;
DiffRed2 = abs(EigenfreqRed2(1:320) - Eigenfreqfull(1:320))./(Eigenfreqfull(1:320))*100;
%%
figure
plot(7:320, DiffRed1(7:320), 'r', 'LineWidth', 2); hold on
plot(7:320, DiffRed2(7:320), 'k', 'LineWidth', 2);
plot([260 260], [0 0.5], 'y', 'LineWidth', 2);
plot([288 288], [0 0.5], 'c', 'LineWidth', 2);
plot([280 280], [0 0.5], 'y', 'LineWidth', 2);
plot([303 303], [0 0.5], 'c', 'LineWidth', 2);
grid on
xlim([7 320])
ylim([0 0.5])
xlabel('Modenzahl', 'FontSize', 16)
ylabel('Eigenfrequenzdifferenz in Prozent (%)', 'FontSize', 16)
legend({'Eigenfrequenzenabweichung nach 1.Reduktionsschritt', 'Eigenfrequenzenabweichung nach 2.Reduktionsschritt', 'Eigenfrequenzenbereich 19.5kHz-20.5kHz nach 1.Reduktionstufe', 'Eigenfrequenzenbereich 19.5kHz-20.5kHz nach 2.Reduktionstufe'}, ...
       'Location', 'best', 'FontSize', 16)
%%
SpeicherCellEigFreq1 = load('EigenfreqFirstRed1_13_40_40_160khz.mat').SpeicherCellEigFreq1;
EigenfreqIF40k = SpeicherCellEigFreq1{1, 1};
EigenfreqIF80k = SpeicherCellEigFreq1{1, 2};
EigenfreqIF120k = SpeicherCellEigFreq1{1, 3};
EigenfreqIF160k = SpeicherCellEigFreq1{1, 4};
DiffRed1IF40k = abs(EigenfreqIF40k(1:400) - EigenfreqUnred1zu13(1:400));
DiffRed1IF80k = abs(EigenfreqIF80k(1:400) - EigenfreqUnred1zu13(1:400));
DiffRed1IF120k = abs(EigenfreqIF120k(1:400) - EigenfreqUnred1zu13(1:400));
DiffRed1IF160k = abs(EigenfreqIF160k(1:400) - EigenfreqUnred1zu13(1:400));
figure
plot(7:350, DiffRed1IF40k(7:350), 'c', 'LineWidth', 2); hold on
plot(7:350, DiffRed1IF80k(7:350), 'r', 'LineWidth', 2); hold on
plot(7:350, DiffRed1IF120k(7:350), 'b', 'LineWidth', 2); hold on
plot(7:350, DiffRed1IF160k(7:350), 'm', 'LineWidth', 2); hold on
plot([260 260], [0 700], 'y', 'LineWidth', 2); hold on
plot([280 280], [0 700], 'y', 'LineWidth', 2); hold on
grid on
xlim([7 300])
ylim([0 700])
xlabel('Modenzahl', 'FontSize', 16)
ylabel('Eigenfrequenzdifferenz in Hertz (Hz)', 'FontSize', 16)
legend({'Eigenfrequenzenabweichung unter Auswahl FI-Moden in Frequenzbereich 0-40kHz', 'Eigenfrequenzenabweichung unter Auswahl FI-Moden in Frequenzbereich 0-80kHz', 'Eigenfrequenzenabweichung unter Auswahl FI-Moden in Frequenzbereich 0-120kHz', 'Eigenfrequenzenabweichung unter Auswahl FI-Moden in Frequenzbereich 0-160kHz', 'Eigenfrequenzenbereich 19.5kHz-20.5kHz'}, ...
       'Location', 'best', 'FontSize', 16)