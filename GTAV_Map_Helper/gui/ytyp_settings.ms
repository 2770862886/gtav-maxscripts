fileIn (scriptspath+"\\GTAV_Map_Helper\\ytyp.ms")

clearlistener()
actionMan.executeAction 0 "40472"
format "Ytyp Script\n\nHow to use the script:\nSelect all the geometries you want to export and click on Export to generate the .ytyp.xml file.\n"

rollout YTYP_Settings "YTYP Settings" width:250 height:500
(
	/*
	group "CMapTypes"
	(
		edittext 'CMapTypes_name_extensions' "extensions:"
		edittext 'CMapTypes_name' "name:"
		edittext 'CMapTypes_dependencies' "dependencies:"
		edittext 'CMapTypes_compositeEntityTypes' "compositeEntityTypes:"
	)
	
	group "CBaseArchetypeDef"
	(
		edittext 'CBaseArchetypeDef_lodDist' "lodDist:"
		edittext 'CBaseArchetypeDef_flags' "flags:"
		edittext 'CBaseArchetypeDef_hdTextureDist' "hdTextureDist:"
		edittext 'CBaseArchetypeDef_specialAttribute' "specialAttribute:"
		edittext 'CBaseArchetypeDef_textureDictionary' "textureDictionary:"
		edittext 'CBaseArchetypeDef_clipDictionary' "clipDictionary:"
		edittext 'CBaseArchetypeDef_drawableDictionary' "drawableDictionary:"
		edittext 'CBaseArchetypeDef_physicsDictionary' "physicsDictionary:"
		edittext 'CBaseArchetypeDef_extensions' "extensions:"
		dropdownlist 'CBaseArchetypeDef_assetType' "assetType:" items:#("ASSET_TYPE_DRAWABLE")
	)*/
	button 'btn_ytyp_export' "Export .ytyp.xml" width:232 height:21 align:#left
	
	on btn_ytyp_export pressed do
	(
		list = getCurrentSelection()
		if(list != undefined and list.count > 0)then
			export_YTYP list "Output"
		else (format "YTYP Exporter: Selection is empty.\n")
	)
)
createdialog YTYP_Settings