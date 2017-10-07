try(destroyDialog FiveM_Rollout )catch()
fileIn (scriptspath+"\\GTAV_Map_Helper\\fivem\\json.ms")

clearlistener()
actionMan.executeAction 0 "40472"
format "FiveM .json Scripts\n\nHow to use the script:\nEXPORT: Select all the geometries you want to export, choose your settings and click on Export to generate the .json file.\nCHECK: Reads a .json file and checks if each object with given archetypeName exists in the scene.\nIMPORT: Reads a .json file and moves/rotates each object according to the entities array.\n\n"
rollout FiveM_Rollout "FiveM .json Scripts" width:170 height:125
(	

	checkbox 'chk_archetypes' "Export Archetypes" 
	checkbox 'chk_entities' "Export Entities"
	button 'btn_json_export' "Export .json" width:150 align:#center
	button 'btn_json_check' "Check .json" width:150 align:#center
	button 'btn_json_import' "Import .json" width:150 align:#center
	
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
createdialog FiveM_Rollout