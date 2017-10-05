try(global Json_Assembly = dotNet.loadAssembly (scriptspath+"\\GTAV_Map_Helper\\fivem\\Newtonsoft.Json.dll"))
catch( messagebox "Impossible to load assembly Newtonsoft.Json.dll\nPlease check if Windows is locking the assembly Newtonsoft.Json.dll\nRight click on it and open Properties, then unlock it from its General tab.\nThen restart 3ds Max.\n\n Json features will be disabled." title:"GTA V Map Helper" )

struct JsonEntityInfo(EntityInfo_position, EntityInfo_rotation, EntityInfo_name)

fn create_JObject_Archetype obj =(
	local Archetype_aabbmin = (in coordsys local obj.min)
	local Archetype_aabbmax = (in coordsys local obj.max)
	local Archetype_centroid = (Archetype_aabbmax + Archetype_aabbmin)/2
	local Archetype_radius = ((distance Archetype_aabbmax Archetype_aabbmin) /2 )
	local Archetype_txdName = (obj.name+"_ytd")
	local Archetype_Name = obj.name
	
	local archetype = dotNetObject "Newtonsoft.Json.Linq.JObject"
	local JArray_aabbmin = dotNetObject "Newtonsoft.Json.Linq.JArray"
	local JArray_aabbmax = dotNetObject "Newtonsoft.Json.Linq.JArray"
	local JArray_centroid = dotNetObject "Newtonsoft.Json.Linq.JArray"
	JArray_aabbmin.Add Archetype_aabbmin.x
	JArray_aabbmin.Add Archetype_aabbmin.y
	JArray_aabbmin.Add Archetype_aabbmin.z
	JArray_aabbmax.Add Archetype_aabbmax.x
	JArray_aabbmax.Add Archetype_aabbmax.y
	JArray_aabbmax.Add Archetype_aabbmax.z
	JArray_centroid.Add Archetype_centroid.x 
	JArray_centroid.Add Archetype_centroid.y
	JArray_centroid.Add Archetype_centroid.z
	local JProperty_radius = dotNetObject "Newtonsoft.Json.Linq.JProperty" "radius" Archetype_radius
	local JProperty_aabbmin = dotNetObject "Newtonsoft.Json.Linq.JProperty" "aabbMin" JArray_aabbmin
	local JProperty_aabbmax = dotNetObject "Newtonsoft.Json.Linq.JProperty" "aabbMax" JArray_aabbmax
	local JProperty_centroid = dotNetObject "Newtonsoft.Json.Linq.JProperty" "centroid" JArray_centroid
	local JProperty_txdName = dotNetObject "Newtonsoft.Json.Linq.JProperty" "txdName" Archetype_txdName
	local JProperty_archetypeName = dotNetObject "Newtonsoft.Json.Linq.JProperty" "archetypeName" Archetype_name
	archetype.Add JProperty_aabbmin
	archetype.Add JProperty_aabbmax
	archetype.Add JProperty_centroid
	archetype.Add JProperty_radius
	archetype.Add JProperty_archetypeName
	archetype.Add JProperty_txdName
	return archetype
)
	
fn create_JObject_Entity obj =(
	local Entity_name = obj.name
	local Entity_position = (in coordsys world obj.pos)
	local Entity_rotation = inverse(in coordsys world obj.rotation)
	
	local entity = dotNetObject "Newtonsoft.Json.Linq.JObject"	
	local JArray_position = dotNetObject"Newtonsoft.Json.Linq.JArray"
	local JArray_rotation = dotNetObject"Newtonsoft.Json.Linq.JArray"
	local Class_Guid = dotNetClass "System.Guid"
	local Guid_Object = Class_Guid.NewGuid()
	JArray_position.Add Entity_position.x
	JArray_position.Add Entity_position.y
	JArray_position.Add Entity_position.z
	JArray_rotation.Add Entity_rotation.x
	JArray_rotation.Add Entity_rotation.y
	JArray_rotation.Add Entity_rotation.z
	JArray_rotation.Add Entity_rotation.w
	local JProperty_rotation = dotNetObject "Newtonsoft.Json.Linq.JProperty" "rotation" JArray_rotation
	local JProperty_position = dotNetObject "Newtonsoft.Json.Linq.JProperty" "position" JArray_position
	local JProperty_guid = dotNetObject "Newtonsoft.Json.Linq.JProperty" "guid" (Guid_Object.ToString(""))
	local JProperty_archetypeName = dotNetObject "Newtonsoft.Json.Linq.JProperty" "archetypeName" Entity_name		
	entity.Add JProperty_position
	entity.Add JProperty_rotation
	entity.Add JProperty_guid
	entity.Add JProperty_archetypeName		
	return entity
)

fn readJson=(
	local filePath = getOpenFileName caption:"Import .Json file" types:"Newtonsoft (*.json)"
			
	if(filePath != undefined) then
	(
		format "JSON READER: %\n\n" (filePath)
		local streamReader  = dotnetObject "System.IO.StreamReader" filePath
		local jsonString = streamReader.ReadToEnd()
		streamReader.close()
		local importedJson=dotNetObject "Newtonsoft.Json.Linq.JObject"
		importedJson=importedJson.parse jsonString
		
		local JEnumerable = importedJson.Item["entities"].Children()
		local Enumerator = JEnumerable.GetEnumerator()
				
		local EntityList =#()
				
		while Enumerator.MoveNext() do
		(
			local iterEntity = dotNetObject "Newtonsoft.Json.Linq.JObject" Enumerator.Current
			local JTokenArrayPos = iterEntity.GetValue "position"
			local JTokenArrayRot = iterEntity.GetValue "rotation"
			local JTokenName = iterEntity.GetValue "archetypeName"
					
			local JValuePosX = JTokenArrayPos.item(0)
			local JValuePosY = JTokenArrayPos.item(1)
			local JValuePosZ = JTokenArrayPos.item(2)
					
			local JValueRotX = JTokenArrayRot.item(0)
			local JValueRotY = JTokenArrayRot.item(1)
			local JValueRotZ = JTokenArrayRot.item(2)
			local JValueRotW = JTokenArrayRot.item(3)
			local JValueName = JTokenName
					
			local PositionValue = [(JValuePosX.Value as float), (JValuePosY.Value as float), (JValuePosZ.Value as float)]
			local RotationValue = [(JValueRotX.Value as float), (JValueRotY.Value as float), (JValueRotZ.Value as float), (JValueRotW.Value as float)]
			local NameValue = JTokenName.Value
					
			local Entity = JsonEntityInfo EntityInfo_position:PositionValue EntityInfo_rotation:RotationValue EntityInfo_name:NameValue
			append EntityList Entity
		)
	)
	return entityList
)

fn exportJson check_archetypes check_entities objects_list=(
	local filePath = getSaveFileName caption:"Save .json file" filename:"Output.json" types:"Newtonsoft (*.json)"
	
	if( filePath != undefined) then
	(
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
					if(finditem archetypes_list obj.name == 0) then
					(
						append archetypes_list obj.name
						local JObject_archetype = create_JObject_Archetype obj
						JArray_archetypes.Add JObject_archetype
					)else (format "Duplicated archetype with the name % found, it will be skipped.(Is this an instance?)\n" (obj.name))
				)
				else (format "% is not a Geometry, archetype will be skipped.\n" (obj.name))
			)
				if check_entities do
				(
					local JObject_Entity = create_JObject_Entity obj
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
			if( getnodebyname(a.EntityInfo_name) == undefined ) do
				appendifunique missing_list a.EntityInfo_name
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
			if( getnodebyname(a.EntityInfo_name) != undefined )then
			(
				if( finditem instances_list a.EntityInfo_name == 0 )then
				(
					format "FOUND: %\n" (a.EntityInfo_name)
					append instances_list a.EntityInfo_name
					selected_node = getnodebyname(a.EntityInfo_name)
					selected_node.rotation = (inverse(quat a.EntityInfo_rotation.x a.EntityInfo_rotation.y a.EntityInfo_rotation.z a.EntityInfo_rotation.w))	
					selected_node.pos = a.EntityInfo_position
				)
				else
				(
					instanced_entity
					format "FOUND: % (INSTANCE)\n" (a.EntityInfo_name)
					selected_node = getnodebyname(a.EntityInfo_name)
					maxOps.CloneNodes selected_node expandHierarchy:true cloneType:#instance newNodes:&instanced_entity
					instanced_entity.rotation = (inverse(quat a.EntityInfo_rotation.x a.EntityInfo_rotation.y a.EntityInfo_rotation.z a.EntityInfo_rotation.w))
					instanced_entity.pos = a.EntityInfo_position
					instanced_entity.name = (a.EntityInfo_name)
				)	
			)else format "MISSING: %\n" (a.EntityInfo_name)
		)
	)
)