-- LUA Script - precede every function and global member with lowercase name of script

attackstart = {}
attackend = {}
damageframestart = {}
damageframeend = {}
lastroar = {}
lastswipe = {}

function ai_zombiewalk_init(e)
 ai_soldier_state[e] = "idle"
 CharacterControlLimbo(e)
 SetAnimationFrames(210,234)
 LoopAnimation(e)
 ModulateSpeed(e,1.0)
 SetAnimationSpeed(e,0.1)
 attackstart[e]=683
 attackend[e]=722
 damageframestart[e]=694
 damageframeend[e]=720
 lastroar[e]=0
 lastswipe[e]=0
end

function ai_zombiewalk_main(e)
 PlayerDist = GetPlayerDistance(e)
 EntObjNo = g_Entity[e]['obj']
 if (PlayerDist < 1000 and ai_soldier_state[e] == "idle" and g_Entity[e]['plrvisible'] == 1) or (AIGetEntityHeardSound(EntObjNo) == 1 and ai_soldier_state[e] == "idle") or (PlayerDist < 100 and ai_soldier_state[e] == "idle") then
  RotateToPlayer(e)
  if GetTimer(e) > lastroar[e] then
   lastroar[e]=GetTimer(e)+5000
   PlaySound(e,0)
  end
 end
 if PlayerDist < 600 and g_Entity[e]['plrvisible']==1 then
  RotateToPlayer(e)
  if PlayerDist < 80 and g_Entity[e]['plrvisible']==1 then
   if ai_soldier_state[e]~="attack" then
    SetAnimationSpeed(e,1.75)
    if GetAnimationFrame(e)<attackstart[e] or GetAnimationFrame(e)>attackend[e] then
     AIEntityStop(EntObjNo)
	 ai_soldier_state[e] = "attack"
     CharacterControlLimbo(e)
     SetAnimationFrames(attackstart[e],attackend[e])
     PlayAnimation(e)
    end
   end
   if ai_soldier_state[e]=="attack" then
    if GetAnimationFrame(e)>damageframestart[e] and GetAnimationFrame(e)<damageframeend[e] then
     if GetPlayerDistance(e)<80 then
      if GetTimer(e) > lastswipe[e] then
       lastswipe[e]= GetTimer(e)+1600
       PlaySound(e,1)
      end
      randomdamage=math.random(3,7)
      HurtPlayer(e,randomdamage)
     end
	end
    if GetAnimationFrame(e)>attackend[e]-1 then
     CharacterControlUnarmed(e)
     ai_soldier_state[e] = "roam"
     if GetPlayerDistance(e) < 80 then
      ai_soldier_state[e] = "idle"
      CharacterControlLimbo(e)
      SetAnimationFrames(attackstart[e]-1,attackstart[e]-1)
      PlayAnimation(e)
      RotateToPlayer(e)
     end
    end
   end
  else 
   if ai_soldier_state[e]~="roam" then
    ai_soldier_state[e] = "roam"
    CharacterControlUnarmed(e)
    ModulateSpeed(e,1.0)
    SetAnimationSpeed(e,1.0)
    SetCharacterToWalk(e)
   end
   rndx=math.random(1,360)
   rndz=math.random(1,360)
   rndx2=math.sin(rndx)*30
   rndz2=math.cos(rndz)*30
   AIEntityGoToPosition(EntObjNo,g_PlayerPosX+rndx2,g_PlayerPosZ+rndz2) 
  end
 else
  if PlayerDist >= 600 and ai_soldier_state[e] ~= "idle" then
   ai_soldier_state[e] = "idle"
   CharacterControlLimbo(e)
   SetAnimationFrames(210,234)
   LoopAnimation(e)
   ModulateSpeed(e,1.0)
   SetAnimationSpeed(e,1.0)
  end
 end
 --PromptLocal(e,"ZOMBIEWALK : Dist=" .. PlayerDist .. " State=" .. ai_soldier_state[e] .. " Vis=" .. g_Entity[e]['plrvisible'] .. " Frm=" .. GetAnimationFrame(e) )
end

function ai_zombiewalk_exit(e)
 PlayCharacterSound(e,"onDeath")
 CollisionOff(e)
end
