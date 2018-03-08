utility GTAV_Map_Helper "GTA V Map Scripts" width:162 height:420
(	
	group "Map scripts" 
	(
		button 'btn_ytyp' "Ytyp" width:140 align:#center
		button 'btn_ymap' "Ymap" width:140 align:#center
		button 'btn_grass' "Instanced Grass" width:140 align:#center
		button 'btn_water' "water.xml" width:140 align:#center
	)
	
	group "Other"
	(
		button 'btn_gimsShortcuts' "GIMS Shortcuts" width:140 align:#center
		button 'btn_popzone' "popzone.ipl" width:140 align:#center
		button 'btn_fivem' "FiveM (.json)" width:140 align:#center
		button 'btn_tools' "Tools" width:140 align:#center
	)
	
	on btn_gimsShortcuts pressed do
	(
		fileIn (scriptspath+"\\GTAV_Map_Helper\\utility\\gims_shortcuts.ms")
	)
	
	on btn_ytyp pressed do
	(
		fileIn (scriptspath+"\\GTAV_Map_Helper\\gui\\ytyp_settings.ms")
	)
	
	on btn_ymap pressed do
	(
		fileIn (scriptspath+"\\GTAV_Map_Helper\\gui\\ymap_settings.ms")
	)
	
	on btn_popzone pressed do
	(
		fileIn (scriptspath+"\\GTAV_Map_Helper\\popzone.ms")
	)
	
	on btn_grass pressed do
	(
		fileIn (scriptspath+"\\GTAV_Map_Helper\\gui\\grass_settings.ms")
	)
	
	on btn_tools pressed do
	(
		fileIn (scriptspath+"\\GTAV_Map_Helper\\utility\\tools.ms")
	)
	
	on btn_fivem pressed do
	(
		fileIn (scriptspath+"\\GTAV_Map_Helper\\fivem\\fivem_settings.ms")
	)
	
	on btn_water pressed do
	(
		fileIn (scriptspath+"\\GTAV_Map_Helper\\gui\\water_settings.ms")
	)
	
)
openutility GTAV_Map_Helper