DotNet.LoadAssembly "System.Xml.Linq"

Class_XName = dotnetClass "System.Xml.Linq.XName"
XName_Item = Class_XName.get "Item"
XName_value = Class_XName.get "value"
XName_minX = Class_XName.get "minX"
XName_maxX = Class_XName.get "maxX"
XName_minY = Class_XName.get "minY"
XName_maxY = Class_XName.get "maxY"
XName_Type = Class_XName.get "Type"
XName_IsInvisible = Class_XName.get "IsInvisible"
XName_HasLimitedDepth = Class_XName.get "HasLimitedDepth"
XName_z = Class_XName.get "z"
XName_a1 = Class_XName.get "a1"
XName_a2 = Class_XName.get "a2"
XName_a3 = Class_XName.get "a3"
XName_a4 = Class_XName.get "a4"
XName_NoStencil = Class_XName.get "NoStencil"
XName_WaterData = Class_XName.get "WaterData"
XName_WaterQuads = Class_XName.get "WaterQuads"
XName_CalmingQuads = Class_XName.get "CalmingQuads"
XName_WaveQuads = Class_XName.get "WaveQuads"
XName_fDampening = Class_XName.get "fDampening"
XName_Amplitude = Class_XName.get "Amplitude"
XName_XDirection = Class_XName.get "XDirection"
XName_YDirection = Class_XName.get "YDirection"

fn create_WaterQuad Water_Settings_Values =(
	local XElement_Item = dotNetObject "System.Xml.Linq.XElement" XName_Item
	
	local XElement_minX = dotNetObject "System.Xml.Linq.XElement" XName_minX
	XElement_minX.SetAttributeValue XName_value Water_Settings_Values.minX
	XElement_Item.Add XElement_minX
	
	local XElement_maxX = dotNetObject "System.Xml.Linq.XElement" XName_maxX
	XElement_maxX.SetAttributeValue XName_value Water_Settings_Values.maxX
	XElement_Item.Add XElement_maxX
	
	local XElement_minY = dotNetObject "System.Xml.Linq.XElement" XName_minY
	XElement_minY.SetAttributeValue XName_value Water_Settings_Values.minY
	XElement_Item.Add XElement_minY
	
	local XElement_maxY = dotNetObject "System.Xml.Linq.XElement" XName_maxY
	XElement_maxY.SetAttributeValue XName_value Water_Settings_Values.maxY
	XElement_Item.Add XElement_maxY
	
	local XElement_Type = dotNetObject "System.Xml.Linq.XElement" XName_Type
	XElement_Type.SetAttributeValue XName_value Water_Settings_Values.Type
	XElement_Item.Add XElement_Type
	
	local XElement_IsInvisible = dotNetObject "System.Xml.Linq.XElement" XName_IsInvisible
	XElement_IsInvisible.SetAttributeValue XName_value Water_Settings_Values.IsInvisible
	XElement_Item.Add XElement_IsInvisible
	
	local XElement_HasLimitedDepth = dotNetObject "System.Xml.Linq.XElement" XName_HasLimitedDepth
	XElement_HasLimitedDepth.SetAttributeValue XName_value Water_Settings_Values.HasLimitedDepth
	XElement_Item.Add XElement_HasLimitedDepth
	
	local XElement_z = dotNetObject "System.Xml.Linq.XElement" XName_z
	XElement_z.SetAttributeValue XName_value Water_Settings_Values.z
	XElement_Item.Add XElement_z
	
	local XElement_a1 = dotNetObject "System.Xml.Linq.XElement" XName_a1
	XElement_a1.SetAttributeValue XName_value Water_Settings_Values.a1
	XElement_Item.Add XElement_a1
	
	local XElement_a2 = dotNetObject "System.Xml.Linq.XElement" XName_a2
	XElement_a2.SetAttributeValue XName_value Water_Settings_Values.a2
	XElement_Item.Add XElement_a2
	
	local XElement_a3 = dotNetObject "System.Xml.Linq.XElement" XName_a3
	XElement_a3.SetAttributeValue XName_value Water_Settings_Values.a3
	XElement_Item.Add XElement_a3
	
	local XElement_a4 = dotNetObject "System.Xml.Linq.XElement" XName_a4
	XElement_a4.SetAttributeValue XName_value Water_Settings_Values.a4
	XElement_Item.Add XElement_a4
	
	local XElement_NoStencil = dotNetObject "System.Xml.Linq.XElement" XName_NoStencil
	XElement_NoStencil.SetAttributeValue XName_value Water_Settings_Values.NoStencil
	XElement_Item.Add XElement_NoStencil
	
	return XElement_Item
)

fn create_CalmingQuad Water_Settings_Values =(
	local XElement_Item = dotNetObject "System.Xml.Linq.XElement" XName_Item
	
	local XElement_minX = dotNetObject "System.Xml.Linq.XElement" XName_minX
	XElement_minX.SetAttributeValue XName_value Water_Settings_Values.minX
	XElement_Item.Add XElement_minX
	
	local XElement_maxX = dotNetObject "System.Xml.Linq.XElement" XName_maxX
	XElement_maxX.SetAttributeValue XName_value Water_Settings_Values.maxX
	XElement_Item.Add XElement_maxX
	
	local XElement_minY = dotNetObject "System.Xml.Linq.XElement" XName_minY
	XElement_minY.SetAttributeValue XName_value Water_Settings_Values.minY
	XElement_Item.Add XElement_minY
	
	local XElement_maxY = dotNetObject "System.Xml.Linq.XElement" XName_maxY
	XElement_maxY.SetAttributeValue XName_value Water_Settings_Values.maxY
	XElement_Item.Add XElement_maxY
	
	local XElement_fDampening = dotNetObject "System.Xml.Linq.XElement" XName_fDampening
	XElement_fDampening.SetAttributeValue XName_value Water_Settings_Values.fDampening
	XElement_Item.Add XElement_fDampening
	
	return XElement_Item
)

fn create_WaveQuad Water_Settings_Values =(
	local XElement_Item = dotNetObject "System.Xml.Linq.XElement" XName_Item
	
	local XElement_minX = dotNetObject "System.Xml.Linq.XElement" XName_minX
	XElement_minX.SetAttributeValue XName_value Water_Settings_Values.minX
	XElement_Item.Add XElement_minX
	
	local XElement_maxX = dotNetObject "System.Xml.Linq.XElement" XName_maxX
	XElement_maxX.SetAttributeValue XName_value Water_Settings_Values.maxX
	XElement_Item.Add XElement_maxX
	
	local XElement_minY = dotNetObject "System.Xml.Linq.XElement" XName_minY
	XElement_minY.SetAttributeValue XName_value Water_Settings_Values.minY
	XElement_Item.Add XElement_minY
	
	local XElement_maxY = dotNetObject "System.Xml.Linq.XElement" XName_maxY
	XElement_maxY.SetAttributeValue XName_value Water_Settings_Values.maxY
	XElement_Item.Add XElement_maxY
	
	local XElement_Amplitude = dotNetObject "System.Xml.Linq.XElement" XName_Amplitude
	XElement_Amplitude.SetAttributeValue XName_value Water_Settings_Values.Amplitude
	XElement_Item.Add XElement_Amplitude
	
	local XElement_XDirection = dotNetObject "System.Xml.Linq.XElement" XName_XDirection
	XElement_XDirection.SetAttributeValue XName_value Water_Settings_Values.XDirection
	XElement_Item.Add XElement_XDirection
	
	local XElement_YDirection = dotNetObject "System.Xml.Linq.XElement" XName_YDirection
	XElement_YDirection.SetAttributeValue XName_value Water_Settings_Values.YDirection
	XElement_Item.Add XElement_YDirection
	
	return XElement_Item
)

fn create_Water=(
	local XDocument_Water = dotNetObject "System.Xml.Linq.XDocument"
	XDocument_Water.Declaration  = (dotNetObject "System.Xml.Linq.XDeclaration" "1.0" "UTF-8" "no")
	
	local XElement_WaterData = dotNetObject "System.Xml.Linq.XElement" XName_WaterData
	XDocument_Water.Add XElement_WaterData
	
	local XElement_WaterQuads = dotNetObject "System.Xml.Linq.XElement" XName_WaterQuads
	XElement_WaterData.Add XElement_WaterQuads
	
	local XElement_CalmingQuads = dotNetObject "System.Xml.Linq.XElement" XName_CalmingQuads
	XElement_WaterData.Add XElement_CalmingQuads
	
	local XElement_WaveQuads = dotNetObject "System.Xml.Linq.XElement" XName_WaveQuads
	XElement_WaterData.Add XElement_WaveQuads
	
	return XDocument_Water
)

fn export_Water XDocument_Water=(
	local filePath = getSaveFileName caption:"Save water.xml file" filename:("water.xml") types:"XML Document (*.xml)"
	if( filePath != undefined) then
	(
		format "WATER EXPORTER: %\n\n" (filePath)
		XDocument_Water.Save filePath
	)
)