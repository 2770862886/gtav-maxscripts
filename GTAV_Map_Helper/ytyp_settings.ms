rollout YTYP_Settings "YTYP Settings" width:250 height:500
(
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
	)
)
createdialog YTYP_Settings
