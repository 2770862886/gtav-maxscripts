rollout YMAP_Settings "YMAP Settings" width:250 height:500
(
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
	)
)
createdialog YMAP_Settings