-- LUA Script - precede every function and global member with lowercase name of script

-- init when level first runs
function ai_charge_init(e)
 ai_soldier_state[e] = "patrol";
 ai_soldier_pathindex[e] = -1;
 ai_start_x[e] = nil
 ai_starting_heath[e] = nil
 ai_ran_to_cover[e] = 0
 ModulateSpeed(e,1.0)
 ai_returning_home[e] = 0
  --MsgBox ( "soldier init" )
end

-- logic will patrol closest waypoint path, then shoot at player if they
-- get too close, and will run away for cover if their health is low
function ai_charge_main(e)

 -- Detect player distance
 PlayerDist = GetPlayerDistance(e)
 
   -- Entity Object Number
 EntObjNo = g_Entity[e]['obj'];
 
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
 if ai_soldier_state[e] == "patrol" then
 
  -- Try and find a close path to patrol, just check once for it
  if ai_soldier_pathindex[e] == -1 then
  
	ai_soldier_pathindex[e] = -2
	
	CharacterControlArmed(e)
	
   -- find initial waypoint path to follow
   PathIndex = -1;
   pClosest = 99999;
   for pa = 1, AIGetTotalPaths(), 1 do
    for po = 1 , AIGetPathCountPoints(pa), 1 do
     pDX = g_Entity[e]['x'] - AIPathGetPointX(pa,po);
     pDZ = g_Entity[e]['z'] - AIPathGetPointZ(pa,po);
     pDist = math.sqrt(math.abs(pDX*pDX)+math.abs(pDZ*pDZ));
     if pDist < pClosest and pDist < 200 then
      pClosest = pDist;
      PathIndex = pa;
     end
    end -- po
   end -- pa
   
   -- follow found path
   if PathIndex > -1 then
    ai_soldier_pathindex[e] = PathIndex;
	ai_path_point_index[e] = 1
	ai_path_point_direction[e] = 1
	ai_path_point_max[e] = AIGetPathCountPoints(ai_soldier_pathindex[e])
   end
   
  end
  
  CharacterControlUnarmed(e)
  
  -- If set to head home, lets go there
  if ai_returning_home[e] == 1 then
    tDistX = g_Entity[e]['x'] - ai_start_x[e];
    tDistZ = g_Entity[e]['z'] - ai_start_z[e];
 
	DistToStart = math.sqrt(math.abs(tDistX*tDistX)+math.abs(tDistZ*tDistZ))
	
	if DistToStart < 200 or GetTimer(e) > ai_combat_state_delay[e] then
		ai_soldier_pathindex[e] = -1
		SetCharacterToWalk(e)
		CharacterControlUnarmed(e)
		AIEntityStop(EntObjNo);
		ModulateSpeed(e,1.0)
		ai_returning_home[e] = 0
		ai_soldier_state[e] = "alerted"
		ai_alerted_mode[e] = 0
	else
		AIEntityGoToPosition(EntObjNo,ai_start_x[e],ai_start_z[e])
	end
  
  -- If we have a path then lets patrol it
  elseif ai_soldier_pathindex[e] > -1 then 

  ai_patrol_x[e] = AIPathGetPointX(ai_soldier_pathindex[e],ai_path_point_index[e])
  ai_patrol_z[e] = AIPathGetPointZ(ai_soldier_pathindex[e],ai_path_point_index[e])
  
  AIEntityGoToPosition(EntObjNo,ai_patrol_x[e],ai_patrol_z[e])  
  
     tDistX = g_Entity[e]['x'] - ai_patrol_x[e]
     tDistZ = g_Entity[e]['z'] - ai_patrol_z[e]
  
	DistFromPath = math.sqrt(math.abs(tDistX*tDistX)+math.abs(tDistZ*tDistZ))	
	
	if DistFromPath < 5 then
		if ai_path_point_direction[e] == 1 then
			ai_path_point_index[e] = ai_path_point_index[e] + 1
			if ( ai_path_point_index[e] > ai_path_point_max[e] ) then
				ai_path_point_index[e] = ai_path_point_max[e] -2
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
	CharacterControlFidget(e)
  end

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

		AISetEntityControl(EntObjNo,AI_MANUAL)
		AIEntityStop(EntObjNo);   
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

			   AISetEntityControl(EntObjNo,AI_MANUAL)
			   AIEntityStop(EntObjNo);   
		   end	
	   end
	   
	end
   
  end
  
   -- Alerted, perhaps player is near?
   if PlayerDist < AIGetEntityViewRange(EntObjNo) / 3.5 or AIGetEntityHeardSound(EntObjNo) == 1 then
	ai_soldier_state[e] = "alerted"
	ai_alerted_mode[e] = 0
   end  
  
 end
 
  -- Combat mode
 if ai_soldier_state[e] == "alerted" then
 
 	LookAtPlayer(e) 
 
	-- alert taken out
	if g_Entity[e]['plrvisible'] == 1 then 
		ai_soldier_state[e] = "combat";
		PlayCombatMusic(8000,500)
		ai_combat_mode[e] = 0
		-- Add this enemy as a point of aggro, alerting anyone near to join the fight
		ai_aggro_entity = e
		ai_aggro_x = g_Entity[e]['x']
		ai_aggro_z = g_Entity[e]['z']

		AISetEntityControl(EntObjNo,AI_MANUAL)
		AIEntityStop(EntObjNo)
		CharacterControlArmed(e)
		SetCharacterToRun(e)
	else
	
		RotateToPlayer(e)
	 
	   if ai_alerted_mode[e] == 0 then
	  
		tSpeed = math.random(100,130) / 100.0
		--ModulateSpeed(e,tSpeed)
	   
		angle = math.random(360)
		
		ai_dest_x[e] = g_PlayerPosX + (math.sin(angle) * 150)
		ai_dest_z[e] = g_PlayerPosZ + (math.cos(angle) * 150)
		  
		AIEntityGoToPosition(EntObjNo,ai_dest_x[e],ai_dest_z[e]) 
		ai_alerted_state_delay[e] = math.random(1,2)
		ai_alerted_old_time[e] = os.clock()
		CharacterControlArmed(e)
		ai_alerted_mode[e] = 1
		RotateToPlayer(e)

		-- Target the player, wait a short time then run in to attack
		elseif ai_alerted_mode[e] == 1 then 
		 --RotateToPlayer(e) 	
		 if os.clock() - ai_alerted_old_time[e] > ai_alerted_state_delay[e] then
			ai_alerted_state_delay[e] = 2
			ai_alerted_mode[e] = 2
			AIEntityStop(EntObjNo)
			AIEntityGoToPosition(EntObjNo,ai_start_x[e],ai_start_z[e]) 	
		 end
		 
		elseif ai_alerted_mode[e] == 2 then
			 if os.clock() - ai_alerted_old_time[e] > ai_alerted_state_delay[e] then		
				AIEntityStop(EntObjNo)
				ai_alerted_mode[e] = 0
				ai_soldier_state[e] = "patrol";
			 end		
		end
		
		if g_Entity[e]['plrvisible'] == 1 then
			ai_soldier_state[e] = "combat";
			PlayCombatMusic(8000,500)
			ai_combat_mode[e] = 0
			-- Add this enemy as a point of aggro, alerting anyone near to join the fight
			ai_aggro_entity = e
			ai_aggro_x = g_Entity[e]['x']
			ai_aggro_z = g_Entity[e]['z']

			AISetEntityControl(EntObjNo,AI_MANUAL)
			AIEntityStop(EntObjNo)
			CharacterControlArmed(e)
			SetCharacterToRun(e)
		end	
	end
 end

 -- Combat mode
 if ai_soldier_state[e] == "combat" then
	
	-- If we are the soldier with aggro then update our position so if we run near to others, we can alert them to the fight
	if ai_aggro_entity ~= null then
		if ai_aggro_entity == e then
			ai_aggro_x = g_Entity[e]['x']
			ai_aggro_z = g_Entity[e]['z']
		end
	end
 
  -- Kick off combat by choosing a destination to head for around the player
  if ai_combat_mode[e] == 0 then
  
	SetCharacterToRun(e)
	
	--tSpeed = math.random(1.8)
	tSpeed = math.random( 145 , 155 ) / 100.0
	ModulateSpeed(e,tSpeed)
		
	ai_combat_old_time[e] = os.clock()
   	
	CharacterControlArmed(e)
	ai_combat_mode[e] = 1

  -- Shoot the player if we can
  elseif ai_combat_mode[e] == 1 then
  
	if PlayerDist > 300 then
		CharacterControlArmed(e)
		AIEntityGoToPosition(EntObjNo,g_PlayerPosX,g_PlayerPosZ) 
	else
		AIEntityStop(EntObjNo);
		ai_combat_mode[e] = 2
	end
   
	if os.clock() - ai_combat_old_time[e] > ai_combat_turn_delay then

		if g_Entity[e]['plrvisible'] == 1 then
			-- We can see the player, lets attack him!
			if math.random(0,3) == 0 then
				FireWeapon(e)
			end
		end		
	
	end  

  elseif ai_combat_mode[e] == 2 then
   
	if PlayerDist > 400 then
		ai_combat_mode[e] = 1
	end
	
	AIEntityStop(EntObjNo)
   
	if os.clock() - ai_combat_old_time[e] > ai_combat_turn_delay then

		if g_Entity[e]['plrvisible'] == 1 then
			-- We can see the player, lets attack him!
			if math.random(0,3) == 0 then
				FireWeapon(e)
			end
		else
			AIEntityStop(EntObjNo);
			RotateToPlayer(e) 
		end		
	
	end   	
    
  -- Out of the range of the player, heading back to start point, once there going back to Patrol mode
  elseif ai_combat_mode[e] == 3 then
	ai_returning_home[e] = 1
	SetCharacterToWalk(e)
	CharacterControlUnarmed(e)	
	AIEntityGoToPosition(EntObjNo,ai_start_x[e],ai_start_z[e])
	ai_soldier_state[e] = "patrol"
	ai_combat_state_delay[e] = 3000
	StartTimer(e)
	tSpeed = math.random(100,130) / 100.0
	ModulateSpeed(e,tSpeed)	
	return
  
  end
  
  -- When player out of range, return to patrol
  if PlayerDist > AIGetEntityViewRange(EntObjNo)*1.5 then
	ai_combat_mode[e] = 3		
  end
  
 end
 
 
end
