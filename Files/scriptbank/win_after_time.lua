--how long player needs to survive (in milliseconds)
local time_to_survive = 160000 
--display countdown on screen (1 = yes / 0 = no)
local show_timer = 1

if g_time_survived == nil then 
	g_time_survived = 0
end 
local timer_started = nil 
local loaded_level = 0
function win_after_time_init(e)
end 
function win_after_time_main(e)
	if timer_started == nil then 
		StartTimer(e)
		timer_started = 1
	else
		timer = GetTimer(e)
		if loaded_level == 0 then 
			time_survived = timer+g_time_survived
			loaded_level = 1 
		else 
			time_survived = timer 
			g_time_survived = g_time_survived+timer
		end
		if time_survived > time_to_survive then 
			--we end the level here by triggering the next level
			--enter the next level's name in 'ifused' field
			--don't forget to also include a winzone with same 'ifused' for standalone purposes
			JumpToLevelIfUsed(e)
		else 
			if show_timer == 1 then 
				seconds = math.ceil((time_to_survive-timer)/1000)
				TextCenterOnX(50,3,3,"Survive for "..seconds.."s")
			end
		end 
	end 
end 