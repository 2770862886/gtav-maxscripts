fileIn (scriptspath+"\\GTAV_Map_Helper\\ymap\\entities.ms")

fn ReadYmapXML filePath = 
(
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
			archetypeName = ToLower archetypeName
			local flags = XmlElement_CEntityDef.Item["flags"].GetAttribute("value")
			local guid = XmlElement_CEntityDef.Item["guid"].GetAttribute("value")

			local XmlElement_position = XmlElement_CEntityDef.Item["position"]
			local position_x = XmlElement_position.GetAttribute("x") as double
			local position_y = XmlElement_position.GetAttribute("y") as double
			local position_z = XmlElement_position.GetAttribute("z") as double
			local _position = [position_x,position_y,position_z]
			
			local XmlElement_rotation = XmlElement_CEntityDef.Item["rotation"]
			local rotation_x = XmlElement_rotation.GetAttribute("x") as double
			local rotation_y = XmlElement_rotation.GetAttribute("y") as double
			local rotation_z = XmlElement_rotation.GetAttribute("z") as double
			local rotation_w = XmlElement_rotation.GetAttribute("w") as double
			local _rotation = quat rotation_x rotation_y rotation_z rotation_w
			
			local scaleXY = XmlElement_CEntityDef.Item["scaleXY"].GetAttribute("value") as double
			local scaleZ = XmlElement_CEntityDef.Item["scaleZ"].GetAttribute("value") as double
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
	return entities
)

fn LoadModelsYmap =
(
	
	local ymapPath = getOpenFileName caption:"Import .ymap.xml file" types:"XML Document (*.xml)"
	if(ymapPath != undefined) then
	(
		format "Reading %\n\n" (ymapPath)
		local entities = ReadYmapXML ymapPath
	)

	local directoryPath = getFilenamePath ymapPath

	local Files = #()

	local TexPaths = GetDirectories (directoryPath+"/*")
	for d in TexPaths do
	  join TexPaths (GetDirectories (d+"/*"))

	for entity in entities do 
	( 
		appendifunique Files (directoryPath+entity.archetypeName+".odr")
		appendifunique TexPaths (directoryPath+entity.archetypeName+"/")
	)

	--assuming "Files" variable contains file paths array...
	--and "TexPaths" variable contains texture paths array...

	if No GIMS.V then
	 throw "GIMS.V not found"
	if not GIMS.V.Loaded then
	 GIMS.V.Start GIMS.V NoEH:true
	local ymapNode = dummy()
	ymapNode.name = filenameFromPath ymapPath
	local instanced = #()
	for File in Files do 
	(
		format "Importing %\n\n" (File)
		
		local Obj = (GIMS.V.Core.MAXFactory.ObjectMgr.StructFromFile File TexPaths)
		if Have Obj then 
		(
			local ObjNode = Obj.Create RootNode
			
			for entity in entities where (entity.archetypeName == ObjNode.name)do
			(
				index = findItem entities entity
				
				if(findItem instanced ObjNode.name == 0)then
				(
					ObjNode.scale = [entity.scaleXY,entity.scaleXY,entity.scaleZ]
					ObjNode.rotation = (inverse(entity._rotation))	
					ObjNode.pos = entity._position
					ObjNode.parent = ymapNode
					appendifunique instanced entity.archetypeName
				)else
				(
					format "Instanced %\n\n" (entity.archetypeName)
					
					maxOps.CloneNodes ObjNode expandHierarchy:true cloneType:#instance newNodes:&instancedNode
					instancedNode.scale = [entity.scaleXY,entity.scaleXY,entity.scaleZ]
					instancedNode.rotation = (inverse(entity._rotation))	
					instancedNode.pos = entity._position
					instancedNode.name = entity.archetypeName
					--instancedNode.parent = ymapNode
				)
			)
		)
	)
)

LoadModelsYmap()