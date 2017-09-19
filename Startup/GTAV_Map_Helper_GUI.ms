fileIn (scriptspath+"\\GTAV_Map_Helper\\GIMS_shortcut.ms")
fileIn (scriptspath+"\\GTAV_Map_Helper\\ytyp.ms")
fileIn (scriptspath+"\\GTAV_Map_Helper\\ymap.ms")

utility GTAV_Map_Helper "GTA V Map Helper" width:162 height:420
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
		button 'btn_water_export' "Water.xml" width:140 align:#center
		button 'btn_grass_export' "GrassInstance" width:140 align:#center
	)
	
	button 'btn_fivem' "FiveM Json" width:140 align:#center
	
	on btn_gtav_settings pressed do
	(
		fileIn (scriptspath+"\\GTAV_Map_Helper\\gui\\ytyp_settings.ms")
		fileIn (scriptspath+"\\GTAV_Map_Helper\\gui\\ymap_settings.ms")
	)
	
	on btn_gtav_export pressed do
	(
		if( chk_ytyp.checked or chk_ymap.checked ) then
		(
			clearlistener()
			list = getCurrentSelection()
			actionMan.executeAction 0 "40472"
			
			if( chk_ytyp.checked )then
				export_YTYP list "Output"
			if( chk_ymap.checked) then
				export_YMAP_entities list "Output"
		)	
	)
	
	on btn_grass_export pressed do
	(
		clearlistener()
		list = getCurrentSelection()
		actionMan.executeAction 0 "40472"
		fileIn (scriptspath+"\\GTAV_Map_Helper\\grass.ms")
		export_YMAP_grass list "Grass"
	)
	
	on btn_fivem pressed do
	(
		fileIn (scriptspath+"\\GTAV_Map_Helper\\fivem\\FiveM_Json.ms")
	)
	
	on btn_water_export pressed do
	(
		fileIn (scriptspath+"\\GTAV_Map_Helper\\gui\\water_settings.ms")
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
openutility GTAV_Map_Helper