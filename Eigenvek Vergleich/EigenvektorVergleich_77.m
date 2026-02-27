function [ELEMENT_eigenvectors, element_eigenvec_interp, MAC_matrix] = EigenvektorVergleich_77(file_ELEMENT_prefix, num_ELEMENT_files, file_element_prefix, num_element_files)
%% 特征向量插值处理后对比(粗网格数据7列，细网格数据7列)
%% 粗网格特征向量处理
% 粗网格特征向量文件前缀和文件数量
file_ELEMENT_suffix = '.txt';

fprintf('\n进入粗网格特征向量处理\n');

% 预分配 cell 数组存储每个向量（因为初始不知道向量长度）
eigenvec_ELEMENT_cell = cell(num_ELEMENT_files, 1);

for i = 1:num_ELEMENT_files
    % 构建文件名，例如 Gitter_5mm_Eigenvek_1.txt
    filename = [file_ELEMENT_prefix, num2str(i), file_ELEMENT_suffix];

    % 读取数据，跳过第一行表头
    data = readmatrix(filename, 'NumHeaderLines', 1);

    % 提取节点编号，坐标和位移
    node_ids = data(:, 1);
    coordinates = data(:, 2:4);
    displacements = data(:, 5:7);

    % 按节点编号升序排序
    [~, sort_idx] = sort(node_ids);
    sorted_displacements = displacements(sort_idx, :);
    
    % 节点坐标验证
    if i==1
        sorted_coordinates = coordinates(sort_idx, :);
    else
        temp_coordinates = coordinates(sort_idx, :);
        issame = isequal(sorted_coordinates, temp_coordinates);
        if issame == false
            break;
        end
    end
    
    % 转为目标向量形式：[x1,y1,z1,x2,y2,z2,...]
    eigenvec = reshape(sorted_displacements.', 1, []);  % 行向量

    % 存入 cell 中
    eigenvec_ELEMENT_cell{i} = eigenvec;
    fprintf('第%d个粗网格特征向量已被存入\n', i);
end

% 将所有向量合并成矩阵（每一行对应一个模态向量）
% 注意：确保每个向量长度相同
ELEMENT_eigenvectors = cell2mat(eigenvec_ELEMENT_cell);

% 按xyz提取粗网格节点坐标
X_coarse_mesh = sorted_coordinates(:, 1);
Y_coarse_mesh = sorted_coordinates(:, 2);
Z_coarse_mesh = sorted_coordinates(:, 3);

%% 细网格特征向量插值处理

fprintf('\n进入细网格特征向量处理\n');

% 细网格特征向量文件前缀和文件数量
file_element_suffix = '.txt';

% 预分配 cell 数组存储每个向量（因为初始不知道向量长度）
eigenvec_element_cell = cell(num_element_files, 1);

for i = 1:num_element_files
    % 构建文件名
    filename = [file_element_prefix, num2str(i), file_element_suffix];

    % 读取数据，跳过第一行表头
    data = readmatrix(filename, 'NumHeaderLines', 1);

    % 提取节点编号，坐标和位移
    coordinates = data(:, 2:4);
    displacements = data(:, 5:7);
    
    % 提取细网格节点坐标
    x_fine_mesh = coordinates(:, 1);
    y_fine_mesh = coordinates(:, 2);
    z_fine_mesh = coordinates(:, 3);

    % 提取细网格节点位移
    Ux_fine_mesh = displacements(:, 1);
    Uy_fine_mesh = displacements(:, 2);
    Uz_fine_mesh = displacements(:, 3);
    tic
    % 构建插值器
    F_Ux = scatteredInterpolant(x_fine_mesh, y_fine_mesh, z_fine_mesh, Ux_fine_mesh, 'linear', 'linear');
    F_Uy = scatteredInterpolant(x_fine_mesh, y_fine_mesh, z_fine_mesh, Uy_fine_mesh, 'linear', 'linear');
    F_Uz = scatteredInterpolant(x_fine_mesh, y_fine_mesh, z_fine_mesh, Uz_fine_mesh, 'linear', 'linear');
    
    % 插值
    Ux_interp = F_Ux(X_coarse_mesh, Y_coarse_mesh, Z_coarse_mesh);
    Uy_interp = F_Uy(X_coarse_mesh, Y_coarse_mesh, Z_coarse_mesh);
    Uz_interp = F_Uz(X_coarse_mesh, Y_coarse_mesh, Z_coarse_mesh);
    toc
    % tic
    % Ux_interp = griddata(x_fine_mesh, y_fine_mesh, z_fine_mesh, Ux_fine_mesh, X_coarse_mesh, Y_coarse_mesh, Z_coarse_mesh, 'linear');
    % Uy_interp = griddata(x_fine_mesh, y_fine_mesh, z_fine_mesh, Uy_fine_mesh, X_coarse_mesh, Y_coarse_mesh, Z_coarse_mesh, 'linear');
    % Uz_interp = griddata(x_fine_mesh, y_fine_mesh, z_fine_mesh, Uz_fine_mesh, X_coarse_mesh, Y_coarse_mesh, Z_coarse_mesh, 'linear');
    % toc

    displacements_interp = zeros(length(Ux_interp), 3);
    displacements_interp(:, 1) = Ux_interp;
    displacements_interp(:, 2) = Uy_interp;
    displacements_interp(:, 3) = Uz_interp;
    
    eigenvec_interp = reshape(displacements_interp.', 1, [] );
    eigenvec_element_cell{i} = eigenvec_interp;
    fprintf('第%d个细网格特征向量已被插值简化并存入\n', i);
end

element_eigenvec_interp = cell2mat(eigenvec_element_cell);

%% Eigenvektor vergleichen

fprintf('\n进入特征向量相似性验证\n');

% Modal ensurence criterion
MAC_matrix = zeros(num_element_files);
for i = 1:1:num_element_files
    for j = 1:1:num_element_files
        MAC_matrix(i, j) = (dot(element_eigenvec_interp(i, :), ELEMENT_eigenvectors(j, :)))^2/dot(element_eigenvec_interp(i, :), element_eigenvec_interp(i, :))/dot(ELEMENT_eigenvectors(j, :), ELEMENT_eigenvectors(j, :));
        fprintf('MAC矩阵第%d行, %d列元素已被计算完成\n', i, j);
    end
end

%Visualisierung
imagesc(MAC_matrix);          % 显示矩阵图像
colormap(jet);  % 从蓝（小）到红（大）
colorbar;            % 显示颜色条
caxis([0 1]);        % 固定颜色范围为 0 到 1
title('Übereinstimmungsquoten Eigenvektor');

%Speichern
% save('element_eigenvec_interp.mat','element_eigenvec_interp')
% save('ELEMENT_eigenvectors.mat','ELEMENT_eigenvectors')

%vek1 = element_eigenvec_interp(1, :);
%vek2 = ELEMENT_eigenvectors(1, :);
%MAC_quote = (dot(vek1, vek2))^2/dot(vek1, vek1)/dot(vek2, vek2);
end

