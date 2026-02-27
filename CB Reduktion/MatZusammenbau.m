function [Tgesexp, Mges, Kges] = MatZusammenbau(DoF_Main, TcbSub1, McbSub1, KcbSub1, TcbSub2, McbSub2, KcbSub2)
%% Matrizenzusammenbau
% Zusammenbau RedukMat
% Bauweise 1: TransformationsMat
% Dimension T bestimmen
Tzeilen = size(TcbSub1, 1) + size(TcbSub2, 1) - DoF_Main;
Tspalten = size(TcbSub1, 2) + size(TcbSub2, 2) - DoF_Main;
% TransformationsMat erstellen und MatExpansion berechnen
TransT11 = sparse(Tzeilen, size(TcbSub1, 1));
TransT12 = sparse(size(TcbSub1, 2), Tspalten);
for i = 1:size(TcbSub1, 1)
    TransT11(i, i) = 1;
end
for i = 1:size(TcbSub1, 2)
    TransT12(i, i) = 1;
end
Texpand1 = TransT11*TcbSub1*TransT12;
TransT21 = sparse(Tzeilen, size(TcbSub2, 1));
TransT22 = sparse(size(TcbSub2, 2), Tspalten);
for i = 1:DoF_Main
    TransT21(i, i) = 1;
end
for i = 1:(size(TcbSub2, 1)-DoF_Main)
    TransT21(size(TcbSub1, 1)+i, DoF_Main+i) = 1;
end
for i = 1:DoF_Main
    TransT22(i, i) = 1;
end
for i = 1:(size(TcbSub2, 2)-DoF_Main)
    TransT22(DoF_Main+i, size(TcbSub1, 2)+i) = 1;
end
Texpand2 = TransT21*TcbSub2*TransT22;
% Zusammenbau T
Tgesexp = Texpand1 + Texpand2;
for i = 1:DoF_Main
    Tgesexp(i, i) = 1;
end

% % Bauweise 2: Stückweise Bauen (zur Überprüfung)
% % erstellen Teil Obenrechts: Nullstück
% T12 = zeros(size(TcbSub1, 1), (size(TcbSub2, 2)-DoF_Main));
% % erstellen Teil Untenlinks: statische Moden aus TcbSub2
% T21_1 = TcbSub2((DoF_Main+1):size(TcbSub2, 1), 1:DoF_Main);
% % erstellen Teil Untenmitte: Nullstück
% T21_2 = zeros((size(TcbSub2, 1)-DoF_Main), (size(TcbSub1, 2)-DoF_Main));
% % erstellen Teil Untenrechts: fixed Interface Moden aus TcbSub2
% T22 = TcbSub2((DoF_Main+1):size(TcbSub2, 1), (DoF_Main+1):size(TcbSub2, 2));
% % Zusammenbau
% Tges = [TcbSub1, T12; T21_1, T21_2, T22];

% Zusammenbau Mass, SteifMat
% Dimension bestimmen
DimA = Tspalten;
% TransformationsMat bestimmen
Trans1 = sparse(DimA, size(McbSub1, 1));
for i = 1:size(McbSub1, 1)
    Trans1(i, i) = 1;
end
Trans2 = sparse(DimA, size(McbSub2, 1));
for i = 1:DoF_Main
    Trans2(i, i) = 1;
end
for i = 1:(size(McbSub2, 1)-DoF_Main)
    Trans2(i+size(McbSub1, 1), i+DoF_Main) = 1;
end
% Zusammenbau
Mges = Trans1*McbSub1*Trans1.' + Trans2*McbSub2*Trans2.';
Kges = Trans1*KcbSub1*Trans1.' + Trans2*KcbSub2*Trans2.';
end

