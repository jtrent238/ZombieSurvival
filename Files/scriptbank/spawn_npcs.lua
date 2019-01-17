-- LUA Script - precede every function and global member with lowercase name of script + '_main'
-- Player Enters Win Zone
function spawn_npcs_init(e)
end

function spawn_npcs_main(e)
 if g_Entity[e]['plrinzone']==1 then
  PlaySound(e,0)
 
  Spawn(136) -- ID Number of NPC - Found by placing mouse pointer
             -- over NPC and reading first Number in Bottom Editor Bar
  Spawn(58) -- Next NPC ID Number
  Spawn(123) -- Next NPC ID Number
  Spawn(119) -- Next NPC ID Number
  Spawn(13) -- Next NPC ID Number
  Spawn(94) -- Next NPC ID Number
  Spawn(124) -- Next NPC ID Number
  Spawn(66) -- Next NPC ID Number
  Spawn(11) -- Next NPC ID Number
  Spawn(148) -- Next NPC ID Number
  Spawn(98) -- Next NPC ID Number
 
  Destroy(e)
 end
end
-- Don't forget to place a NO in the Spawn section of the NPC
