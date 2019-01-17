-- LUA Script - precede every function and global member with lowercase name of script

-- init when level first runs
function ai_neutral_init(e)
 CharacterControlUnarmed(e)
end

function ai_neutral_main(e)
 PlayerDist = GetPlayerDistance(e)
 if PlayerDist < 200 then
  LookAtPlayer(e)
 end 
end
