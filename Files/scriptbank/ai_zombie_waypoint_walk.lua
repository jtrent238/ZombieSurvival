
local damage = 25
local attack_range = 100

local ai_starting_health = {}
local hit = {}
local lastroar = {}
local damageframe={}
local start_frame = {}
local end_frame = {}


function ai_zombie_waypoint_walk_init_name(e,name)
weapon_name[e] = name
end

function ai_zombie_waypoint_walk_main(e)

if ai_starting_health[e] == nil then
ai_starting_health[e] = g_Entity[e]['health']
ai_soldier_pathindex[e] = -1
ai_soldier_state[e] = "idle"
lastroar[e]= GetTimer(e)+math.random(6000,12000)
if weapon_name[e] == "Clown Zombie" then
damageframe[e] = 700
start_frame[e] = 683
end_frame[e] = 726
else
damageframe[e] = 2580
start_frame[e] = 2529
end_frame[e] = 2600
end
hit[e] = 0
else

EntObjNo = g_Entity[e]['obj']
--if player nearby / heard or damage taken
if ai_soldier_state[e] == "idle" then
if g_Entity[e]['health'] < ai_starting_health[e] or GetPlayerDistance(e) < AIGetEntityViewRange(EntObjNo) / 3 or AIGetEntityHeardSound(EntObjNo) == 1 then
ai_soldier_state[e] = "alert"
else
if GetTimer(e) > lastroar[e] then
   lastroar[e]= GetTimer(e)+math.random(6000,12000)
   PlaySound(e,0)
  end
--follow waypoint or random wander
if ai_soldier_pathindex[e] == -1 then
   ai_soldier_pathindex[e] = -2
   PathIndex = -1
   PathPointIndex = -1
   pClosest = 99999
   ai_patrol_x[e] = g_Entity[e]['x']
   ai_patrol_z[e] = g_Entity[e]['z']
   for pa = 1, AIGetTotalPaths(), 1 do
    for po = 1 , AIGetPathCountPoints(pa), 1 do
     pDX = g_Entity[e]['x'] - AIPathGetPointX(pa,po)
     pDZ = g_Entity[e]['z'] - AIPathGetPointZ(pa,po)
     pDist = math.sqrt(math.abs(pDX*pDX)+math.abs(pDZ*pDZ))
     if pDist < pClosest and pDist < 200 then
      pClosest = pDist
      PathIndex = pa
	  PathPointIndex = po
     end
    end -- po
   end -- pa
   if PathIndex > -1 then
    ai_soldier_pathindex[e] = PathIndex
	ai_path_point_index[e] = PathPointIndex
	ai_path_point_direction[e] = 1
	ai_path_point_max[e] = AIGetPathCountPoints(ai_soldier_pathindex[e])
   end   
  end
  if ai_soldier_pathindex[e] > -1 then 
  SetCharacterToWalk(e)
  CharacterControlUnarmed(e)
  ModulateSpeed(e,1)
   ai_patrol_x[e] = AIPathGetPointX(ai_soldier_pathindex[e],ai_path_point_index[e])
   ai_patrol_z[e] = AIPathGetPointZ(ai_soldier_pathindex[e],ai_path_point_index[e])
   AIEntityGoToPosition(EntObjNo,ai_patrol_x[e],ai_patrol_z[e])
   tDistX = g_Entity[e]['x'] - ai_patrol_x[e]
   tDistZ = g_Entity[e]['z'] - ai_patrol_z[e]
   DistFromPath = math.sqrt(math.abs(tDistX*tDistX)+math.abs(tDistZ*tDistZ))	
   if DistFromPath < 75 then
	if ai_path_point_direction[e] == 1 then
	 ai_path_point_index[e] = ai_path_point_index[e] + 1
	 if ( ai_path_point_index[e] > ai_path_point_max[e] ) then
	  ai_path_point_index[e] = ai_path_point_max[e] - 1
	  ai_path_point_direction[e] = 0
	 end
	else
	 ai_path_point_index[e] = ai_path_point_index[e] - 1
	 if ( ai_path_point_index[e] < 1 ) then
	  ai_path_point_index[e] = 2
	  ai_path_point_direction[e] = 1
	 end		
	end
	end
   else
   if g_Entity[e]['x'] > ai_patrol_x[e] - 70 and g_Entity[e]['x'] < ai_patrol_x[e] + 70 and g_Entity[e]['z'] > ai_patrol_z[e] - 70 and g_Entity[e]['z'] < ai_patrol_z[e] + 70 then
   ai_patrol_x[e] = g_Entity[e]['x'] + math.random(-500,500)
   ai_patrol_z[e] = g_Entity[e]['z'] + math.random(-500,500)
   if ai_patrol_x[e] < g_Entity[e]['x'] then
   ai_patrol_x[e] = ai_patrol_x[e] - 200
   else
   ai_patrol_x[e] = ai_patrol_x[e] + 200
   end
   if ai_patrol_z[e] < g_Entity[e]['z'] then
   ai_patrol_z[e] = ai_patrol_z[e] - 200
   else
   ai_patrol_z[e] = ai_patrol_z[e] + 200
   end
   else
   CharacterControlUnarmed(e)
   SetCharacterToWalk(e)
   AIEntityGoToPosition(EntObjNo,ai_patrol_x[e],ai_patrol_z[e])
   end
  end
end --player noticed

elseif ai_soldier_state[e] == "alert" then
CharacterControlUnarmed(e)
SetCharacterToWalk(e)
if GetPlayerDistance(e) > attack_range then
AIEntityGoToPosition(EntObjNo,g_PlayerPosX,g_PlayerPosZ)
else
ai_soldier_state[e] = "attack"
AIEntityGoToPosition(EntObjNo,g_Entity[e]['x'],g_Entity[e]['z'])
StopAnimation(e)
end

elseif ai_soldier_state[e] == "attack" then
RotateToPlayer(e)
LookAtPlayer(e)
SetAnimationSpeed(e,1)
CharacterControlLimbo(e)
if g_Entity[e]['animating'] == 0 then
SetAnimationFrames(start_frame[e],end_frame[e])
PlayAnimation(e)
g_Entity[e]['animating'] = 1 
end
if GetAnimationFrame(e) < damageframe[e] then
hit[e] = 0
else
if GetAnimationFrame(e)> damageframe[e] and hit[e] == 0 then
PlaySound(e,1)
hit[e] = 1 
HurtPlayer(e,damage)
end
if g_Entity[e]['plrvisible'] == 0 or GetPlayerDistance(e) > attack_range then
ai_soldier_state[e] = "idle"
end
end

end --state

end --health



end --main

function ai_zombie_waypoint_walk_exit(e)
PlayCharacterSound(e,"onDeath")
 CollisionOff(e)
end