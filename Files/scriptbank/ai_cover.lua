-- LUA Script - precede every function and global member with lowercase name of script

-- init when level first runs
function ai_cover_init(e)
 ai_soldier_state[e] = "hiding";
 ai_soldier_pathindex[e] = -1;
 ai_start_x[e] = nil
 ai_starting_heath[e] = nil
 ModulateSpeed(e,1.0)
 CharacterControlArmed(e)
 CharacterControlDucked(e)
 LockCharacterPosition(e)
 Include("ai_soldier.lua")
end

-- main
function ai_cover_main(e)

 -- Detect player distance
 PlayerDist = GetPlayerDistance(e)
 
 -- Entity Object Number
 EntObjNo = g_Entity[e]['obj'];
 
 if PlayerDist < 500 then
	UnlockCharacterPosition(e)
	SwitchScript(e,"ai_soldier")
	ai_soldier_state[e] = "combat"
	PlayCombatMusic(8000,500)
	ai_combat_mode[e] = 0
	return
 end
 
 if ai_starting_heath[e] == nil then
	ai_starting_heath[e] = g_Entity[e]['health']
 end
 
 -- Store starting point so we can return there if player moves far away
 if ai_start_x[e] == nil then
	ai_start_x[e] = g_Entity[e]['x']
	ai_start_z[e] = g_Entity[e]['z']
	AISetEntityControl(EntObjNo,AI_MANUAL);
 end
  
 -- Patrol Mode
 if ai_soldier_state[e] == "hiding" then

	LookAtPlayer(e)
	AIEntityStop(EntObjNo);
 
  -- If there player is in range and we can see him, or we have been shot, move into combat mode
  if PlayerDist < AIGetEntityViewRange(EntObjNo) then 
	if g_Entity[e]['plrvisible'] == 1 or g_Entity[e]['health'] < ai_starting_heath[e] then
	
		ai_soldier_state[e] = "combat";
		PlayCombatMusic(8000,500)
		ai_combat_mode[e] = 0
		-- Add this enemy as a point of aggro, alerting anyone near to join the fight
		ai_aggro_entity = e
		ai_aggro_x = g_Entity[e]['x']
		ai_aggro_z = g_Entity[e]['z']  
	else
		-- We cant see the player, but perhaps we are near someone that can
		if ai_aggro_entity ~= nil then
			tDistX = g_Entity[e]['x'] - ai_aggro_x
			tDistZ = g_Entity[e]['z'] - ai_aggro_z
		  
			tDist = math.sqrt(math.abs(tDistX*tDistX)+math.abs(tDistZ*tDistZ))	
		   
		   if tDist < ai_aggro_range then
			   ai_soldier_state[e] = "combat";
			   PlayCombatMusic(8000,500)
			   ai_combat_mode[e] = 0

			   AIEntityStop(EntObjNo);   
		   end	
	   end
	end
   
  end
  
 end

 -- Combat mode
 if ai_soldier_state[e] == "combat" then
 
	LookAtPlayer(e)
	AIEntityStop(EntObjNo);
  
  -- Kick off combat, starting in hiding
  if ai_combat_mode[e] == 0 then
  
	CharacterControlDucked(e)	
	
	if g_Entity[e]['plrvisible'] == 1 then
		if math.random(1,120) == 60 then
			CharacterControlStand(e)
			ai_combat_old_time[e] = os.clock()
			ai_combat_state_delay[e] = 1
			ai_combat_mode[e] = 1
		end	
	end
       
  end   
   
  -- Shoot
  if ai_combat_mode[e] == 1 then
  
	if g_Entity[e]['plrvisible'] == 1 then
		if os.clock() - ai_combat_old_time[e] > ai_combat_state_delay[e] then
			CharacterControlStand(e)
			ai_combat_old_time[e] = os.clock()
			ai_combat_state_delay[e] = 1			
			ai_combat_mode[e] = 2
		end
	end
       
  end  

  -- Back to ducking
  if ai_combat_mode[e] == 2 then
  
	if g_Entity[e]['plrvisible'] == 1 then
		FireWeapon(e)	
	end

	if os.clock() - ai_combat_old_time[e] > ai_combat_state_delay[e] then
		ai_combat_mode[e] = 0
	end
       
  end   
   
  -- When player out of range, return to hiding
  if PlayerDist > AIGetEntityViewRange(EntObjNo) then
	ai_soldier_state[e] = "hiding"	
  end
  
 end
 
 
end
