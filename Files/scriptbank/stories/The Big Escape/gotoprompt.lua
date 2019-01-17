-- LUA Script - precede every function and global member with lowercase name of script + '_main'
-- Player Enters Win Zone

function gotoprompt_init(e)
end

function gotoprompt_main(e)
 if g_Entity[e]['plrinzone']==1 then
 PromptDuration("Quickly, collect the map, near the building.",3000)
 
 end
end
