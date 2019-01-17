-- LUA Script - precede every function and global member with lowercase name of script + '_main'

g_lightswitch = {}

function lightswitch_init(e)
 g_lightswitch[e] = "on"
end

function lightswitch_main(e)
 PlayerDist = GetPlayerDistance(e)
 if PlayerDist < 150 and g_PlayerHealth > 0 then
  if g_lightswitch[e]=="on" then
   Prompt ( "Press E to turn light off" )
   if g_KeyPressE == 1 then
    g_lightswitch[e] = "offing"
	HideLight(e)
   end
  end
  if g_lightswitch[e]=="off" then
   Prompt ( "Press E to turn light on" )
   if g_KeyPressE == 1 then
    g_lightswitch[e] = "oning"
	ShowLight(e)
   end
  end
 end
 if g_KeyPressE == 0 then
  if g_lightswitch[e]=="oning" then
   g_lightswitch[e] = "on"
  end
  if g_lightswitch[e]=="offing" then
   g_lightswitch[e] = "off"
  end
 end
end
