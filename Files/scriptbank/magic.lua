-- LUA Script - precede every function and global member with lowercase name of script + '_main'

function magic_init(e)
end

function magic_main(e)
 PlayerDist = GetPlayerDistance(e)
 if PlayerDist < 80 and g_PlayerHealth > 0 then
   PromptDuration("Collected magic",3000)
   PlaySound(e,0)
   AddPlayerPower(e,g_Entity[e]['health'])
   Destroy(e)
   ActivateIfUsed(e)
 end
end
