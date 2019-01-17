-- LUA Script - precede every function and global member with lowercase name of script + '_main'
-- Displays coins to collect

function coindisplay_init(e)
LoadImages("cartoon",0)
end

function coindisplay_main(e)

     SetImagePosition(50,10)
     ShowImage(0)

     PromptTextSize(5)
     Prompt (" " .. 100 - CoinCount .. " more to collect!" )

     if CoinCount==100 then
      HideImage(1)
      FreezePlayer()
      SetImagePosition(50,50)
      ShowImage(1)
       if g_KeyPressE == 1 then
        UnFreezePlayer()
        HideImage(0)
        FinishLevel()
        Destroy(e)
       end
       Prompt("Press E to close or Esc to end level.")
      end
      
     end

