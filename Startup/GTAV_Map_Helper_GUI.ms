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
	
	group "FiveM"
	(
		checkbutton 'enable_json' "Enable Json" width:140 align:#center tooltip:"WARNING:This will load the Newtonsoft assembly!"
		checkbox 'chk_archetypes' "Export Archetypes" 
		checkbox 'chk_entities' "Export Entities"
		button 'btn_json_export' "Export Json" width:140 align:#center
		button 'btn_json_check' "Check Json" width:140 align:#center
		button 'btn_json_import' "Import Json" width:140 align:#center
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
	
	on enable_json changed state do
	(
		if (enable_json.state == true) do 
		(
			fileIn (scriptspath+"\\GTAV_Map_Helper\\json.ms")
			if(Json_Assembly == undefined) do
			(
				messageBox "Please check if Windows is locking the assembly Newtonsoft.Json.dll\nRight click on it and open Properties, then unlock it from its General tab.\nThen restart 3ds Max."
				enable_json.state = false
			)
		)
	)
	
	on btn_json_export pressed do
	(
		if(enable_json.checked)then
		(
			list = getCurrentSelection()
			if(chk_archetypes.checked or chk_entities.checked) do
				exportJson chk_archetypes.checked chk_entities.checked list
		)else messageBox "First enable the json core."
	)
	
	on btn_json_import pressed do
	(
		if(enable_json.checked) then
			importJson()
		else messageBox "First enable the json core."
	)
	
	on btn_json_check pressed do
	(
		if(enable_json.checked) then
			checkJson()
		else messageBox "First enable the json core."
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