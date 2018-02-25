/*TODO
Expose custom AlignToNormal operand param to maxscript
Get BB which contains all the instances

*/
/*
fn ParticleBatches bbsize blocksize pSource =
(
  disableSceneRedraw() 
  suspendEditing() 
  
  undo off
	(
		local numblocks = [(bbsize.x/blocksize.x)as integer,(bbsize.y/blocksize.y),(bbsize.z/blocksize.z)] + [1,1,1];
		local arrayX =#()
		
		for x= -numblocks.x to numblocks.x do
		(
			local arrayY =#()	
			for y= -numblocks.y to numblocks.y do
			(
				local arrayZ =#()
				for z=-numblocks.z to numblocks.z do
				(
					local theContainer =#()
					append arrayZ theContainer
				)
				append arrayY arrayZ
			)
			append arrayX arrayY
		)
		print arrayX
		
		for id = 1 to pSource.numparticles() do 
		(
			pSource.particleId = id
			pPos = pSource.particlePosition
			
			for x= -numblocks.x to numblocks.x do
			(
				for y= -numblocks.y to numblocks.y do
				(
					for z=-numblocks.z to numblocks.z do
					(	
						if (pPos.x >= x*blocksize.x) and (pPos.x < (x+1)*blocksize.x) and (pPos.y >= y*blocksize.y) and (pPos.y < (y+1)*blocksize.y) and (pPos.z >= z*blocksize.z) and (pPos.z < (z+1)*blocksize.z) do
						(
							append arrayX[x+numblocks.x][y+numblocks.y][z+numblocks.z] id
						)
					)
				)
			)
			
			for x=1 to arrayX.count do
			(
				for y=1 to arrayX[x].count do
				(
					for z=1 to arrayX[x][y].count do
					(

						if(arrayX[x][y][z][1] != undefined)do
						(
							local batchbbmax = [x,y,z,0] + [numblocks.x, numblocks.y, numblocks.z, 0] + [blocksize.x,blocksize.y,blocksize.z,0]
							local batchbbmin = [x,y,z,0] + [numblocks.x, numblocks.y, numblocks.z, 0]
							
							local batch = rage__spdAABB _min:batchbbmin _max:batchbbmax
							
							local ScaleRange = BatchSettings[1]
							local archetypeName = BatchSettings[2]
							local lodDist = BatchSettings[3]
							local LodFadeStartDist = BatchSettings[4]
							local LodInstFadeRange = BatchSettings[5]
							local OrientToTerrain = BatchSettings[6]
							
							local InstanceList = #()
							
							for id in arrayX[x][y][z] do 
							(
								pSource.particleId = id
								local pDir = pSource.particleTM.row3 --MAYBE NEEDS TO BE NORMALIZED
								local idPos =  pSource.particlePosition
								
								local NormalX = ((pDir.x +1)*0.5 * 255) as integer
								local NormalY = ((pDir.y +1)*0.5 * 255) as integer

								local _Scale = InstanceSettings[1]
								local Colors = InstanceSettings[2]
								local Ao = InstanceSettings[3]
								local Pad = InstanceSettings[4]
								
								local world_pos = idPos
								local batch_pos = (world_pos - batch._min)/(batch._max-batch._min) * 65535 
								local new_pos = #(batch_pos.x as integer,batch_pos.y as integer,batch_pos.z as integer)
								
								local InstanceData = rage__fwGrassInstanceListDef__InstanceData Position:new_pos NormalX:NormalX NormalY:NormalY _Color:Colors _Scale:_Scale Ao:Ao Pad:Pad
								append InstanceList InstanceData
							)
							local Batch = rage__fwGrassInstanceListDef BatchAABB:batch ScaleRange:ScaleRange archetypeName:archetypeName lodDist:lodDist LodFadeStartDist:LodFadeStartDist LodInstFadeRange:LodInstFadeRange	OrientToTerrain:OrientToTerrain InstanceList:InstanceList
							
							append GrassInstanceList Batch
						)
						
					)
				)
			)			
		)
	)
  resumeEditing() 
  enableSceneRedraw()
)
*/

/*
on btn_grassymap_fromparticles pressed do
	(
		RefreshSettings()
		for obj in selection do
		(	
			if (classof(obj) == PF_Source)do ParticleBatches [1500.0,1500.0,1500.0] [500.0,500.0,500.0] obj
		)
	)
*/
fn SaveParticlesInfoText pSource =
(
	local filePath = getSaveFileName caption:"Save .txt" filename:("particles.txt") types:"Text File (*.txt)"
	
	if( filePath != undefined) then
	(
		local f = createfile filePath
		local fmt = "%%\n"
		local fmtNum = "#g"
		for i = 1 to pSource.numparticles() do 
		(
			pSource.particleId = i
			pDir = pSource.particleTM.row3 --MAYBE NEEDS TO BE NORMALIZED
			pPos =  pSource.particlePosition
			format fmt (formattedprint pPos format:fmtNum) (formattedprint pDir format:fmtNum) to:f
			
		)
	flush f
	close f
	)
)


fn SaveParticlesInfo pSource =
(
	local filePath = getSaveFileName caption:"Save .txt" filename:("particles.txt") types:"Text File (*.txt)"
	
	if( filePath != undefined) then
	(
	/*
		local f=fopen filePath "wb"
		
		for i = 1 to pSource.numparticles() do 
		(
			pSource.particleId = i
			pDir = pSource.particleTM.row3 --MAYBE NEEDS TO BE NORMALIZED
			pPos =  pSource.particlePosition
			WriteFloat f pPos.x
			WriteFloat f pPos.y
			WriteFloat f pPos.z
			WriteFloat f pDir.x
			WriteFloat f pDir.y
			--WriteFloat f pDir.z
		)
	fflush f
	fclose f*/
		
		local fmtNum = "#g"
		local writer = dotNetClass "System.IO.BinaryWriter"
		local file = dotNetClass "System.IO.File"
		local file_stream = dotNetObject writer (file.Create filePath)
		
		for i = 1 to pSource.numparticles() do 
		(
			pSource.particleId = i
			pDir = pSource.particleTM.row3 --MAYBE NEEDS TO BE NORMALIZED
			pPos =  pSource.particlePosition
			file_stream.Write pPos.x
			file_stream.Write pPos.y
			file_stream.Write pPos.z
			file_stream.Write pDir.x
			file_stream.Write pDir.y
			--file_stream.WriteLine ((formattedprint pPos format:fmtNum) + (formattedprint pDir format:fmtNum))
		)
 
        file_stream.Close()
        file_stream.Dispose()
        file_stream = undefined
	)
)

fn GetInstancedDataFromPFSource pSource obj =
(
    for i = 1 to pSource.numparticles() do 
	(
        pSource.particleId = i
		local theInstance = instance obj name:obj.name transform:pSource.particleTM wirecolor:obj.wirecolor
		theInstance.parent = pSource	
	) 
)

fn CreateBatchFromPFEvent theSurface theParticleMesh instancesAmount =
(
	local pfGTAV = PF_Source()
	pfGTAV.name = uniquename"GTAV_instancedData_Batch_"
	pfGTAV.Quantity_Viewport = 100
	pfGTAV.Show_Logo = off
	--TEMP STUFFS
	pfGTAV.Show_Emitter = on
	pfGTAV.Emitter_Length = theSurface.max.y - theSurface.min.y 
	pfGTAV.Emitter_Width = theSurface.max.x - theSurface.min.x
	pfGTAV.Emitter_Height = theSurface.max.z - theSurface.min.z
	pfGTAV.pos = theSurface.center
	pfGTAV.Particle_Amount_Limit = 1000000
	--END OF TEMP STUFFS
	
	particleFlow.BeginEdit()
	
	local ev1 = Event()
	ev1.name = uniquename "Batch_"
	
	local op1 = Birth()
	op1.Emit_Start = 0
	op1.Emit_Stop = 0
	op1.amount = instancesAmount
	ev1.AppendAction op1
	
	local op2 = Position_Object()
	appendifunique op2.Emitter_Objects theSurface
	op2.Lock_On_Emitter = on
	op2.location = 3
	op2.Random_Seed = random 0 1000000000
	ev1.AppendAction op2
	
	--TRICK TO GET SURFACE NORMALS
	/*local op5 = Speed_by_Surface()
	appendifunique op5.Surface_Objects theSurface
	op5.Direction_Type = 0
	op5.Speed_Value = 1
	ev1.AppendAction op5
	local op6 = Rotation()
	op6.direction = 3
	op6.Euler_Y = 90.0
	ev1.AppendAction op6
	local op7 = Speed()
	op7.speed = 0
	ev1.AppendAction op7*/
	-- END OF TRICK
	
	--CUSTOM ALIGN TO SURFACE (CAN'T ACCESS TO EXPOSED PARAM)
	local op8 = AlignToNormalOperator()
	--op8.Parameters[1] = theSurface --HOW ??!?!?
	ev1.AppendAction op8
	
	local op3 = Shape_Instance()
	if(superclassof(theParticleMesh)==Geometry) do op3.Shape_Object = theParticleMesh
	ev1.AppendAction op3
	
	local op4 = DisplayParticles()
	op4.type = 6
	op4.Selected_Type = 6
	ev1.AppendAction op4

	particleFlow.EndEdit()

	pfGTAV.AppendAction ev1
	
	pfGTAV.AppendInitialActionList ev1
)

rollout PFSource_Rollout "Particles Generator"
(
	pickbutton pck_surface "Select Surface" tooltip:"Select A Scene Object" autoDisplay:true width:150 
	pickbutton pck_obj "Select Particle" tooltip:"Select A Scene Object" autoDisplay:true width:150
	spinner spn_count "Instances" range:[0,1000000,100] type:#integer width:100
	button btn_create "Create Particles" width:150
	button btn_test "Test Export" width:150
	--on pck_surface picked obj do if isValidNode obj do pck_surface.name = obj.name
	--on pck_obj picked obj do if isValidNode obj do pck_obj.message = obj.name	
	
	on btn_create pressed do 
	(
		if((isValidNode pck_surface.object) and (superclassOf(pck_surface.object) == GeometryClass))then
		(
			if((isValidNode pck_obj.object))then
			(
				 CreateBatchFromPFEvent pck_surface.object pck_obj.object spn_count.value
			)else messageBox "Particle Object isn't a valid node"
		)else messageBox "Surface Object isn't a Geometry"
	)
	
	on btn_test pressed do
	(
		SaveParticlesInfo $selection[1]
	)
)
createDialog PFSource_Rollout

