fileIn (scriptspath+"\\GTAV_Map_Helper\\xml.ms")

fn export_YmapGrass filename ymap =(
	local filePath = getSaveFileName caption:"Save .ymap.xml file" filename:(filename+".ymap.xml") types:"XML Document (*.xml)"
	if( filePath != undefined) then
	( 	
		format "YMAP GrassInstance EXPORTER: %\n\nExtents might be inaccurate.\n" (filePath)
		local ymapfile = dotNetObject "System.Xml.Linq.XDocument" ymap
		ymapfile.Save filePath
	)
)

fn get_SelectedFaces_Bound obj=(
	local bbmax = [-8192,-8192,-8192]
	local bbmin = [8192,8192,8192]
	
	local faces = for face in obj.selectedFaces collect face.index
	for face in faces do
	(
		local vertices = polyop.getFaceVerts obj face
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
	local batch = #(bbmin,bbmax)
	return batch
)

fn create_InstanceListItem obj face instances_settings=(
	local FaceNormal = polyop.getFaceNormal obj face
	local NormalX = (((FaceNormal.x +1)*0.5 * 255) as integer)
	local NormalY = (((FaceNormal.y +1)*0.5 * 255) as integer)
	local Colors = instances_settings[2]
	local Color_x = Colors[1] as integer
	local Color_y = Colors[2] as integer
	local Color_z = Colors[3] as integer
	local Scale_value = instances_settings[1]
	local Ao = instances_settings[3]
	local Pad = instances_settings[4]
	local Pad_x = Pad[1] as integer
	local Pad_y = Pad[2] as integer
	local Pad_z = Pad[3] as integer
	
	local world_pos = polyop.getFaceCenter obj face
	local batch_pos = (world_pos - obj.min)/(obj.max-obj.min) * 65535 /*world_pos = ((batch_pos / 65535) * (obj.max-obj.min)) + obj.min*/
	local int_batch_pos_x = batch_pos.x as integer
	local int_batch_pos_y = batch_pos.y as integer
	local int_batch_pos_z = batch_pos.z as integer
	
	local XElement_Item2 = dotNetObject "System.Xml.Linq.XElement" XName_Item
	local XElement_Position = dotNetObject "System.Xml.Linq.XElement" XName_Position
	XElement_Position.SetAttributeValue XName_content "short_array"
	XElement_Position.SetValue ("\n              " + (int_batch_pos_x as string) + "\n              " + (int_batch_pos_y as string) + "\n              " + (int_batch_pos_z as string) + "\n            ")
	XElement_Item2.Add XElement_Position
	local XElement_NormalX = dotNetObject "System.Xml.Linq.XElement" XName_NormalX
	XElement_NormalX.SetAttributeValue XName_value NormalX
	XElement_Item2.Add XElement_NormalX
	local XElement_NormalY = dotNetObject "System.Xml.Linq.XElement" XName_NormalY
	XElement_NormalY.SetAttributeValue XName_value NormalY
	XElement_Item2.Add XElement_NormalY
	local XElement_Color = dotNetObject "System.Xml.Linq.XElement" XName_Color
	XElement_Color.SetAttributeValue XName_content "char_array"
	XElement_Color.SetValue ("\n              " + (Color_x as string) + "\n              " + (Color_y as string) + "\n              " + (Color_z as string) + "\n            ")
	XElement_Item2.Add XElement_Color
	local XElement_Scale = dotNetObject "System.Xml.Linq.XElement" XName_Scale
	XElement_Scale.SetAttributeValue XName_value Scale_value
	XElement_Item2.Add XElement_Scale
	local XElement_Ao = dotNetObject "System.Xml.Linq.XElement" XName_Ao
	XElement_Ao.SetAttributeValue XName_value Ao
	XElement_Item2.Add XElement_Ao
	local XElement_Pad = dotNetObject "System.Xml.Linq.XElement" XName_Pad
	XElement_Pad.SetAttributeValue XName_content "char_array"
	XElement_Pad.SetValue ("\n              " + (Pad_x as string) + "\n              " + (Pad_y as string) + "\n              " + (Pad_z as string) + "\n            ")
	XElement_Item2.Add XElement_Pad
	
	return XElement_Item2
)

fn create_GrassInstanceListItem obj batch_settings instances_settings =(
	local archetypeName = batch_settings[1]
	local ScaleRange = batch_settings[2]
	local lodDist = batch_settings[3]
	local LodFadeStartDist = batch_settings[4]
	local LodInstFadeRange = batch_settings[5]
	local OrientToTerrain = batch_settings[6]
	
	local batch = get_SelectedFaces_Bound obj
	local batchaabb_min = batch[1]
	local batchaabb_max= batch[2]
	
	local XElement_Item = dotNetObject "System.Xml.Linq.XElement" XName_Item 
	local XElement_BatchAABB = dotNetObject "System.Xml.Linq.XElement" XName_BatchAABB
	local XElement_min = dotNetObject "System.Xml.Linq.XElement" XName_min
	XElement_min.SetAttributeValue XName_x batchaabb_min.x
	XElement_min.SetAttributeValue XName_y batchaabb_min.y
	XElement_min.SetAttributeValue XName_z batchaabb_min.z
	XElement_min.SetAttributeValue XName_w 0
	local XElement_max = dotNetObject "System.Xml.Linq.XElement" XName_max
	XElement_max.SetAttributeValue XName_x batchaabb_max.x
	XElement_max.SetAttributeValue XName_y batchaabb_max.y
	XElement_max.SetAttributeValue XName_z batchaabb_max.z
	XElement_max.SetAttributeValue XName_w 0
	XElement_BatchAABB.Add XElement_min
	XElement_BatchAABB.Add XElement_max
	XElement_Item.Add XElement_BatchAABB
	local XElement_ScaleRange = dotNetObject "System.Xml.Linq.XElement" XName_ScaleRange
	XElement_ScaleRange.SetAttributeValue XName_x ScaleRange.x
	XElement_ScaleRange.SetAttributeValue XName_y ScaleRange.y
	XElement_ScaleRange.SetAttributeValue XName_z ScaleRange.z
	XElement_Item.Add XElement_ScaleRange
	local XElement_archetypeName = dotNetObject "System.Xml.Linq.XElement" XName_archetypeName
	XElement_archetypeName.SetValue archetypeName
	XElement_Item.Add XElement_archetypeName
	local XElement_lodDist = dotNetObject "System.Xml.Linq.XElement" XName_lodDist
	XElement_lodDist.SetAttributeValue XName_value lodDist
	XElement_Item.Add XElement_lodDist
	local XElement_LodFadeStartDist = dotNetObject "System.Xml.Linq.XElement" XName_LodFadeStartDist
	XElement_LodFadeStartDist.SetAttributeValue XName_value LodFadeStartDist
	XElement_Item.Add XElement_LodFadeStartDist
	local XElement_LodInstFadeRange = dotNetObject "System.Xml.Linq.XElement" XName_LodInstFadeRange
	XElement_LodInstFadeRange.SetAttributeValue XName_value LodInstFadeRange
	XElement_Item.Add XElement_LodInstFadeRange
	local XElement_OrientToTerrain = dotNetObject "System.Xml.Linq.XElement" XName_OrientToTerrain
	XElement_OrientToTerrain.SetAttributeValue XName_value OrientToTerrain
	XElement_Item.Add XElement_OrientToTerrain
	local XElement_InstanceList= dotNetObject "System.Xml.Linq.XElement" XName_InstanceList
	
	/*uses faces of the object as item*/
	
	/* ALL FACES */
	/*
	local faceCount = obj.numfaces
	for face = 1 to faceCount do
	(
		local InstanceList_Item = create_InstanceListItem obj face
		XElement_InstanceList.Add InstanceList_Item
	)
	*/
	
	/*ONLY SELECTED FACES*/
	local selected_faces = polyop.getFaceSelection obj
	for face in selected_faces do
	(
		local InstanceList_Item = create_InstanceListItem obj face instances_settings
		XElement_InstanceList.Add InstanceList_Item
	)
	
	XElement_Item.Add XElement_InstanceList
	
	return XElement_Item
)