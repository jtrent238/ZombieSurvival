Hi all,

Files included are now named the same as the files they should replace in the applicable weapon folder i.e.

MAIN SOUNDS:

fire.wav

reload.wav (includes "cock.wav" sound)

dryfire.wav

NEW EXTRA SOUNDS:

cock_Separate.wav

reload_Separate.wav

putaway.wav (when pressing "0")

retrieve.wav (when pressing allocated weapon number key)

_________________________________________________________


IMPROVEMENT RECOMMENDATIONS... Tavor

1. I've included a "quick-fix" gunspec file which sets up the fire and reload sounds to work with the animation (works well @~ 35fps).  Included gunspec file is needed when auditioning this sound set.

2. Muzzle-flash animation is positioned too low.  

3. I've had to incorporate the reload and cock sounds into one because I couldn't get them to fire separately via the existing gunspec file.  Due to the length of the reload animation, and the loss of sync. which occurs as the frame rate drops (the sounds take the same time to play regardless), in a busy scene, it would be best to trigger the reload and cock sounds separately as the animation plays through.

This method would make the loss of sync. less noticable.

That's it for for this one!
 
Rick Harrison.
