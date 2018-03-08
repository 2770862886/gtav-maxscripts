fn create_GIMS_model=(
	model_new = EGIMS_V_Model()
	for i in selection do 
	(	
		if((superclassOf i) == GeometryClass) then
		(
			model_new.rotation = i.rotation
			model_new.pivot = i.pivot
			i.parent  = model_new
			if((classOf i) == Editable_Mesh or (classOf i) == Editable_Poly) then
			(
				addmodifier i (EGIMS_V_ModelMesh())
			)
			else
			(
				format "% is not an Editable_Mesh or Editable_Poly, Game_mesh modifier skipped\n" (i.name)
			)
		)
		else
		(
			format "% is not a Geometry\n" (i.name)
		)
	)
)

fn create_multiple_GIMS_models=(
	for i in selection do 
	(	
		if((superclassOf i) == GeometryClass) then
		(
			model_new = EGIMS_V_Model()
			model_new.name = i.name
			model_new.rotation = i.rotation
			model_new.pivot = i.pivot
			i.parent  = model_new
			if((classOf i) == Editable_Mesh or (classOf i) == Editable_Poly) then
			(
				addmodifier i (EGIMS_V_ModelMesh())
			)
			else
			(
				format "% is not an Editable_Mesh or Editable_Poly, Game_mesh modifier skipped\n" (i.name)
			)
		)
		else
		(
			format "% is not a Geometry\n" (i.name)
		)
	)
)

fn create_GIMS_composite=(
	composite_new = EGIMS_V_Col_Composite()
	for i in selection do 
	(	
		if((superclassOf i) == GeometryClass) then
		(
			i.parent  = composite_new
			i.pivot = composite_new.pivot
			if((classOf i) == Editable_Mesh or (classOf i) == Editable_Poly) then
			(
				addmodifier i (EGIMS_V_CollisionMesh())
			)
			else
			(
				format "% is not an Editable_Mesh or Editable_Poly, Mesh modifier skipped\n" (i.name)
			)
		)
		else
		(
			format "% is not a Geometry\n" (i.name)
		)
	)
)

try(destroyDialog GIMS_Shortcuts )catch()

rollout GIMS_Shortcuts "GIMS Shortcuts" width:170 height:125
(	

	group "GIMS EVO Shortcuts"
	(
		button 'btn_createmodel' "Create Model" width:140 align:#center
		button 'btn_createmultimodels' "Create Multiple Models" width:140 align:#center
		button 'btn_createcomposite' "Create Composite" width:140 align:#center
	)
	
	on btn_createmodel pressed do
	(
		create_GIMS_model()
	)	
	
	on btn_createmultimodels pressed do
	(
		create_multiple_GIMS_models()
	)
	
	on btn_createcomposite pressed do
	(
		create_GIMS_composite()
	)
)
createdialog GIMS_Shortcuts