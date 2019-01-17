-- LUA Script - precede every function and global member with lowercase name of script

ai_newdest_time = {}
ai_cover_on = {}
RPG_CLOSEST_TO_PLAYER = 500

-- init when level first runs
function ai_soldier_rpg_init(e)
 ai_soldier_state[e] = "patrol";
 ai_soldier_pathindex[e] = -1;
 ai_start_x[e] = nil
 ai_starting_heath[e] = nil
 ai_ran_to_cover[e] = 0
 ModulateSpeed(e,1.0)
 ai_old_health[e] = 0
 CharacterControlStand(e)
 ai_returning_home[e] = 0
 ai_newdest_time[e] = -1
 ai_cover_on[e] = 0
 ai_alerted_spoken[e] = 0
 SetCharacterSound(e,"soldier")
    --MsgBox ( "soldier init" )
end

-- logic will patrol closest waypoint path, then shoot at player if they
-- get too close, and will run away for cover if their health is low
function ai_soldier_rpg_main(e)

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
	ai_path_point_index[e] = 2
	ModulateSpeed(e,1.0)
	SetCharacterToWalk(e)
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
	
	if DistFromPath < 50 then
		if ai_path_point_direction[e] == 1 then
			ai_path_point_index[e] = ai_path_point_index[e] + 1
			if ( ai_path_point_index[e] > ai_path_point_max[e] ) then
				ai_path_point_index[e] = ai_path_point_max[e] -1
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
  
  ai_soldier_rpg_AggroCheck(e)
  ai_soldier_rpg_AlertAggroCheck(e)
  
   -- Alerted, perhaps player is near or gunshots can be heard?
   if PlayerDist < AIGetEntityViewRange(EntObjNo) / 3 or AIGetEntityHeardSound(EntObjNo) == 1 then
	ai_soldier_state[e] = "alerted"
	ai_alerted_mode[e] = 0
	ai_alert_x = g_Entity[e]['x']
	ai_alert_z = g_Entity[e]['z']
	ai_alert_counter = 10
	ai_alert_entity = e
   end
  
 end
 
  -- alerted mode
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

	   if ai_alerted_mode[e] == 0 then
	  
		tSpeed = math.random(100,130) / 100.0
		ModulateSpeed(e,tSpeed)
	   
		angle = math.random(360)
		
		ai_dest_x[e] = g_PlayerPosX + (math.sin(angle) * 150)
		ai_dest_z[e] = g_PlayerPosZ + (math.cos(angle) * 150)
		  
		AIEntityGoToPosition(EntObjNo,ai_dest_x[e],ai_dest_z[e]) 
		ai_alerted_state_delay[e] = math.random(0,1)
		ai_alerted_old_time[e] = os.clock()
		CharacterControlArmed(e)
		ai_alerted_mode[e] = 1
		if ai_alerted_spoken[e] == 0 then
			PlayCharacterSound(e,"onAlert")
			ai_alerted_spoken[e] = 1
		end

		-- Target the player, run in to attack
		elseif ai_alerted_mode[e] == 1 then 
		LookAtPlayer(e) 	
		 if os.clock() - ai_alerted_old_time[e] > ai_alerted_state_delay[e] then
			ai_alerted_state_delay[e] = 2
			ai_alerted_mode[e] = 2	
			AIEntityGoToPosition(EntObjNo,ai_dest_x[e],ai_dest_z[e]) 
		 end
		 
		elseif ai_alerted_mode[e] == 2 then
			 if os.clock() - ai_alerted_old_time[e] > ai_alerted_state_delay[e] then		
				AIEntityStop(EntObjNo)
				ai_alerted_mode[e] = 0
				ai_soldier_state[e] = "patrol";
				ai_soldier_rpg_AggroCheck(e)
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
 
	LookAtPlayer(e)
	--SetCharacterToRun(e)	

	-- If we are the soldier with aggro then update our position so if we run near to others, we can alert them to the fight
	if ai_aggro_entity ~= null then
		if ai_aggro_entity == e then
			ai_aggro_x = g_Entity[e]['x']
			ai_aggro_z = g_Entity[e]['z']
		end
	end
	
	--Prompt(ai_combat_mode[e])
 
  -- Kick off combat by choosing a destination to head for around the player
  if ai_combat_mode[e] == 0 then
    
	--SetCharacterToRun(e)	
	
	tSpeed = math.random(100,130) / 100.0
	ModulateSpeed(e,tSpeed)
   
	angle = math.random(360)
	
	ai_dest_x[e] = g_PlayerPosX + (math.sin(angle) * 500)
	ai_dest_z[e] = g_PlayerPosZ - (math.cos(angle) * 500)
	
	-- Check if we can get to the new position without going around something
	if ( AICouldSee ( EntObjNo , ai_dest_x[e] , g_Entity[e]['y'] , ai_dest_z[e] ) == 0 )  then
		ai_dest_x[e] = g_PlayerPosX;
		ai_dest_z[e] = g_PlayerPosZ;
	end
		
	--ai_combat_state_delay[e] = math.random(1000,2500)
	StartTimer(e)
	
	CharacterControlArmed(e)
	ai_combat_mode[e] = 1
	
	--if ai_newdest_time[e] == -1 then
	--	ai_newdest_time[e] = os.clock() + math.random(0,5)
	--	if AIEntityMoveToCover(EntObjNo,g_PlayerPosX,g_PlayerPosZ) == 0 then 
	--		AIEntityGoToPosition(EntObjNo,ai_dest_x[e],ai_dest_z[e])
	--	end
	--elseif os.clock() - ai_newdest_time[e] > 8 then
	--	ai_newdest_time[e] = -1
	--	AIEntityGoToPosition(EntObjNo,ai_dest_x[e],ai_dest_z[e])
	--else
		ai_cover_on[e] = AIEntityMoveToCover(EntObjNo,g_PlayerPosX,g_PlayerPosZ)
		if ai_cover_on[e] == 0 then 
			AIEntityGoToPosition(EntObjNo,ai_dest_x[e],ai_dest_z[e])
			ai_combat_state_delay[e] = math.random(500,1000)
		else
			ai_combat_state_delay[e] = math.random(3000,5000)
		end
	--end	

  -- Target the player, wait a short time then run in to attack
  elseif ai_combat_mode[e] == 1 then 
  
	if GetTimer(e) > ai_combat_state_delay[e] then
		ai_combat_state_delay[e] = math.random(1000,2500)
		StartTimer(e)
		ai_combat_mode[e] = 2
	end
		
	if g_Entity[e]['plrvisible'] == 1 then
		AIEntityStop(EntObjNo)
		FireWeapon(e)	
	end
	
  -- Run to destination for a small amount of time
  elseif ai_combat_mode[e] == 2 then   
  
	if g_Entity[e]['plrvisible'] == 1 then
		AIEntityStop(EntObjNo)
		FireWeapon(e)
		--if math.random(0,1000) == 500 then
		--	PlayCharacterSound(e,"onHurtPlayer")
		--end
	end

	if (GetTimer(e) > ai_combat_state_delay[e]) or PlayerDist <= RPG_CLOSEST_TO_PLAYER then
		if PlayerDist <= RPG_CLOSEST_TO_PLAYER then 
			AIEntityStop(EntObjNo);  
		end
		ai_combat_mode[e] = 3
	end	

  -- Target the player
  elseif ai_combat_mode[e] == 3 then
  
	CharacterControlArmed(e)
   
	ai_combat_mode[e] = 4
	-- Set how long we will shoot him for
	--if ai_cover_on[e] == 1 then
		--ai_combat_state_delay[e] = math.random(2000,4000)
	--else
	if ai_cover_on[e] == 1 then
		ai_combat_state_delay[e] = math.random(2000,4000)
	else
		ai_combat_state_delay[e] = math.random(500,1000)
	end
	--end
	StartTimer(e)
	if g_Entity[e]['plrvisible'] == 1 then
		AIEntityStop(EntObjNo)	
		FireWeapon(e)
	end
	
	if PlayerDist <= RPG_CLOSEST_TO_PLAYER then
		ai_combat_mode[e] = 0
	end		

  -- Shoot the player if we can, if not head off to find him
  elseif ai_combat_mode[e] == 4 then
  	
	if g_Entity[e]['plrvisible'] == 1 then
		AIEntityStop(EntObjNo)
		FireWeapon(e)
	end
	
  
	if ai_cover_on[e] == 1 then
		CharacterControlDucked(e)	
	
		--if g_Entity[e]['plrvisible'] == 1 then
			--if math.random(1,120) == 60 then
				--CharacterControlStand(e)
				--ai_combat_old_time[e] = os.clock()
				--ai_combat_state_delay[e] = 1
				--ai_combat_mode[e] = 11
			--end	
		--end	
	end
			   
	-- Once our shooting time has ended, lets go back to mode 0 and start over
	-- If we cannot see the player, wait a short time before hunting him down
	if GetTimer(e) > ai_combat_state_delay[e] then
		CharacterControlStand(e)
		if g_Entity[e]['plrvisible'] == 0 then
			ai_combat_mode[e] = 7
			ai_cover_on[e] = 0
			ai_combat_state_delay[e] = math.random(1000,2000)
			StartTimer(e)
			AIEntityStop(EntObjNo);
			--if PlayerDist > RPG_CLOSEST_TO_PLAYER then	
				AIEntityGoToPosition(EntObjNo,g_PlayerPosX,g_PlayerPosZ)
			--end
		else 		
			ai_combat_mode[e] = 0
			AIEntityStop(EntObjNo);
		end
	end 
	
	-- if we have been hurt, lets strafe a bit
	--if ai_old_health[e] > g_Entity[e]['health'] then
	--	ai_combat_mode[e] = 8
	--	ai_combat_state_delay[e] = 1
	--end
	
	ai_old_health[e] = g_Entity[e]['health']				
		
   
   -- In cover, we wait a while, shoot if we can see the player, before venturing out again
   elseif ai_combat_mode[e] == 5 then
	CharacterControlArmed(e)
	
	if g_Entity[e]['plrvisible'] == 1 then
		AIEntityStop(EntObjNo)
		FireWeapon(e)	
	end
    
	if GetTimer(e) > ai_combat_old_time[e] then	
		ModulateSpeed(e,1.0)
		--AIEntityStop(EntObjNo)
		ai_combat_mode[e] = 0
	end
	  
  -- Out of the range of the player, heading back to start point for a while, once there going back to Patrol mode
  elseif ai_combat_mode[e] == 6 then
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
  
  -- Unable to see the player to shoot, so heading after him
  elseif ai_combat_mode[e] == 7 then
  
  	if g_Entity[e]['plrvisible'] == 1 then
		AIEntityStop(EntObjNo)
		FireWeapon(e)	
		--PlayCharacterSound(e,"onAggro")
	end	
	
	AIEntityGoToPosition(EntObjNo,g_PlayerPosX,g_PlayerPosZ)
  
	if ( g_Entity[e]['plrvisible'] == 1 or PlayerDist <= RPG_CLOSEST_TO_PLAYER ) and GetTimer(e) > ai_combat_state_delay[e] then
		AIEntityStop(EntObjNo)
		ai_combat_mode[e] = 0
	end
	
  elseif ai_combat_mode[e] == 8 then

	ai_combat_mode[e] = 9
  
	AIEntityStop(EntObjNo)
	
  elseif ai_combat_mode[e] == 9 then

	ai_combat_mode[e] = 10
  	
	-- Pick left or right strafe
	if ( math.random(0,1) == 0 ) then
		SetCharacterToStrafeLeft(e)
	else
		SetCharacterToStrafeRight(e)
	end		
	
	ai_combat_old_time[e] = os.clock()	

  elseif ai_combat_mode[e] == 10 then

	-- We can see the player, lets shoot him!
	--RotateToPlayer(e)  
	if g_Entity[e]['plrvisible'] == 1 then
		AIEntityStop(EntObjNo)
		FireWeapon(e)
	end

	if os.clock() - ai_combat_old_time[e] > ai_combat_state_delay[e] then
		ai_combat_state_delay[e] = math.random(1,3)
		ai_combat_mode[e] = 4
		--SetCharacterToRun(e)
		ai_old_health[e] = g_Entity[e]['health']
	end
	
	elseif ai_combat_mode[e] == 11 then
	
	if g_Entity[e]['plrvisible'] == 1 then
		if os.clock() - ai_combat_old_time[e] > ai_combat_state_delay[e] then
			CharacterControlStand(e)
			ai_combat_old_time[e] = os.clock()
			ai_combat_state_delay[e] = 1			
			ai_combat_mode[e] = 12
		end
	end	
	
	if ai_combat_mode[e] == 12 then
  
		if g_Entity[e]['plrvisible'] == 1 then
			AIEntityStop(EntObjNo)
			FireWeapon(e)	
		end

		if os.clock() - ai_combat_old_time[e] > ai_combat_state_delay[e] then
			ai_combat_mode[e] = 4
		end
       	
	
	end
       
  end   
  
  -- If health is below 30, run and hide, then head to mode 5
  if g_Entity[e]['health'] < 30  and ai_combat_mode[e] ~= 4 and ai_ran_to_cover[e] == 0 then
	ModulateSpeed(e,1.3)
	ai_ran_to_cover[e] = 1
	AISetEntityControl(EntObjNo,AI_MANUAL);
	a=AIEntityMoveToCover(EntObjNo,g_PlayerPosX,g_PlayerPosZ);
	ai_combat_old_time[e] = 3000
	StartTimer(e)
	ai_combat_mode[e] = 5
  end   
  
  -- When player out of range, return to patrol
  if PlayerDist > AIGetEntityViewRange(EntObjNo)*1.5 then
	ai_combat_mode[e] = 6		
  end

  
  --RotateToPlayer(e)
  
 end
 
--if (ai_combat_mode[e] ~= nil) then
--	Prompt(ai_combat_mode[e])
--end
 
end

function ai_soldier_rpg_AggroCheck(e)
  -- If there player is in range and we can see him, or we have been shot, move into combat mode
  if PlayerDist < AIGetEntityViewRange(EntObjNo) then 
	if g_Entity[e]['plrvisible'] == 1 or g_Entity[e]['health'] < ai_starting_heath[e] then
	
		ai_soldier_state[e] = "combat";
		PlayCombatMusic(8000,500)
		ai_combat_mode[e] = 0
		PlayCharacterSound(e,"onAggro")
		-- Add this enemy as a point of aggro, alerting anyone near to join the fight
		ai_aggro_entity = e
		ai_aggro_x = g_Entity[e]['x']
		ai_aggro_z = g_Entity[e]['z']
		
		ai_alert_x = g_Entity[e]['x']
		ai_alert_z = g_Entity[e]['z']

		AISetEntityControl(EntObjNo,AI_MANUAL)
		AIEntityStop(EntObjNo);   
		SetCharacterToRun(e)
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
			   SetCharacterToRun(e)
		   end	
	   end
	   

	end
  end
end

function ai_soldier_rpg_AlertAggroCheck(e)
  -- If there is an alert close by
  
	if e == ai_alert_entity then
		ai_alert_counter = ai_alert_counter - 1
		if ai_alert_counter <= 0 then
			ai_alert_x = -10000
			ai_alert_z = -10000
			ai_alert_entity = 0  
		end
	end
  
     pDX = g_Entity[e]['x'] - ai_alert_x
     pDZ = g_Entity[e]['z'] - ai_alert_z;
     pDist = math.sqrt(math.abs(pDX*pDX)+math.abs(pDZ*pDZ));
     if pDist < 800 then
		ai_soldier_state[e] = "alerted"
		ai_alerted_mode[e] = 0		
	 end
  
end

function ai_soldier_rpg_exit(e)
	PlayCharacterSound(e,"onDeath")
end
