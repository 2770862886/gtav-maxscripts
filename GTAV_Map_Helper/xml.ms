DotNet.LoadAssembly "System.Xml.Linq"
fileIn ("$scripts\\GTAV_Map_Helper\\gtav_formats.ms")

Class_XName = dotnetClass "System.Xml.Linq.XName"
XName_type = Class_XName.get "type"
XName_Item = Class_XName.get "Item"
XName_value = Class_XName.get "value"
XName_lodDist = Class_XName.get "lodDist"
XName_flags = Class_XName.get "flags"
XName_specialAttribute = Class_XName.get "specialAttribute"
XName_x = Class_XName.get "x"
XName_y = Class_XName.get "y"
XName_z = Class_XName.get "z"
XName_w = Class_XName.get "w"
XName_bbMin = Class_XName.get "bbMin"
XName_bbMax = Class_XName.get "bbMax"
XName_bsCentre = Class_XName.get "bsCentre"
XName_bsRadius = Class_XName.get "bsRadius"
XName_hdTextureDist = Class_XName.get "hdTextureDist"
XName_textureDictionary = Class_XName.get "textureDictionary"
XName_clipDictionary = Class_XName.get "clipDictionary"
XName_drawableDictionary = Class_XName.get "drawableDictionary"
XName_physicsDictionary = Class_XName.get "physicsDictionary"
XName_assetType = Class_XName.get "assetType"
XName_assetName= Class_XName.get "assetName"
XName_extensions = Class_XName.get "extensions"
XName_CMapTypes = Class_XName.get "CMapTypes"
XName_archetypes = Class_XName.get "archetypes"
XName_name = Class_XName.get "name"
XName_dependencies = Class_XName.get "dependencies"
XName_compositeEntityTypes = Class_XName.get "compositeEntityTypes"

XName_archetypeName = Class_XName.get "archetypeName"
XName_guid = Class_XName.get "guid"
XName_position = Class_XName.get "position"
XName_rotation = Class_XName.get "rotation"
XName_scaleXY = Class_XName.get "scaleXY"
XName_scaleZ = Class_XName.get "scaleZ"
XName_parentIndex = Class_XName.get "parentIndex"
XName_childLodDist = Class_XName.get "childLodDist"
XName_lodLevel = Class_XName.get "lodLevel"
XName_numChildren = Class_XName.get "numChildren"
XName_priorityLevel = Class_XName.get "priorityLevel"
XName_ambientOcclusionMultiplier = Class_XName.get "ambientOcclusionMultiplier"
XName_artificialAmbientOcclusion = Class_XName.get "artificialAmbientOcclusion"
XName_tintValue = Class_XName.get "tintValue"
XName_CMapData = Class_XName.get "CMapData"
XName_parent = Class_XName.get "parent"
XName_contentFlags = Class_XName.get "contentFlags"
XName_streamingExtentsMin = Class_XName.get "streamingExtentsMin"
XName_streamingExtentsMax = Class_XName.get "streamingExtentsMax"
XName_entitiesExtentsMin = Class_XName.get "entitiesExtentsMin"
XName_entitiesExtentsMax = Class_XName.get "entitiesExtentsMax"
XName_entities = Class_XName.get "entities"
XName_containerLods = Class_XName.get "containerLods"
XName_boxOccluders = Class_XName.get "boxOccluders"
XName_occludeModels = Class_XName.get "occludeModels"
XName_physicsDictionaries = Class_XName.get "physicsDictionaries"
XName_instancedData = Class_XName.get "instancedData"
XName_ImapLink = Class_XName.get "ImapLink"
XName_PropInstanceList = Class_XName.get "PropInstanceList"
XName_GrassInstanceList = Class_XName.get "GrassInstanceList"
XName_timeCycleModifiers = Class_XName.get "timeCycleModifiers"
XName_carGenerators = Class_XName.get "carGenerators"
XName_LODLightsSOA = Class_XName.get "LODLightsSOA"
XName_direction = Class_XName.get "direction"
XName_falloff = Class_XName.get "falloff"
XName_falloffExponent = Class_XName.get "falloffExponent"
XName_timeAndStateFlags = Class_XName.get "timeAndStateFlags"
XName_hash = Class_XName.get "hash"
XName_coneInnerAngle = Class_XName.get "coneInnerAngle"
XName_coneOuterAngleOrCapExt = Class_XName.get "coneOuterAngleOrCapExt"
XName_coronaIntensity = Class_XName.get "coronaIntensity"
XName_DistantLODLightsSOA = Class_XName.get "DistantLODLightsSOA"
XName_RGBI = Class_XName.get "RGBI"
XName_numStreetLights = Class_XName.get "numStreetLights"
XName_category = Class_XName.get "category"
XName_block = Class_XName.get "block"
XName_version = Class_XName.get "version"
XName_exportedBy = Class_XName.get "exportedBy"
XName_owner = Class_XName.get "owner"
XName_time = Class_XName.get "time"

fn create_CBaseArchetypeDef obj=(
	local XElement_CBaseArchetypeDef = dotNetObject "System.Xml.Linq.XElement" XName_Item 
	XElement_CBaseArchetypeDef.SetAttributeValue XName_type "CBaseArchetypeDef"
	
	local XElement_lodDist = dotNetObject "System.Xml.Linq.XElement" XName_lodDist
	XElement_lodDist.SetAttributeValue XName_value (obj.radius+100)
	XElement_CBaseArchetypeDef.Add XElement_lodDist
	
	local XElement_flags = dotNetObject "System.Xml.Linq.XElement" XName_flags
	XElement_flags.SetAttributeValue XName_value 0
	XElement_CBaseArchetypeDef.Add XElement_flags
	
	local XElement_specialAttribute = dotNetObject "System.Xml.Linq.XElement" XName_specialAttribute
	XElement_specialAttribute.SetAttributeValue XName_value 0
	XElement_CBaseArchetypeDef.Add XElement_specialAttribute
	
	local XElement_bbMin = dotNetObject "System.Xml.Linq.XElement" XName_bbMin
	XElement_bbMin.SetAttributeValue XName_x obj.aabbmin.x
	XElement_bbMin.SetAttributeValue XName_y obj.aabbmin.y
	XElement_bbMin.SetAttributeValue XName_z obj.aabbmin.z
	XElement_CBaseArchetypeDef.Add XElement_bbMin
	
	local XElement_bbMax = dotNetObject "System.Xml.Linq.XElement" XName_bbMax
	XElement_bbMax.SetAttributeValue XName_x obj.aabbmax.x
	XElement_bbMax.SetAttributeValue XName_y obj.aabbmax.y
	XElement_bbMax.SetAttributeValue XName_z obj.aabbmax.z
	XElement_CBaseArchetypeDef.Add XElement_bbMax
	
	local XElement_bsCentre = dotNetObject "System.Xml.Linq.XElement" XName_bsCentre
	XElement_bsCentre.SetAttributeValue XName_x obj.centroid.x
	XElement_bsCentre.SetAttributeValue XName_y obj.centroid.y
	XElement_bsCentre.SetAttributeValue XName_z obj.centroid.z
	XElement_CBaseArchetypeDef.Add XElement_bsCentre
	
	local XElement_bsRadius = dotNetObject "System.Xml.Linq.XElement" XName_bsRadius
	XElement_bsRadius.SetAttributeValue XName_value obj.radius
	XElement_CBaseArchetypeDef.Add XElement_bsRadius
	
	local XElement_hdTextureDist = dotNetObject "System.Xml.Linq.XElement" XName_hdTextureDist
	XElement_hdTextureDist.SetAttributeValue XName_value (obj.radius+100)
	XElement_CBaseArchetypeDef.Add XElement_hdTextureDist
	
	local XElement_name = dotNetObject "System.Xml.Linq.XElement" XName_name
	XElement_name.SetValue obj.name
	XElement_CBaseArchetypeDef.Add XElement_name
	
	local XElement_textureDictionary = dotNetObject "System.Xml.Linq.XElement" XName_textureDictionary
	XElement_textureDictionary.SetValue obj.txdName
	XElement_CBaseArchetypeDef.Add XElement_textureDictionary
	
	local XElement_clipDictionary = dotNetObject "System.Xml.Linq.XElement" XName_clipDictionary
	XElement_CBaseArchetypeDef.Add XElement_clipDictionary
	
	local XElement_drawableDictionary = dotNetObject "System.Xml.Linq.XElement" XName_drawableDictionary
	XElement_CBaseArchetypeDef.Add XElement_drawableDictionary
	
	local XElement_physicsDictionary = dotNetObject "System.Xml.Linq.XElement" XName_physicsDictionary
	XElement_CBaseArchetypeDef.Add XElement_physicsDictionary
	
	local XElement_assetType = dotNetObject "System.Xml.Linq.XElement" XName_assetType
	XElement_assetType.SetValue "ASSET_TYPE_DRAWABLE"
	XElement_CBaseArchetypeDef.Add XElement_assetType
	
	local XElement_assetName = dotNetObject "System.Xml.Linq.XElement" XName_assetName
	XElement_assetName.SetValue obj.name
	XElement_CBaseArchetypeDef.Add XElement_assetName
	
	local XElement_extensions = dotNetObject "System.Xml.Linq.XElement" XName_extensions
	XElement_CBaseArchetypeDef.Add XElement_extensions
	
	return XElement_CBaseArchetypeDef
)

fn create_YTYP filename=(
	local XDocument_YTYP = dotNetObject "System.Xml.Linq.XDocument"
	XDocument_YTYP.Declaration  = (dotNetObject "System.Xml.Linq.XDeclaration" "1.0" "UTF-8" "no")
	
	local XElement_CMapTypes = dotNetObject "System.Xml.Linq.XElement" XName_CMapTypes
	XDocument_YTYP.Add XElement_CMapTypes
	
	local XElement_extensions = dotNetObject "System.Xml.Linq.XElement" XName_extensions
	XElement_CMapTypes.Add XElement_extensions
	
	local XElement_archetypes = dotNetObject "System.Xml.Linq.XElement" XName_archetypes
	XElement_CMapTypes.Add XElement_archetypes
	
	local XElement_name = dotNetObject "System.Xml.Linq.XElement" XName_name
	XElement_name.SetValue filename
	XElement_CMapTypes.Add XElement_name
	
	local XElement_dependencies = dotNetObject "System.Xml.Linq.XElement" XName_dependencies
	XElement_CMapTypes.Add XElement_dependencies
	
	local XElement_compositeEntityTypes = dotNetObject "System.Xml.Linq.XElement" XName_compositeEntityTypes
	XElement_CMapTypes.Add XElement_compositeEntityTypes
	
	return XDocument_YTYP
)

fn export_YTYP objects_list filename=(
	local filePath = getSaveFileName caption:"Save .ytyp.xml file" filename:(filename+".ytyp.xml") types:"XML Document (*.xml)"
	
	if( filePath != undefined) then
	(
		format "YTYP EXPORTER: %\n\n" (filePath)
		local archetypes_list = #()
		local XDocument_YTYP = create_YTYP filename
		XElement_CMapTypes = XDocument_YTYP.Element XName_CMapTypes
		XElement_archetypes = XElement_CMapTypes.Element XName_archetypes
		for obj in objects_list do
		(
			if((superclassOf obj) == GeometryClass) then
			(
				local archetype = getArchetype(obj)
				if(finditem archetypes_list archetype.name == 0) then
				(
					local XElement_CBaseArchetypeDef = create_CBaseArchetypeDef archetype
					XElement_archetypes.Add XElement_CBaseArchetypeDef
					append archetypes_list archetype.name
				)
				else (format "Duplicated archetype with the name % found, it will be skipped.(Is this an instance?)\n" (obj.name))
			)
			else (format "% is not a Geometry, archetype will be skipped.\n" (obj.name))
		)
		XDocument_YTYP.Save filePath
	)
)

fn create_CEntityDef obj=(
	local XElement_CEntityDef = dotNetObject "System.Xml.Linq.XElement" XName_Item 
	XElement_CEntityDef.SetAttributeValue XName_type "CEntityDef"
	
	local XElement_archetypeName = dotNetObject "System.Xml.Linq.XElement" XName_archetypeName
	XElement_archetypeName.SetValue obj.ENTname
	XElement_CEntityDef.Add XElement_archetypeName
	
	local XElement_flags = dotNetObject "System.Xml.Linq.XElement" XName_flags
	XElement_flags.SetAttributeValue XName_value 0
	XElement_CEntityDef.Add XElement_flags
	
	local XElement_guid = dotNetObject "System.Xml.Linq.XElement" XName_guid
	XElement_guid.SetAttributeValue XName_value (random 1 2147483647)
	XElement_CEntityDef.Add XElement_guid
	
	local XElement_position = dotNetObject "System.Xml.Linq.XElement" XName_position
	XElement_position.SetAttributeValue XName_x obj.ENTposition.x
	XElement_position.SetAttributeValue XName_y obj.ENTposition.y
	XElement_position.SetAttributeValue XName_z obj.ENTposition.z
	XElement_CEntityDef.Add XElement_position
	
	local XElement_rotation = dotNetObject "System.Xml.Linq.XElement" XName_rotation
	XElement_rotation.SetAttributeValue XName_x obj.ENTrotation.x
	XElement_rotation.SetAttributeValue XName_y obj.ENTrotation.y
	XElement_rotation.SetAttributeValue XName_z obj.ENTrotation.z
	XElement_rotation.SetAttributeValue XName_w obj.ENTrotation.w
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

fn export_YMAP objects_list filename = (
	local filePath = getSaveFileName caption:"Save .ymap.xml file" filename:(filename+".ymap.xml") types:"XML Document (*.xml)"
	
	if( filePath != undefined) then
	( 	
		format "YMAP EXPORTER: %\n\n" (filePath)
		local XDocument_YMAP = create_YMAP filename selection.min selection.max /*(objects_list.min) (objects_list.max)*/
		
		XElement_CMapData = XDocument_YMAP.Element XName_CMapData
		XElement_entities = XElement_CMapData.Element XName_entities
		for obj in objects_list do
		(
			local entity = getEntity(obj)
			local XElement_CEntityDef= create_CEntityDef entity
			XElement_entities.Add XElement_CEntityDef
		)
		XDocument_YMAP.Save filePath
	)
)
