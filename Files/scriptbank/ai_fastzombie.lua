-- LUA Script - precede every function and global member with lowercase name of script

require "scriptbank\\killcounter"
Killed = 0
attackstart = {}
attackend = {}
damageframestart = {}
damageframeend = {}
lastroar = {}
lastswipe = {}

function ai_fastzombie_init(e)
 ai_soldier_state[e] = "idle"
 SetAnimationFrames(2552,2603)
 LoopAnimation(e)
 ModulateSpeed(e,1.0)
 SetAnimationSpeed(e,1.0)
 attackstart[e]=2981
 attackend[e]=3034
 damageframestart[e]=3010
 damageframeend[e]=3015
 lastroar[e] = 0
 lastswipe[e] = 0
end

function ai_fastzombie_main(e)
 PlayerDist = GetPlayerDistance(e)
 EntObjNo = g_Entity[e]['obj']
 if (PlayerDist < 1000 and ai_soldier_state[e] == "idle" and g_Entity[e]['plrvisible'] == 1) or (AIGetEntityHeardSound(EntObjNo) == 1 and ai_soldier_state[e] == "idle") or (PlayerDist < 100 and ai_soldier_state[e] == "idle") then
  -- detected player
  RotateToPlayer(e)
  if GetTimer(e) > lastroar[e] then
   if lastroar[e]==0 then
    -- roar when we see player for first time
    chooseidle=math.random(1,2)
    if chooseidle == 1 then
     SetAnimationFrames(3046,3094)
    end
    if chooseidle == 2 then
     SetAnimationFrames(3105,3155)
    end  
    PlayAnimation(e)
    ModulateSpeed(e,1.0)
    SetAnimationSpeed(e,1.0)
	ai_soldier_state[e] = "roar"
   end
  end
 end
 if ai_soldier_state[e]=="roar" then
  -- handle roar sequence and scream sound
  if (GetAnimationFrame(e)<3105 and GetAnimationFrame(e)>=3094) or (GetAnimationFrame(e)>=3155) then
   ai_soldier_state[e] = "idle"
  end
  if lastroar[e]==0 and ((GetAnimationFrame(e)<3105 and GetAnimationFrame(e)>=3060) or (GetAnimationFrame(e)>=3120)) then
   lastroar[e]=GetTimer(e)+4000
   PlaySound(e,0)
  end
 else
 if PlayerDist < 1000 and g_Entity[e]['plrvisible']==1 then
  -- while visible in range
  RotateToPlayer(e)
  if PlayerDist < 100 and g_Entity[e]['plrvisible']==1 then
   -- attack if close enough
   if ai_soldier_state[e]~="attack" then
    if GetAnimationFrame(e)<attackstart[e] or GetAnimationFrame(e)>attackend[e] then
     AIEntityStop(EntObjNo)
	 ai_soldier_state[e] = "attack"   
     CharacterControlLimbo(e)
     randomattack=math.random(1,3)       
 	 if randomattack == 1 then
      attackstart[e]=2775
      attackend[e]=2848
      damageframestart[e]=2795
      damageframeend[e]=2830
     end
     if randomattack == 2 then
      attackstart[e]=2916
      attackend[e]=2969
      damageframestart[e]=2945
      damageframeend[e]=2950
     end
     if randomattack == 3 then
      attackstart[e]=2981
      attackend[e]=3034
      damageframestart[e]=3010
      damageframeend[e]=3015
     end
     SetAnimationFrames(attackstart[e],attackend[e])
     PlayAnimation(e)
     SetAnimationSpeed(e,9.0)
    end
   end
   if ai_soldier_state[e]=="attack" then
    if GetAnimationFrame(e)>damageframestart[e] and GetAnimationFrame(e)<damageframeend[e] then
     if GetPlayerDistance(e)<110 then
      if GetTimer(e) > lastswipe[e] then
       lastswipe[e]= GetTimer(e)+1600
       PlaySound(e,1)
      end
      randomdamage=math.random(3,7)
      HurtPlayer(e,randomdamage)
     end
	end
    if GetAnimationFrame(e)>attackend[e]-2 then
	 if PlayerDist < 100 then
	  -- quickly attack again
	  ai_soldier_state[e] = "attackagain"
      SetAnimationFrames(attackstart[e]-1,attackstart[e]-1)
	  PlayAnimation(e)
	 end
    end
   end
  else
   -- not close enough, so roam moves to player
   if ai_soldier_state[e]~="roam" then
    ai_soldier_state[e] = "roam"
    CharacterControlUnarmed(e)
    ModulateSpeed(e,1.2)
    SetAnimationSpeed(e,1.2)
    SetCharacterToRun(e)
   end
   rndx=math.random(1,360)
   rndz=math.random(1,360)
   rndx2=math.sin(rndx)*30
   rndz2=math.cos(rndz)*30
   AIEntityGoToPosition(EntObjNo,g_PlayerPosX+rndx2,g_PlayerPosZ+rndz2)
  end
 else
  -- if not in attack range, revert to idle
  if PlayerDist >= 1000 and ai_soldier_state[e] ~= "idle" then
   ai_soldier_state[e] = "idle"
   CharacterControlLimbo(e)
   SetAnimationFrames(2552,2603)
   LoopAnimation(e)
   ModulateSpeed(e,1.0)
   SetAnimationSpeed(e,1.0)
   lastroar[e]=0
  end
 end
 end
 --PromptLocal(e,"FASTZOMBIE : Dist=" .. PlayerDist .. " State=" .. ai_soldier_state[e] .. " Vis=" .. g_Entity[e]['plrvisible'] .. " Frm=" .. GetAnimationFrame(e) )
end

function ai_fastzombie_exit(e)
PlayCharacterSound(e,"onDeath")
        Killed = Killed + 1
CollisionOff(e)
end