-- LUA Script - precede every function and global member with lowercase name of script

function ai_melee_init(e)
 ai_soldier_state[e] = "idle"
 ModulateSpeed(e,1.0)
end

function ai_melee_main(e)
 PlayerDist = GetPlayerDistance(e)
 EntObjNo = g_Entity[e]['obj']
 if PlayerDist < 600 and ai_soldier_state[e] == "idle" and g_Entity[e]['plrvisible'] == 1 then
  ai_soldier_state[e] = "detected"
 end
 if PlayerDist < 600 and ai_soldier_state[e] ~= "idle" then
  RotateToPlayer(e)
  if PlayerDist < 100 and g_Entity[e]['plrvisible']==1 then
   if ai_soldier_state[e]~="attack" then
    if GetAnimationFrame(e)<2981 or GetAnimationFrame(e)>3034 then
     AIEntityStop(EntObjNo)
	 ai_soldier_state[e] = "attack"
     CharacterControlLimbo(e)
     SetAnimationFrames(2981,3034)
     PlayAnimation(e)
    end
   end
   if ai_soldier_state[e]=="attack" then
    if GetAnimationFrame(e)>3010 and GetAnimationFrame(e)<3015 then
     HurtPlayer(e,5)
	end
    if GetAnimationFrame(e)>3032 then
	 ai_soldier_state[e] = "roam"
     SetAnimationFrames(2552,2603)
     PlayAnimation(e)
	end
   end
  else
   if ai_soldier_state[e]~="roam" then
    ai_soldier_state[e] = "roam"
    CharacterControlUnarmed(e)
    SetCharacterToRun(e)
   end
   AIEntityGoToPosition(EntObjNo,g_PlayerPosX,g_PlayerPosZ) 
  end
 end
 --PromptLocal(e,"Dist=" .. PlayerDist .. " State=" .. ai_soldier_state[e] .. " Vis=" .. g_Entity[e]['plrvisible'])
end
