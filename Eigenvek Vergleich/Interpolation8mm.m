function [element_eigenvec_interp] = Interpolation8mm(file_element_prefix, num_element_files)
%% 特征向量插值(8mm网格)
%% 8mm网格节点坐标
% 粗网格特征向量文件前缀和文件数量
file_ELEMENT_nodes_coordinate = 'Gitter_8mm_Knoten_Koordinaten.txt';
fprintf('\n进入8mm网格节点坐标存入阶段\n')
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
% 按xyz提取粗网格节点坐标
X_coarse_mesh = sorted_coordinates(:, 1);
Y_coarse_mesh = sorted_coordinates(:, 2);
Z_coarse_mesh = sorted_coordinates(:, 3);
%% 网格特征向量插值处理

fprintf('\n进入细网格特征向量处理\n');

% 细网格特征向量文件前缀和文件数量
file_element_suffix = '.txt';

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

    % 提取节点编号，坐标和位移
    %node_ids = data(:, 1);
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
    displacements_interp = zeros(length(Ux_interp), 3);
    displacements_interp(:, 1) = Ux_interp;
    displacements_interp(:, 2) = Uy_interp;
    displacements_interp(:, 3) = Uz_interp;
    
    eigenvec_interp = reshape(displacements_interp.', 1, [] );
    eigenvec_element_cell{i} = single(eigenvec_interp);
    fprintf('第%d个细网格特征向量已被插值简化并存入\n', i);
end

element_eigenvec_interp = cell2mat(eigenvec_element_cell);

end