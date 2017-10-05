fileIn (scriptspath+"\\GTAV_Map_Helper\\xml.ms")

fn create_CEntityDef obj=(
	local CEntityDef_name = obj.name
	local CEntityDef_position = (in coordsys world obj.pos)
	local CEntityDef_rotation = inverse(in coordsys world obj.rotation)
	
	local XElement_CEntityDef = dotNetObject "System.Xml.Linq.XElement" XName_Item 
	XElement_CEntityDef.SetAttributeValue XName_type "CEntityDef"
	local XElement_archetypeName = dotNetObject "System.Xml.Linq.XElement" XName_archetypeName
	XElement_archetypeName.SetValue CEntityDef_name
	XElement_CEntityDef.Add XElement_archetypeName
	local XElement_flags = dotNetObject "System.Xml.Linq.XElement" XName_flags
	XElement_flags.SetAttributeValue XName_value 0
	XElement_CEntityDef.Add XElement_flags
	local XElement_guid = dotNetObject "System.Xml.Linq.XElement" XName_guid
	XElement_guid.SetAttributeValue XName_value (random 1 2147483647)
	XElement_CEntityDef.Add XElement_guid
	local XElement_position = dotNetObject "System.Xml.Linq.XElement" XName_position
	XElement_position.SetAttributeValue XName_x CEntityDef_position.x
	XElement_position.SetAttributeValue XName_y CEntityDef_position.y
	XElement_position.SetAttributeValue XName_z CEntityDef_position.z
	XElement_CEntityDef.Add XElement_position
	local XElement_rotation = dotNetObject "System.Xml.Linq.XElement" XName_rotation
	XElement_rotation.SetAttributeValue XName_x CEntityDef_rotation.x
	XElement_rotation.SetAttributeValue XName_y CEntityDef_rotation.y
	XElement_rotation.SetAttributeValue XName_z CEntityDef_rotation.z
	XElement_rotation.SetAttributeValue XName_w CEntityDef_rotation.w
	XElement_CEntityDef.Add XElement_rotation
	local XElement_scaleXY = dotNetObject "System.Xml.Linq.XElement" XName_scaleXY
	XElement_scaleXY.SetAttributeValue XName_value 1
	XElement_CEntityDef.Add XElement_scaleXY
	local XElement_scaleZ = dotNetObject "System.Xml.Linq.XElement" XName_scaleZ
	XElement_scaleZ.SetAttributeValue XName_value 1
	XElement_CEntityDef.Add XElement_scaleZ
	local XElement_parentIndex = dotNetObject "System.Xml.Linq.XElement" XName_parentIndex
	XElement_parentIndex.SetAttributeValue XName_value (-1)
	XElement_CEntityDef.Add XElement_parentIndex
	local XElement_lodDist = dotNetObject "System.Xml.Linq.XElement" XName_lodDist
	XElement_lodDist.SetAttributeValue XName_value (100)
	XElement_CEntityDef.Add XElement_lodDist
	local XElement_childLodDist = dotNetObject "System.Xml.Linq.XElement" XName_childLodDist
	XElement_childLodDist.SetAttributeValue XName_value (0)
	XElement_CEntityDef.Add XElement_childLodDist
	local XElement_lodLevel = dotNetObject "System.Xml.Linq.XElement" XName_lodLevel
	XElement_lodLevel.SetValue "LODTYPES_DEPTH_HD"
	XElement_CEntityDef.Add XElement_lodLevel
	local XElement_numChildren = dotNetObject "System.Xml.Linq.XElement" XName_numChildren
	XElement_numChildren.SetAttributeValue XName_value (0)
	XElement_CEntityDef.Add XElement_numChildren
	local XElement_priorityLevel = dotNetObject "System.Xml.Linq.XElement" XName_priorityLevel
	XElement_priorityLevel.SetValue "PRI_REQUIRED"
	XElement_CEntityDef.Add XElement_priorityLevel
	local XElement_extensions = dotNetObject "System.Xml.Linq.XElement" XName_extensions
	XElement_CEntityDef.Add XElement_extensions
	local XElement_ambientOcclusionMultiplier = dotNetObject "System.Xml.Linq.XElement" XName_ambientOcclusionMultiplier
	XElement_ambientOcclusionMultiplier.SetAttributeValue XName_value (255)
	XElement_CEntityDef.Add XElement_ambientOcclusionMultiplier
	local XElement_artificialAmbientOcclusion = dotNetObject "System.Xml.Linq.XElement" XName_artificialAmbientOcclusion
	XElement_artificialAmbientOcclusion.SetAttributeValue XName_value (255)
	XElement_CEntityDef.Add XElement_artificialAmbientOcclusion
	local XElement_tintValue = dotNetObject "System.Xml.Linq.XElement" XName_tintValue
	XElement_tintValue.SetAttributeValue XName_value (0)
	XElement_CEntityDef.Add XElement_tintValue
	
	return XElement_CEntityDef
)

fn create_YMAP filename ExtentsMin ExtentsMax =(
	local XDocument_YMAP = dotNetObject "System.Xml.Linq.XDocument"
	XDocument_YMAP.Declaration  = (dotNetObject "System.Xml.Linq.XDeclaration" "1.0" "UTF-8" "no")
	local XElement_CMapData = dotNetObject "System.Xml.Linq.XElement" XName_CMapData
	XDocument_YMAP.Add XElement_CMapData
	local XElement_name = dotNetObject "System.Xml.Linq.XElement" XName_name
	XElement_name.SetValue filename
	XElement_CMapData.Add XElement_name
	local XElement_parent = dotNetObject "System.Xml.Linq.XElement" XName_parent
	XElement_CMapData.Add XElement_parent
	local XElement_flags = dotNetObject "System.Xml.Linq.XElement" XName_flags
	XElement_flags.SetAttributeValue XName_value 0
	XElement_CMapData.Add XElement_flags
	local XElement_contentFlags = dotNetObject "System.Xml.Linq.XElement" XName_contentFlags
	XElement_contentFlags.SetAttributeValue XName_value 0
	XElement_CMapData.Add XElement_contentFlags
	local XElement_streamingExtentsMin = dotNetObject "System.Xml.Linq.XElement" XName_streamingExtentsMin
	XElement_streamingExtentsMin.SetAttributeValue XName_x (ExtentsMin.x-200)
	XElement_streamingExtentsMin.SetAttributeValue XName_y (ExtentsMin.y-200)
	XElement_streamingExtentsMin.SetAttributeValue XName_z (ExtentsMin.z-200)
	XElement_CMapData.Add XElement_streamingExtentsMin
	local XElement_streamingExtentsMax = dotNetObject "System.Xml.Linq.XElement" XName_streamingExtentsMax
	XElement_streamingExtentsMax.SetAttributeValue XName_x (ExtentsMax.x+200)
	XElement_streamingExtentsMax.SetAttributeValue XName_y (ExtentsMax.y+200)
	XElement_streamingExtentsMax.SetAttributeValue XName_z (ExtentsMax.z+200)
	XElement_CMapData.Add XElement_streamingExtentsMax
	local XElement_entitiesExtentsMin = dotNetObject "System.Xml.Linq.XElement" XName_entitiesExtentsMin
	XElement_entitiesExtentsMin.SetAttributeValue XName_x ExtentsMin.x
	XElement_entitiesExtentsMin.SetAttributeValue XName_y ExtentsMin.y
	XElement_entitiesExtentsMin.SetAttributeValue XName_z ExtentsMin.z
	XElement_CMapData.Add XElement_entitiesExtentsMin
	local XElement_entitiesExtentsMax = dotNetObject "System.Xml.Linq.XElement" XName_entitiesExtentsMax
	XElement_entitiesExtentsMax.SetAttributeValue XName_x ExtentsMax.x
	XElement_entitiesExtentsMax.SetAttributeValue XName_y ExtentsMax.y
	XElement_entitiesExtentsMax.SetAttributeValue XName_z ExtentsMax.z
	XElement_CMapData.Add XElement_entitiesExtentsMax
	local XElement_entities = dotNetObject "System.Xml.Linq.XElement" XName_entities
	XElement_CMapData.Add XElement_entities
	local XElement_containerLods = dotNetObject "System.Xml.Linq.XElement" XName_containerLods
	XElement_CMapData.Add XElement_containerLods
	local XElement_boxOccluders = dotNetObject "System.Xml.Linq.XElement" XName_boxOccluders
	XElement_CMapData.Add XElement_boxOccluders
	local XElement_occludeModels = dotNetObject "System.Xml.Linq.XElement" XName_occludeModels
	XElement_CMapData.Add XElement_occludeModels
	local XElement_physicsDictionaries = dotNetObject "System.Xml.Linq.XElement" XName_physicsDictionaries
	XElement_CMapData.Add XElement_physicsDictionaries
	local XElement_instancedData = dotNetObject "System.Xml.Linq.XElement" XName_instancedData
	XElement_CMapData.Add XElement_instancedData
	local XElement_ImapLink = dotNetObject "System.Xml.Linq.XElement" XName_ImapLink
	XElement_instancedData.Add XElement_ImapLink
	local XElement_PropInstanceList = dotNetObject "System.Xml.Linq.XElement" XName_PropInstanceList
	XElement_instancedData.Add XElement_PropInstanceList
	local XElement_GrassInstanceList = dotNetObject "System.Xml.Linq.XElement" XName_GrassInstanceList
	XElement_instancedData.Add XElement_GrassInstanceList
	local XElement_timeCycleModifiers = dotNetObject "System.Xml.Linq.XElement" XName_timeCycleModifiers
	XElement_CMapData.Add XElement_timeCycleModifiers
	local XElement_carGenerators = dotNetObject "System.Xml.Linq.XElement" XName_carGenerators
	XElement_CMapData.Add XElement_carGenerators
	local XElement_LODLightsSOA = dotNetObject "System.Xml.Linq.XElement" XName_LODLightsSOA
	XElement_CMapData.Add XElement_LODLightsSOA
	local XElement_direction = dotNetObject "System.Xml.Linq.XElement" XName_direction
	XElement_LODLightsSOA.Add XElement_direction
	local XElement_falloff = dotNetObject "System.Xml.Linq.XElement" XName_falloff
	XElement_LODLightsSOA.Add XElement_falloff
	local XElement_falloffExponent = dotNetObject "System.Xml.Linq.XElement" XName_falloffExponent
	XElement_LODLightsSOA.Add XElement_falloffExponent
	local XElement_timeAndStateFlags = dotNetObject "System.Xml.Linq.XElement" XName_timeAndStateFlags
	XElement_LODLightsSOA.Add XElement_timeAndStateFlags
	local XElement_hash = dotNetObject "System.Xml.Linq.XElement" XName_hash
	XElement_LODLightsSOA.Add XElement_hash
	local XElement_coneInnerAngle = dotNetObject "System.Xml.Linq.XElement" XName_coneInnerAngle
	XElement_LODLightsSOA.Add XElement_coneInnerAngle
	local XElement_coneOuterAngleOrCapExt = dotNetObject "System.Xml.Linq.XElement" XName_coneOuterAngleOrCapExt
	XElement_LODLightsSOA.Add XElement_coneOuterAngleOrCapExt
	local XElement_coronaIntensity = dotNetObject "System.Xml.Linq.XElement" XName_coronaIntensity
	XElement_LODLightsSOA.Add XElement_coronaIntensity
	local XElement_DistantLODLightsSOA = dotNetObject "System.Xml.Linq.XElement" XName_DistantLODLightsSOA
	XElement_CMapData.Add XElement_DistantLODLightsSOA
	local XElement_position = dotNetObject "System.Xml.Linq.XElement" XName_position
	XElement_DistantLODLightsSOA.Add XElement_position
	local XElement_RGBI = dotNetObject "System.Xml.Linq.XElement" XName_RGBI
	XElement_DistantLODLightsSOA.Add XElement_RGBI
	local XElement_numStreetLights = dotNetObject "System.Xml.Linq.XElement" XName_numStreetLights
	XElement_numStreetLights.SetAttributeValue XName_value 0
	XElement_DistantLODLightsSOA.Add XElement_numStreetLights
	local XElement_category = dotNetObject "System.Xml.Linq.XElement" XName_category 
	XElement_category .SetAttributeValue XName_value 0
	XElement_DistantLODLightsSOA.Add XElement_category 
	local XElement_block = dotNetObject "System.Xml.Linq.XElement" XName_block
	XElement_CMapData.Add XElement_block
	local XElement_version = dotNetObject "System.Xml.Linq.XElement" XName_version
	XElement_version.SetAttributeValue XName_value 0
	XElement_block.Add XElement_version
	local XElement_flags = dotNetObject "System.Xml.Linq.XElement" XName_flags
	XElement_flags.SetAttributeValue XName_value 0
	XElement_block.Add XElement_flags
	local XElement_name = dotNetObject "System.Xml.Linq.XElement" XName_name
	XElement_block.Add XElement_name
	local XElement_exportedBy = dotNetObject "System.Xml.Linq.XElement" XName_exportedBy
	XElement_exportedBy.SetValue "Neos7's Maxscript"
	XElement_block.Add XElement_exportedBy
	local XElement_owner = dotNetObject "System.Xml.Linq.XElement" XName_owner
	XElement_owner.SetValue sysInfo.username
	XElement_block.Add XElement_owner
	local XElement_time = dotNetObject "System.Xml.Linq.XElement" XName_time
	XElement_time.SetValue localtime
	XElement_block.Add XElement_time
	
	return XDocument_YMAP
)

fn export_YMAP_entities objects_list filename =(
	local filePath = getSaveFileName caption:"Save .ymap.xml file" filename:(filename+".ymap.xml") types:"XML Document (*.xml)"
	if( filePath != undefined) then
	( 	
		format "YMAP EXPORTER: %\n\n" (filePath)
		local XDocument_YMAP = create_YMAP filename (selection.min) (selection.max)
		XElement_CMapData = XDocument_YMAP.Element XName_CMapData
		XElement_entities = XElement_CMapData.Element XName_entities
		for obj in objects_list do
		(
			local XElement_CEntityDef= create_CEntityDef obj
			XElement_entities.Add XElement_CEntityDef
		)
		XDocument_YMAP.Save filePath
	)
)