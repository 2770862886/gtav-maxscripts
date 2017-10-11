--fileIn (scriptspath+"\\GTAV_Map_Helper\\xml.ms")
fileIn (scriptspath+"\\GTAV_Map_Helper\\ymap.ms")

fn WriteXML InstancedMapData = 
(
	XmlDoc = dotNetObject "System.Xml.XmlDocument"
	
	XmlNode_instancedData = XmlDoc.CreateElement "instancedData"
	XmlDoc.appendChild XmlNode_instancedData
	
	XmlNode_ImapLink = XmlDoc.CreateElement "ImapLink"
	XmlNode_PropInstanceList = XmlDoc.CreateElement "PropInstanceList"
	XmlNode_GrassInstanceList = XmlDoc.CreateElement "GrassInstanceList"
	
	XmlNode_instancedData.appendChild XmlNode_ImapLink
	XmlNode_instancedData.appendChild XmlNode_PropInstanceList

	for Item in InstancedMapData.GrassInstanceList do
	(
		XmlNode_Item = XmlDoc.CreateElement "Item"

		XmlNode_BatchAABB = XmlDoc.CreateElement "BatchAABB"
		XmlNode_min = XmlDoc.CreateElement "min"
		XmlNode_min.SetAttribute "x" (Item.BatchAABB._min.x as string)
		XmlNode_min.SetAttribute "y" (Item.BatchAABB._min.y as string)
		XmlNode_min.SetAttribute "z" (Item.BatchAABB._min.z as string)
		XmlNode_min.SetAttribute "w" (Item.BatchAABB._min.w as string)
		XmlNode_max = XmlDoc.CreateElement "max"
		XmlNode_max.SetAttribute "x" (Item.BatchAABB._max.x as string)
		XmlNode_max.SetAttribute "y" (Item.BatchAABB._max.y as string)
		XmlNode_max.SetAttribute "z" (Item.BatchAABB._max.z as string)
		XmlNode_max.SetAttribute "w" (Item.BatchAABB._max.w as string)

		XmlNode_BatchAABB.appendChild XmlNode_min
		XmlNode_BatchAABB.appendChild XmlNode_max
		XmlNode_Item.appendChild XmlNode_BatchAABB

		XmlNode_ScaleRange = XmlDoc.CreateElement "ScaleRange"
		XmlNode_ScaleRange.SetAttribute "x" (Item.ScaleRange.x as string)
		XmlNode_ScaleRange.SetAttribute "y" (Item.ScaleRange.y as string)
		XmlNode_ScaleRange.SetAttribute "z" (Item.ScaleRange.z as string)
		XmlNode_Item.appendChild XmlNode_ScaleRange

		XmlNode_archetypeName = XmlDoc.CreateElement "archetypeName"
		XmlNode_archetypeName.InnerText = Item.archetypeName
		XmlNode_Item.appendChild XmlNode_archetypeName

		XmlNode_lodDist = XmlDoc.CreateElement "lodDist"
		XmlNode_lodDist.SetAttribute "value" (Item.lodDist as string)
		XmlNode_Item.appendChild XmlNode_lodDist

		XmlNode_LodFadeStartDist = XmlDoc.CreateElement "LodFadeStartDist"
		XmlNode_LodFadeStartDist.SetAttribute "value" (Item.LodFadeStartDist as string)
		XmlNode_Item.appendChild XmlNode_LodFadeStartDist

		XmlNode_LodInstFadeRange = XmlDoc.CreateElement "LodInstFadeRange"
		XmlNode_LodInstFadeRange.SetAttribute "value" (Item.LodInstFadeRange as string)
		XmlNode_Item.appendChild XmlNode_LodInstFadeRange

		XmlNode_OrientToTerrain = XmlDoc.CreateElement "OrientToTerrain"
		XmlNode_OrientToTerrain.SetAttribute "value" (Item.OrientToTerrain as string)
		XmlNode_Item.appendChild XmlNode_OrientToTerrain

		XmlNode_InstanceList = XmlDoc.CreateElement "InstanceList"
		
		for InstanceItem in Item.InstanceList do
		(
			local PositionValue = ("\n              " + (InstanceItem.Position[1] as string) + "\n              " + (InstanceItem.Position[2] as string) + "\n              " + (InstanceItem.Position[3] as string) + "\n            ")
			local ColorValue = ("\n              " + (InstanceItem._Color[1] as string) + "\n              " + (InstanceItem._Color[2] as string) + "\n              " + (InstanceItem._Color[3] as string) + "\n            ")
			local PadValue = ("\n              " + (InstanceItem.Pad[1] as string) + "\n              " + (InstanceItem.Pad[2] as string) + "\n              " + (InstanceItem.Pad[3] as string) + "\n            ")	

			XmlNode_InstanceItem = XmlDoc.CreateElement "Item"

			XmlNode_Position = XmlDoc.CreateElement "Position"
			XmlNode_Position.SetAttribute "content" "short_array"
			XmlNode_Position.InnerText = PositionValue
			XmlNode_InstanceItem.appendChild XmlNode_Position

			XmlNode_NormalX = XmlDoc.CreateElement "NormalX"
			XmlNode_NormalX.SetAttribute "value" (InstanceItem.NormalX as string)
			XmlNode_InstanceItem.appendChild XmlNode_NormalX

			XmlNode_NormalY = XmlDoc.CreateElement "NormalY"
			XmlNode_NormalY.SetAttribute "value" (InstanceItem.NormalY as string)
			XmlNode_InstanceItem.appendChild XmlNode_NormalY 

			XmlNode_Color = XmlDoc.CreateElement "Color"
			XmlNode_Color.SetAttribute "content" "char_array"
			XmlNode_Color.InnerText = ColorValue
			XmlNode_InstanceItem.appendChild XmlNode_Color

			XmlNode_Scale = XmlDoc.CreateElement "Scale"
			XmlNode_Scale.SetAttribute "value" (InstanceItem._Scale as string)
			XmlNode_InstanceItem.appendChild XmlNode_Scale 

			XmlNode_Ao = XmlDoc.CreateElement "Ao"
			XmlNode_Ao.SetAttribute "value" (InstanceItem.Ao as string)
			XmlNode_InstanceItem.appendChild XmlNode_Ao

			XmlNode_Pad = XmlDoc.CreateElement "Pad"
			XmlNode_Pad.SetAttribute "content" "char_array"
			XmlNode_Pad.InnerText = PadValue
			XmlNode_InstanceItem.appendChild XmlNode_Pad

			XmlNode_InstanceList.appendChild XmlNode_InstanceItem
		)

		XmlNode_Item.appendChild XmlNode_InstanceList	

		XmlNode_GrassInstanceList.appendChild XmlNode_Item
	)
	
	XmlNode_instancedData.appendChild XmlNode_GrassInstanceList
	return XmlDoc
)

struct CMapData__Extents
(
	streamingExtentsMin,
	streamingExtentsMax,
	entitiesExtentsMin,
	entitiesExtentsMax
)

struct rage__fwInstancedMapData
(
    ImapLink,
    PropInstanceList,
	GrassInstanceList,

	fn GetExtents  = 
	(
		local streamingExtentsMin = [8192,8192,8192]
		local streamingExtentsMax = [-8192,-8192,-8192]
		local entitiesExtentsMin = [8192,8192,8192]
		local entitiesExtentsMax = [-8192,-8192,-8192]

		for Item in GrassInstanceList do
		(
			local BatchAABB = Item.BatchAABB
			local lodDist = item.lodDist as float
		
			entitiesExtentsMax.x = amax entitiesExtentsMax.x BatchAABB._max.x
			entitiesExtentsMax.y = amax entitiesExtentsMax.y BatchAABB._max.y
			entitiesExtentsMax.z = amax entitiesExtentsMax.z BatchAABB._max.z

			entitiesExtentsMin.x = amin entitiesExtentsMin.x BatchAABB._min.x
			entitiesExtentsMin.y = amin entitiesExtentsMin.y BatchAABB._min.y
			entitiesExtentsMin.z = amin entitiesExtentsMin.z BatchAABB._min.z

			streamingExtentsMax.x = amax streamingExtentsMax.x (BatchAABB._max.x + lodDist)
			streamingExtentsMax.y = amax streamingExtentsMax.y (BatchAABB._max.y + lodDist)
			streamingExtentsMax.z = amax streamingExtentsMax.z (BatchAABB._max.z + lodDist - 100.0)

			streamingExtentsMin.x = amin streamingExtentsMin.x (BatchAABB._min.x - lodDist)
			streamingExtentsMin.y = amin streamingExtentsMin.y (BatchAABB._min.y - lodDist)
			streamingExtentsMin.z = amin streamingExtentsMin.z (BatchAABB._min.z - lodDist + 100.0)
		)
		local Extents = CMapData__Extents streamingExtentsMin:streamingExtentsMin streamingExtentsMax:streamingExtentsMax entitiesExtentsMin:entitiesExtentsMin entitiesExtentsMax:entitiesExtentsMax
		return Extents
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

fn ExportYmapGrass filename InstancedData =
(
	local filePath = getSaveFileName caption:"Save .ymap.xml file" filename:(filename+".ymap.xml") types:"XML Document (*.xml)"
	if( filePath != undefined) then
	( 	
		format "YMAP GrassInstance EXPORTER: %\n\n" (filePath)
		
		local Extents = InstancedData.GetExtents()
		
		XDocument_YMAP = create_YMAP filename [0,0,0] [0,0,0]
		XElement_CMapData = XDocument_YMAP.Element XName_CMapData
		
		XElement_streamingExtentsMin = XElement_CMapData.Element XName_streamingExtentsMin
		XElement_streamingExtentsMin.SetAttributeValue XName_x (Extents.streamingExtentsMin.x as string)
		XElement_streamingExtentsMin.SetAttributeValue XName_y (Extents.streamingExtentsMin.y as string)
		XElement_streamingExtentsMin.SetAttributeValue XName_z (Extents.streamingExtentsMin.z as string)
		
		XElement_streamingExtentsMax = XElement_CMapData.Element XName_streamingExtentsMax
		XElement_streamingExtentsMax.SetAttributeValue XName_x (Extents.streamingExtentsMax.x as string)
		XElement_streamingExtentsMax.SetAttributeValue XName_y (Extents.streamingExtentsMax.y as string)
		XElement_streamingExtentsMax.SetAttributeValue XName_z (Extents.streamingExtentsMax.z as string)
		
		XElement_entitiesExtentsMin = XElement_CMapData.Element XName_entitiesExtentsMin
		XElement_entitiesExtentsMin.SetAttributeValue XName_x (Extents.entitiesExtentsMin.x as string)
		XElement_entitiesExtentsMin.SetAttributeValue XName_y (Extents.entitiesExtentsMin.y as string)
		XElement_entitiesExtentsMin.SetAttributeValue XName_z (Extents.entitiesExtentsMin.z as string)
		
		XElement_entitiesExtentsMax = XElement_CMapData.Element XName_entitiesExtentsMax
		XElement_entitiesExtentsMax.SetAttributeValue XName_x (Extents.entitiesExtentsMax.x as string)
		XElement_entitiesExtentsMax.SetAttributeValue XName_y (Extents.entitiesExtentsMax.y as string)
		XElement_entitiesExtentsMax.SetAttributeValue XName_z (Extents.entitiesExtentsMax.z as string)
		
		XElement_contentFlags = XElement_CMapData.Element XName_contentFlags
		XElement_contentFlags.SetAttributeValue XName_value 1088
		XElement_physicsDictionaries = XElement_CMapData.Element XName_physicsDictionaries
		XElement_Item = dotNetObject "System.Xml.Linq.XElement" XName_Item
		XElement_Item.SetValue "v_proc1"
		XElement_physicsDictionaries.Add XElement_Item
		XElement_instancedData = XElement_CMapData.Element XName_instancedData
		
		--TEMPORARY: XML.LINQ IS LOW AT WRITING
		xmlDoc = WriteXML(InstancedData)
		NodeReader = dotNetObject "System.Xml.XmlNodeReader" xmlDoc
		new = (dotNetClass "System.Xml.Linq.XElement").Load(NodeReader)
		XElement_instancedData.ReplaceWith (new)
		XDocument_YMAP.Save filePath
	)
)