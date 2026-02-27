function [MAC_Matrix] = MAC(Matrix_1, Matrix_2)
[Reihen_1, ~] = size(Matrix_1);
[Reihen_2, ~] = size(Matrix_2);
MAC_Matrix = zeros(Reihen_1, Reihen_2);
for i = 1:1:Reihen_1
    for j = 1:1:Reihen_2
        MAC_Matrix(i, j) = (dot(Matrix_1(i, :), Matrix_2(j, :)))^2/dot(Matrix_1(i, :), Matrix_1(i, :))/dot(Matrix_2(j, :), Matrix_2(j, :));
        fprintf('MAC矩阵第%d行, %d列元素已被计算完成\n', i, j);
    end
end

%Visualisierung
figure;
imagesc(MAC_Matrix);          % 显示矩阵图像
colormap(jet);  % 从蓝（小）到红（大）
colorbar;            % 显示颜色条
caxis([0 1]);        % 固定颜色范围为 0 到 1
title('Übereinstimmungsquoten Eigenvektor');
end

