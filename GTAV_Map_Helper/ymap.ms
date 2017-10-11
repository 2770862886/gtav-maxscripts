fileIn (scriptspath+"\\GTAV_Map_Helper\\xml.ms")

struct CMapData__Extents
(
	streamingExtentsMin,
	streamingExtentsMax,
	entitiesExtentsMin,
	entitiesExtentsMax
)

struct CEntityDef
(
	archetypeName,
	flags,
	guid,
	_position,
	_rotation,
	scaleXY,
	scaleZ,parentIndex,
	lodDist,
	childLodDist,
	lodLevel,
	numChildren,
	priorityLevel,
	extensions,
	ambientOcclusionMultiplier,
	artificialAmbientOcclusion,
	tintValue
)

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

fn ReadEntitiesFromYmap = 
(
	local filePath = getOpenFileName caption:"Import .ymap.xml file" types:"XML Document (*.xml)"
	
	if(filePath != undefined) then
	(
		format "YMAP READER: %\n\n" (filePath)
		
		local XmlDocument_Ymap = dotNetObject "System.Xml.XmlDocument"
		XmlDocument_Ymap.Load(filePath)
		local XmlElement_entities = XmlDocument_Ymap.SelectNodes("descendant::CMapData/entities/Item")
		local Enumerator = XmlElement_entities.GetEnumerator()
		
		local entities =#()
				
		while Enumerator.MoveNext() do
		(
			local XmlElement_CEntityDef = dotNetObject "System.Xml.XmlElement" Enumerator.Current
			local type = XmlElement_CEntityDef.GetAttribute("type")
			
			if(type == "CEntityDef")then
			(
				local archetypeName = XmlElement_CEntityDef.Item["archetypeName"].InnerText
				local flags = XmlElement_CEntityDef.Item["flags"].GetAttribute("value")
				local guid = XmlElement_CEntityDef.Item["guid"].GetAttribute("value")
	
				local XmlElement_position = XmlElement_CEntityDef.Item["position"]
				local position_x = XmlElement_position.GetAttribute("x") as float
				local position_y = XmlElement_position.GetAttribute("y") as float
				local position_z = XmlElement_position.GetAttribute("z") as float
				local _position = [position_x,position_y,position_z]
				
				local XmlElement_rotation = XmlElement_CEntityDef.Item["rotation"]
				local rotation_x = XmlElement_rotation.GetAttribute("x") as float
				local rotation_y = XmlElement_rotation.GetAttribute("y") as float
				local rotation_z = XmlElement_rotation.GetAttribute("z") as float
				local rotation_w = XmlElement_rotation.GetAttribute("w") as float
				local _rotation = quat rotation_x rotation_y rotation_z rotation_w
				
				local scaleXY = XmlElement_CEntityDef.Item["scaleXY"].GetAttribute("value") as float
				local scaleZ = XmlElement_CEntityDef.Item["scaleZ"].GetAttribute("value") as float
				local parentIndex = XmlElement_CEntityDef.Item["parentIndex"].GetAttribute("value")
				local lodDist = XmlElement_CEntityDef.Item["lodDist"].GetAttribute("value")
				local childLodDist = XmlElement_CEntityDef.Item["childLodDist"].GetAttribute("value")
				local lodLevel = XmlElement_CEntityDef.Item["lodLevel"].InnerText
				local numChildren = XmlElement_CEntityDef.Item["numChildren"].GetAttribute("value")
				local priorityLevel = XmlElement_CEntityDef.Item["priorityLevel"].InnerText
				local extensions = #() --NOT SUPPORTED
				local ambientOcclusionMultiplier = XmlElement_CEntityDef.Item["ambientOcclusionMultiplier"].GetAttribute("value")
				local artificialAmbientOcclusion = XmlElement_CEntityDef.Item["artificialAmbientOcclusion"].GetAttribute("value")
				local tintValue = XmlElement_CEntityDef.Item["tintValue"].GetAttribute("value")
	
				local Entity = CEntityDef archetypeName:archetypeName flags:flags guid:guid _position:_position _rotation:_rotation scaleXY:scaleXY scaleZ:scaleZ parentIndex:parentIndex lodDist:lodDist childLodDist:childLodDist lodLevel:lodLevel numChildren:numChildren priorityLevel:priorityLevel extensions:extensions ambientOcclusionMultiplier:ambientOcclusionMultiplier artificialAmbientOcclusion:artificialAmbientOcclusion tintValue:tintValue
				append entities Entity
			)else
			(
				format "Skipped unsupported %\n" (type)
			)
		)
	)
	return entities
)

fn CheckEntitiesFromYmap =
(
	local entities = ReadEntitiesFromYmap()
	local missing = #()
	if(entities != undefined and entities.count > 0) then
	(
		for entity in entities do
		(
			if( getnodebyname(entity.archetypeName) == undefined ) do
				appendifunique missing entity.archetypeName
		)	
		if(missing !=undefined and missing.count >0 )then
		(
			for item in missing do
				format "MISSING: %\n" (item)
		) else format "No entity missing in scene!\n"
	)else format "The .ymap.xml file doesn't contain any entity.\n"
)

--TODO: CASE SCENE HAS MULTIPLE OBJECTS WITH SAME NAME
fn MoveObjectsByYmap =
(
	local entities = ReadEntitiesFromYmap()
	local instances = #()
			
	if(entities != undefined and entities.count > 0) then
	(
		for entity in entities do
		(
			if( getnodebyname(entity.archetypeName) != undefined )then
			(
				if( finditem instances entity.archetypeName == 0 )then
				(
					format "FOUND: %\n" (entity.archetypeName)
					append instances entity.archetypeName
					selected_node = getnodebyname(entity.archetypeName)
					selected_node.scale = [entity.scaleXY,entity.scaleXY,entity.scaleZ]
					selected_node.rotation = (inverse(entity._rotation))	
					selected_node.pos = entity._position
				)
				else
				(
					instanced_entity
					format "FOUND: % (INSTANCE)\n" (entity.archetypeName)
					selected_node = getnodebyname(entity.archetypeName)
					maxOps.CloneNodes selected_node expandHierarchy:true cloneType:#instance newNodes:&instanced_entity
					instanced_entity.scale = [entity.scaleXY,entity.scaleXY,entity.scaleZ]
					instanced_entity.rotation = (inverse(entity._rotation))	
					instanced_entity.pos = entity._position
					instanced_entity.name = entity.archetypeName
				)	
			)else format "MISSING: %\n" (entity.archetypeName)
		)
	)
)

--TESTING STUFFS
fn WriteEmptyYmap filename =
(
	local XmlDocument = dotNetObject "System.Xml.XmlDocument"
	XmlDocument.appendChild (XmlDocument.CreateXmlDeclaration "1.0" "utf-8" "no")
	local XmlElement_CMapData = XmlDocument.CreateElement "CMapData"
	
	local XmlElement_name = XmlDocument.CreateElement "name"
	XmlElement_name.InnerText = filename
	XmlElement_CMapData.appendChild XmlElement_name
	XmlElement_CMapData.appendChild (XmlDocument.CreateElement "parent")
	local XmlElement_flags = XmlDocument.CreateElement "flags"
	XmlElement_flags.SetAttribute "value" "0"
	XmlElement_CMapData.appendChild XmlElement_flags
	local XmlElement_contentFlags = XmlDocument.CreateElement "contentFlags"
	XmlElement_contentFlags.SetAttribute "value" "0"
	XmlElement_CMapData.appendChild XmlElement_contentFlags
	local XmlElement_streamingExtentsMin = XmlDocument.CreateElement "streamingExtentsMin"
	XmlElement_streamingExtentsMin.SetAttribute "x" "0"
	XmlElement_streamingExtentsMin.SetAttribute "y" "0"
	XmlElement_streamingExtentsMin.SetAttribute "z" "0"
	XmlElement_CMapData.appendChild XmlElement_streamingExtentsMin
	local XmlElement_streamingExtentsMax = XmlDocument.CreateElement "streamingExtentsMax"
	XmlElement_streamingExtentsMax.SetAttribute "x" "0"
	XmlElement_streamingExtentsMax.SetAttribute "y" "0"
	XmlElement_streamingExtentsMax.SetAttribute "z" "0"
	XmlElement_CMapData.appendChild XmlElement_streamingExtentsMax
	local XmlElement_entitiesExtentsMin = XmlDocument.CreateElement "entitiesExtentsMin"
	XmlElement_entitiesExtentsMin.SetAttribute "x" "0"
	XmlElement_entitiesExtentsMin.SetAttribute "y" "0"
	XmlElement_entitiesExtentsMin.SetAttribute "z" "0"
	XmlElement_CMapData.appendChild XmlElement_entitiesExtentsMin
	local XmlElement_entitiesExtentsMax = XmlDocument.CreateElement "entitiesExtentsMax"
	XmlElement_entitiesExtentsMax.SetAttribute "x" "0"
	XmlElement_entitiesExtentsMax.SetAttribute "y" "0"
	XmlElement_entitiesExtentsMax.SetAttribute "z" "0"
	XmlElement_CMapData.appendChild XmlElement_entitiesExtentsMax
	XmlElement_CMapData.appendChild (XmlDocument.CreateElement "entities")
	XmlElement_CMapData.appendChild (XmlDocument.CreateElement "containerLods")
	XmlElement_CMapData.appendChild (XmlDocument.CreateElement "boxOccluders")
	XmlElement_CMapData.appendChild (XmlDocument.CreateElement "occludeModels")
	XmlElement_CMapData.appendChild (XmlDocument.CreateElement "physicsDictionaries")

	local XmlElement_instancedData = XmlDocument.CreateElement "instancedData"
	XmlElement_instancedData.appendChild (XmlDocument.CreateElement "ImapLink")
	XmlElement_instancedData.appendChild (XmlDocument.CreateElement "PropInstanceList")
	XmlElement_instancedData.appendChild (XmlDocument.CreateElement "GrassInstanceList")
	XmlElement_CMapData.appendChild XmlElement_instancedData

	XmlElement_CMapData.appendChild (XmlDocument.CreateElement "timeCycleModifiers")
	XmlElement_CMapData.appendChild (XmlDocument.CreateElement "carGenerators")

	local XmlElement_LODLightsSOA = XmlDocument.CreateElement "LODLightsSOA"
	XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "direction")
	XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "falloff")
	XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "falloffExponent")
	XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "timeAndStateFlags")
	XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "hash")
	XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "coneInnerAngle")
	XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "coneOuterAngleOrCapExt")
	XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "coronaIntensity")
	XmlElement_CMapData.appendChild XmlElement_LODLightsSOA

	local XmlElement_DistantLODLightsSOA = XmlDocument.CreateElement "DistantLODLightsSOA"
	XmlElement_DistantLODLightsSOA.appendChild (XmlDocument.CreateElement "position")
	XmlElement_DistantLODLightsSOA.appendChild (XmlDocument.CreateElement "RGBI")
	local XmlElement_numStreetLights = XmlDocument.CreateElement "numStreetLights"
	XmlElement_numStreetLights.SetAttribute "value" "0"
	XmlElement_DistantLODLightsSOA.appendChild XmlElement_numStreetLights
	local XmlElement_category = XmlDocument.CreateElement "category"
	XmlElement_category.SetAttribute "value" "0"
	XmlElement_DistantLODLightsSOA.appendChild XmlElement_category
	XmlElement_CMapData.appendChild XmlElement_DistantLODLightsSOA

	local XmlElement_block = XmlDocument.CreateElement "block"
	local XmlElement_version = XmlDocument.CreateElement "version"
	XmlElement_version.SetAttribute "value" "0"
	XmlElement_block.appendChild XmlElement_version
	local XmlElement_blockflags = XmlDocument.CreateElement "flags"
	XmlElement_blockflags.SetAttribute "value" "0"
	XmlElement_block.appendChild XmlElement_blockflags
	local XmlElement_blockname = XmlDocument.CreateElement "name"
	XmlElement_blockname.InnerText = filename
	XmlElement_block.appendChild XmlElement_blockname
	local XmlElement_exportedBy = XmlDocument.CreateElement "exportedBy"
	XmlElement_exportedBy.InnerText = "Neos7's Maxscript"
	XmlElement_block.appendChild XmlElement_exportedBy
	local XmlElement_owner = XmlDocument.CreateElement "owner"
	XmlElement_owner.InnerText = sysInfo.username
	XmlElement_block.appendChild XmlElement_owner
	local XmlElement_time = XmlDocument.CreateElement "time"
	XmlElement_time.InnerText = localtime
	XmlElement_block.appendChild XmlElement_time
	XmlElement_CMapData.appendChild XmlElement_block

	XmlDocument.appendChild XmlElement_CMapData
	return XmlDocument
)