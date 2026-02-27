### Python Script for Export all Vectors and Mass- und StiffMat of all Substructures
### Parameter setting
NumGeoComponents = 15
NumModes = 1 
NameComponents = """SubGeo{0}"""
NameJobSubstruc = """Modal Substructure{0}"""
SavePath = r"""C:\Leibniz_Uni\Studienarbeit\Referenzmodell_Ultraschallsys"""
APDLScriptInhalte = """/aux2 
*smat, WBMsub{0}, d, import, full, file.full, mass, , 
*smat, WBKsub{0}, d, import, full, file.full, stiff, , 
*vec, WBMapbacksub{0}, i, import, full, file.full, back
*export, WBMsub{0}, mmf, {1}\\Msub{0}.mmf
*export, WBKsub{0}, mmf, {1}\\Ksub{0}.mmf
*export, WBMapbacksub{0}, mmf, {1}\\Mapbacksub{0}.mmf
finish"""
### obtain the list of Ids of all bodies
ModelAssembly = DataModel.GeoData.Assemblies[0]
ModelPart = ModelAssembly.Parts[0]
BodyIdList = []
for ModelBody in ModelPart.Bodies:
    BodyIdList.append(ModelBody.Id)
### the fist overall modal analyse for export of vectors
ModalAnalyse = Model.Analyses[0]
ModalAnalyse.Name = r"""Modal Complete Part"""
ModalAnalyseSetting = ModalAnalyse.Children[1]
ModalAnalyseSetting.MaximumModesToFind = NumModes
ModalAnalyseSetting.SolverType = SolverType.Direct
ModalAnalyseSetting.SaveMAPDLDB = True
ModalAnalyseSetting.DeleteUnneededFiles = False
ModalAnalyseSolution = ModalAnalyse.Solution
APDLScript = ModalAnalyseSolution.AddCommandSnippet()
APDLScript.Input = """/aux2
! MainKnoten von InternInterface
nsel, s, node, , MainNodeIntern
*vget, ArrayMainNodeIntern, node, , nlist
*vec, VecMainNodeIntern, i, import, apdl, ArrayMainNodeIntern
*export, VecMainNodeIntern, mmf, {0}\\VecMainIntern.mmf
! MainKnoten von ExternInterface
nsel, s, node, , MainNodeExtern
*vget, ArrayMainNodeExtern, node, , nlist
*vec, VecMainNodeExtern, i, import, apdl, ArrayMainNodeExtern
*export, VecMainNodeExtern, mmf, {0}\\VecMainExtern.mmf
! MainKnoten von Adap_Trans_Interface
nsel, s, node, , MainNodeInterTrAd
*vget, ArrayMainNodeTrAd, node, , nlist
*vec, VecMainNodeTrAd, i, import, apdl, ArrayMainNodeTrAd
*export, VecMainNodeTrAd, mmf, {0}\\VecMainTrAd.mmf
finish""".format(SavePath)
APDLScript.Name = r"""VecExport"""
for resultnum in range(NumModes):
    result = ModalAnalyseSolution.AddTotalDeformation()
    result.SetNumber = resultnum + 1
    result.Name = "TotalDeformation{}".format(resultnum+1)
ModalAnalyseSolution.Solve(True)
ModalAnalyseSolution.EvaluateAllResults()
### start modal analyse for substructures
for k in range(NumGeoComponents):
    ### add modal analyse for substructure
    Model.AddModalAnalysis()
    ### unsuppress all bodies
    Model.Geometry.UnsuppressAllBodies()
    ### save the bodyIds of selected component (substructure) in a list 
    SelComponents = Model.NamedSelections
    for i, component in enumerate(SelComponents.Children):
        if component.Name == NameComponents.format(k+1):
            SelBodyId = component.Location.Ids
            break
    ### find the Id of bodies which need to be suppressed
    SuppressBodyIdList = list(set(BodyIdList) - set(SelBodyId))
    ### suppress bodies
    with Transaction(True):
        for suppressed_body_id in SuppressBodyIdList:
            BodySuppressed = DataModel.GeoData.GeoEntityById(suppressed_body_id)
            SuppBodyonTree = Model.Geometry.GetBody(BodySuppressed)
            SuppBodyonTree.Suppressed = True
    ### find current analyse
    ModalAnalyse = Model.Analyses[k+1]
    ### rename job
    ModalAnalyse.Name = NameJobSubstruc.format(k+1)
    ### find 'analyse setting' through the second tree branch: Children[1]
    ModalAnalyseSetting = ModalAnalyse.Children[1]
    ### several settings to the modal analyse
    ModalAnalyseSetting.MaximumModesToFind = NumModes
    ModalAnalyseSetting.SolverType = SolverType.Direct
    ModalAnalyseSetting.SaveMAPDLDB = True
    ModalAnalyseSetting.DeleteUnneededFiles = False
    ### add the apdl command and analyse results to the modal analyse
    ModalAnalyseSolution = ModalAnalyse.Solution
    APDLScript = ModalAnalyseSolution.AddCommandSnippet()
    APDLScript.Input = APDLScriptInhalte.format(k+1, SavePath)
    APDLScript.Name = r"""MatExport"""
    for resultnum in range(NumModes):
        result = ModalAnalyseSolution.AddTotalDeformation()
        result.SetNumber = resultnum + 1
        result.Name = "TotalDeformation{}".format(resultnum+1)
    ### execute the analyse
    ModalAnalyseSolution.Solve(True)
    ### evaluate all the results
    ModalAnalyseSolution.EvaluateAllResults()
### unsuppress all bodies
Model.Geometry.UnsuppressAllBodies()


