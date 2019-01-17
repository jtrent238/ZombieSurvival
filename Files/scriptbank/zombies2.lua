

--when to start being able to attack
local attack_range = 100
--delay before resetting state (if cant see player etc)
local delay_init = 3000
--time before warning becomes attacking
local w2a_delay_init = 1000
--how long before dead body gets removed
local remove_delay_init = 7000
--damage per attack
local damage = 80

--animation speed for idle
local idle_speed = 1
--animation speed for walking
local move_speed = 1
--animation speed for warning
local warning_speed = 1
--animation speed for attacking
local attack_speed =2
--animation speed for dying
local die_speed = 1

local remove_delay = {}
local state = {}
local health = {}
local delay = {}
local w2a = {}
local hit = {}

local attacking = {}
local warning = {}
local idle = {}



function zombies2_init(e)
state[e] = "wander"
delay[e] = delay_init
hit[e] = 0
attacking[e] = 0
warning[e] = 0
idle[e] = 0
end


function zombies2_main(e)
--Text(2,2,4,"dead creatures : "..Killed)
EntObjNo = g_Entity[e]['obj']
if health[e] == nil then
health[e] = g_Entity[e]['health'] + 5000
SetEntityHealth(e,g_Entity[e]['health'] + 5000)
ai_soldier_pathindex[e] = -1
elseif g_Entity[e]['health'] > 5000 then


if state[e] == "wander" then
warning[e] = 0
attacking[e] = 0
  if ai_soldier_pathindex[e] == -1 then
   ai_soldier_pathindex[e] = -2
   PathIndex = -1
   PathPointIndex = -1
   pClosest = 99999
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
  elseif ai_soldier_pathindex[e] > -1 then 
   ai_patrol_x[e] = AIPathGetPointX(ai_soldier_pathindex[e],ai_path_point_index[e])
   ai_patrol_z[e] = AIPathGetPointZ(ai_soldier_pathindex[e],ai_path_point_index[e])
   CharacterControlUnarmed(e)
   SetCharacterToWalk(e)
   ModulateSpeed(e,move_speed)
   AIEntityGoToPosition(g_Entity[e]['obj'],ai_patrol_x[e],ai_patrol_z[e])
   tDistX = g_Entity[e]['x'] - ai_patrol_x[e]
   tDistZ = g_Entity[e]['z'] - ai_patrol_z[e]
   DistFromPath = math.sqrt(math.abs(tDistX*tDistX)+math.abs(tDistZ*tDistZ))	
   if DistFromPath < 50 then
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
    --idle
   if idle[e] == 0 then
   idle[e] = 1 
   AIEntityStop(EntObjNo)
   StopAnimation(e)
LoopSound(e,2)
   ModulateSpeed(e,idle_speed)
   CharacterControlLimbo(e)
   if g_Entity[e]['animating'] == 0 then
  SetAnimation(1)
  LoopAnimation(e)
  g_Entity[e]['animating'] = 1 
  end
  end
  end
  
  if g_Entity[e]['plrvisible'] == 1 or g_Entity[e]['health'] < health[e] or GetPlayerDistance(e) < attack_range * 2 then
  w2a[e] = GetTimer(e) + w2a_delay_init
  delay[e] = GetTimer(e) + delay_init
  warning[e] = 0
  idle[e] = 0
  state[e] = "alert"
  end

 elseif state[e] == "alert" then
 idle[e] = 0
 attacking[e] = 0
StopSound(e,2)
 LoopSound(e,1)
 --LookAtPlayer(e)
 if warning[e] == 0 then
 StopAnimation(e)
 AIEntityStop(e)
 ModulateSpeed(e,warning_speed)
 CharacterControlLimbo(e)
 RotateToPlayer(e)
 if g_Entity[e]['animating'] == 0 then
 warning[e] = 1
 SetAnimation(2)
 LoopAnimation(e)
 g_Entity[e]['animating'] = 1 
 end
 end
 if g_Entity[e]['plrvisible'] == 0 and AIGetEntityHeardSound(g_Entity[e]['obj']) == 0 and GetTimer(e) >= delay[e] then
 warning[e] = 0
 state[e] = "wander"
 StopSound(e,1)
 else
 if GetPlayerDistance(e) <= attack_range or g_Entity[e]['health'] < health[e] or GetTimer(e) > w2a[e] then
 state[e] = "attack"
 delay[e] = GetTimer(e) + delay_init
--*********************************************************************
 --StopSound(e,1)
PlaySound(e,1)
--*********************************************************************
 end
 end
 
 elseif state[e] == "attack" then
 warning[e] = 0
 idle[e] = 0
StopSound(e,1)
 --LookAtPlayer(e)
 if GetPlayerDistance(e) > attack_range then
  attacking[e] = 0
  CharacterControlUnarmed(e)
  ModulateSpeed(e,move_speed)
  SetCharacterToWalk(e)
 AIEntityGoToPosition(g_Entity[e]['obj'],g_PlayerPosX,g_PlayerPosZ)
 hit[e] = 0
 else
 health[e] = g_Entity[e]['health']
 if GetAnimationFrame(e) < 228 or GetAnimationFrame(e) > 364 then
 StopAnimation(e)
 AIEntityStop(EntObjNo)
 end
 ModulateSpeed(e,attack_speed)
 CharacterControlLimbo(e)
 RotateToPlayer(e)
 if g_Entity[e]['animating'] == 0 then
  hit[e] = 0
  attacking[e] = 1
--******************************************************************
PlaySound(e,4)
--******************************************************************
 SetAnimation(3)
 PlayAnimation(e)
 g_Entity[e]['animating'] = 1 
 end
  if GetAnimationFrame(e) > 363 and GetAnimationFrame(e) <= 364 and hit[e] == 0 then
  hit[e] = 1
 FireWeapon(e)
 HurtPlayer(e,damage)
 attacking[e] = 0
 end
 end
 if g_Entity[e]['plrvisible'] == 0 and AIGetEntityHeardSound(g_Entity[e]['obj']) ~= 1 and GetTimer(e) >= delay[e] then
 state[e] = "wander"
 end
 
 
 end --state
 else

 if state[e] ~= "dead" then
 StopSound(e,4)
 StopAnimation(e)
 AIEntityStop(EntObjNo)
 CharacterControlLimbo(e)
 state[e] = "dead"
 remove_delay[e] = GetTimer(e) + remove_delay_init
 else
 if GetAnimationFrame(e) < 367 or GetAnimationFrame(e) > 448 then
  StopAnimation(e)
 PlaySound(e,3)
  end
 ModulateSpeed(e,die_speed)
 CharacterControlLimbo(e)
 RotateToPlayer(e)
 if g_Entity[e]['animating'] == 0 and hit[e] < 2 then
 SetAnimation(4)
 hit[e] = 2
 PlayAnimation(e)
 g_Entity[e]['animating'] = 1 
 end
 if GetAnimationFrame(e) >= 447 and GetTimer(e) >= remove_delay[e] then
 StopSound(e,3)
Destroy(e)
 end
 end



 --Prompt(state[e])
end --health
end --main


function zombies2_exit(e)
    PlayCharacterSound(e,"onDeath")
        --Killed = Killed + 1
        --critter = critter - 1
end