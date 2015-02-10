import XMonad.Actions.Volume (getVolume,getMute)

-- to install just compile this file with ghc and
-- add the following to the command list in the .xmobarrc file:
-- -- Run Com "PATH-TO-SOUNDMON" [] "vol" 1
-- and add
-- -- %vol%
-- to the template line.
-- prints the master volume reported by Alsa and prints it in red in
-- case Master is muted.

main :: IO()
main = do 
       vol <- getVolume
       mute <- getMute
       let printable = show  ((floor  vol)::Integer)
       if mute
         then putStrLn $ "<fc=#ff0000>" ++ printable ++"</fc>"
         else
         putStrLn printable
