DotNet.LoadAssembly "System.Xml"

struct WaterData
(
	WaterQuads,
	CalmingQuads,
	WaveQuads,

	fn WriteXML =
	(
		local XmlDocument = dotNetObject "System.Xml.XmlDocument"
		XmlDocument.appendChild (XmlDocument.CreateXmlDeclaration "1.0" "utf-8" "no")
		local XmlElement_WaterData = XmlDocument.CreateElement "WaterData"
		local XmlElement_WaterQuads = XmlDocument.CreateElement "WaterQuads"
		local XmlElement_CalmingQuads = XmlDocument.CreateElement "CalmingQuads"
		local XmlElement_WaveQuads = XmlDocument.CreateElement "WaveQuads"

		for WaterQuad in WaterQuads do 
		(
			local XmlElement_WaterQuad = XmlDocument.CreateElement "Item"
			
			local XmlElement_minX = XmlDocument.CreateElement "minX"
			XmlElement_minX.SetAttribute "value" (WaterQuad.minX as string)
			XmlElement_WaterQuad.appendChild XmlElement_minX
			
			local XmlElement_maxX = XmlDocument.CreateElement "maxX"
			XmlElement_maxX.SetAttribute "value" (WaterQuad.maxX as string)
			XmlElement_WaterQuad.appendChild XmlElement_maxX
			
			local XmlElement_minY = XmlDocument.CreateElement "minY"
			XmlElement_minY.SetAttribute "value" (WaterQuad.minY as string)
			XmlElement_WaterQuad.appendChild XmlElement_minY
			
			local XmlElement_maxY = XmlDocument.CreateElement "maxY"
			XmlElement_maxY.SetAttribute "value" (WaterQuad.maxY as string)
			XmlElement_WaterQuad.appendChild XmlElement_maxY

			local XmlElement_Type = XmlDocument.CreateElement "Type"
			XmlElement_Type.SetAttribute "value" (WaterQuad.Type as string)
			XmlElement_WaterQuad.appendChild XmlElement_Type
			
			local XmlElement_IsInvisible = XmlDocument.CreateElement "IsInvisible"
			XmlElement_IsInvisible.SetAttribute "value" (WaterQuad.IsInvisible as string)
			XmlElement_WaterQuad.appendChild XmlElement_IsInvisible
			
			local XmlElement_HasLimitedDepth = XmlDocument.CreateElement "HasLimitedDepth"
			XmlElement_HasLimitedDepth.SetAttribute "value" (WaterQuad.HasLimitedDepth as string)
			XmlElement_WaterQuad.appendChild XmlElement_HasLimitedDepth
			
			local XmlElement_z = XmlDocument.CreateElement "z"
			XmlElement_z.SetAttribute "value" (WaterQuad.z as string)
			XmlElement_WaterQuad.appendChild XmlElement_z

			local XmlElement_a1 = XmlDocument.CreateElement "a1"
			XmlElement_a1.SetAttribute "value" (WaterQuad.a1 as string)
			XmlElement_WaterQuad.appendChild XmlElement_a1
			
			local XmlElement_a2 = XmlDocument.CreateElement "a2"
			XmlElement_a2.SetAttribute "value" (WaterQuad.a2 as string)
			XmlElement_WaterQuad.appendChild XmlElement_a2

			local XmlElement_a3 = XmlDocument.CreateElement "a3"
			XmlElement_a3.SetAttribute "value" (WaterQuad.a3 as string)
			XmlElement_WaterQuad.appendChild XmlElement_a3

			local XmlElement_a4 = XmlDocument.CreateElement "a4"
			XmlElement_a4.SetAttribute "value" (WaterQuad.a4 as string)
			XmlElement_WaterQuad.appendChild XmlElement_a4

			local XmlElement_NoStencil = XmlDocument.CreateElement "NoStencil"
			XmlElement_NoStencil.SetAttribute "value" (WaterQuad.NoStencil as string)
			XmlElement_WaterQuad.appendChild XmlElement_NoStencil
			
			XmlElement_WaterQuads.appendChild XmlElement_WaterQuad
		)
		XmlElement_WaterData.appendChild XmlElement_WaterQuads

		for CalmingQuad in CalmingQuads do
		(
			local XmlElement_CalmingQuad = XmlDocument.CreateElement "Item"
			
			local XmlElement_minX = XmlDocument.CreateElement "minX"
			XmlElement_minX.SetAttribute "value" (CalmingQuad.minX as string)
			XmlElement_CalmingQuad.appendChild XmlElement_minX
			
			local XmlElement_maxX = XmlDocument.CreateElement "maxX"
			XmlElement_maxX.SetAttribute "value" (CalmingQuad.maxX as string)
			XmlElement_CalmingQuad.appendChild XmlElement_maxX
			
			local XmlElement_minY = XmlDocument.CreateElement "minY"
			XmlElement_minY.SetAttribute "value" (CalmingQuad.minY as string)
			XmlElement_CalmingQuad.appendChild XmlElement_minY
			
			local XmlElement_maxY = XmlDocument.CreateElement "maxY"
			XmlElement_maxY.SetAttribute "value" (CalmingQuad.maxY as string)
			XmlElement_CalmingQuad.appendChild XmlElement_maxY

			local XmlElement_fDampening = XmlDocument.CreateElement "fDampening"
			XmlElement_fDampening.SetAttribute "value" (CalmingQuad.fDampening as string)
			XmlElement_CalmingQuad.appendChild XmlElement_fDampening

			XmlElement_CalmingQuads.appendChild XmlElement_CalmingQuad
		)
		XmlElement_WaterData.appendChild XmlElement_CalmingQuads

		for WaveQuad in WaveQuads do
		(
			local XmlElement_WaveQuad = XmlDocument.CreateElement "Item"
			
			local XmlElement_minX = XmlDocument.CreateElement "minX"
			XmlElement_minX.SetAttribute "value" (WaveQuad.minX as string)
			XmlElement_WaveQuad.appendChild XmlElement_minX
			
			local XmlElement_maxX = XmlDocument.CreateElement "maxX"
			XmlElement_maxX.SetAttribute "value" (WaveQuad.maxX as string)
			XmlElement_WaveQuad.appendChild XmlElement_maxX
			
			local XmlElement_minY = XmlDocument.CreateElement "minY"
			XmlElement_minY.SetAttribute "value" (WaveQuad.minY as string)
			XmlElement_WaveQuad.appendChild XmlElement_minY
			
			local XmlElement_maxY = XmlDocument.CreateElement "maxY"
			XmlElement_maxY.SetAttribute "value" (WaveQuad.maxY as string)
			XmlElement_WaveQuad.appendChild XmlElement_maxY

			local XmlElement_Amplitude = XmlDocument.CreateElement "Amplitude"
			XmlElement_Amplitude.SetAttribute "value" (WaveQuad.Amplitude as string)
			XmlElement_WaveQuad.appendChild XmlElement_Amplitude

			local XmlElement_XDirection = XmlDocument.CreateElement "XDirection"
			XmlElement_XDirection.SetAttribute "value" (WaveQuad.XDirection as string)
			XmlElement_WaveQuad.appendChild XmlElement_XDirection

			local XmlElement_YDirection = XmlDocument.CreateElement "YDirection"
			XmlElement_YDirection.SetAttribute "value" (WaveQuad.YDirection as string)
			XmlElement_WaveQuad.appendChild XmlElement_YDirection
			
			XmlElement_WaveQuads.appendChild XmlElement_WaveQuad
		)
		XmlElement_WaterData.appendChild XmlElement_WaveQuads

		XmlDocument.appendChild XmlElement_WaterData
		return XmlDocument
	)
)

struct WaterQuad
(
	minX,
	maxX,
	minY,
	maxY,
	Type,
	IsInvisible,
	HasLimitedDepth,
	z,
	a1,
	a2,
	a3,
	a4,
	NoStencil
)

struct CalmingQuad
(
	minX,
	maxX,
	minY,
	maxY,
	fDampening
)

struct WaveQuad
(
	minX,
	maxX,
	minY,
	maxY,
	Amplitude,
	XDirection,
	YDirection
)


fn WaterQuadFromPlane settings =
(
	return (WaterQuad minX:settings.minX maxX:settings.maxX minY:settings.minY maxY:settings.maxY Type:settings.Type IsInvisible:settings.IsInvisible HasLimitedDepth:settings.HasLimitedDepth z:settings.z a1:settings.a1 a2:settings.a2 a3:settings.a3 a4:settings.a4 NoStencil:settings.NoStencil)
)

fn CalmingQuadFromPlane settings =
(
	return (CalmingQuad minX:settings.minX maxX:settings.maxX minY:settings.minY maxY:settings.maxY fDampening:settings.fDampening)
)

fn WaveQuadFromPlane settings =
(
	return (WaveQuad minX:settings.minX maxX:settings.maxX minY:settings.minY maxY:settings.maxY Amplitude:settings.Amplitude XDirection:settings.XDirection YDirection:settings.YDirection)
)



fn ExportWaterData WaterData =
(
	local filePath = getSaveFileName caption:"Save water.xml file" filename:("water.xml") types:"XML Document (*.xml)"
	if( filePath != undefined) then
	(
		format "WATER EXPORTER: %\n\n" (filePath)
		local XmlDocument = WaterData.WriteXML()
		XmlDocument.Save(filePath)
	)
)