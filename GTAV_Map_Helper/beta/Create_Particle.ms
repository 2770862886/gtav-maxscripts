/*TODO
Expose custom AlignToNormal operand param to maxscript
Get BB which contains all the instances

*/

fn GetInstancedDataFromPFSource pSource obj =
(
	local InstanceList = #()
    for i = 1 to pSource.numparticles() do 
	(
        pSource.particleId = i
		
		pDir = pSource.particleTM.row3 --MAYBE NEEDS TO BE NORMALIZED
		pPos =  pSource.particlePosition
		append InstanceList pDir
		
		local NormalX = ((pDir.x +1)*0.5 * 255) as integer
		local NormalY = ((pDir.y +1)*0.5 * 255) as integer

		local _Scale = 1--settings[1]
		local Colors = [0,0,0]--settings[2]
		local Ao = 255--settings[3]
		local Pad = [0,0,0]--settings[4]
		
		local world_pos = pPos
		local batch_pos = (world_pos - batch._min)/(batch._max-batch._min) * 65535 
		local new_pos = #(batch_pos.x as integer,batch_pos.y as integer,batch_pos.z as integer)
		
		local InstanceData = rage__fwGrassInstanceListDef__InstanceData Position:new_pos NormalX:NormalX NormalY:NormalY _Color:Colors _Scale:_Scale Ao:Ao Pad:Pad
		append InstanceList InstanceData
	)
	--return InstanceData    
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
	op3.Shape_Object = theParticleMesh
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
		GetInstancedDataFromPFSource $selection[1] undefined
	)
)
createDialog PFSource_Rollout

