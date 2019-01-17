-- LUA Script - precede every function and global member with lowercase name of script + '_main'
-- Player Collects Health

function health_init(e)
end

function health_main(e)
 PlayerDist = GetPlayerDistance(e)
 if PlayerDist < 80 and g_PlayerHealth > 0 then
   PromptDuration("Collected health",3000)
   PlaySound(e,0)
   AddPlayerHealth(e)
   Destroy(e)
   ActivateIfUsed(e)
 end
end
