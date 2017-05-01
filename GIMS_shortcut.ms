/*clearlistener()
actionMan.executeAction 0 "40472"
format "GIMS_Shortcut\n"*/
fn create_GIMS_model=(
	model_new = EGIMS_V_Model()
	for i in selection do 
	(	
		if((classOf i) == Editable_Mesh or (classOf i) == Editable_Poly) then
		(
			model_new.rotation = i.rotation
			model_new.pivot = i.pivot
			i.parent  = model_new
		)
		else
		(
			format "% is not an Editable_Poly or Editable_Mesh\n" (i.name)
		)
	)
)

fn create_multiple_GIMS_models=(
	for i in selection do 
	(	
		if((classOf i) == Editable_Mesh or (classOf i) == Editable_Poly) then
		(
			model_new = EGIMS_V_Model()
			model_new.name = i.name
			model_new.rotation = i.rotation
			model_new.pivot = i.pivot
			i.parent  = model_new
		)
		else
		(
			format "% is not an Editable_Poly or Editable_Mesh\n" (i.name)
		)
	)
)

fn create_GIMS_composite=(
	composite_new = EGIMS_V_Col_Composite()
	for i in selection do 
	(	
		if((classOf i) == Editable_Mesh or (classOf i) == Editable_Poly) then
		(
			i.parent  = composite_new
			i.pivot = composite_new.pivot
		)
		else
		(
			format "% is not an Editable_Poly or Editable_Mesh\n" (i.name)
		)
	)
)