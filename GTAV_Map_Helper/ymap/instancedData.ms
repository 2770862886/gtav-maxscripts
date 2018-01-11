fileIn (scriptspath+"\\GTAV_Map_Helper\\ymap\\CMapData.ms")

fn BatchFromDummy dummyBox =
(
	local bbmax = [dummyBox.max.x,dummyBox.max.y,dummyBox.max.z,0]
	local bbmin = [dummyBox.min.x,dummyBox.min.y,dummyBox.min.z,0]
	local batch = rage__spdAABB _min:bbmin _max:bbmax
	return batch
)

fn InstanceDataFromMesh batch obj settings =
(
	local NormalX = ((obj.dir.x +1)*0.5 * 255) as integer
	local NormalY = ((obj.dir.y +1)*0.5 * 255) as integer

	local _Scale = settings[1]
	local Colors = settings[2]
	local Ao = settings[3]
	local Pad = settings[4]
	
    local world_pos = obj.position
    local batch_pos = (world_pos - batch._min)/(batch._max-batch._min) * 65535 
	local new_pos = #(batch_pos.x as integer,batch_pos.y as integer,batch_pos.z as integer)
	
    local InstanceData = rage__fwGrassInstanceListDef__InstanceData Position:new_pos NormalX:NormalX NormalY:NormalY _Color:Colors _Scale:_Scale Ao:Ao Pad:Pad
    return InstanceData
)

fn GrassInstanceListFromMeshes objList dummyBox BatchSettings InstancesSettings =
(
	local batch = BatchFromDummy dummyBox
	local ScaleRange = BatchSettings[1]
	local archetypeName = objList[1].name  -- TODO: BE SURE ALL THE INSTANCES USE THE SAME ARCHETYPE
	local lodDist = BatchSettings[3]
	local LodFadeStartDist = BatchSettings[4]
	local LodInstFadeRange = BatchSettings[5]
	local OrientToTerrain = BatchSettings[6]
	local InstanceList = #()
	
	for obj in objList do
	(
		local settings = deepCopy InstancesSettings	
		if(InstancesSettings[1] == -1)do(settings[1] = random 1 255)
		
		if(InstancesSettings[2][1] == -1)do(settings[2][1] = random 0 255)
		if(InstancesSettings[2][2] == -1)do(settings[2][2] = random 0 255)
		if(InstancesSettings[2][3] == -1)do(settings[2][3] = random 0 255)
		
		local InstanceData = InstanceDataFromMesh batch obj settings
		append InstanceList InstanceData
	)
	local GrassInstanceList = rage__fwGrassInstanceListDef BatchAABB:batch ScaleRange:ScaleRange archetypeName:archetypeName	lodDist:lodDist	LodFadeStartDist:LodFadeStartDist LodInstFadeRange:LodInstFadeRange	OrientToTerrain:OrientToTerrain InstanceList:InstanceList
)

fn ReadGrassFromXML = 
(
	local filePath = getOpenFileName caption:"Import .ymap.xml file" types:"XML Document (*.xml)"
	
	if(filePath != undefined) then
	(
		format "YMAP READER: %\n\n" (filePath)
		
		local XmlDocument_Ymap = dotNetObject "System.Xml.XmlDocument"
		XmlDocument_Ymap.Load(filePath)
		local XmlElement_GrassInstanceList = XmlDocument_Ymap.SelectNodes("descendant::CMapData/instancedData/GrassInstanceList/Item")
		local GrassInstanceList_Enumerator = XmlElement_GrassInstanceList.GetEnumerator()

		local GrassInstanceList = #()

		while GrassInstanceList_Enumerator.MoveNext() do
		(
			local XmlElement_GrassInstanceList_Item = dotNetObject "System.Xml.XmlElement" GrassInstanceList_Enumerator.Current
			
			local XmlElement_BatchAABB = XmlElement_GrassInstanceList_Item.Item["BatchAABB"]
			
			local XmlElement_BatchAABB_min = XmlElement_BatchAABB.Item["min"]
			local min_x = XmlElement_BatchAABB_min.GetAttribute("x") as double
			local min_y = XmlElement_BatchAABB_min.GetAttribute("y") as double
			local min_z = XmlElement_BatchAABB_min.GetAttribute("z") as double
			local min_w = XmlElement_BatchAABB_min.GetAttribute("w") as double
			local XmlElement_BatchAABB_max = XmlElement_BatchAABB.Item["max"]
			local max_x = XmlElement_BatchAABB_max.GetAttribute("x") as double
			local max_y = XmlElement_BatchAABB_max.GetAttribute("y") as double
			local max_z = XmlElement_BatchAABB_max.GetAttribute("z") as double
			local max_w = XmlElement_BatchAABB_max.GetAttribute("w") as double
			
			local bbmin = [min_x,min_y,min_z,min_w]
			local bbmax = [max_x,max_y,max_z,max_w]
			local batch = rage__spdAABB _min:bbmin _max:bbmax

			local XmlElement_ScaleRange = XmlElement_GrassInstanceList_Item.Item["ScaleRange"]
			local ScaleRange_x = XmlElement_ScaleRange.GetAttribute("x") as float
			local ScaleRange_y = XmlElement_ScaleRange.GetAttribute("y") as float
			local ScaleRange_z = XmlElement_ScaleRange.GetAttribute("z") as float
			local ScaleRange = [ScaleRange_x,ScaleRange_y,ScaleRange_z]

			local grass_archetypeName = XmlElement_GrassInstanceList_Item.Item["archetypeName"].InnerText
			local grass_lodDist = XmlElement_GrassInstanceList_Item.Item["lodDist"].GetAttribute("value") as float
			local LodFadeStartDist = XmlElement_GrassInstanceList_Item.Item["LodFadeStartDist"].GetAttribute("value") as float
			local LodInstFadeRange = XmlElement_GrassInstanceList_Item.Item["LodInstFadeRange"].GetAttribute("value") as float
			local OrientToTerrain = XmlElement_GrassInstanceList_Item.Item["OrientToTerrain"].GetAttribute("value") as float

			local XmlElement_InstanceList = XmlElement_GrassInstanceList_Item.SelectNodes("descendant::InstanceList/Item")
			local InstanceList_Enumerator = XmlElement_InstanceList.GetEnumerator()

			local InstanceList = #()
			
			while InstanceList_Enumerator.MoveNext() do
			(
				local XmlElement_Instance = dotNetObject "System.Xml.XmlElement" InstanceList_Enumerator.Current

				local Instance_Position = XmlElement_Instance.Item["Position"].InnerText
				local Instance_Position_Array = (DotNetObject "System.String" Instance_Position).Split("\n")
				local Position_x = (DotNetObject "System.String" Instance_Position_Array[2]).Trim() as integer
				local Position_y = (DotNetObject "System.String" Instance_Position_Array[3]).Trim() as integer
				local Position_z = (DotNetObject "System.String" Instance_Position_Array[4]).Trim() as integer
				local Position = [Position_x,Position_y,Position_z]

				local NormalX = XmlElement_Instance.Item["NormalX"].GetAttribute("value") as integer
				local NormalY = XmlElement_Instance.Item["NormalY"].GetAttribute("value") as integer

				local Instance_Color = XmlElement_Instance.Item["Color"].InnerText
				local Instance_Color_Array = (DotNetObject "System.String" Instance_Color).Split("\n")
				local Color_Array_R = (DotNetObject "System.String" Instance_Color_Array[2]).Trim() as integer
				local Color_Array_G = (DotNetObject "System.String" Instance_Color_Array[3]).Trim() as integer
				local Color_Array_B = (DotNetObject "System.String" Instance_Color_Array[4]).Trim() as integer
				local _Color = [Color_Array_R,Color_Array_G,Color_Array_B]

				local _Scale = XmlElement_Instance.Item["Scale"].GetAttribute("value") as integer
				local Ao = XmlElement_Instance.Item["Ao"].GetAttribute("value") as integer

				local Instance_Pad = XmlElement_Instance.Item["Pad"].InnerText
				local Instance_Pad_Array = (DotNetObject "System.String" Instance_Pad).Split("\n")
				local Instance_Pad_x = (DotNetObject "System.String" Instance_Pad_Array[2]).Trim() as integer
				local Instance_Pad_y = (DotNetObject "System.String" Instance_Pad_Array[3]).Trim() as integer
				local Instance_Pad_z = (DotNetObject "System.String" Instance_Pad_Array[4]).Trim() as integer
				local Pad = [Instance_Pad_x,Instance_Pad_y,Instance_Pad_z]

				local InstanceData = rage__fwGrassInstanceListDef__InstanceData Position:Position NormalX:NormalX NormalY:NormalY _Color:_Color _Scale:_Scale Ao:Ao Pad:Pad
				append InstanceList InstanceData
			)

			local GrassInstanceList_Item = rage__fwGrassInstanceListDef BatchAABB:batch ScaleRange:ScaleRange archetypeName:grass_archetypeName lodDist:grass_lodDist LodFadeStartDist:LodFadeStartDist LodInstFadeRange:LodInstFadeRange OrientToTerrain:OrientToTerrain InstanceList:InstanceList
			append GrassInstanceList GrassInstanceList_Item
		)
	)
	return GrassInstanceList
)

fn CheckGrassFromYmap =
(
	local GrassInstanceList = ReadGrassFromXML()
	local missing = #()
	if(GrassInstanceList != undefined and GrassInstanceList.count > 0) then
	(
		for grass in GrassInstanceList do
		(
			if( getnodebyname(grass.archetypeName) == undefined ) do
				appendifunique missing grass.archetypeName
		)	
		if(missing !=undefined and missing.count >0 )then
		(
			for item in missing do
				format "MISSING: %\n" (item)
		) else format "No mesh missing in scene!\n"
	)else format "The .ymap.xml file doesn't contain any batch of grass.\n"
)

fn InstanceDataFromXML =
(
	local GrassInstanceList = ReadGrassFromXML()

	if(GrassInstanceList != undefined and GrassInstanceList.count > 0) then
	(
		with redraw off
		(
			for grass in GrassInstanceList do
			(
				batchDummy = Dummy()
				batchDummy.name = uniquename("Batch_")
		
				Batch_max = [grass.BatchAABB._max.x,grass.BatchAABB._max.y,grass.BatchAABB._max.z]
				Batch_min = [grass.BatchAABB._min.x,grass.BatchAABB._min.y,grass.BatchAABB._min.z]
				Batch_position = (Batch_max + Batch_min)/2
				Batch_size = Batch_max - Batch_min
					
				batchDummy.position = Batch_position
				batchDummy.boxsize = Batch_size
					
				for instanceGrass in grass.InstanceList do
				(
					local grassMesh = InstanceGrassAsset grass.archetypeName
					grassMesh.parent = batchDummy
					
					grassMesh.pos = ((instanceGrass.Position/65535)*(Batch_size))+Batch_min
					grassMesh.dir.y = ((instanceGrass.NormalY/255.0)/0.5)-1.0
					grassMesh.dir.x = ((instanceGrass.NormalX/255.0)/0.5)-1.0
					--grassMesh.dir.y = instanceGrass.NormalY*0.0078431373 - 1.0
					--grassMesh.dir.x = instanceGrass.NormalX*0.0078431373 - 1.0


					--grassMesh.scale = [instanceGrass._Scale,instanceGrass._Scale,instanceGrass._Scale]
					--handle others properties..
				)
			)
		)
	)
)


/*
fn ColorFromFaceTexture obj faceIndex bitmapName = 
(
	--local obj = snapshotAsMesh theobj
	local mapChannel = 1
	
	if(polyop.getMapSupport obj mapChannel) then
	(
		
		--local matID = polyop.getFaceMatID obj faceIndex
		--local mat = obj.material[matID]
		--local matDiffuseMap = mat.diffuseMap
		--local bitmapTest = openBitMap matDiffuseMap.filename
		local bitmapTest = bitmapName
		
		local colorAvg = color 0 0 0
		local mapFace = polyop.getMapFace obj mapChannel faceIndex
		local faceVerts = polyop.getFaceVerts obj faceIndex
		
		for vertIndex = 1 to faceVerts.count do
		(
			local mapVert = polyop.getMapVert obj mapChannel mapFace[vertIndex] --vertices uv map
			
			--vertices absolute uv map
			local myPoint = point2 (mod mapVert.x 1) (mod mapVert.y 1) --TEMP
			if (myPoint.x < 0) do (myPoint.x = 1 + myPoint.x) --TEMP
			if (myPoint.y < 0) do (myPoint.y = 1 + myPoint.y) --TEMP

			local pixelPoint = point2 (myPoint.x*bitmapTest.width) (myPoint.y*bitmapTest.height) --pixel from vertices uv map
			local pixelColor = getPixels bitmapTest pixelPoint 1 --rgb of the pixel
			colorAvg = colorAvg + pixelColor[1]
		)
		colorAvg.r = (colorAvg.r/faceVerts.count)
		colorAvg.g = (colorAvg.g/faceVerts.count)
		colorAvg.b = (colorAvg.b/faceVerts.count)

		close bitmapTest
		return colorAvg
	)
	else
	(
		format "Map Channel % undefined" mapChannel 
	)
)

fn BatchFromFaces obj faces =
(
	local bbmax = [-65536,-65536,-65536,0]
	local bbmin = [65536,65536,65536,0]
	
	for index in faces do
	(
		local vertices = polyop.getFaceVerts obj index
		for vertex in vertices do
		(
			local vertex_position = polyop.getVert obj vertex
			bbmax.x = amax bbmax.x vertex_position.x
			bbmax.y = amax bbmax.y vertex_position.y
			bbmax.z = amax bbmax.z vertex_position.z
			bbmin.x = amin bbmin.x vertex_position.x
			bbmin.y = amin bbmin.y vertex_position.y
			bbmin.z = amin bbmin.z vertex_position.z
		)
	)
	local batch = rage__spdAABB _min:bbmin _max:bbmax
	return batch
)

fn InstanceDataFromFace batch obj face settings =
(
	local FaceNormal = polyop.getFaceNormal obj face
	local NormalX = ((FaceNormal.x +1)*0.5 * 255) as integer
	local NormalY = ((FaceNormal.y +1)*0.5 * 255) as integer

	local _Scale = settings[1]
	local Colors = settings[2]
	local Ao = settings[3]
	local Pad = settings[4]
	
    local world_pos = polyop.getFaceCenter obj face
    local batch_pos = (world_pos - batch._min)/(batch._max-batch._min) * 65535 
	local new_pos = #(batch_pos.x as integer,batch_pos.y as integer,batch_pos.z as integer)
	
    local InstanceData = rage__fwGrassInstanceListDef__InstanceData Position:new_pos NormalX:NormalX NormalY:NormalY _Color:Colors _Scale:_Scale Ao:Ao Pad:Pad
    return InstanceData
)

fn GrassInstanceListFromFaces obj faces BatchSettings InstancesSettings bitmapName =
(
	local batch = BatchFromFaces obj faces
	local ScaleRange = BatchSettings[1]
	local archetypeName = BatchSettings[2]
	local lodDist = BatchSettings[3]
	local LodFadeStartDist = BatchSettings[4]
	local LodInstFadeRange = BatchSettings[5]
	local OrientToTerrain = BatchSettings[6]
	local InstanceList = #()
	
	for face in faces do
	(
		local settings = deepCopy InstancesSettings	
		if(InstancesSettings[1] == -1)do(settings[1] = random 1 255)
		
		if((InstancesSettings[2][1] == -2) and (InstancesSettings[2][2] == -2) and (InstancesSettings[2][3] == -2))then
		(
			bitmapColor = ColorFromFaceTexture obj face bitmapName
			settings[2][1] = bitmapColor.r as integer
			settings[2][2] = bitmapColor.g as integer
			settings[2][3] = bitmapColor.b as integer
		)else 
		(
			if(InstancesSettings[2][1] == -1)do(settings[2][1] = random 0 255)
			if(InstancesSettings[2][2] == -1)do(settings[2][2] = random 0 255)
			if(InstancesSettings[2][3] == -1)do(settings[2][3] = random 0 255)
		)
		
		local InstanceData = InstanceDataFromFace batch obj face settings
		append InstanceList InstanceData
	)
	local GrassInstanceList = rage__fwGrassInstanceListDef BatchAABB:batch ScaleRange:ScaleRange	archetypeName:archetypeName	lodDist:lodDist	LodFadeStartDist:LodFadeStartDist LodInstFadeRange:LodInstFadeRange	OrientToTerrain:OrientToTerrain InstanceList:InstanceList
)*/