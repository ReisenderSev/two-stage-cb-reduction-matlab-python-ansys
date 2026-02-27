# setting number of User Defined Result_UVECTORS
num_results = 26
folder_path = 'C:\Leibniz Uni\Studienarbeit\Saeule_Test\Seaule_2mm_mesh_files\dp0\SYS-2'
mesh_mm = 2
mesh_methode = 2 #1#2#3

if mesh_methode == 1:
    mesh_methode = 'HexDom'
elif mesh_methode == 2:
    mesh_methode = 'TetraDom'
elif mesh_methode == 3:
    mesh_methode = 'selfdefinedmesh'

mesh_str = '{}mm'.format(mesh_mm)

mesh_coordinates_files = 'Gitter_{}_'.format(mesh_str) + mesh_methode + '_Knoten_Koordinaten.txt'
eigenvek_file_template = 'Gitter_{}_'.format(mesh_str) + mesh_methode + '_Eigenvek_{}.txt'

output_path_nodes = folder_path + '\\' + mesh_coordinates_files
output_path_eigenvek = folder_path + '\\' + eigenvek_file_template

MeshInfo = DataModel.MeshDataByName('Global')
nodes = MeshInfo.Nodes

with open(output_path_nodes, 'w') as file:
    file.write('{:<12} {:<15} {:<15} {:<15}\n'.format('Node_Number', 'X_Coordinate', 'Y_Coordinate', 'Z_Coordinate'))
    for node in nodes:
        file.write('{} {} {} {}\n'.format(node.Id, node.X, node.Y, node.Z))

# get Solution 
sol = Model.Analyses[0].Solution

# establish User Defined Results for Eigenvectors
for i in range(num_results):
    result = sol.AddUserDefinedResult()
    result.Expression = 'UVECTORS'
    result.SetNumber = i + 1
    result.Name = "User_Defined_Result_{}".format(i + 1)

# Evaluate all Results
sol.EvaluateAllResults()

# Export User Defined Results in xls/txt
# find Start-Index by Name 'User_Defined_Result_1'
start_index = None
for i, child in enumerate(sol.Children):
    if child.Name == "User_Defined_Result_1":
        start_index = i
        break

# possible Error Info
if start_index is None:
    raise Exception("No User_Defined_Result_1 was found in Solution.Children")

# Export
for i in range(num_results):
    result = sol.Children[start_index + i]
    file_path = output_path_eigenvek.format(i + 1)
    result.ExportToTextFile(file_path)
