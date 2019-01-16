-- 
-- LUA Globals Common Header
--

-- Constants
AI_MANUAL = 0
AI_AUTOMATIC = 1
AI_CLOSEST_TO_PLAYER = 50

-- Globals (built-in)
g_Entity = {}

-- AI Globals
ai_soldier_state = {}
ai_soldier_pathindex = {}
ai_combat_mode = {}
ai_combat_state_delay = {}
ai_combat_old_time = {}
ai_combat_turn_delay = 1
ai_combat_cover_delay = 4
ai_combat_delay_after_finding = 2
ai_next_aggro_delay = 0
ai_start_x = {}
ai_start_z = {}
ai_dest_x = {}
ai_dest_z = {}
ai_old_health = {}
ai_ran_to_cover = {}
ai_alerted_mode = {}
ai_alerted_state_delay = {}
ai_alerted_old_time = {}
ai_alerted_spoken = {}
ai_returning_home = {}
ai_alert_x = -10000
ai_alert_z = -10000
ai_alert_counter = 0
ai_alert_entity = 0
ai_path_point_index = {}
ai_path_point_direction = {}
ai_path_point_max = {}
ai_starting_heath = {}
ai_patrol_x = {}
ai_patrol_z = {}
ai_aggro_x = nil
ai_aggro_z = nil
ai_aggro_entity = nil
ai_aggro_range = 400
PlayerDist = 0
Killed = 0

-- Weapon name global
weapon_name = {}

-- Globals (passed-in)
g_PlayerPosX = 0
g_PlayerPosY = 0
g_PlayerPosZ = 0
g_PlayerAngX = 0
g_PlayerAngY = 0
g_PlayerAngZ = 0
g_PlayerObjNo = 0
g_PlayerHealth = 0
g_PlayerLives = 0
g_PlayerFlashlight = 0
g_PlayerGunCount = 0
g_PlayerGunID = 0
g_Time = 0
g_TimeElapsed = 0
g_KeyPressE = 0
g_Scancode = 0
g_InKey = ""

-- Multiplayer
mp_isServer = 0
mp_playerNames = {}
mp_playerKills = {}
mp_playerDeaths = {}
mp_playerConnected = {}
mp_playerTeam = {}
mp_isConnectedToSteam = 0
mp_gameMode = 0
mp_servertimer = 0
mp_showscores = 0
mp_teambased = 0
mp_friendlyfireoff = 0
mp_me = 0;
mp_coop = 0;
mp_enemiesLeftToKill = 100;

-- Common Updater Functions (called by Engine)

function UpdateEntitySMALL(e,object,x,y,z)
 g_Entity[e] = {x=x; y=y; z=z; obj=object;}
end

function UpdateEntity(e,object,x,y,z,act,col,key,zon,plrvis,ani,hea,frm,tmr,pdst,avd)
 g_Entity[e] = {x=x; y=y; z=z; activated=act; animating=ani; collected=col; haskey=key; plrinzone=zon; plrvisible=plrvis; obj=object; health=hea; frame=frm; timer=tmr; plrdist=pdst; avoid=avd; }
end

function UpdateEntityRT(e,object,x,y,z,act,col,key,zon,plrvis,hea,frm,tmr,pdst,avd)
 g_Entity[e]['x'] = x;
 g_Entity[e]['y'] = y;
 g_Entity[e]['z'] = z;
 g_Entity[e]['obj'] = object;
 g_Entity[e]['activated'] = act;
 g_Entity[e]['collected'] = col;
 g_Entity[e]['haskey'] = key;
 g_Entity[e]['plrinzone'] = zon;
 g_Entity[e]['plrvisible'] = plrvis;
 g_Entity[e]['health'] = hea;
 g_Entity[e]['frame'] = frm;
 g_Entity[e]['timer'] = tmr;
 g_Entity[e]['plrdist'] = pdst;
 g_Entity[e]['avoid'] = avd;
end

function UpdateEntityAnimatingFlag(e,ani)
 g_Entity[e]['animating'] = ani;
end

-- Macro Functions

function GetPlayerDistance(e)
  tPlayerDX = (g_Entity[e]['x'] - g_PlayerPosX)
  tPlayerDY = (g_Entity[e]['y'] - g_PlayerPosY)
  tPlayerDZ = (g_Entity[e]['z'] - g_PlayerPosZ)
  if math.abs(tPlayerDY) > 100 then 
   tPlayerDY = tPlayerDY * 4
  end
  return math.sqrt(math.abs(tPlayerDX*tPlayerDX)+math.abs(tPlayerDY*tPlayerDY)+math.abs(tPlayerDZ*tPlayerDZ));
end

-- Common Action Functions (called by LUA)

function Prompt(str)
 SendMessageS("prompt",str);
end
function PromptDuration(str,v)
 SendMessageS("promptduration",v,str);
end
function PromptTextSize(v)
 SendMessageI("prompttextsize",v);
end
function PromptLocal(e,str)
 SendMessageS("promptlocal",e,str);
end
function SetFogNearest(v)
 SendMessageF("setfognearest",v)
end
function SetFogDistance(v)
 SendMessageF("setfogdistance",v)
end
function SetFogRed(v)
 SendMessageF("setfogred",v)
end
function SetFogGreen(v)
 SendMessageF("setfoggreen",v)
end
function SetFogBlue(v)
 SendMessageF("setfogblue",v)
end
function SetAmbienceIntensity(v)
 SendMessageF("setambienceintensity",v)
end
function SetAmbienceRed(v)
 SendMessageF("setambiencered",v)
end
function SetAmbienceGreen(v)
 SendMessageF("setambiencegreen",v)
end
function SetAmbienceBlue(v)
 SendMessageF("setambienceblue",v)
end
function SetSurfaceRed(v)
 SendMessageF("setsurfacered",v)
end
function SetSurfaceGreen(v)
 SendMessageF("setsurfacegreen",v)
end
function SetSurfaceBlue(v)
 SendMessageF("setsurfaceblue",v)
end

function JumpToLevelIfUsed(e)
 SendMessageS("jumptolevel",e,"")
end
function JumpToLevel(levelname)
 SendMessageS("jumptolevel",0,levelname)
end
function FinishLevel()
 SendMessageI("finishlevel",0);
end

function HideTerrain()
 SendMessageF("hideterrain",0)
end
function ShowTerrain()
 SendMessageF("showterrain",0)
end
function HideWater()
 SendMessageF("hidewater",0)
end
function ShowWater()
 SendMessageF("showwater",0)
end
function HideHuds()
 SendMessageF("hidehuds",0)
end
function ShowHuds()
 SendMessageF("showhuds",0)
end
function FreezeAI()
 SendMessageF("freezeai",0)
end
function UnFreezeAI()
 SendMessageF("unfreezeai",0)
end
function FreezePlayer()
 SendMessageF("freezeplayer",0)
end
function UnFreezePlayer()
 SendMessageF("unfreezeplayer",0)
end

function SetPlayerHealth(v)
 SendMessageF("setplayerhealth",v)
end
function SetEntityHealth(e,v)
 SendMessageI("setentityhealth",e,v);
end
function StartParticleEmitter(e)
 SendMessageF("startparticleemitter",e,0);
end
function StopParticleEmitter(e)
 SendMessageF("stopparticleemitter",e,0);
end

function StartTimer(e)
 SendMessageI("starttimer",e);
end
function GetTimer(e)
 return g_Time - g_Entity[e]['timer'];
end
function Destroy(e)
 SendMessageI("destroy",e);
end
function CollisionOn(e)
 SendMessageI("collisionon",e);
end
function CollisionOff(e)
 SendMessageI("collisionoff",e);
end
function GetEntityPlayerVisibility(e)
 SendMessageI("getentityplrvisible",e);
end
function Hide(e)
 SendMessageI("hide",e);
end
function Show(e)
 SendMessageI("show",e);
end
function Spawn(e)
 SendMessageI("spawn",e);
end
function SetActivated(e,v)
 g_Entity[e]['activated'] = v
 SendMessageI("setactivated",e,v);
end
function ActivateIfUsed(e)
 SendMessageI("activateifused",e);
end
function TransportToIfUsed(e)
 SendMessageI("transporttoifused",e);
end
function Collected(e)
 SendMessageI("collected",e);
end
function MoveUp(e,v)
 SendMessageF("moveup",e,v);
end
function MoveForward(e,v)
 SendMessageF("moveforward",e,v);
end
function MoveBackward(e,v)
 SendMessageF("movebackward",e,v);
end
function SetPosition(e,x,y,z)
 SendMessageF("setpositionx",e,x);
 SendMessageF("setpositiony",e,y);
 SendMessageF("setpositionz",e,z);
end
function ResetPosition(e,x,y,z)
 SendMessageF("resetpositionx",e,x);
 SendMessageF("resetpositiony",e,y);
 SendMessageF("resetpositionz",e,z);
end
function SetRotation(e,x,y,z)
 SendMessageF("setrotationx",e,x);
 SendMessageF("setrotationy",e,y);
 SendMessageF("setrotationz",e,z);
end
function ModulateSpeed(e,v)
 SendMessageF("modulatespeed",e,v);
end
function RotateX(e,v)
 SendMessageF("rotatex",e,v);
end
function RotateY(e,v)
 SendMessageF("rotatey",e,v);
end
function RotateZ(e,v)
 SendMessageF("rotatez",e,v);
end
function Scale(e,v)
 SendMessageF("scale",e,v);
end
function SetAnimation(e)
 SendMessageI("setanimation",e);
end
function SetAnimationFrames(e,v)
 SendMessageI("setanimationframes",e,v);
end
function PlayAnimation(e)
 SendMessageI("playanimation",e);
end
function LoopAnimation(e)
 SendMessageI("loopanimation",e);
end
function StopAnimation(e)
 SendMessageI("stopanimation",e);
end
function SetAnimationSpeed(e,v)
 SendMessageI("setanimationspeed",e,v);
end
function SetAnimationFrame(e,v)
 SendMessageF("setanimationframe",e,v);
end
function GetAnimationFrame(e)
 return g_Entity[e]['frame'];
end
function CharacterControlUnarmed(e)
 SendMessageI("charactercontrolunarmed",e);
end
function CharacterControlLimbo(e)
 SendMessageI("charactercontrollimbo",e);
end
function CharacterControlArmed(e)
 SendMessageI("charactercontrolarmed",e);
end
function CharacterControlFidget(e)
 SendMessageI("charactercontrolfidget",e);
end
function CharacterControlDucked(e)
 SendMessageI("charactercontrolducked",e);
end
function CharacterControlStand(e)
 SendMessageI("charactercontrolstand",e);
end
function SetCharacterToWalk(e)
 SendMessageI("setcharactertowalkrun",e,0);
end
function SetCharacterToRun(e)
 SendMessageI("setcharactertowalkrun",e,1);
end
function SetCharacterToStrafeLeft(e)
 SendMessageI("setcharactertostrafe",e,0);
end
function SetCharacterToStrafeRight(e)
 SendMessageI("setcharactertostrafe",e,1);
end
function SetCharacterVisionDelay(e,v)
 SendMessageI("setcharactervisiondelay",e,v);
end
function LockCharacterPosition(e,v)
 SendMessageI("setlockcharacter",e,1);
end
function UnlockCharacterPosition(e,v)
 SendMessageI("setlockcharacter",e,0);
end
function GravityOff(e)
 SendMessageI("setnogravity",e,1);
end
function GravityOn(e)
 SendMessageI("setnogravity",e,0);
end
function LookAtPlayer(e)
 SendMessageI("lookatplayer",e);
end
function RotateToPlayer(e)
 SendMessageI("rotatetoplayer",e,100);
end
function RotateToCamera(e)
 SendMessageI("rotatetocamera",e,100);
end
function RotateToPlayerSlowly(e,v)
 SendMessageI("rotatetoplayer",e,v);
end
function AddPlayerWeapon(e)
 SendMessageI("addplayerweapon",e);
end
function ReplacePlayerWeapon(e)
 SendMessageI("replaceplayerweapon",e);
end
function AddPlayerAmmo(e)
 SendMessageI("addplayerammo",e);
end
function AddPlayerHealth(e)
 SendMessageI("addplayerhealth",e);
end
function SetPlayerPower(e,v)
 SendMessageI("setplayerpower",e,v);
end
function AddPlayerPower(e,v)
 SendMessageI("addplayerpower",e,v);
end
function SetPlayerLives(e,v)
 SendMessageI("setplayerlives",e,v);
end
function RemovePlayerWeapons(e)
 SendMessageI("removeplayerweapons",e);
end
function AddPlayerJetPack(e,fuel)
 SendMessageI("addplayerjetpack",e,fuel);
end
function Checkpoint(e)
 SendMessageI("checkpoint",e);
end
function GetPlayerInZone(e)
 return g_Entity[e]['plrinzone'];
end
function PlaySound(e,v)
 SendMessageI("playsound",e,v);
end
function PlaySoundIfSilent(e,v)
 SendMessageI("playsoundifsilent",e,v);
end
function PlayNon3DSound(e,v)
 SendMessageI("playnon3dsound",e,v);
end
function LoopSound(e,v)
 SendMessageI("loopsound",e,v);
end
function StopSound(e,v)
 SendMessageI("stopsound",e,v);
end
function SetSoundSpeed(freq)
 SendMessageI("setsoundspeed",freq);
end
function SetSoundVolume(vol)
 SendMessageI("setsoundvolume",vol);
end
function PlayVideo(e,v)
 SendMessageI("playvideo",e,v);
end
function StopVideo(e,v)
 SendMessageI("stopvideo",e,v);
end
function FireWeapon(e)
 SendMessageI("fireweapon",e);
end
function HurtPlayer(e,v)
 SendMessageI("hurtplayer",e,v);
end
function SwitchScript(e,str)
 SendMessageS("switchscript",e,str);
end
function SetCharacterSoundSet(e)
 SendMessageI("setcharactersoundset",e);
end
function SetCharacterSound(e,str)
 SendMessageS("setcharactersound",e,str);
end
function PlayCharacterSound(e,str)
 SendMessageS("playcharactersound",e,str);
end
function PlayCombatMusic(playTime,fadeTime)
 music_play_timecue(2,playTime,fadeTime);
end
function PlayFinalAssaultMusic(fadeTime)
 music_play_cue(3,fadeTime);
end
function DisableMusicReset(v)
 SendMessageI("disablemusicreset",v);
end
function HideLight(e)
 SendMessageI("setlightvisible",e,0);
end
function ShowLight(e)
 SendMessageI("setlightvisible",e,1);
end
function LoadImages(str,v)
 SendMessageS("loadimages",v,str);
end
function SetImagePosition(x,y)
 SendMessageF("setimagepositionx",x);
 SendMessageF("setimagepositiony",y);
end
function ShowImage(i)
 SendMessageI("showimage",i);
end
function HideImage(i)
 SendMessageI("hideimage",i);
end
function SetImageAlignment(i)
 SendMessageI("setimagealignment",i);
end
function Text(x,y,size,txt)
 SendMessageF("textx",x);
 SendMessageF("texty",y);
 SendMessageI("textsize",size);
 SendMessageS("texttxt",txt);
end
function TextCenterOnX(x,y,size,txt)
 SendMessageF("textx",x);
 SendMessageF("texty",y);
 SendMessageI("textsize",size);
 SendMessageI("textcenterx",0);
 SendMessageS("texttxt",txt);
end
function TextColor(x,y,size,txt,r,g,b)
 SendMessageF("textx",x);
 SendMessageF("texty",y);
 SendMessageI("textsize",size);
 SendMessageI("textred",r);
 SendMessageI("textgreen",g);
 SendMessageI("textblue",b);
 SendMessageS("texttxt",txt);
end
function TextCenterOnXColor(x,y,size,txt,r,g,b)
 SendMessageF("textx",x);
 SendMessageF("texty",y);
 SendMessageI("textsize",size);
 SendMessageI("textcenterx",0);
 SendMessageI("textred",r);
 SendMessageI("textgreen",g);
 SendMessageI("textblue",b);
 SendMessageS("texttxt",txt);
end
function Panel(x,y,x2,y2)
 SendMessageF("panelx",x);
 SendMessageF("panely",y);
 SendMessageF("panelx2",x2);
 SendMessageF("panely2",y2);
end

-- Common Multiplayer

function MP_IsServer()
 -- 1 = is the server, 0 = is not the server
 return mp_isServer;
end

function SetMultiplayerGameMode(mode)
 SendMessageI("mpgamemode",mode);
 mp_gameMode = mode;
end

function GetMultiplayerGameMode(mode)
 return mp_gameMode;
end

function SetServerTimer(t)
	SendMessageI("setservertimer",t);
	mp_servertimer = t;
end

function GetServerTimer(t)
	return mp_servertimer;
end

function GetServerTimerPassed()
	return os.time()-mp_servertimer;
end

function ServerRespawnAll()
	SendMessageI("serverrespawnall",0);
end

function ServerEndPlay()
	SendMessageI("serverendplay",0);
end

function GetShowScores()
	return mp_showscores;
end

function SetServerKillsToWin(v)
	SendMessageI("setserverkillstowin",v);
end

function GetInKey()
	return g_InKey;
end

function GetScancode()
	return g_Scancode;
end

function GetMultiplayerTeamBased()
	return mp_teambased;
end

function SetMultiplayerGameFriendlyFireOff()
	mp_friendlyfireoff = 1;
end

function SetNameplatesOff()
	SendMessageI("nameplatesoff",v);
end

function GetCoOpMode()
	return mp_coop
end

function GetCoOpEnemiesAlive()
	return mp_enemiesLeftToKill
end