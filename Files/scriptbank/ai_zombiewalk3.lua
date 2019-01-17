-- LUA Script - precede every function and global member with lowercase name of script

attackstart = {}
attackend = {}
damageframestart = {}
damageframeend = {}
lastroar = {}
lastswipe = {}

function ai_zombiewalk3_init(e)
 ai_soldier_state[e] = "idle"
 CharacterControlLimbo(e)
 SetAnimationFrames(210,234)
 LoopAnimation(e)
 ModulateSpeed(e,1.0)
 SetAnimationSpeed(e,1.0)
 attackstart[e]=2561
 attackend[e]=2600
 damageframestart[e]=2570
 damageframeend[e]=2590
 lastroar[e]=0
 lastswipe[e]=0
end

function ai_zombiewalk3_main(e)
 PlayerDist = GetPlayerDistance(e)
 EntObjNo = g_Entity[e]['obj']
 if (PlayerDist < 600 and ai_soldier_state[e] == "idle" and g_Entity[e]['plrvisible'] == 1) or (AIGetEntityHeardSound(EntObjNo) == 1 and ai_soldier_state[e] == "idle") or (PlayerDist < 100 and ai_soldier_state[e] == "idle") then
  RotateToPlayer(e)
  if GetTimer(e) > lastroar[e] then
   lastroar[e]= GetTimer(e)+6000
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
     randomattack=math.random(1,3)
     if randomattack==1 then 
      attackstart[e]=2561
      attackend[e]=2600
      damageframestart[e]=2580
      damageframeend[e]=2595
     end
     if randomattack==2 then
      attackstart[e]=2869
      attackend[e]=2907
      damageframestart[e]=2885
      damageframeend[e]=2890
     end
     if randomattack==3 then
      attackstart[e]=2910
      attackend[e]=3023
      damageframestart[e]=2950
      damageframeend[e]=3010
     end
     SetAnimationFrames(attackstart[e],attackend[e])
     PlayAnimation(e)     
    end
   end
   if ai_soldier_state[e]=="attack" then
    SetAnimationSpeed(e,2)
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
     randomroam=math.random(1,2)
     if randomroam == 1 then
      SetAnimationFrames(2530,2559)
     end
     if randomroam == 2 then
      SetAnimationFrames(2499,2528)
     end
     if GetPlayerDistance(e)<80 then
      ai_soldier_state[e] = "idle"
      CharacterControlLimbo(e)
      SetAnimationFrames(1,1)
      RotateToPlayer(e)
     end
     PlayAnimation(e)
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
 --PromptLocal(e,"ZOMBIEWALK3 : Dist=" .. PlayerDist .. " State=" .. ai_soldier_state[e] .. " Vis=" .. g_Entity[e]['plrvisible'] .. " Frm=" .. GetAnimationFrame(e) )
end

function ai_zombiewalk3_exit(e)
 PlayCharacterSound(e,"onDeath")
 CollisionOff(e)
end