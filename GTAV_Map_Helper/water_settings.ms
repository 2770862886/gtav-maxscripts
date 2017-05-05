fileIn (scriptspath+"\\GTAV_Map_Helper\\water.ms")
struct WaterQuadValues(minX,maxX,minY,maxY,Type,IsInvisible,HasLimitedDepth,z,a1,a2,a3,a4,NoStencil,fDampening,Amplitude,XDirection,YDirection)

XDocument_Water = create_Water()
XElement_WaterData = XDocument_Water.Element XName_WaterData
XElement_WaterQuads = XElement_WaterData.Element XName_WaterQuads
XElement_CalmingQuads = XElement_WaterData.Element XName_CalmingQuads
XElement_WaveQuads = XElement_WaterData.Element XName_WaveQuads
		
rollout Water_Exporter "Water.xml Exporter" width:200 height:530
(	
	group "WaterQuads"
	(
		spinner 'WaterQuads_minX' "minX" range:[-8192,8192,0] type:#integer align:#center width:150
		spinner 'WaterQuads_maxX' "maxX" range:[-8192,8192,0] type:#integer align:#center width:150
		spinner 'WaterQuads_minY' "minY" range:[-8192,8192,0] type:#integer align:#center width:150
		spinner 'WaterQuads_maxY' "maxY" range:[-8192,8192,0] type:#integer align:#center width:150
		
		spinner 'WaterQuads_Type' "Type" range:[0,3,0] type:#integer align:#center width:150
		checkbox 'WaterQuads_IsInvisible' "IsInvisible" align:#center width:150
		checkbox 'WaterQuads_HasLimitedDepth' "HasLimitedDepth" align:#center width:150
		spinner 'WaterQuads_z' "z" range:[-6000,6000,0] scale: 0.001 type:#float align:#center width:150
		spinner 'WaterQuads_a1' "a1" range:[0,100,26] type:#integer align:#center width:150
		spinner 'WaterQuads_a2' "a2" range:[0,100,26] type:#integer align:#center width:150
		spinner 'WaterQuads_a3' "a3" range:[0,100,26] type:#integer align:#center width:150
		spinner 'WaterQuads_a4' "a4" range:[0,100,26] type:#integer align:#center width:150
		checkbox 'WaterQuads_NoStencil' "NoStencil" align:#center width:150
	)
	
	group "CalmingQuads"
	(
		checkbox 'CalmingQuads_Add' "Enable" align:#center width:150
		spinner 'CalmingQuads_fDampening' "fDampening" range:[0,1,0] scale: 0.001 type:#float align:#center
	)
	
	group "WaveQuads"
	(
		checkbox 'WaveQuads_Add' "Enable" align:#center width:150
		spinner 'WaveQuads_Amplitude' "Amplitude" range:[0,2,0] scale: 0.1 type:#float align:#center
		spinner 'WaveQuads_XDirection' "XDirection" range:[-1,1,0] scale: 0.001 type:#float align:#center
		spinner 'WaveQuads_YDirection' "YDirection" range:[-1,1,0] scale: 0.001 type:#float align:#center 
	)
	button 'WaterQuads_Add' "Add Blocks" align:#center width:150
	button 'Water_Export' "Export water.xml" align:#center width:150
	
	on WaterQuads_Add pressed do
	(
		Water_Settings_Values = WaterQuadValues minX:WaterQuads_minX.value maxX:WaterQuads_maxX.value minY:WaterQuads_minY.value maxY:WaterQuads_maxY.value Type:WaterQuads_Type.value IsInvisible:WaterQuads_IsInvisible.checked HasLimitedDepth:WaterQuads_HasLimitedDepth.checked z:WaterQuads_z.value a1:WaterQuads_a1.value a2:WaterQuads_a2.value a3:WaterQuads_a3.value a4:WaterQuads_a4.value NoStencil:WaterQuads_NoStencil.checked fDampening:CalmingQuads_fDampening.value Amplitude:WaveQuads_Amplitude.value XDirection:WaveQuads_XDirection.value YDirection:WaveQuads_YDirection.value
		
		list = getCurrentSelection()
		
		if(list.count == 0)then
		(
			XElement_WaterQuad = create_WaterQuad Water_Settings_Values
			XElement_WaterQuads.Add XElement_WaterQuad
			if(CalmingQuads_Add.checked)do
			(
				XElement_CalmingQuad = create_CalmingQuad Water_Settings_Values
				XElement_CalmingQuads.Add XElement_CalmingQuad
			)
			if(WaveQuads_Add.checked)do
			(
				XElement_WaveQuad = create_WaveQuad Water_Settings_Values
				XElement_WaveQuads.Add XElement_WaveQuad
			)
			
		)else
		(
			for obj in list do
			(
				if((superclassOf obj) == GeometryClass) then
				(
					Water_Settings_Values.minX = floor(obj.min.x)
					Water_Settings_Values.maxX = ceil(obj.max.x)
					Water_Settings_Values.minY = floor(obj.min.y)
					Water_Settings_Values.maxY = ceil(obj.max.y)
					XElement_WaterQuad = create_WaterQuad Water_Settings_Values
					XElement_WaterQuads.Add XElement_WaterQuad
					
					if(CalmingQuads_Add.checked)do
					(
						XElement_CalmingQuad = create_CalmingQuad Water_Settings_Values
						XElement_CalmingQuads.Add XElement_CalmingQuad
					)
					if(WaveQuads_Add.checked)do
					(
						XElement_WaveQuad = create_WaveQuad Water_Settings_Values
						XElement_WaveQuads.Add XElement_WaveQuad
					)
				)
				else (format "% is not a Geometry, water block will be skipped.\n" (obj.name))
			)
		)
	)
	
	on Water_Export pressed do
	(
		export_Water XDocument_Water
	)		
)
createdialog Water_Exporter
