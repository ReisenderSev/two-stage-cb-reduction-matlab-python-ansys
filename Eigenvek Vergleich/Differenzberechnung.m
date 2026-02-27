function [num, Diff_pos] = Differenzberechnung(MAC, Eigenfrequenz, Eigenfrequenz21)
% num: Anzahl der Elementen in MAC_Matrix mit Werten größer als 0.8
% Diff_pos: Matrix in 2 Reihen, 2.Reihe beinhalten Differenz der
% Eigenwerten, 1.Reihe beinhalten die Position der Differenzen(basiert auf Eigenfrequenz21)
[maxwert,pos_max] = max(MAC,[],2);
num = length(find(maxwert>=0.8));
pos = [];
Differenz = [];
for i = 1:length(maxwert)
    if maxwert(i) >= 0.8
        Differenzwert = abs(Eigenfrequenz21(pos_max(i)) - Eigenfrequenz(i));
        Differenz = [Differenz, Differenzwert];
        pos = [pos, pos_max(i)];
    end
end
[sorted_pos, sort_idx] = sort(pos);
sorted_Differenz = Differenz(sort_idx);
Diff_pos = [sorted_pos; sorted_Differenz];
end

