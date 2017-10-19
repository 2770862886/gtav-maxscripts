try(destroyDialog Water_Rollout )catch()
fileIn (scriptspath+"\\GTAV_Map_Helper\\water.ms")
struct WaterSettings(minX,maxX,minY,maxY,Type,IsInvisible,HasLimitedDepth,z,a1,a2,a3,a4,NoStencil,fDampening,Amplitude,XDirection,YDirection)

clearlistener()
actionMan.executeAction 0 "40472"
format "water.xml Script\n\nHow to use the script:\nWork from Top view and create planes for each water block.\nCustomize your settings and add the blocks.\nIf no plane is selected the selected min and max values are used.\nWhen you have finished just export the .xml file.\n"

WaterQuads = #()
CalmingQuads = #()
WaveQuads = #()
		
rollout Water_Rollout "Water.xml Scripts" width:170 height:555
(
	
	groupBox 'grp1' "WaterQuads" pos:[5,8] width:160 height:290 align:#left
	spinner 'WaterQuads_minX' "minX" pos:[15,26] width:117 height:16 range:[-8192,8192,0] type:#integer align:#left
	spinner 'WaterQuads_maxX' "maxX" pos:[15,47] width:114 height:16 range:[-8192,8192,0] type:#integer align:#left
	spinner 'WaterQuads_minY' "minY" pos:[15,68] width:117 height:16 range:[-8192,8192,0] type:#integer align:#left
	spinner 'WaterQuads_maxY' "maxY" pos:[15,89] width:114 height:16 range:[-8192,8192,0] type:#integer align:#left
		
	spinner 'WaterQuads_Type' "Type" pos:[15,110] width:116 height:16 range:[0,3,0] type:#integer align:#left
	checkbox 'WaterQuads_IsInvisible' "IsInvisible" pos:[15,131] width:140 height:15 align:#left
	checkbox 'WaterQuads_HasLimitedDepth' "HasLimitedDepth" pos:[15,151] width:140 height:15 align:#left
	spinner 'WaterQuads_z' "z" pos:[15,171] width:135 height:16 range:[-6000,6000,0] type:#float scale:0.001 align:#left
	spinner 'WaterQuads_a1' "a1" pos:[15,192] width:128 height:16 range:[0,100,26] type:#integer align:#left
	spinner 'WaterQuads_a2' "a2" pos:[15,213] width:128 height:16 range:[0,100,26] type:#integer align:#left
	spinner 'WaterQuads_a3' "a3" pos:[15,234] width:128 height:16 range:[0,100,26] type:#integer align:#left
	spinner 'WaterQuads_a4' "a4" pos:[15,255] width:128 height:16 range:[0,100,26] type:#integer align:#left
	checkbox 'WaterQuads_NoStencil' "NoStencil" pos:[15,276] width:140 height:15 align:#left
	
	groupBox 'grp2' "CalmingQuads" pos:[5,303] width:160 height:61 align:#left
	checkbox 'CalmingQuads_Add' "Enable" pos:[15,321] width:140 height:15 align:#left
	spinner 'CalmingQuads_fDampening' "fDampening" pos:[15,341] width:83 height:16 range:[0,1,0] type:#float scale:0.001 align:#left
	
	groupBox 'grp3' "WaveQuads" pos:[5,369] width:160 height:103 align:#left
	checkbox 'WaveQuads_Add' "Enable" pos:[15,387] width:140 height:15 align:#left
	spinner 'WaveQuads_Amplitude' "Amplitude" pos:[15,407] width:94 height:16 range:[0,2,0] type:#float scale:0.1 align:#left
	spinner 'WaveQuads_XDirection' "XDirection" pos:[15,428] width:91 height:16 range:[-1,1,0] type:#float scale:0.001 align:#left
	spinner 'WaveQuads_YDirection' "YDirection" pos:[15,449] width:91 height:16 range:[-1,1,0] type:#float scale:0.001 align:#left 
	button 'WaterQuads_Add' "Add Blocks" pos:[10,476] width:150 height:21 align:#left
	button 'Water_Export' "Export water.xml" pos:[10,502] width:150 height:21 align:#left
	button 'Water_Restart' "Restart" pos:[10,528] width:150 height:21 align:#left

	on WaterQuads_Add pressed do
	(
		Settings = WaterSettings minX:WaterQuads_minX.value maxX:WaterQuads_maxX.value minY:WaterQuads_minY.value maxY:WaterQuads_maxY.value Type:WaterQuads_Type.value IsInvisible:WaterQuads_IsInvisible.checked HasLimitedDepth:WaterQuads_HasLimitedDepth.checked z:WaterQuads_z.value a1:WaterQuads_a1.value a2:WaterQuads_a2.value a3:WaterQuads_a3.value a4:WaterQuads_a4.value NoStencil:WaterQuads_NoStencil.checked fDampening:CalmingQuads_fDampening.value Amplitude:WaveQuads_Amplitude.value XDirection:WaveQuads_XDirection.value YDirection:WaveQuads_YDirection.value
		
		list = getCurrentSelection()
		
		if(list.count == 0)then
		(
			local WaterQuad = WaterQuadFromPlane Settings
			append WaterQuads WaterQuad
			if(CalmingQuads_Add.checked)do
			(
				local CalmingQuad = CalmingQuadFromPlane Settings
				append CalmingQuads CalmingQuad
			)
			if(WaveQuads_Add.checked)do
			(
				local WaveQuad = WaveQuadFromPlane Settings
				append WaveQuads WaveQuad
			)
			
		)else
		(
			for obj in list do
			(
				if((superclassOf obj) == GeometryClass) then
				(
					Settings.minX = floor(obj.min.x)
					Settings.maxX = ceil(obj.max.x)
					Settings.minY = floor(obj.min.y)
					Settings.maxY = ceil(obj.max.y)
					local WaterQuad = WaterQuadFromPlane Settings
					append WaterQuads WaterQuad
					
					if(CalmingQuads_Add.checked)do
					(
						local CalmingQuad = CalmingQuadFromPlane Settings
						append CalmingQuads CalmingQuad
					)
					if(WaveQuads_Add.checked)do
					(
						local WaveQuad = WaveQuadFromPlane Settings
						append WaveQuads WaveQuad
					)
				)
				else (format "% is not a Geometry, water block will be skipped.\n" (obj.name))
			)
		)
	)

	on Water_Export pressed do
	(
		local Data = WaterData WaterQuads:WaterQuads CalmingQuads:CalmingQuads WaveQuads:WaveQuads
		ExportWaterData Data
	)

	on Water_Restart pressed do
	(
		WaterQuads = #()
		CalmingQuads = #()
		WaveQuads = #()
	)
)
createdialog Water_Rollout
