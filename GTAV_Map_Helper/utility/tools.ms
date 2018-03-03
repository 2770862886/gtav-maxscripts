try(destroyDialog PropsUtilityGUI )catch()
rollout PaintVertices_Rollout "Vertices Painter" width:150 height:114
(
	dropdownlist 'the_Channel' pos:[10,10] width:130 height:16 items:#("Vertex Color","Vertex Illumination","Vertex Alpha")
	colorPicker 'the_Color' "" pos:[10,36] width:130 height:16 alpha:false color:[255,0,0]
	button 'btn_Paint' "Paint" pos:[10,88] width:130 height:16
	checkbox 'ck_selected' "Only selected vertices" pos:[10,62] width:130 height:16
	
	on btn_Paint pressed do
	(
		with undo on
		(
			theColor = the_Color.color
			theChannel = case the_Channel.selected of
			(
				"Vertex Color": 0
				"Vertex Illumination": -1
				"Vertex Alpha": -2
				default: 0
			)
			
			for obj in (selection as array) do
			( 
				if(ck_selected.checked)then local vertList = obj.selectedVerts
				else local vertList = obj.verts
				
				/*if(theChannel == -2) then
				(
					if classOf obj == editable_mesh then meshop.setVertAlpha obj theChannel vertList (theColor.alpha/255.0 as float)
					--if classOf obj == editable_poly then polyop.setVertAlpha obj theChannel vertList (theColor.alpha/255.0 as float)
				)*/
				
				if classOf obj == editable_mesh then meshop.setVertColor obj theChannel vertList theColor
				else if classOf obj == editable_poly then polyop.setVertColor obj theChannel vertList theColor
					
				update obj
			)
		)
	)
)

fn alignPivotToFaceZUp node face:1 =
(
	c = polyop.getfacecenter node face
	n = polyop.getfacenormal node face
	
	side = cross z_axis n
	up = cross n side
	
	ftm = matrix3 n side up c
	
	p = (nodeGetBoundingBox node ftm)[1] * ftm
	prerotateZ ftm -90 
		
	itm = ftm*(inverse node.transform)
	node.transform = ftm
	node.objectOffsetPos *= inverse itm
	node.objectOffsetRot *= inverse itm.rotation
		
	node.pivot = p
	node.transform
)

rollout PropsUtilityGUI "Placement Tools" width:170 height:290
	(	
		group "Utility"
		(
			button 'btn_center' "Center Pivot to Children" width:150 align:#center
			button 'btn_reset2' "Pos and Rot to Parent" width:150 align:#center
			button 'btn_reset1' "Pivot to Parent" width:150 align:#center
			button 'btn_centerbottom' "Center Pivot to Bottom" width:150 align:#center
			button 'btn_reset3' "Position to Parent" width:150 align:#center
			button 'btn_reset4' "Reset Z up" width:150 align:#center
			button 'btn_bottom_face' "Pivot to Bottom Face" width:150 align:#center
			button 'btn_delete_duplicate' "Delete objects with same name" width:150 align:#center
			button 'btn_vertices_painter' "Vertices Painter" width:150 align:#center
			button 'btn_group_by_material' "Group By Material" width:150 align:#center
		)
		
		on btn_group_by_material pressed do
		(
			with undo on
			(	
				for mat in SceneMaterials do
				(
					local selected = for geom in Geometry where geom.material == mat collect geom
					local theGroup = group selected name:mat.name select:false
					--for n in theGroup where (isGroupHead n == true) do (setGroupOpen n true)
				)
			)
		)
		
		on btn_vertices_painter pressed do
		(
			try(destroyDialog PaintVertices_Rollout )catch()
			createdialog PaintVertices_Rollout
		)
		
		on btn_bottom_face pressed do
		(
			with undo on
			(
				for obj in selection do
					(	
						if(classof(obj) == Editable_Poly)then
						(
							local faces = polyop.getNumFaces obj
							local fbottom = polyop.getfacecenter obj 1
							local fcenter = polyop.getfacecenter obj 1
							for face = 2 to faces do
							(
								fcenter = polyop.getfacecenter obj face
								if(fcenter.z < fbottom.z)do
									fbottom = fcenter
							)
							obj.pivot = fbottom
						)else format "% is not an Editable_Poly.\n" (obj.name)
					)
			)
		)
		
		on btn_delete_duplicate pressed do
		(
			with undo on
			(
				local allNames = #()
				local duplicateObjs = #()

				for obj in objects do
				(
					if findItem allNames obj.name == 0 then append allNames obj.name
					else append duplicateObjs obj
				)
				delete duplicateObjs
				allNames = #()	
			)
		)
		
		on btn_reset4 pressed do 
		(
			with undo on
			(
				for obj in selection do
					(
						if (classof(obj) == Editable_Poly) then
						(
							obj.pivot = obj.center
							alignPivotToFaceZUp obj
							obj.pivot = obj.center
						)else format "% is not an Editable_Poly.\n" (obj.name)
					)
			)
		)


		on btn_center pressed do
		(
			with undo on
			(
				for i in selection do
					(	
						if(i.children.count > 0) then
						(
							children_center = [0,0,0]
							for b in i.children do
							(
								children_center = children_center + b.center
							)
							children_center = children_center/i.children.count
							i.pivot = children_center
							i.children.pivot = children_center
						)else format "% hasn't any child.\n" (i.name)
					)
			)
		)
		
		on btn_reset1 pressed do
		(
			with undo on
			(
				for i in selection do
					(
						if(i.parent != undefined) then
						(
							i.pivot = i.parent.pivot
						)else format "% has no parent.\n" (i.name)
					)
			)
		)
		
		on btn_reset2 pressed do
		(
			with undo on
			(
				for i in selection do
					(
						if(i.parent != undefined) then
						(
							i.pos = i.parent.pos
							i.rotation = i.parent.rotation
						)else format "% has no parent.\n" (i.name)
					)
			)
		)
		
		on btn_reset3 pressed do
		(
			with undo on
			(
				for i in selection do
					(
						if(i.parent != undefined) then
						(
							i.pos = i.parent.pos
						)else format "% has no parent.\n" (i.name)
					)
			)
		)
		
		on btn_centerbottom pressed do
		(
			with undo on
			(
				for i in selection do
					(
						i.pivot = i.center
						i.pivot.z = i.min.z
					)
			)
		)
	)
createdialog PropsUtilityGUI