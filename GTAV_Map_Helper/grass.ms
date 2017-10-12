fileIn (scriptspath+"\\GTAV_Map_Helper\\ymap.ms")

struct rage__fwInstancedMapData
(
    ImapLink = #(),
    PropInstanceList = #(),
	GrassInstanceList = #(),

	fn GetExtents  = 
	(
		local Extents = CMapData__Extents()

		for Item in GrassInstanceList do
		(
			local BatchAABB = Item.BatchAABB
			local lodDist = Item.lodDist as float
		
			Extents.entitiesExtentsMax.x = amax Extents.entitiesExtentsMax.x BatchAABB._max.x
			Extents.entitiesExtentsMax.y = amax Extents.entitiesExtentsMax.y BatchAABB._max.y
			Extents.entitiesExtentsMax.z = amax Extents.entitiesExtentsMax.z BatchAABB._max.z

			Extents.entitiesExtentsMin.x = amin Extents.entitiesExtentsMin.x BatchAABB._min.x
			Extents.entitiesExtentsMin.y = amin Extents.entitiesExtentsMin.y BatchAABB._min.y
			Extents.entitiesExtentsMin.z = amin Extents.entitiesExtentsMin.z BatchAABB._min.z

			Extents.streamingExtentsMax.x = amax Extents.streamingExtentsMax.x (BatchAABB._max.x + lodDist)
			Extents.streamingExtentsMax.y = amax Extents.streamingExtentsMax.y (BatchAABB._max.y + lodDist)
			Extents.streamingExtentsMax.z = amax Extents.streamingExtentsMax.z (BatchAABB._max.z + lodDist - 100.0)

			Extents.streamingExtentsMin.x = amin Extents.streamingExtentsMin.x (BatchAABB._min.x - lodDist)
			Extents.streamingExtentsMin.y = amin Extents.streamingExtentsMin.y (BatchAABB._min.y - lodDist)
			Extents.streamingExtentsMin.z = amin Extents.streamingExtentsMin.z (BatchAABB._min.z - lodDist + 100.0)
		)
		return Extents
	),

	fn WriteXML = 
	(
		XmlDocument = dotNetObject "System.Xml.XmlDocument"
		
		XmlElement_instancedData = XmlDocument.CreateElement "instancedData"
		XmlDocument.appendChild XmlElement_instancedData
		
		XmlElement_ImapLink = XmlDocument.CreateElement "ImapLink"
		XmlElement_PropInstanceList = XmlDocument.CreateElement "PropInstanceList"
		XmlElement_GrassInstanceList = XmlDocument.CreateElement "GrassInstanceList"
		
		XmlElement_instancedData.appendChild XmlElement_ImapLink
		XmlElement_instancedData.appendChild XmlElement_PropInstanceList
	
		for Item in GrassInstanceList do
		(
			XmlElement_Item = XmlDocument.CreateElement "Item"
	
			XmlElement_BatchAABB = XmlDocument.CreateElement "BatchAABB"
			XmlElement_min = XmlDocument.CreateElement "min"
			XmlElement_min.SetAttribute "x" (Item.BatchAABB._min.x as string)
			XmlElement_min.SetAttribute "y" (Item.BatchAABB._min.y as string)
			XmlElement_min.SetAttribute "z" (Item.BatchAABB._min.z as string)
			XmlElement_min.SetAttribute "w" (Item.BatchAABB._min.w as string)
			XmlElement_max = XmlDocument.CreateElement "max"
			XmlElement_max.SetAttribute "x" (Item.BatchAABB._max.x as string)
			XmlElement_max.SetAttribute "y" (Item.BatchAABB._max.y as string)
			XmlElement_max.SetAttribute "z" (Item.BatchAABB._max.z as string)
			XmlElement_max.SetAttribute "w" (Item.BatchAABB._max.w as string)
	
			XmlElement_BatchAABB.appendChild XmlElement_min
			XmlElement_BatchAABB.appendChild XmlElement_max
			XmlElement_Item.appendChild XmlElement_BatchAABB
	
			XmlElement_ScaleRange = XmlDocument.CreateElement "ScaleRange"
			XmlElement_ScaleRange.SetAttribute "x" (Item.ScaleRange.x as string)
			XmlElement_ScaleRange.SetAttribute "y" (Item.ScaleRange.y as string)
			XmlElement_ScaleRange.SetAttribute "z" (Item.ScaleRange.z as string)
			XmlElement_Item.appendChild XmlElement_ScaleRange
	
			XmlElement_archetypeName = XmlDocument.CreateElement "archetypeName"
			XmlElement_archetypeName.InnerText = Item.archetypeName
			XmlElement_Item.appendChild XmlElement_archetypeName
	
			XmlElement_lodDist = XmlDocument.CreateElement "lodDist"
			XmlElement_lodDist.SetAttribute "value" (Item.lodDist as string)
			XmlElement_Item.appendChild XmlElement_lodDist
	
			XmlElement_LodFadeStartDist = XmlDocument.CreateElement "LodFadeStartDist"
			XmlElement_LodFadeStartDist.SetAttribute "value" (Item.LodFadeStartDist as string)
			XmlElement_Item.appendChild XmlElement_LodFadeStartDist
	
			XmlElement_LodInstFadeRange = XmlDocument.CreateElement "LodInstFadeRange"
			XmlElement_LodInstFadeRange.SetAttribute "value" (Item.LodInstFadeRange as string)
			XmlElement_Item.appendChild XmlElement_LodInstFadeRange
	
			XmlElement_OrientToTerrain = XmlDocument.CreateElement "OrientToTerrain"
			XmlElement_OrientToTerrain.SetAttribute "value" (Item.OrientToTerrain as string)
			XmlElement_Item.appendChild XmlElement_OrientToTerrain
	
			XmlElement_InstanceList = XmlDocument.CreateElement "InstanceList"
			
			for InstanceItem in Item.InstanceList do
			(
				local PositionValue = ("\n              " + (InstanceItem.Position[1] as string) + "\n              " + (InstanceItem.Position[2] as string) + "\n              " + (InstanceItem.Position[3] as string) + "\n            ")
				local ColorValue = ("\n              " + (InstanceItem._Color[1] as string) + "\n              " + (InstanceItem._Color[2] as string) + "\n              " + (InstanceItem._Color[3] as string) + "\n            ")
				local PadValue = ("\n              " + (InstanceItem.Pad[1] as string) + "\n              " + (InstanceItem.Pad[2] as string) + "\n              " + (InstanceItem.Pad[3] as string) + "\n            ")	
	
				XmlElement_InstanceItem = XmlDocument.CreateElement "Item"
	
				XmlElement_Position = XmlDocument.CreateElement "Position"
				XmlElement_Position.SetAttribute "content" "short_array"
				XmlElement_Position.InnerText = PositionValue
				XmlElement_InstanceItem.appendChild XmlElement_Position
	
				XmlElement_NormalX = XmlDocument.CreateElement "NormalX"
				XmlElement_NormalX.SetAttribute "value" (InstanceItem.NormalX as string)
				XmlElement_InstanceItem.appendChild XmlElement_NormalX
	
				XmlElement_NormalY = XmlDocument.CreateElement "NormalY"
				XmlElement_NormalY.SetAttribute "value" (InstanceItem.NormalY as string)
				XmlElement_InstanceItem.appendChild XmlElement_NormalY 
	
				XmlElement_Color = XmlDocument.CreateElement "Color"
				XmlElement_Color.SetAttribute "content" "char_array"
				XmlElement_Color.InnerText = ColorValue
				XmlElement_InstanceItem.appendChild XmlElement_Color
	
				XmlElement_Scale = XmlDocument.CreateElement "Scale"
				XmlElement_Scale.SetAttribute "value" (InstanceItem._Scale as string)
				XmlElement_InstanceItem.appendChild XmlElement_Scale 
	
				XmlElement_Ao = XmlDocument.CreateElement "Ao"
				XmlElement_Ao.SetAttribute "value" (InstanceItem.Ao as string)
				XmlElement_InstanceItem.appendChild XmlElement_Ao
	
				XmlElement_Pad = XmlDocument.CreateElement "Pad"
				XmlElement_Pad.SetAttribute "content" "char_array"
				XmlElement_Pad.InnerText = PadValue
				XmlElement_InstanceItem.appendChild XmlElement_Pad
	
				XmlElement_InstanceList.appendChild XmlElement_InstanceItem
			)
	
			XmlElement_Item.appendChild XmlElement_InstanceList	
	
			XmlElement_GrassInstanceList.appendChild XmlElement_Item
		)
		
		XmlElement_instancedData.appendChild XmlElement_GrassInstanceList
		return XmlDocument
	)
)

struct rage__fwGrassInstanceListDef
(
	BatchAABB,
	ScaleRange,
	archetypeName,
	lodDist,
	LodFadeStartDist,
	LodInstFadeRange,
	OrientToTerrain,
	InstanceList
)

struct rage__spdAABB
(
	_min,
	_max
)

struct rage__fwGrassInstanceListDef__InstanceData
(
    Position,
    NormalX,
    NormalY,
    _Color,
    _Scale,
    Ao,
	Pad
)

fn BatchFromFaces obj faces =
(
	local bbmax = [-8192,-8192,-8192,0]
	local bbmin = [8192,8192,8192,0]
	
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

fn GrassInstanceListFromFaces obj faces BatchSettings InstancesSettings =
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
		if(InstancesSettings[2][1] == -1)do(settings[2][1] = random 0 255)
		if(InstancesSettings[2][2] == -1)do(settings[2][2] = random 0 255)
		if(InstancesSettings[2][3] == -1)do(settings[2][3] = random 0 255)
		
		local InstanceData = InstanceDataFromFace batch obj face settings
		append InstanceList InstanceData
	)
	local GrassInstanceList = rage__fwGrassInstanceListDef BatchAABB:batch ScaleRange:ScaleRange	archetypeName:archetypeName	lodDist:lodDist	LodFadeStartDist:LodFadeStartDist LodInstFadeRange:LodInstFadeRange	OrientToTerrain:OrientToTerrain InstanceList:InstanceList
)