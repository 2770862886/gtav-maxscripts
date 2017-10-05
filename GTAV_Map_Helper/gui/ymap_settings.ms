fileIn (scriptspath+"\\GTAV_Map_Helper\\ymap.ms")

clearlistener()
actionMan.executeAction 0 "40472"
format "Ymap Script\n\nHow to use the script:\nSelect all the geometries you want to export and click on Export to generate the .ymap.xml file."

rollout YMAP_Settings "YMAP Settings" width:250 height:500
(
	/*
	group "CMapData"
	(
		
	)
	
	group "CEntityDef"
	(
		edittext 'CEntityDef_flags' "flags:"
		edittext 'CEntityDef_parentIndex' "parentIndex:"
		edittext 'CEntityDef_lodDist' "lodDist:"
		edittext 'CEntityDef_numChildren' "numChildren:"
		dropdownlist 'CEntityDef_priorityLevel' "priorityLevel:" items:#("PRI_REQUIRED")
	)*/
		button 'btn_ymap_export' "Export .ymap.xml" width:232 height:21 align:#left
	
	on btn_ymap_export pressed do
	(
		list = getCurrentSelection()
		if(list != undefined and list.count > 0)then
			export_YMAP_entities list "Output"
		else (format "YMAP Exporter: Selection is empty.\n")
	)
)
createdialog YMAP_Settings