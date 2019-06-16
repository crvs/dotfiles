import Data.Text(pack,unpack,split)
import System.Exit
import Control.Applicative()
import System.IO
import Text.Regex.Posix
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders(noBorders)
import XMonad.Layout.Minimize(minimizeWindow,minimize,MinimizeMsg(RestoreNextMinimizedWin))
import XMonad.Util.Run(runProcessWithInput,spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Util.Font
import XMonad.Util.Loggers

startup :: X ()
startup = spawn "/home/crvs/.xsession"

main :: IO ()
main = do
    dzproc <- spawnPipe "dzen2 -p 1 -xs 1 -fg white -bg '#333333' -fn 'monofur for Powerline:regular:pixelsize=15' -expand right "
    ckwidth <- show . (+) (-570) . (read :: String -> Int) . unpack . head . split (== 'x') . (!! 3) . split (== ' ') . pack . head . filter (=~ "primary") . map unpack . split (== '\n') . pack <$> runProcessWithInput "xrandr" ["--current"] []
    spawn $ "conky -c /home/crvs/.xmonad/conky.conf | dzen2 -xs 1 -fg white -bg '#333333' -fn 'monofur for Powerline:regular:pixelsize=15' -w " ++ ckwidth ++ " -x 590"
    xmonad $ defaultConfig
        { manageHook = composeAll
                       [ className =? "Gimp"         --> doFloat
                       , title     =? "Event Tester" --> doFloat
                       , manageDocks
                       ]
        , startupHook = startup
        , focusedBorderColor = "#ffff00"
        , normalBorderColor = "#000000"
        , borderWidth = 1
        , layoutHook = myLayout
        , focusFollowsMouse = False
        , logHook = dynamicLogWithPP dzenPP
                    { ppOutput          = hPutStrLn dzproc
                    , ppTitle           = const ""
                    , ppVisible         = dzenColor "#a0a0a0" "#234848" . pad
                    , ppCurrent         = dzenColor "#ffffff" "#306060" . pad
                    , ppHidden          = dzenColor "#ffffff" "#555555" . pad
                    , ppLayout          = const ""
                    , ppHiddenNoWindows = dzenColor "#555555" "#333333" . pad
                    , ppSep             = " "
                    , ppWsSep           = ""
                    , ppExtras          = [ (return . return :: String -> X(Maybe String)) "^p(_LEFT)^p(210)"
                                          , fixedWidthL AlignLeft " " 80 . dzenColorL "#ffffff" "#333333" . shortenL 40 $ logTitle
                                          ]
                    } >> ewmhDesktopsLogHook >> setWMName "XMonad"
        , modMask = mod4Mask
        --, terminal = "termite"
        , terminal = "urxvt -e tmux"
        , workspaces = ["1","2","3","4","5","6","7","8","9"]
        }`additionalKeys`
            [ (( modM , xK_z ) , spawn "slock")
            , (( modS , xK_z ) , spawn "systemctl suspend || true && slock")
            , (( modM , xK_a ) , spawn "pavucontrol" ) -- $ term  "alsamixer" "alsamixer" )
            , (( modS , xK_BackSpace ), io exitSuccess)
            , (( modS , xK_e ) , spawn $ term "vim" "vim" )
            , (( modN , brightnessUpKey) , brightnessUpCommand)
            , (( modN , brightnessDownKey) , brightnessDownCommand)
            , (( modM , xK_F8) , brightnessUpCommand)
            , (( modM , xK_F7) , brightnessDownCommand)
            , (( modM , xK_F1 ) , muteAudioCommand )
            , (( modM , xK_F2 ) , lowerAudioCommand )
            , (( modM , xK_F3 ) , raiseAudioCommand )
            , (( modN , raiseAudioKey ), raiseAudioCommand)
            , (( modN , lowerAudioKey ), lowerAudioCommand)
            , (( modN , muteAudioKey ), muteAudioCommand)
            , (( modM , xK_f ) , spawn $ term "vifm" "vifm" )
            , (( modN , toggleBacklightKey ) , spawn toggleBacklightCommand )
            , (( modS , xK_m ) , spawn $ term "" oldSpawn )
            , (( modM , xK_m ) , spawn $ term "cmus" cmusCommand )
            , (( modS , xK_p ) , spawn $ term "htop" "htop" )
            , (( modM , xK_i ) , spawn $ term "irssi" "irssi" )
            , (( modS , xK_t ) , spawn "compton-trans -c 90" )
            , (( modS , xK_q ) , spawn "killall dzen2 ; xmonad --restart" )
            , (( modM , xK_q ) , spawn "killall dzen2 ; xmonad --recompile || xmonad --restart" )
            , (( modN , pauseKey ) , pauseCommand )
            , (( modM , xK_F11 ) , pauseCommand )
            , (( modN , nextKey ) , nextCommand )
            , (( modM , xK_F12 ) , nextCommand )
            , (( modN , previousKey ) , previousCommand)
            , (( modM , xK_F10 ) , previousCommand)
            , (( modS , xK_s) , swapNextScreen )
            , (( modS , xK_h) , shiftPrevScreen )
            , (( modS , xK_l) , shiftNextScreen )
            , (( modM , xK_s) , nextScreen )
            , (( modM , xK_Right) , nextWS )
            , (( modM , xK_Left) , prevWS )
            , (( modM , xK_b) , launchBrowser )
            , (( modM , xK_g) , withFocused minimizeWindow )
            , (( modS , xK_g) , sendMessage RestoreNextMinimizedWin )
            , (( modM , xK_p) , spawn dmenuCommand )
        ]
        where
            term :: String -> String -> String
            term t c = "urxvt -title " ++ t ++ " -e " ++ c
            modM              = mod4Mask
            modN              = noModMask
            modS              = mod4Mask .|. shiftMask
            cmusCommand       = "~/.xmonad/cmusLaunch.sh"
            dmenuCommand      = "dmenu_run -nb rgb:30/30/30 -sb rgb:220/55/55 -nf white -sf white -p 'run ' -fn 'monofur for Powerline:regular:pixelsize=15'"
            toggleBacklightKey     = stringToKeysym "XF86Display"
            toggleBacklightCommand = "~/.xmonad/backlighttoggle.sh"
            raiseAudioKey     = stringToKeysym "XF86AudioRaiseVolume"
            raiseAudioCommand = spawn "amixer sset Master unmute && amixer sset Master 5%+"
            lowerAudioKey     = stringToKeysym "XF86AudioLowerVolume"
            lowerAudioCommand = spawn "amixer sset Master 5%-"
            muteAudioKey      = stringToKeysym "XF86AudioMute"
            muteAudioCommand  = spawn "amixer sset Master togglemute"
            brightnessUpKey   = stringToKeysym "XF86MonBrightnessUp"
            brightnessDownKey = stringToKeysym "XF86MonBrightnessDown"
            brightnessUpCommand   = spawn "xbacklight -inc 5"
            brightnessDownCommand = spawn "xbacklight -dec 5"
            pauseKey          = stringToKeysym "XF86AudioPlay"
            pauseCommand      = spawn "cmus-remote --pause"
            nextKey           = stringToKeysym "XF86AudioNext"
            nextCommand       = spawn "cmus-remote --next"
            previousKey       = stringToKeysym "XF86AudioPrev"
            previousCommand   = spawn "cmus-remote --prev"
            launchBrowser     = spawn "firefox"
            myLayout =
                minimize $
                    avoidStruts ( tallLayout ||| mirrorTall ||| noBorders Full )
                        ||| noBorders Full
              where
                tallLayout = Tall {tallNMaster = 1, tallRatioIncrement = 3 / 100, tallRatio = 1 / 2}
                mirrorTall = Mirror tallLayout

