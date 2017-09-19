fileIn (scriptspath+"\\GTAV_Map_Helper\\xml.ms")

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
