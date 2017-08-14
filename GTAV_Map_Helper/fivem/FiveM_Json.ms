fileIn (scriptspath+"\\GTAV_Map_Helper\\fivem\\json.ms")

rollout FiveM_Json "FiveM Json" width:162 height:130
(	

	checkbox 'chk_archetypes' "Export Archetypes" 
	checkbox 'chk_entities' "Export Entities"
	button 'btn_json_export' "Export Json" width:140 align:#center
	button 'btn_json_check' "Check Json" width:140 align:#center
	button 'btn_json_import' "Import Json" width:140 align:#center
	
	on btn_json_export pressed do
	(
		if(Json_Assembly != undefined)then
		(
			list = getCurrentSelection()
			if(chk_archetypes.checked or chk_entities.checked) do
				exportJson chk_archetypes.checked chk_entities.checked list
		)else messageBox "Newtonsoft.Json.dll isn't loaded."
	)
	
	on btn_json_import pressed do
	(
		if(Json_Assembly != undefined) then
			importJson()
		else messageBox "Newtonsoft.Json.dll isn't loaded."
	)
	
	on btn_json_check pressed do
	(
		if(Json_Assembly != undefined) then
			checkJson()
		else messageBox "Newtonsoft.Json.dll isn't loaded."
	)
	
)
createdialog FiveM_Json