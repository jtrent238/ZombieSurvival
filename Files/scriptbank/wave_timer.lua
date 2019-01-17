local wave_started = {}
local wave_delay = {}

local check_delay = 0.01 --for performance (try increase if game is running slow)

wave = 1
local count = 0
local timer_started = 0
local max_in_wave = 0
local state = "active" 
--script works with wave_ai.lua
function wave_timer_init(e)
--set time delay for waves here (in seconds)
--note you must set a delay for every wave!
wave_delay[1] = 3
wave_delay[2] = 2
wave_delay[3] = 3

check_delay = check_delay * 1000

Hide(e)
CollisionOff(e)
end

function wave_timer_main(e)
Hide(e)
CollisionOff(e)

if state == "active" then
if timer_started == 0 then
StartTimer(e)
timer_started = 1 
else
if wave_started[wave] == nil then
wave_started[wave] = 0
else
if wave_started[wave] == 0 then
max_in_wave = 0
Panel(30,5,70,10)
TextCenterOnX(50,7.5,3,"Time to wave "..wave.." : "..math.floor(((wave_delay[wave] * 1000) - GetTimer(e))/1000).."s")
if GetTimer(e) > wave_delay[wave] * 1000 then
for a = 1,9999 do
if g_Entity[a] ~= nil then
if weapon_name[a] ~= nil then
if weapon_name[a] == "wave"..tostring(wave) then
SetActivated(a,1)
max_in_wave = max_in_wave + 1 
end
end
end
end
wave_started[wave] = 1 
end
count = 0
else
Panel(30,5,70,10)
TextCenterOnX(50,7.5,3,"Enemies remaining: "..max_in_wave - count)
if GetTimer(e) > check_delay then
StartTimer(e)
for a = 1,9999 do
if g_Entity[a] ~= nil then
if weapon_name[a] ~= nil then
if weapon_name[a] == "wave"..wave then
if dead[a] == 1 then
dead[a] = 2
count = count + 1
end
end
end
end
end
end
if count >= max_in_wave then
wave = wave + 1 
if wave_delay[wave] == nil then
state = ""
Destroy(e)
end
end
end --wave started

end
end --timer
end
end --main


function wave_timer_exit(e)

end