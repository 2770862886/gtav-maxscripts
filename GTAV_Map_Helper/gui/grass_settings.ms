fileIn (scriptspath+"\\GTAV_Map_Helper\\grass.ms")
fileIn (scriptspath+"\\GTAV_Map_Helper\\ymap.ms")


XDocument_YMAP = create_YMAP "Grass" [0,0,0] [0,0,0]
XElement_CMapData = XDocument_YMAP.Element XName_CMapData
XElement_instancedData = XElement_CMapData.Element XName_instancedData
XElement_GrassInstanceList = XElement_instancedData.Element XName_GrassInstanceList

rollout Grass_Instance "GrassInstance Exporter (.ymap.xml)" width:248 height:672
(
	groupBox 'grp1' "Batch" pos:[8,7] width:232 height:297 align:#left
	dropdownList 'Batch_archetypeName' "archetypeName(v_proc1):" pos:[13,26] width:147 height:40 items:#("proc_brittlebush_01", "proc_desert_sage_01", "proc_drygrasses01", "proc_drygrasses01b", "proc_drygrassfronds01", "proc_dryplantsgrass_01", "proc_dryplantsgrass_02", "proc_dry_plants_01", "proc_forest_grass01", "proc_forest_ivy_01", "proc_grassdandelion01", "proc_grasses01", "proc_grasses01b", "proc_grassfronds01", "proc_grassplantmix_01", "proc_grassplantmix_02", "proc_indian_pbrush_01", "proc_leafybush_01", "proc_leafyplant_01", "proc_lizardtail_01", "proc_lupins_01", "proc_meadowmix_01", "proc_meadowpoppy_01", "proc_sage_01", "proc_scrub_bush01", "proc_sml_reeds_01", "proc_sml_reeds_01b", "proc_sml_reeds_01c", "proc_stones_01", "proc_stones_02", "proc_stones_03", "proc_stones_04", "proc_stones_05", "proc_stones_06", "proc_wildquinine", "prop_dandy_b", "prop_dryweed_001_a", "prop_dryweed_002_a", "prop_fernba", "prop_fernbb", "prop_flowerweed_005_a", "prop_grass_001_a", "prop_grass_ca", "prop_grass_da", "prop_log_aa", "prop_log_ab", "prop_log_ac", "prop_log_ad", "prop_log_ae", "prop_log_af", "prop_saplin_001_b", "prop_saplin_001_c", "prop_saplin_002_b", "prop_saplin_002_c", "prop_small_bushyba", "prop_tall_drygrass_aa", "prop_tall_grass_ba", "prop_thindesertfiller_aa", "prop_weed_001_aa", "prop_weed_002_ba", "urbandryfrnds_01", "urbandrygrass_01", "urbangrnfrnds_01", "urbangrngrass_01", "urbanweeds01", "urbanweeds01_l1", "urbanweeds02", "urbanweeds02_l1") align:#left
	checkbox 'Batch_archetypeName_random' "Random" pos:[168,48] width:64 height:15 checked:true align:#left
			
	spinner 'Batch_ScaleRangeX' "ScaleRange X:" pos:[16,80] width:72 height:16 range:[0.0,100.0,0.6] type:#float align:#left
	checkbox 'Batch_ScaleRangeX_random' "Random" pos:[168,80] width:64 height:15 align:#left
	spinner 'Batch_ScaleRangeY' "ScaleRange Y:" pos:[16,112] width:72 height:16 range:[0.0,100.0,2.3] type:#float align:#left
	checkbox 'Batch_ScaleRangeY_random' "Random" pos:[168,112] width:64 height:15 align:#left
	spinner 'Batch_ScaleRangeZ' "ScaleRange Z:" pos:[16,144] width:72 height:16 range:[0.0,100.0,0.2] type:#float align:#left
	checkbox 'Batch_ScaleRangeZ_random' "Random" pos:[168,144] width:64 height:15 align:#left
	spinner 'Batch_lodDist' "lodDist:" pos:[16,176] width:109 height:16 range:[0,100,40] type:#integer align:#left
	checkbox 'Batch_lodDist_random' "Random" pos:[168,176] width:64 height:15 align:#left	
	
	spinner 'Batch_LodFadeStartDist' "LodFadeStartDist:" pos:[16,208] width:59 height:16 range:[0.0,100.0,20.0] type:#float align:#left
	checkbox 'Batch_LodFadeStartDist_random' "Random" pos:[168,208] width:64 height:15 align:#left
	spinner 'Batch_LodInstFadeRange' "LodInstFadeRange:" pos:[16,240] width:50 height:16 range:[0.0,100.0,0.75] type:#float align:#left
	checkbox 'Batch_LodInstFadeRange_random' "Random" pos:[168,240] width:64 height:15 align:#left
	spinner 'Batch_OrientToTerrain' "OrientToTerrain:" pos:[16,273] width:67 height:16 range:[0.0,100,1.0] type:#float align:#left
	checkbox 'Batch_OrientToTerrain_random' "Random" pos:[168,272] width:64 height:15 checked:false align:#left
	
	groupBox 'grp2' "Instances" pos:[8,320] width:232 height:280 align:#left
	spinner 'Instances_Scale' "Scale:" pos:[16,344] width:114 height:16 range:[0,255,1] type:#integer align:#left
	checkbox 'Instances_Scale_random' "Random" pos:[168,344] width:64 height:15 checked:true align:#left
	spinner 'Instances_ColorR' "Color R:" pos:[16,376] width:106 height:16 range:[0,255,0] type:#integer align:#left
	checkbox 'Instances_ColorR_random' "Random" pos:[168,376] width:64 height:15 checked:true align:#left
	spinner 'Instances_ColorG' "Color G:" pos:[16,408] width:106 height:16 range:[0,255,0] type:#integer align:#left
	checkbox 'Instances_ColorG_random' "Random" pos:[168,408] width:64 height:15 checked:true align:#left
	spinner 'Instances_ColorB' "Color B:" pos:[16,440] width:107 height:16 range:[0,255,0] type:#integer align:#left
	checkbox 'Instances_ColorB_random' "Random" pos:[168,440] width:64 height:15 checked:true align:#left
	spinner 'Instances_Ao' "Ao:" pos:[16,472] width:128 height:16 range:[0,255,255] type:#integer align:#left
	spinner 'Instances_PadX' "Pad X:" pos:[16,504] width:112 height:16 range:[0,255,0] type:#integer align:#left
	spinner 'Instances_PadY' "Pad Y:" pos:[16,536] width:112 height:16 range:[0,255,0] type:#integer align:#left
	spinner 'Instances_PadZ' "Pad Z:" pos:[16,568] width:112 height:16 range:[0,255,0] type:#integer align:#left
	
	button 'btn_grassymap_addbatch' "Add Batch" pos:[8,608] width:232 height:21 align:#left
	button 'btn_grassymap_export' "Export .ymap.xml" pos:[8,640] width:232 height:21 align:#left
	

	on btn_grassymap_addbatch pressed do
	(
		if(Batch_archetypeName_random.checked)then
		(
			v_proc1 = Batch_archetypeName.items
			i = random 1 v_proc1.count
			archetypeName = v_proc1[i]
		)
		else(archetypeName = Batch_archetypeName.selected)
		if(Batch_ScaleRangeX_random.checked)then(ScaleRangeX = random 0 255)else(ScaleRangeX = Batch_ScaleRangeX.value)
		if(Batch_ScaleRangeY_random.checked)then(ScaleRangeY = random 0 255)else(ScaleRangeY = Batch_ScaleRangeY.value)
		if(Batch_ScaleRangeZ_random.checked)then(ScaleRangeZ = random 0 255)else(ScaleRangeZ = Batch_ScaleRangeZ.value)
		if(Batch_lodDist_random.checked)then(lodDist = random 0 255)else(lodDist = Batch_lodDist.value)
		if(Batch_LodFadeStartDist_random.checked)then(LodFadeStartDist = random 0 255)else(LodFadeStartDist = Batch_LodFadeStartDist.value)
		if(Batch_LodInstFadeRange_random.checked)then(LodInstFadeRange = random 0 255)else(LodInstFadeRange = Batch_LodInstFadeRange.value)
		if(Batch_OrientToTerrain_random.checked)then(OrientToTerrain = random 0 255)else(OrientToTerrain = Batch_OrientToTerrain.value)
		
		if(Instances_Scale_random.checked)then(InstanceScale = random 1 255)else(InstanceScale = Instances_Scale.value)
		if(Instances_ColorR_random.checked)then(InstanceColorR = random 0 255)else(InstanceColorR = Instances_ColorR.value)
		if(Instances_ColorG_random.checked)then(InstanceColorG = random 0 255)else(InstanceColorG = Instances_ColorG.value)
		if(Instances_ColorB_random.checked)then(InstanceColorB = random 0 255)else(InstanceColorB = Instances_ColorB.value)
		InstanceColor = [InstanceColorR,InstanceColorG,InstanceColorB]
		InstanceAo = Instances_Ao.value
		InstancePad = [Instances_PadX.value,Instances_PadY.value,Instances_PadZ.value]
		
		batch_settings = #(archetypeName,[ScaleRangeX,ScaleRangeY,ScaleRangeZ],lodDist,LodFadeStartDist,LodInstFadeRange,OrientToTerrain)
		instances_settings = #(InstanceScale,InstanceColor,InstanceAo,InstancePad)
		
		list = getCurrentSelection()
		for obj in list do
		(
			if((classOf obj) == Editable_Poly) then
			(
				local GrassInstanceList_Item = create_GrassInstanceListItem obj batch_settings instances_settings
				XElement_GrassInstanceList.Add GrassInstanceList_Item
			)
			else (format "% is not of class Editable_Poly, it will be skipped.\n" (obj.name))
		)
	)
	on btn_grassymap_export pressed do
	(
		clearlistener()
		actionMan.executeAction 0 "40472"
		export_YmapGrass "Grass" XDocument_YMAP
	)
)
createdialog Grass_Instance