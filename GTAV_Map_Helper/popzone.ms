fn export_popzoneipl objects_list =(
	local filePath = getSaveFileName caption:"Save popzone.ipl file" filename:"popzone.ipl" types:"IPL Text File (*.ipl)"
	if( filePath != undefined) then
	( 	
		format "POPZONE.IPL EXPORTER: %\n\n" (filePath)
		local popzone = "zone\n"
		for obj in objects_list do
		(
			if((superclassOf obj) == GeometryClass) then
				(
					popzone = popzone + obj.name + ", " + (obj.min.x as string) + ", " + (obj.min.y as string) + ", " + (obj.min.z as string) + ", " + (obj.max.x as string) + ", " + (obj.max.y as string) + ", " + (obj.max.z as string) + ", " + ("display_"+obj.name) + ", " + (0 as string) + "\n"
				)
		)
		popzone = popzone + "end"
		try
		( 
			fs = openFile filePath mode:"wt"
			format "%" popzone to:fs
			close fs
		)
		catch (messagebox "Can't write the file!")
	)
)

list = getCurrentSelection()
export_popzoneipl list