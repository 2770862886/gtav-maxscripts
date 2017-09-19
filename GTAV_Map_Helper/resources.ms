struct archetype(aabbMin, aabbMax, centroid ,radius , txdName , name)
struct entity(ENTposition, ENTrotation, ENTname)

fn getArchetype obj =(
	in coordsys local aabbmin = obj.min
	in coordsys local aabbmax = obj.max
	local centroid = (aabbmax + aabbmin)/2
	local radius = ((distance aabbmax aabbmin) /2 )
	local txdName = (obj.name+"_ytd")
	local archetypeName = obj.name
	local arch = archetype aabbMin:aabbmin aabbmax:aabbmax centroid:centroid radius:radius txdName:txdName name:archetypeName
	return arch
)

fn getEntity obj=(
	local entity_position  = in coordsys world obj.pos
	local entity_rotation = inverse(in coordsys world obj.rotation)
	local archetypeName = obj.name
	local ent = entity ENTposition:entity_position ENTrotation:entity_rotation ENTname:archetypeName
	return ent
)