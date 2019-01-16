-- LUA Script - precede every function and global member with lowercase name of script + '_main'
-- Kill counter - Counts your kills.

local Killed = 0

function killcounter_init(e)
end

function killcounter_main(e)
	TextCenterOnX(50,6,3,"You have Killed: "..Killed.." Zombies!")
end
