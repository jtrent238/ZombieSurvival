

dead = {}
require "scriptbank\\ai_zombie" --name of AI script to use (no .lua needed)
function ai_respawn_init(e)
 
end
   
--script to be used in conjunction with ai_respawner.lua
function ai_respawn_main(e)
if dead[e] == nil then
  dead[e] = 0 
  ai_zombie_init(e) --init(e) call from the AI script used
end
--PromptDuration(dead[e],20000)
if dead[e] == 0 then
Show(e)
ai_zombie_main(e) --main(e) call from the AI script used
elseif dead[e] > 2 then
ai_zombie_init(e) --init(e) call from the AI script used
Hide(e)
CollisionOff(e)
end

--if g_Entity[e]['health'] < 1 then 
	--if dead[e] ~= 1 then 
		--dead[e] = 1 
		--ai_zombie_exit(e) --exit(e) call from the AI script used
	--end 
--end 
 
end
   
function ai_respawn_exit(e)
	dead[e] = 1 
	--ai_zombie_exit(e) --exit(e) call from the AI script used
end
 
