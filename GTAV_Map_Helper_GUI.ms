fileIn (scriptspath+"\\GTAV_Map_Helper\\json.ms")
fileIn (scriptspath+"\\GTAV_Map_Helper\\GIMS_shortcut.ms")
fileIn (scriptspath+"\\GTAV_Map_Helper\\xml.ms")

utility GTAV_Map_Helper "GTA V Map Helper" width:162 /*height:344*/ height:400
(	
	group "GIMS EVO Shortcut"
	(
		button 'btn_createmodel' "Create Model" width:140 align:#center
		button 'btn_createmultimodels' "Create Multiple Models" width:140 align:#center
		button 'btn_createcomposite' "Create Composite" width:140 align:#center
	)
	
	group "GTA V" 
	(
		checkbox 'chk_ytyp' ".ytyp.xml" 
		checkbox 'chk_ymap' ".ymap.xml"
		button 'btn_gtav_settings' "Settings" width:140 align:#center
		button 'btn_gtav_export' "Export" width:140 align:#center
	)
	
	group "FiveM Import"
	(
		button 'btn_json_check' "Check Json" width:140 align:#center
		button 'btn_json_import' "Import Json" width:140 align:#center
	)
	
	group "FiveM Export"
	(
		checkbox 'chk_archetypes' "Archetypes" 
		checkbox 'chk_entities' "Entities"
		button 'btn_json_export' "Export Json" width:140 align:#center
	)
	
	on btn_gtav_settings pressed do
	(
		fileIn (scriptspath+"\\GTAV_Map_Helper\\ytyp_settings.ms")
		fileIn (scriptspath+"\\GTAV_Map_Helper\\ymap_settings.ms")
	)
	
	on btn_gtav_export pressed do
	(
		if( chk_ytyp.checked or chk_ymap.checked ) then
		(
			clearlistener()
			list = getCurrentSelection()
		
			if( chk_ytyp.checked )then
				export_YTYP list "Output"
			if( chk_ymap.checked) then
				export_YMAP list "Output"
			
			actionMan.executeAction 0 "40472"
		)	
	)
	
	on btn_json_export pressed do
	(
		list = getCurrentSelection()
		
		if(chk_archetypes.checked or chk_entities.checked) do
			exportJson chk_archetypes.checked chk_entities.checked list
	)
	on btn_json_import pressed do
	(
		importJson()
	)
	on btn_json_check pressed do
	(
		checkJson()
	)
	on btn_createmodel pressed do
	(
		create_GIMS_model()
	)	
	on btn_createmultimodels pressed do
	(
		create_multiple_GIMS_models()
	)
	on btn_createcomposite pressed do
	(
		create_GIMS_composite()
	)
	
)
openUtility GTAV_Map_Helper
format "GTA V Map Helper\nMade by Neos7\nVersion: 0.1\n"