fileIn (scriptspath+"\\GTAV_Map_Helper\\xml.ms")
rnd = dotNetObject "System.Random"

struct CMapData__Extents
(
	streamingExtentsMin = [8192,8192,8192],
	streamingExtentsMax = [-8192,-8192,-8192],
	entitiesExtentsMin = [8192,8192,8192],
	entitiesExtentsMax = [-8192,-8192,-8192]
)

struct CBlockDesc
(
	version,
	flags,
	_name,
	exportedBy = "Neos7's Maxscript",
	owner = sysInfo.username,
	_time = localtime
)

struct CEntityDef
(
	archetypeName,
	flags,
	guid,
	_position,
	_rotation,
	scaleXY,
	scaleZ,
	parentIndex,
	lodDist,
	childLodDist,
	lodLevel,
	numChildren,
	priorityLevel,
	extensions,
	ambientOcclusionMultiplier,
	artificialAmbientOcclusion,
	tintValue,

	fn WriteXML =
	(
		local XmlDocument = dotNetObject "System.Xml.XmlDocument"
		local XmlElement_Item = XmlDocument.CreateElement "Item"
		XmlElement_Item.SetAttribute "type" "CEntityDef"

		local XmlElement_archetypeName = XmlDocument.CreateElement "archetypeName"
		XmlElement_archetypeName.InnerText = archetypeName
		XmlElement_Item.appendChild XmlElement_archetypeName

		local XmlElement_flags = XmlDocument.CreateElement "flags"
		XmlElement_flags.SetAttribute "value" (flags as string)
		XmlElement_Item.appendChild XmlElement_flags

		local XmlElement_guid = XmlDocument.CreateElement "guid"
		XmlElement_guid.SetAttribute "value" (guid as string)
		XmlElement_Item.appendChild XmlElement_guid

		local XmlElement_position = XmlDocument.CreateElement "position"
		XmlElement_position.SetAttribute "x" (_position.x as string)
		XmlElement_position.SetAttribute "y" (_position.y as string)
		XmlElement_position.SetAttribute "z" (_position.z as string)
		XmlElement_Item.appendChild XmlElement_position

		local XmlElement_rotation = XmlDocument.CreateElement "rotation"
		XmlElement_rotation.SetAttribute "x" (_rotation.x as string)
		XmlElement_rotation.SetAttribute "y" (_rotation.y as string)
		XmlElement_rotation.SetAttribute "z" (_rotation.z as string)
		XmlElement_rotation.SetAttribute "w" (_rotation.w as string)
		XmlElement_Item.appendChild XmlElement_rotation

		local XmlElement_scaleXY = XmlDocument.CreateElement "scaleXY"
		XmlElement_scaleXY.SetAttribute "value" (scaleXY as string)
		XmlElement_Item.appendChild XmlElement_scaleXY

		local XmlElement_scaleZ = XmlDocument.CreateElement "scalez"
		XmlElement_scaleZ.SetAttribute "value" (scaleZ as string)
		XmlElement_Item.appendChild XmlElement_scaleZ

		local XmlElement_parentIndex = XmlDocument.CreateElement "parentIndex"
		XmlElement_parentIndex.SetAttribute "value" (parentIndex as string)
		XmlElement_Item.appendChild XmlElement_parentIndex

		local XmlElement_lodDist = XmlDocument.CreateElement "lodDist"
		XmlElement_lodDist.SetAttribute "value" (lodDist as string)
		XmlElement_Item.appendChild XmlElement_lodDist

		local XmlElement_childLodDist = XmlDocument.CreateElement "childLodDist"
		XmlElement_childLodDist.SetAttribute "value" (childLodDist as string)
		XmlElement_Item.appendChild XmlElement_childLodDist

		local XmlElement_lodLevel = XmlDocument.CreateElement "lodLevel"
		XmlElement_lodLevel.InnerText = lodLevel
		XmlElement_Item.appendChild XmlElement_lodLevel

		local XmlElement_numChildren = XmlDocument.CreateElement "numChildren"
		XmlElement_numChildren.SetAttribute "value" (numChildren as string)
		XmlElement_Item.appendChild XmlElement_numChildren

		local XmlElement_priorityLevel = XmlDocument.CreateElement "priorityLevel"
		XmlElement_priorityLevel.InnerText = priorityLevel
		XmlElement_Item.appendChild XmlElement_priorityLevel

		local XmlElement_extensions = XmlDocument.CreateElement "extensions"--TODO
		XmlElement_Item.appendChild XmlElement_extensions

		local XmlElement_ambientOcclusionMultiplier = XmlDocument.CreateElement "ambientOcclusionMultiplier"
		XmlElement_ambientOcclusionMultiplier.SetAttribute "value" (ambientOcclusionMultiplier as string)
		XmlElement_Item.appendChild XmlElement_ambientOcclusionMultiplier

		local XmlElement_artificialAmbientOcclusion = XmlDocument.CreateElement "artificialAmbientOcclusion"
		XmlElement_artificialAmbientOcclusion.SetAttribute "value" (artificialAmbientOcclusion as string)
		XmlElement_Item.appendChild XmlElement_artificialAmbientOcclusion

		local XmlElement_tintValue = XmlDocument.CreateElement "tintValue"
		XmlElement_tintValue.SetAttribute "value" (tintValue as string)
		XmlElement_Item.appendChild XmlElement_tintValue

		XmlDocument.appendChild XmlElement_Item
		return XmlDocument
	)
)

struct CMapData
(
	_name,
	parent,
	flags,
	contentFlags,
	streamingExtentsMin,
	streamingExtentsMax,
	entitiesExtentsMin,
	entitiesExtentsMax,
	entities,
	containerLods,
	boxOccluders,
	occludeModels,
	physicsDictionaries,
	instancedData,
	timeCycleModifiers,
	carGenerators,
	LODLightsSOA,
	DistantLODLightsSOA,
	_block,

	fn WriteXML =
	(
		local XmlDocument = dotNetObject "System.Xml.XmlDocument"
		XmlDocument.appendChild (XmlDocument.CreateXmlDeclaration "1.0" "utf-8" "no")
		local XmlElement_CMapData = XmlDocument.CreateElement "CMapData"
		
		local XmlElement_name = XmlDocument.CreateElement "name"
		if(_name != undefined and _name != "") do 
			XmlElement_name.InnerText = _name
		XmlElement_CMapData.appendChild XmlElement_name

		local XmlElement_parent = XmlDocument.CreateElement "parent"
		if(parent != undefined and parent != "") do 
			XmlElement_parent.InnerText = parent
		XmlElement_CMapData.appendChild XmlElement_parent

		local XmlElement_flags = XmlDocument.CreateElement "flags"
		XmlElement_flags.SetAttribute "value" (flags as string)
		XmlElement_CMapData.appendChild XmlElement_flags

		local XmlElement_contentFlags = XmlDocument.CreateElement "contentFlags"
		XmlElement_contentFlags.SetAttribute "value" (contentFlags as string)
		XmlElement_CMapData.appendChild XmlElement_contentFlags

		local XmlElement_streamingExtentsMin = XmlDocument.CreateElement "streamingExtentsMin"
		XmlElement_streamingExtentsMin.SetAttribute "x" (streamingExtentsMin.x as string)
		XmlElement_streamingExtentsMin.SetAttribute "y" (streamingExtentsMin.y as string)
		XmlElement_streamingExtentsMin.SetAttribute "z" (streamingExtentsMin.z as string)
		XmlElement_CMapData.appendChild XmlElement_streamingExtentsMin

		local XmlElement_streamingExtentsMax = XmlDocument.CreateElement "streamingExtentsMax"
		XmlElement_streamingExtentsMax.SetAttribute "x" (streamingExtentsMax.x as string)
		XmlElement_streamingExtentsMax.SetAttribute "y" (streamingExtentsMax.y as string)
		XmlElement_streamingExtentsMax.SetAttribute "z" (streamingExtentsMax.z as string)
		XmlElement_CMapData.appendChild XmlElement_streamingExtentsMax

		local XmlElement_entitiesExtentsMin = XmlDocument.CreateElement "entitiesExtentsMin"
		XmlElement_entitiesExtentsMin.SetAttribute "x" (entitiesExtentsMin.x as string)
		XmlElement_entitiesExtentsMin.SetAttribute "y" (entitiesExtentsMin.y as string)
		XmlElement_entitiesExtentsMin.SetAttribute "z" (entitiesExtentsMin.z as string)
		XmlElement_CMapData.appendChild XmlElement_entitiesExtentsMin

		local XmlElement_entitiesExtentsMax = XmlDocument.CreateElement "entitiesExtentsMax"
		XmlElement_entitiesExtentsMax.SetAttribute "x" (entitiesExtentsMax.x as string)
		XmlElement_entitiesExtentsMax.SetAttribute "y" (entitiesExtentsMax.y as string)
		XmlElement_entitiesExtentsMax.SetAttribute "z" (entitiesExtentsMax.z as string)
		XmlElement_CMapData.appendChild XmlElement_entitiesExtentsMax
		
		local XmlElement_entities = XmlDocument.CreateElement "entities"
		if(entities != undefined and entities.count > 0)do
		(
			for entity in entities do
			(
				local XmlElement_entity = XmlDocument.ImportNode (entity.WriteXML()).DocumentElement true
				XmlElement_entities.appendChild XmlElement_entity
			)
		)
		XmlElement_CMapData.appendChild XmlElement_entities

		XmlElement_CMapData.appendChild (XmlDocument.CreateElement "containerLods")---TO DO
		XmlElement_CMapData.appendChild (XmlDocument.CreateElement "boxOccluders")---TO DO
		XmlElement_CMapData.appendChild (XmlDocument.CreateElement "occludeModels")---TO DO
		
		local XmlElement_physicsDictionaries = XmlDocument.CreateElement "physicsDictionaries"
		if(physicsDictionaries != undefined and physicsDictionaries.count > 0)do
		(
			for physicsDictionary in physicsDictionaries do
			(
				local XmlElement_physicsDictionary = XmlDocument.CreateElement "Item"
				XmlElement_physicsDictionary.InnerText = physicsDictionary
				XmlElement_physicsDictionaries.appendChild XmlElement_physicsDictionary
			)
		)
		XmlElement_CMapData.appendChild XmlElement_physicsDictionaries
		

		if(instancedData.GrassInstanceList != undefined and instancedData.GrassInstanceList.count > 0)then
		(
			local XmlElement_instancedData = XmlDocument.ImportNode (instancedData.WriteXML()).DocumentElement true
			XmlElement_CMapData.appendChild XmlElement_instancedData
		)else
		(
			local XmlElement_instancedData = XmlDocument.CreateElement "instancedData"
			XmlElement_instancedData.appendChild (XmlDocument.CreateElement "ImapLink")
			XmlElement_instancedData.appendChild (XmlDocument.CreateElement "PropInstanceList")
			XmlElement_instancedData.appendChild (XmlDocument.CreateElement "GrassInstanceList")
			XmlElement_CMapData.appendChild XmlElement_instancedData
		)
	
		XmlElement_CMapData.appendChild (XmlDocument.CreateElement "timeCycleModifiers")---TO DO
		XmlElement_CMapData.appendChild (XmlDocument.CreateElement "carGenerators")---TO DO
	
		local XmlElement_LODLightsSOA = XmlDocument.CreateElement "LODLightsSOA"---TO DO
		XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "direction")
		XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "falloff")
		XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "falloffExponent")
		XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "timeAndStateFlags")
		XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "hash")
		XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "coneInnerAngle")
		XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "coneOuterAngleOrCapExt")
		XmlElement_LODLightsSOA.appendChild (XmlDocument.CreateElement "coronaIntensity")
		XmlElement_CMapData.appendChild XmlElement_LODLightsSOA
	
		local XmlElement_DistantLODLightsSOA = XmlDocument.CreateElement "DistantLODLightsSOA"---TO DO
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
		XmlElement_version.SetAttribute "value" (_block.version as string)
		XmlElement_block.appendChild XmlElement_version
		local XmlElement_blockflags = XmlDocument.CreateElement "flags"
		XmlElement_blockflags.SetAttribute "value" (_block.flags as string)
		XmlElement_block.appendChild XmlElement_blockflags
		local XmlElement_blockname = XmlDocument.CreateElement "name"
		XmlElement_blockname.InnerText = (_block._name as string)
		XmlElement_block.appendChild XmlElement_blockname
		local XmlElement_exportedBy = XmlDocument.CreateElement "exportedBy"
		XmlElement_exportedBy.InnerText = (_block.exportedBy as string)
		XmlElement_block.appendChild XmlElement_exportedBy
		local XmlElement_owner = XmlDocument.CreateElement "owner"
		XmlElement_owner.InnerText = (_block.owner as string)
		XmlElement_block.appendChild XmlElement_owner
		local XmlElement_time = XmlDocument.CreateElement "time"
		XmlElement_time.InnerText = (_block._time as string)
		XmlElement_block.appendChild XmlElement_time
		XmlElement_CMapData.appendChild XmlElement_block
	
		XmlDocument.appendChild XmlElement_CMapData
		return XmlDocument
	)
)

fn CreateCMapData settings =
(
	local _name = settings[1]
	local parent = settings[2]
	local flags = settings[3]
	local contentFlags = settings[4]
	local streamingExtentsMin = [0,0,0]
	local streamingExtentsMax = [0,0,0]
	local entitiesExtentsMin = [0,0,0]
	local entitiesExtentsMax = [0,0,0]
	local entities = #()
	local containerLods = #()
	local boxOccluders = #()
	local occludeModels = #()
	local physicsDictionaries = #()
	local instancedData = rage__fwInstancedMapData()
	local timeCycleModifiers = #()
	local carGenerators = #()
	local LODLightsSOA = #()
	local DistantLODLightsSOA = #()
	local _block = CBlockDesc version:0 flags:0 _name:"Custom"

	local MapData = CMapData _name:_name parent:parent flags:flags contentFlags:contentFlags streamingExtentsMin:streamingExtentsMin streamingExtentsMax:streamingExtentsMax entitiesExtentsMin:entitiesExtentsMin entitiesExtentsMax:entitiesExtentsMax entities:entities containerLods:containerLods boxOccluders:boxOccluders occludeModels:occludeModels physicsDictionaries:physicsDictionaries instancedData:instancedData timeCycleModifiers:timeCycleModifiers carGenerators:carGenerators LODLightsSOA:LODLightsSOA DistantLODLightsSOA:DistantLODLightsSOA _block:_block
	return MapData
)

fn EntityFromGeometry obj settings =
(	
	local archetypeName = obj.name
	local flags = settings[1]
	--local guid = random 1 4294967295
	local guid = rnd.Next()
	local _position = (in coordsys world obj.pos)
	local _rotation = inverse(in coordsys world obj.rotation)
	local scaleXY = 1
	local scaleZ = 1
	local parentIndex = -1
	local lodDist = 100 + (1.5 * (distance obj.max obj.min)/2)
	local childLodDist = 0
	local lodLevel = settings[2]
	local numChildren = 0
	local priorityLevel = settings[3]
	local extensions = #()
	local ambientOcclusionMultiplier = 255
	local artificialAmbientOcclusion = 255
	local tintValue = 0

	local Entity = CEntityDef archetypeName:archetypeName flags:flags guid:guid _position:_position _rotation:_rotation scaleXY:scaleXY scaleZ:scaleZ parentIndex:parentIndex lodDist:lodDist childLodDist:childLodDist lodLevel:lodLevel numChildren:numChildren priorityLevel:priorityLevel extensions:extensions ambientOcclusionMultiplier:ambientOcclusionMultiplier artificialAmbientOcclusion:artificialAmbientOcclusion tintValue:tintValue
	return Entity
)

fn ExportYmap CMapData =(
	local filePath = getSaveFileName caption:"Save .ymap.xml file" filename:(CMapData._name+".ymap.xml") types:"Ymap XML Document (*.ymap.xml)"
	if( filePath != undefined) then
	( 	
		format "YMAP EXPORTER: %\n\n" (filePath)
		local XmlDocument = CMapData.WriteXML()
		XmlDocument.Save(filePath)
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