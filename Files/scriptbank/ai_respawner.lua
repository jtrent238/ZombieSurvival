
--time to wait before removing the dead bodies (in seconds)
--note, dont set too long or it may get removed by the system and then there will be no possibility of respawn
local body_removal_delay = 5
--time to wait before respawning the enemies (in seconds)
local respawn_delay = 0
  
--amount of variation in x,y and z placements when enemies are respawned (in percent)
--note this is taken from where they die
--note2  y position doesnt currently work due to a GG bug
local reposition = 0
local xmod = 0.0
local zmod = 0.0
local ymod = 0
  
--time to wait between checks (for performance reasons)
local delay = 1000
  
---------
local x = {}
local y = {}
local z = {}
local timer = {}
  
--script to work in conjunction with ai_respawn.lua
--set always active
function ai_respawner_init(e)
Hide(e)
CollisionOff(e)
end
  
function ai_respawner_main(e)
Hide(e)
CollisionOff(e)
if GetTimer(e) > delay then
StartTimer(e)
for a = 1,9999 do
if g_Entity[a] ~= nil and a ~= e then
if dead[a] ~= nil then
--PromptLocal(a,dead[a])
if dead[a] == 1 then
if reposition == 0 then 
	x[a] = g_Entity[a]['x']
	y[a] = g_Entity[a]['y']
	z[a] = g_Entity[a]['z']
else 
	if xmod <= 0 or xmod > 99 then
	x[a] = g_Entity[a]['x']
	else
	x[a] = g_Entity[a]['x'] * math.random(1-(xmod/10),1+(xmod/10))
	end
	if ymod <= 0 or ymod > 99 then
	y[a] = g_Entity[a]['y']
	else
	y[a] = g_Entity[a]['y'] * math.random(1-(ymod/10),1+(ymod/10))
	end
	if zmod <= 0 or zmod > 99 then
	z[a] = g_Entity[a]['z']
	else
	z[a] = g_Entity[a]['z'] * math.random(1-(zmod/10),1+(zmod/10))
	end
end 
dead[a] = 2 
timer[a] = g_Time + (body_removal_delay*1000)
  
--check body for removal
elseif dead[a] == 2 then
if g_Time >= timer[a] then
--PromptDuration("removed body",500)
timer[a] = g_Time + (respawn_delay*1000)
Spawn(a)
if respawn_delay > 0 then 
	Hide(a)
	--CollisionOff(a)
	dead[a] = 3
else 
	Show(a)
	--CollisionOn(a)
	dead[a] = nil
	ai_respawn_main(a)
end 
--if reposition == 1 then 
	SetPosition(a,x[a],y[a],z[a])
	ResetPosition(a,x[a],y[a],z[a])
	AIEntityGoToPosition(g_Entity[a]['obj'],x[a],z[a])
	AISetEntityPosition(g_Entity[a]['obj'],GetEntityPositionX(a),GetEntityPositionY(a),GetEntityPositionZ(a))
--end 
end
  
--check for respawn
elseif dead[a] == 3 then
	if g_Time >= timer[a] then
		--PromptDuration("respawned enemy",500)
		Show(a)
		CollisionOn(a)
		dead[a] = nil
		ai_respawn_main(a)
	end
end
end
end
end
end
  
  
end
  
  
function ai_respawner_exit(e)
end