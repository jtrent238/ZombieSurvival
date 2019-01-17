-- LUA Script - precede every function and global member with lowercase name of script + '_main'
-- Player Collects Key

function key_init(e)
end

function key_main(e)
 PlayerDist = GetPlayerDistance(e)
 if PlayerDist < 150 and g_PlayerHealth > 0 then
	SourceAngle = g_PlayerAngY
	while SourceAngle < 0.0 do
		SourceAngle = SourceAngle + 360.0
	end	
	while SourceAngle > 340.0 do
		SourceAngle = SourceAngle - 360.0
	end
		
    PlayerDX = (g_Entity[e]['x'] - g_PlayerPosX)
    PlayerDZ = (g_Entity[e]['z'] - g_PlayerPosZ)
	DestAngle = math.atan2( PlayerDZ , PlayerDX )
	-- Convert to degrees
	DestAngle = (DestAngle * 57.2957795) - 90.0
	
	Result = math.abs(math.abs(SourceAngle)-math.abs(DestAngle))
	if Result > 180 then
		Result = 0
	end	
	
	if Result < 20.0 then
	--[[
		SourceAngle = g_PlayerAngX
		while SourceAngle < 0.0 do
			SourceAngle = SourceAngle + 360.0
		end	
		while SourceAngle > 335.0 do
			SourceAngle = SourceAngle - 360.0
		end	
				
		DestAngle = math.atan2( PlayerDZ , PlayerDY )
		-- Convert to degrees
		DestAngle = (DestAngle * 57.2957795) - 90.0		
			
		Result = math.abs(math.abs(SourceAngle)-math.abs(DestAngle))
		if Result > 180 then
			Result = 0
		end		
		
		if Result < 25.0 then
		--]]
			Prompt ("Press E To pick up key")
	 
			if g_KeyPressE == 1 then
				PromptDuration("Collected key",3000)
				PlaySound(e,0)
				Collected(e)
				Destroy(e)
				ActivateIfUsed(e)
			end
		--end
   end
 end
end
