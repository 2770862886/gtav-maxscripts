try( 
	global Json_Assembly = dotNet.loadAssembly (scriptspath+"\\GTAV_Map_Helper\\fivem\\Newtonsoft.Json.dll")
	)
catch( 
	messagebox "Impossible to load assembly Newtonsoft.Json.dll\nPlease check if Windows is locking the assembly Newtonsoft.Json.dll\nRight click on it and open Properties, then unlock it from its General tab.\nThen restart 3ds Max.\n\n Json features will be disabled." title:"GTA V Map Helper" 
	)

fileIn (scriptspath+"\\GTAV_Map_Helper\\resources.ms")

fn create_JObject_Archetype obj =(
	local archetype = dotNetObject "Newtonsoft.Json.Linq.JObject"
	local JArray_aabbmin = dotNetObject "Newtonsoft.Json.Linq.JArray"
	local JArray_aabbmax = dotNetObject "Newtonsoft.Json.Linq.JArray"
	local JArray_centroid = dotNetObject "Newtonsoft.Json.Linq.JArray"
	JArray_aabbmin.Add obj.aabbMin.x
	JArray_aabbmin.Add obj.aabbMin.y
	JArray_aabbmin.Add obj.aabbMin.z
	JArray_aabbmax.Add obj.aabbMax.x
	JArray_aabbmax.Add obj.aabbMax.y
	JArray_aabbmax.Add obj.aabbMax.z
	JArray_centroid.Add obj.centroid.x 
	JArray_centroid.Add obj.centroid.y
	JArray_centroid.Add obj.centroid.z
	local JProperty_radius = dotNetObject "Newtonsoft.Json.Linq.JProperty" "radius" obj.radius
	local JProperty_aabbmin = dotNetObject "Newtonsoft.Json.Linq.JProperty" "aabbMin" JArray_aabbmin
	local JProperty_aabbmax = dotNetObject "Newtonsoft.Json.Linq.JProperty" "aabbMax" JArray_aabbmax
	local JProperty_centroid = dotNetObject "Newtonsoft.Json.Linq.JProperty" "centroid" JArray_centroid
	local JProperty_txdName = dotNetObject "Newtonsoft.Json.Linq.JProperty" "txdName" obj.txdName
	local JProperty_archetypeName = dotNetObject "Newtonsoft.Json.Linq.JProperty" "archetypeName" obj.name
	archetype.Add JProperty_aabbmin
	archetype.Add JProperty_aabbmax
	archetype.Add JProperty_centroid
	archetype.Add JProperty_radius
	archetype.Add JProperty_archetypeName
	archetype.Add JProperty_txdName
	return archetype
)
	
fn create_JObject_Entity obj =(
	local entity = dotNetObject "Newtonsoft.Json.Linq.JObject"	
	local JArray_position = dotNetObject"Newtonsoft.Json.Linq.JArray"
	local JArray_rotation = dotNetObject"Newtonsoft.Json.Linq.JArray"
	local Class_Guid = dotNetClass "System.Guid"
	local Guid_Object = Class_Guid.NewGuid()
	JArray_position.Add obj.ENTposition.x
	JArray_position.Add obj.ENTposition.y
	JArray_position.Add obj.ENTposition.z
	JArray_rotation.Add obj.ENTrotation.x
	JArray_rotation.Add obj.ENTrotation.y
	JArray_rotation.Add obj.ENTrotation.z
	JArray_rotation.Add obj.ENTrotation.w
	local JProperty_rotation = dotNetObject "Newtonsoft.Json.Linq.JProperty" "rotation" JArray_rotation
	local JProperty_position = dotNetObject "Newtonsoft.Json.Linq.JProperty" "position" JArray_position
	local JProperty_guid = dotNetObject "Newtonsoft.Json.Linq.JProperty" "guid" (Guid_Object.ToString(""))
	local JProperty_archetypeName = dotNetObject "Newtonsoft.Json.Linq.JProperty" "archetypeName" obj.ENTname			
	entity.Add JProperty_position
	entity.Add JProperty_rotation
	entity.Add JProperty_guid
	entity.Add JProperty_archetypeName		
	return entity
)

fn readJson=(
	clearlistener()
	filePath = getOpenFileName caption:"Import .Json file" types:"Newtonsoft (*.json)"
			
	if(filePath != undefined) then
	(
		actionMan.executeAction 0 "40472"
		format "JSON IMPORTER %\n\n" (filePath)
		streamReader  = dotnetObject "System.IO.StreamReader" filePath
		jsonString = streamReader.ReadToEnd()
		streamReader.close()
		importedJson=dotNetObject "Newtonsoft.Json.Linq.JObject"
		importedJson=importedJson.parse jsonString
		
		JEnumerable = importedJson.Item["entities"].Children()
		enumerator = JEnumerable.GetEnumerator()
				
		local entityList =#()
				
		while enumerator.MoveNext() do
		(
			iterEntity = dotNetObject "Newtonsoft.Json.Linq.JObject" enumerator.Current
			JTokenArrayPos = iterEntity.GetValue "position"
			JTokenArrayRot = iterEntity.GetValue "rotation"
			JTokenName = iterEntity.GetValue "archetypeName"
					
			JValuePosX = JTokenArrayPos.item(0)
			JValuePosY = JTokenArrayPos.item(1)
			JValuePosZ = JTokenArrayPos.item(2)
					
			JValueRotX = JTokenArrayRot.item(0)
			JValueRotY = JTokenArrayRot.item(1)
			JValueRotZ = JTokenArrayRot.item(2)
			JValueRotW = JTokenArrayRot.item(3)
			JValueName = JTokenName
					
			PositionValue = [(JValuePosX.Value as float), (JValuePosY.Value as float), (JValuePosZ.Value as float)]
			RotationValue = [(JValueRotX.Value as float), (JValueRotY.Value as float), (JValueRotZ.Value as float), (JValueRotW.Value as float)]
			NameValue = JTokenName.Value
					
			local foundEntity = entity ENTposition:PositionValue ENTrotation:RotationValue ENTname:NameValue
			append entityList foundEntity
		)
	)
	return entityList
)

fn exportJson check_archetypes check_entities objects_list=(
	clearlistener()
	local filePath = getSaveFileName caption:"Save .json file" filename:"Output.json" types:"Newtonsoft (*.json)"
	
	if( filePath != undefined) then
	(
		actionMan.executeAction 0 "40472"
		format "JSON EXPORTER: %\n\n" (filePath)
		local JObject = dotNetObject "Newtonsoft.Json.Linq.JObject"
		local JProperty_schema = dotNetObject "Newtonsoft.Json.Linq.JProperty" "$schema" "schema.json"
		local JArray_archetypes = dotNetObject "Newtonsoft.Json.Linq.JArray"
		local JArray_entities = dotNetObject "Newtonsoft.Json.Linq.JArray"
			
		local archetypes_list = #()
			
		for obj in objects_list do
		(	
		if check_archetypes do
			(
				if((superclassOf obj) == GeometryClass) then
				(	
					local archetype = getArchetype(obj)
					if(finditem archetypes_list archetype.name == 0) then
					(
						append archetypes_list archetype.name
						local JObject_archetype = create_JObject_Archetype archetype
						JArray_archetypes.Add JObject_archetype
					)else (format "Duplicated archetype with the name % found, it will be skipped.(Is this an instance?)\n" (obj.name))
				)
				else (format "% is not a Geometry, archetype will be skipped.\n" (obj.name))
			)
				if check_entities do
				(
					local entity = getEntity(obj)
					local JObject_Entity = create_JObject_Entity entity
					JArray_entities.Add JObject_Entity
				)		
		)
		JObject.Add JProperty_schema	
		if(check_archetypes and JArray_archetypes.count > 0) then
		(	
			JProperty_archetypes = dotNetObject "Newtonsoft.Json.Linq.JProperty" "archetypes" JArray_archetypes
			JObject.Add JProperty_archetypes
		)
		if(check_entities and JArray_entities.count > 0) then
		(
			JProperty_entities = dotNetObject "Newtonsoft.Json.Linq.JProperty" "entities" JArray_entities
			JObject.Add JProperty_entities
		)
	
		local JObject_String = JObject.toString()
		try
		( 
			fs= openFile filePath mode:"wt"
			format "%" JObject_String to:fs
			close fs
		)
		catch (messagebox "Can't write the file!")
	)
)

fn checkJson=(
	local entities_list = readJson()
	local missing_list = #()
	if(entities_list != undefined and entities_list.count > 0) then
	(
		for a in entities_list do
		(
			if( getnodebyname(a.ENTname) == undefined ) do
				appendifunique missing_list a.ENTname
		)	
		if(missing_list !=undefined and missing_list.count >0 )then
		(
			for b in missing_list do
				format "MISSING: %\n" (b)
		) else format "No archetype missing in scene!\n"
	)else format "The .json file doesn't contain any entity.\n"
)

fn importJson=(
	local entities_list = readJson()
	local instances_list = #()
			
	if(entities_list != undefined and entities_list.count > 0) then
	(
		for a in entities_list do
		(
			if( getnodebyname(a.ENTname) != undefined )then
			(
				if( finditem instances_list a.ENTname == 0 )then
				(
					format "FOUND: %\n" (a.ENTname)
					append instances_list a.ENTname
					selected_node = getnodebyname(a.ENTname)
					selected_node.rotation = (inverse(quat a.ENTrotation.x a.ENTrotation.y a.ENTrotation.z a.ENTrotation.w))	
					selected_node.pos = a.ENTposition
				)
				else
				(
					instanced_entity
					format "INSTANCE FOUND: %\n" (a.ENTname)
					selected_node = getnodebyname(a.ENTname)
					maxOps.CloneNodes selected_node expandHierarchy:true cloneType:#instance newNodes:&instanced_entity
					instanced_entity.rotation = (inverse(quat a.ENTrotation.x a.ENTrotation.y a.ENTrotation.z a.ENTrotation.w))
					instanced_entity.pos = a.ENTposition
					instanced_entity.name = (a.ENTname+"_INSTANCE")
				)	
			)else format "----- MISSING: %\n" (a.ENTname)
		)
	)
)