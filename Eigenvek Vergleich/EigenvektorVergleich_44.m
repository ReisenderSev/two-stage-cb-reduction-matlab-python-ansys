function [ELEMENT_eigenvectors, element_eigenvec_interp, MAC_matrix] = EigenvektorVergleich_44(file_ELEMENT_prefix, num_ELEMENT_files, file_ELEMENT_nodes_coordinate, file_element_prefix, num_element_files, file_element_nodes_coordinate)
%% 特征向量插值处理后对比(粗网格数据4列，细网格数据4列)
%% 粗网格特征向量处理
% 粗网格特征向量文件前缀和文件数量
file_ELEMENT_suffix = '.txt';

fprintf('\n进入粗网格特征向量处理阶段\n')
% replace all , with .
txt = fileread(file_ELEMENT_nodes_coordinate);
txt = strrep(txt, ',', '.');
fid = fopen(file_ELEMENT_nodes_coordinate, 'w');
fwrite(fid, txt);
fclose(fid);
data = readmatrix(file_ELEMENT_nodes_coordinate, 'NumHeaderLines', 1);
% 节点编号 X Y Z 
node_ids = data(:, 1);
coordinates = data(:, 2:4); 
[~, sort_idx] = sort(node_ids);
sorted_coordinates = coordinates(sort_idx, :);

% 预分配 cell 数组存储每个向量（因为初始不知道向量长度）
eigenvec_ELEMENT_cell = cell(num_ELEMENT_files, 1);

for i = 1:num_ELEMENT_files
    % 构建文件名，例如 Gitter_5mm_Eigenvek_1.txt
    filename = [file_ELEMENT_prefix, num2str(i), file_ELEMENT_suffix];

    % replace all , with .
    txt = fileread(filename);
    txt = strrep(txt, ',', '.');
    fid = fopen(filename, 'w');
    fwrite(fid, txt);
    fclose(fid);

    % 读取数据，跳过第一行表头
    data = readmatrix(filename, 'NumHeaderLines', 1);

    % 提取节点编号和位移
    node_ids = data(:, 1);
    displacements = data(:, 2:4);

    % 按节点编号升序排序
    [~, sort_idx] = sort(node_ids);
    sorted_displacements = displacements(sort_idx, :);
    
    % 转为目标向量形式：[x1,y1,z1,x2,y2,z2,...]
    eigenvec = reshape(sorted_displacements.', 1, []);  % 行向量

    % 存入 cell 中
    eigenvec_ELEMENT_cell{i} = single(eigenvec);
    fprintf('第%d个粗网格特征向量已被排序并存储\n', i);
end

% 将所有向量合并成矩阵（每一行对应一个模态向量）
% 注意：确保每个向量长度相同
ELEMENT_eigenvectors = cell2mat(eigenvec_ELEMENT_cell);

% 按xyz提取粗网格节点坐标
X_coarse_mesh = sorted_coordinates(:, 1);
Y_coarse_mesh = sorted_coordinates(:, 2);
Z_coarse_mesh = sorted_coordinates(:, 3);

%% 细网格特征向量插值处理
% 细网格特征向量文件前缀和文件数量
file_element_suffix = '.txt';

fprintf('\n进入细网格特征向量处理阶段\n')
% replace all , with .
txt = fileread(file_element_nodes_coordinate);
txt = strrep(txt, ',', '.');
fid = fopen(file_element_nodes_coordinate, 'w');
fwrite(fid, txt);
fclose(fid);
data = readmatrix(file_element_nodes_coordinate, 'NumHeaderLines', 1);
% 节点编号 X Y Z 
node_ids = data(:, 1);
coordinates = data(:, 2:4);
[~, sort_idx] = sort(node_ids);
sorted_coordinates = coordinates(sort_idx, :);

% 预分配 cell 数组存储每个向量（因为初始不知道向量长度）
eigenvec_element_cell = cell(num_element_files, 1);

for i = 1:num_element_files
    % 构建文件名
    filename = [file_element_prefix, num2str(i), file_element_suffix];

    % replace all , with .
    txt = fileread(filename);
    txt = strrep(txt, ',', '.');
    fid = fopen(filename, 'w');
    fwrite(fid, txt);
    fclose(fid);

    % 读取数据，跳过第一行表头
    data = readmatrix(filename, 'NumHeaderLines', 1);

    % 提取节点编号和位移
    node_ids = data(:, 1);
    displacements = data(:, 2:4);
    [~, sort_idx] = sort(node_ids);
    sorted_displacements = displacements(sort_idx, :);
    
    % 提取细网格节点坐标
    x_fine_mesh = sorted_coordinates(:, 1);
    y_fine_mesh = sorted_coordinates(:, 2);
    z_fine_mesh = sorted_coordinates(:, 3);

    % 提取细网格节点位移
    Ux_fine_mesh = sorted_displacements(:, 1);
    Uy_fine_mesh = sorted_displacements(:, 2);
    Uz_fine_mesh = sorted_displacements(:, 3);
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
    displacements_interp = zeros(length(Ux_interp), 3);
    displacements_interp(:, 1) = Ux_interp;
    displacements_interp(:, 2) = Uy_interp;
    displacements_interp(:, 3) = Uz_interp;
    
    eigenvec_interp = reshape(displacements_interp.', 1, [] );
    eigenvec_element_cell{i} = single(eigenvec_interp);
    fprintf('第%d个细网格特征向量已被插值并存储\n', i);
end

element_eigenvec_interp = cell2mat(eigenvec_element_cell);

%% Eigenvektor vergleichen
% Modal ensurence criterion
fprintf('\n进入MAC矩阵生成\n');
MAC_matrix = zeros(num_element_files, num_ELEMENT_files);
for i = 1:1:num_element_files
    for j = 1:1:num_ELEMENT_files
        MAC_matrix(i, j) = (dot(element_eigenvec_interp(i, :), ELEMENT_eigenvectors(j, :)))^2/dot(element_eigenvec_interp(i, :), element_eigenvec_interp(i, :))/dot(ELEMENT_eigenvectors(j, :), ELEMENT_eigenvectors(j, :));
        fprintf('MAC矩阵第%d行%d列的值已被计算完成\n', i, j);
    end
end

% imagesc(MAC_matrix);          % 显示矩阵图像
% colormap(jet);  % 从蓝（小）到红（大）
% colorbar;            % 显示颜色条
% caxis([0 1]);        % 固定颜色范围为 0 到 1
% title('Übereinstimmungsquoten Eigenvektor');


%vek1 = element_eigenvec_interp(1, :);
%vek2 = ELEMENT_eigenvectors(1, :);
%MAC_quote = (dot(vek1, vek2))^2/dot(vek1, vek1)/dot(vek2, vek2);
end

