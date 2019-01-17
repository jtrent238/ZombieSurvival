dead = {}
package.path = "scriptbank/?.lua;"
require('ai_zombiewalk3') --name of AI script to use (no .lua needed)
weapon_name = {}
--script works with wave_timer.lua
function wave_ai_init_name(e,name)
weapon_name[e] = tostring(name)
dead[e] = 0
ai_zombiewalk3_init(e) --init(e) call from the AI script used
Hide(e)
CollisionOff(e)
end

function wave_ai_main(e)

if g_Entity[e]['activated'] == 1 then
Show(e)
CollisionOn(e)
ai_zombiewalk3_main(e) --main(e) call from the AI script used
else
--SetActivated(e,0)
end

end

function wave_ai_exit(e)
dead[e] = 1
ai_zombiewalk3_exit(e) --exit(e) call from the AI script used
end