Eigenmat8021 = load('Eigenvekmatrix_2.1mm(grob_8mm_fein_2.1mm).mat');
Eigenmat5021 = load('Eigenvekmatrix_2.1mm(grob_5mm_fein_2.1mm).mat');
Eigenmat3021 = load('Eigenvekmatrix_2.1mm(grob_3mm_fein_2.1mm).mat');
Eigenmat8025 = load('Eigenvekmatrix_2.5mm(grob_8mm_fein_2.5mm).mat');
Eigenmat8024 = load('Eigenvekmatrix_2.4mm(grob_8mm_fein_2.4mm).mat');
Eigenmat8023 = load('Eigenvekmatrix_2.3mm(grob_8mm_fein_2.3mm).mat');
Eigenmat8022 = load('Eigenvekmatrix_2.2mm(grob_8mm_fein_2.2mm).mat');
Eigenmat80 = load('Eigenvekmatrix_8mm(grob_8mm_fein_2.1mm).mat');
Eigenmat50 = load('Eigenvekmatrix_5mm(grob_5mm_fein_2.1mm).mat');
Eigenmat30 = load('Eigenvekmatrix_3mm(grob_3mm_fein_2.1mm).mat');
Eigenvek_80_21 = single(Eigenmat8021.Eigenvek_fein);
Eigenvek_50_21 = single(Eigenmat5021.Eigenvek_fein);
Eigenvek_30_21 = single(Eigenmat3021.Eigenvek_fein);
Eigenvek_80_25 = single(Eigenmat8025.Eigenvek_grob);
Eigenvek_80_24 = single(Eigenmat8024.Eigenvek_grob);
Eigenvek_80_23 = single(Eigenmat8023.Eigenvek_grob);
Eigenvek_80_22 = single(Eigenmat8022.Eigenvek_grob);
Eigenvek_80 = single(Eigenmat80.Eigenvek_grob);
Eigenvek_50 = single(Eigenmat50.Eigenvek_grob);
Eigenvek_30 = single(Eigenmat30.Eigenvek_grob);
%% MAC(8mm_2.1mm)
MAC_80_21 = MAC(Eigenvek_80, Eigenvek_80_21);
%% MAC(5mm_2.1mm)
MAC_50_21 = MAC(Eigenvek_50, Eigenvek_50_21);
%% MAC(3mm_2.1mm)
MAC_30_21 = MAC(Eigenvek_30, Eigenvek_30_21);
%% MAC(2.5mm_2.1mm)
MAC_25_21 = MAC(Eigenvek_80_25, Eigenvek_80_21);
%% MAC(2.4mm_2.1mm)
MAC_24_21 = MAC(Eigenvek_80_24, Eigenvek_80_21);
%% MAC(2.3mm_2.1mm)
MAC_23_21 = MAC(Eigenvek_80_23, Eigenvek_80_21);
%% MAC(2.2mm_2.1mm)
MAC_22_21 = MAC(Eigenvek_80_22, Eigenvek_80_21);