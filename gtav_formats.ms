struct archetype(aabbMin, aabbMax, centroid ,radius , txdName , name)
struct entity(ENTposition, ENTrotation, ENTname)

fn getArchetype i =(
	local tmp = copy i
	tmp.rotation =  (quat 0 0 0 1)
	tmp.pos = [0,0,0]
	local aabbmin = tmp.min
	local aabbmax = tmp.max
	local centroid = (aabbmax + aabbmin)/2
	local radius = ((distance aabbmax aabbmin) /2 )
	local txdName = (i.name+"_ytd")
	local archetypeName = i.name
	delete tmp
	local arch = archetype aabbMin:aabbmin aabbmax:aabbmax centroid:centroid radius:radius txdName:txdName name:archetypeName
	return arch
)

fn getEntity obj=(
	local entity_position  = coordsys world obj.pos
	local entity_rotation = inverse(coordsys world obj.rotation)
	local archetypeName = obj.name
	local ent = entity ENTposition:entity_position ENTrotation:entity_rotation ENTname:archetypeName
	return ent
)