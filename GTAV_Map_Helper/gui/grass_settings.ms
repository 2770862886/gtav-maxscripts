try(destroyDialog GrassInstance_Rollout )catch()
fileIn (scriptspath+"\\GTAV_Map_Helper\\ymap\\instancedData.ms")

clearlistener()
actionMan.executeAction 0 "40472"
format "Instanced Grass Painter\n\nHow to use the script:\nClick on the button to import the assets and wait until they are loaded.\n\nSelect the meshes you want to paint over, select the archetypeName and click on 'Enable Paint' to start painting.\nClick again on 'Enable Paint' to close the current batch. Repeat these steps for each batch.\nWhen you finish, select the root dummies of the batches, customize your setting for both batches and instances and click 'Add Batches'.\nThe chosen settings will be used for all the selected batches when you add them.\nClick 'Reset' if you want to reset the batches you collected in the exporter.\nTo export the .ymap.xml file just click on 'Export .ymap.xml'\n\nNOTE: This is a beta script, it may crash.\n\n"
format "WIP:\n-Display the chosen color as tint over the meshes of the instances\n-Allow brush settings customization linked to instances settings (size,density, etc)\n"

GrassInstanceList = #()
global assetsPath = (scriptspath+"\\GTAV_Map_Helper\\assets\\v_proc1\\")
global BatchSettings = #()
global InstanceSettings = #()
global batchDummy

--TODO: CREATE A COPY FOR EACH BATCH THEN INSTANCES INSIDE THAT BATCH
--TODO: LINK COLOR OF INSTANCES TO A TINT TO BE ADDED TO THE MATERIAL (TO PREVIEW IT)

fn CalculateBoundBoxFromChildren dummyBox =
(
	--TEMPORARY STUPID THING BECAUSE I DIDN'T MANAGE TO EDIT THE PARENT NODE WITHOUT AFFECTING CHILDREN
	local oldSelection = getCurrentSelection()
	select dummyBox.children
	local batchCenter = selection.center
	local boxsize = selection.max  - selection.min
				
	local tmp = dummy()
	tmp.name = dummyBox.name
	tmp.position = batchCenter
	tmp.boxsize = boxsize
	
	for child in dummyBox.children do child.parent = tmp
	dummyBox.position = batchCenter
	dummyBox.boxsize = boxsize
	for child in tmp.children do child.parent = dummyBox
	
	delete tmp
	select oldSelection
)

fn InstanceDataFromFaces obj faces =
(
	for face in faces do
	(
		local grassDir = polyop.getFaceNormal obj face	
		local grassPos = polyop.getFaceCenter obj face
		local grassMesh = InstanceGrassAsset BatchSettings[2]

		grassMesh.pos = grassPos
		grassMesh.dir = grassDir
		grassMesh.parent = batchDummy
	)
)

fn InstanceGrassAsset grassName =
(
	if(getnodebyname(grassName) != undefined) then
	(
		local selectedNode = getnodebyname(grassName)
		maxOps.CloneNodes selectedNode expandHierarchy:false cloneType:#instance newNodes:&grassMesh
		grassMesh.name = grassName
	)
	else(format "Mesh named % not found in scene.\n" (grassName as string))
	return grassMesh
)

fn ImportInstancedGrassAssets grassName =
(	
	if(getnodebyname(grassName) == undefined) then
	(
		local filePath = (assetsPath + (grassName as string) + ".FBX")
		importFile  filePath #noPrompt using:FBXIMP
		format "FBX Importer: % imported.\n" (filePath)
		local grassMesh = getnodebyname(grassName)
		local assetsDummy = getnodebyname("v_proc1")
		grassMesh.parent = assetsDummy
	)else	(format "FBX Importer: % already in scene.\n" (grassName as string))
)

fn PaintGrass = 
(
	try
	(
		with redraw off
		(
			localHit = Point3 0 0 0
			localNormal = Point3 0 0 0
			worldHit = Point3 0 0 0
			worldNormal = Point3 0 0 0
			str = 0.0f
			radius = 0.0f
				
			thePainterInterface.getHitPointData &localHit &localNormal &worldHit &worldNormal &radius &str 0
			hit = thePainterInterface.getIsHit 0
			
			if (hit) then
			( 
				local grassMesh = InstanceGrassAsset BatchSettings[2]
				grassMesh.pos = worldHit
				grassMesh.dir = worldNormal
				grassMesh.parent = batchDummy
			)
		)
	)
	catch
	(
		print (getCurrentException())
	)
)

--PAINT FUNCTIONS
fn StartPaintGrass = ( thePainterInterface.undoStart() )
fn EndPaintGrass = ()
fn CancelPaintGrass = print "Cancel Paint Grass"
fn systemEnd  = print "SystemEnd"
	


rollout GrassInstance_Rollout "Instanced Grass Painter" width:504 height:480
(
	GroupBox 'grp1' "Batch Settings" pos:[8,8] width:240 height:300 align:#left
	dropdownList 'Batch_archetypeName' "archetypeName(v_proc1):" pos:[13,26] width:155 height:40 items:#("proc_brittlebush_01", "proc_desert_sage_01", "proc_drygrasses01", "proc_drygrasses01b", "proc_drygrassfronds01", "proc_dryplantsgrass_01", "proc_dryplantsgrass_02", "proc_dry_plants_01", "proc_forest_grass01", "proc_forest_ivy_01", "proc_grassdandelion01", "proc_grasses01", "proc_grasses01b", "proc_grassfronds01", "proc_grassplantmix_01", "proc_grassplantmix_02", "proc_indian_pbrush_01", "proc_leafybush_01", "proc_leafyplant_01", "proc_lizardtail_01", "proc_lupins_01", "proc_meadowmix_01", "proc_meadowpoppy_01", "proc_sage_01", "proc_scrub_bush01", "proc_sml_reeds_01", "proc_sml_reeds_01b", "proc_sml_reeds_01c", "proc_stones_01", "proc_stones_02", "proc_stones_03", "proc_stones_04", "proc_stones_05", "proc_stones_06", "proc_wildquinine", "prop_dandy_b", "prop_dryweed_001_a", "prop_dryweed_002_a", "prop_fernba", "prop_fernbb", "prop_flowerweed_005_a", "prop_grass_001_a", "prop_grass_ca", "prop_grass_da", "prop_log_aa", "prop_log_ab", "prop_log_ac", "prop_log_ad", "prop_log_ae", "prop_log_af", "prop_saplin_001_b", "prop_saplin_001_c", "prop_saplin_002_b", "prop_saplin_002_c", "prop_small_bushyba", "prop_tall_drygrass_aa", "prop_tall_grass_ba", "prop_thindesertfiller_aa", "prop_weed_001_aa", "prop_weed_002_ba", "urbandryfrnds_01", "urbandrygrass_01", "urbangrnfrnds_01", "urbangrngrass_01", "urbanweeds01", "urbanweeds01_l1", "urbanweeds02", "urbanweeds02_l1") align:#left
	checkbox 'Batch_archetypeName_random' "Random" pos:[176,48] width:64 height:15 checked:false align:#left
			
	spinner 'Batch_ScaleRangeX' "ScaleRange X:" pos:[16,80] width:80 height:16 range:[0,100,0.6] type:#float align:#left
	checkbox 'Batch_ScaleRangeX_random' "Random" pos:[176,80] width:64 height:15 align:#left
	spinner 'Batch_ScaleRangeY' "ScaleRange Y:" pos:[16,112] width:80 height:16 range:[0,100,2.3] type:#float align:#left
	checkbox 'Batch_ScaleRangeY_random' "Random" pos:[176,112] width:64 height:15 align:#left
	spinner 'Batch_ScaleRangeZ' "ScaleRange Z:" pos:[16,144] width:80 height:16 range:[0,100,0.2] type:#float align:#left
	checkbox 'Batch_ScaleRangeZ_random' "Random" pos:[176,144] width:64 height:15 align:#left
	spinner 'Batch_lodDist' "lodDist:" pos:[16,176] width:117 height:16 range:[0,100,40] type:#integer align:#left
	checkbox 'Batch_lodDist_random' "Random" pos:[176,176] width:64 height:15 align:#left	
	
	
	spinner 'Batch_LodFadeStartDist' "LodFadeStartDist:" pos:[16,208] width:67 height:16 range:[0,100,20] type:#float align:#left
	checkbox 'Batch_LodFadeStartDist_random' "Random" pos:[176,208] width:64 height:15 align:#left
	spinner 'Batch_LodInstFadeRange' "LodInstFadeRange:" pos:[16,240] width:58 height:16 range:[0,100,0.75] type:#float align:#left
	checkbox 'Batch_LodInstFadeRange_random' "Random" pos:[176,240] width:64 height:15 align:#left
	spinner 'Batch_OrientToTerrain' "OrientToTerrain:" pos:[16,272] width:75 height:16 range:[0,100,1] type:#float align:#left
	checkbox 'Batch_OrientToTerrain_random' "Random" pos:[176,272] width:64 height:15 checked:false align:#left
	
	GroupBox 'grp2' "Instances Settings" pos:[256,8] width:240 height:300 align:#left
	spinner 'Instances_Scale' "Scale:" pos:[264,32] width:114 height:16 range:[0,255,1] type:#integer align:#left
	checkbox 'Instances_Scale_random' "Random" pos:[424,32] width:64 height:15 checked:true align:#left
	spinner 'Instances_ColorR' "Color R:" pos:[264,64] width:106 height:16 range:[0,255,0] type:#integer align:#left
	checkbox 'Instances_ColorR_random' "Random" pos:[424,64] width:64 height:15 checked:true align:#left
	spinner 'Instances_ColorG' "Color G:" pos:[264,96] width:106 height:16 range:[0,255,0] type:#integer align:#left
	checkbox 'Instances_ColorG_random' "Random" pos:[424,96] width:64 height:15 checked:true align:#left
	spinner 'Instances_ColorB' "Color B:" pos:[264,128] width:107 height:16 range:[0,255,0] type:#integer align:#left
	checkbox 'Instances_ColorB_random' "Random" pos:[424,128] width:64 height:15 checked:true align:#left
	spinner 'Instances_Ao' "Ao:" pos:[264,160] width:128 height:16 range:[0,255,255] type:#integer align:#left
	spinner 'Instances_PadX' "Pad X:" pos:[264,192] width:112 height:16 range:[0,255,0] type:#integer align:#left
	spinner 'Instances_PadY' "Pad Y:" pos:[264,224] width:112 height:16 range:[0,255,0] type:#integer align:#left
	spinner 'Instances_PadZ' "Pad Z:" pos:[264,256] width:112 height:16 range:[0,255,0] type:#integer align:#left
	
	checkbutton 'btn_grassymap_paint' "Enable Paint" pos:[12,320] width:232 height:21 checked:false align:#left
	button 'btn_grassymap_addbatch' "Add Batch" pos:[12,352] width:232 height:21 align:#left
	button 'btn_grassymap_export' "Export .ymap.xml" pos:[12,384] width:232 height:21 align:#left
	button 'btn_grassymap_reset' "Reset" pos:[12,416] width:232 height:21 align:#left
	button 'btn_grassymap_importassets' "Import Assets" pos:[12,448] width:232 height:21 align:#left
	button 'btn_grassymap_fillfaces' "Fill Select Faces" pos:[260,320] width:232 height:21 align:#left
	
	fn RefreshSettings =
	(
			if(Batch_archetypeName_random.checked)then
			(
				local v_proc1 = Batch_archetypeName.items
				local index = random 1 v_proc1.count
				archetypeName = v_proc1[index]
			)
			else(archetypeName = Batch_archetypeName.selected)

			if(Batch_ScaleRangeX_random.checked)then(ScaleRangeX = random 0 255)else(ScaleRangeX = Batch_ScaleRangeX.value)
			if(Batch_ScaleRangeY_random.checked)then(ScaleRangeY = random 0 255)else(ScaleRangeY = Batch_ScaleRangeY.value)
			if(Batch_ScaleRangeZ_random.checked)then(ScaleRangeZ = random 0 255)else(ScaleRangeZ = Batch_ScaleRangeZ.value)
			if(Batch_lodDist_random.checked)then(lodDist = random 0 255)else(lodDist = Batch_lodDist.value)
			if(Batch_LodFadeStartDist_random.checked)then(LodFadeStartDist = random 0 255)else(LodFadeStartDist = Batch_LodFadeStartDist.value)
			if(Batch_LodInstFadeRange_random.checked)then(LodInstFadeRange = random 0 255)else(LodInstFadeRange = Batch_LodInstFadeRange.value)
			if(Batch_OrientToTerrain_random.checked)then(OrientToTerrain = random 0 255)else(OrientToTerrain = Batch_OrientToTerrain.value)
			if(Instances_Scale_random.checked)then(InstanceScale = -1)else(InstanceScale = Instances_Scale.value)
			
			if(Instances_ColorR_random.checked)then(InstanceColorR = -1)else(InstanceColorR = Instances_ColorR.value)
			if(Instances_ColorG_random.checked)then(InstanceColorG = -1)else(InstanceColorG = Instances_ColorG.value)
			if(Instances_ColorB_random.checked)then(InstanceColorB = -1)else(InstanceColorB = Instances_ColorB.value)
			InstanceColor = #(InstanceColorR,InstanceColorG,InstanceColorB)
			InstanceAo = Instances_Ao.value
			InstancePad = #(Instances_PadX.value,Instances_PadY.value,Instances_PadZ.value)
			BatchSettings = #([ScaleRangeX,ScaleRangeY,ScaleRangeZ],archetypeName,lodDist,LodFadeStartDist,LodInstFadeRange,OrientToTerrain)
			InstanceSettings = #(InstanceScale,InstanceColor,InstanceAo,InstancePad)
	)
	
	on btn_grassymap_importassets pressed do 
	(
		--TODO: READ YTYP AND RESCALE THE MESH IF REQUIRED (DIFFERENT UNITS?!)
		if(getnodebyname("v_proc1") == undefined)then
		(
			assetsDummy = Dummy()
			assetsDummy.name = "v_proc1"
		)
		for item in Batch_archetypeName.items do (ImportInstancedGrassAssets item)
	)
	
	on btn_grassymap_paint changed state do
	(
		btn_grassymap_fillfaces.enabled = not btn_grassymap_fillfaces.enabled
		if(state == true)then
		(
			list = getCurrentSelection()
			if(list.count > 0)then
			(
				batchDummy = Dummy()
				batchDummy.name = uniquename("Batch_")
				RefreshSettings()
			
				--TODO: ALLOW BRUSH SETTINGS CUSTOMIZATION
				thePainterInterface.ScriptFunctions StartPaintGrass PaintGrass EndPaintGrass CancelPaintGrass systemEnd
				thePainterInterface.drawTrace = false
				thePainterInterface.pressureEnable = false
				if(thePainterInterface.inPaintMode()) then thePainterInterface.endPaintSession() 
				thePainterInterface.initializeNodes 0 list
				thePainterInterface.startPaintSession()
			)
		)else
		(
			thePainterInterface.endPaintSession()
			if(batchDummy != undefined)then
			(
				if(isDeleted(batchDummy) == false)then
				(
					if(batchDummy.children != undefined)do
					(	
						CalculateBoundBoxFromChildren batchDummy
					)
				)
			)
		)
	)

	on btn_grassymap_fillfaces pressed do 
	(	
		list = getCurrentSelection()
		if(list.count > 0)then
		(
			RefreshSettings()
			batchDummy = Dummy()
			batchDummy.name = uniquename("Batch_")
			
			for obj in list do
			(
				if((classOf obj) == Editable_Poly) then
				(
					local faces = polyop.getFaceSelection obj
					InstanceDataFromFaces obj faces
				)else (format "% is not of class Editable_Poly, it will be skipped.\n" (obj.name))
			)
			if(batchDummy != undefined)then
			(
				if(isDeleted(batchDummy) == false)then
				(
					if(batchDummy.children != undefined)do
					(	
						CalculateBoundBoxFromChildren batchDummy
					)
				)
			)
		)
	)

	on btn_grassymap_addbatch pressed do
	(
		RefreshSettings()
		
		list = getCurrentSelection()
		for obj in list do
		(
			if((classOf obj) == Dummy) then
			(
				--RECHECK REQUIRED IN CASE OF MANUALLY ADDED/REMOVED INSTANCES
				CalculateBoundBoxFromChildren obj
				
				local Batch = GrassInstanceListFromMeshes obj.children obj BatchSettings InstanceSettings 
				append GrassInstanceList Batch
			)
			else (format "% is not of class Dummy, it will be skipped.\n" (obj.name))
		)
	)
	
	on btn_grassymap_export pressed do
	(
		if(GrassInstanceList != undefined and GrassInstanceList.count > 0)then
		(
			local CMapDataSettings = #("instancedData","",0,0)
			local instancedData = rage__fwInstancedMapData ImapLink:undefined PropInstanceList:undefined GrassInstanceList:GrassInstanceList
			local Extents = instancedData.GetExtents()
			
			local CMapData = CreateCMapData CMapDataSettings
			CMapData.instancedData = instancedData
			CMapData.contentFlags = 1088
			append (CMapData.physicsDictionaries) "v_proc1"
			CMapData.streamingExtentsMin = Extents.streamingExtentsMin
			CMapData.streamingExtentsMax = Extents.streamingExtentsMax
			CMapData.entitiesExtentsMin = Extents.entitiesExtentsMin
			CMapData.entitiesExtentsMax = Extents.entitiesExtentsMax
			ExportYmap CMapData
		)else(format "YMAP Exporter: GrassInstanceList array is empty.\n")	
	)
	
	on btn_grassymap_reset pressed do
	(
		free GrassInstanceList
		GrassInstanceList = #()
	)
)
createdialog GrassInstance_Rollout