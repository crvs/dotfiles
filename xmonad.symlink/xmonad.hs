import Data.List
import System.Exit
import System.IO
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.NoBorders(toggleBorder)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
-- import XMonad.Hooks.UrgencyHook
import XMonad.Layout.BoringWindows(boringWindows)
import XMonad.Layout.NoBorders(noBorders)
import XMonad.Layout.Minimize(minimizeWindow,minimize,MinimizeMsg(RestoreNextMinimizedWin))
import XMonad.Layout.Maximize
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Reflect
import qualified XMonad.StackSet as W
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.WorkspaceCompare(getSortByXineramaRule)

startup :: X ()
startup = do
    spawn "/home/crvs/.xsession"

main :: IO ()
main = do
    -- xmproc <- spawnPipe "xmobar /home/crvs/.xmobarrc"
    dzproc <- spawnPipe "dzen2 -p 1 -xs 1 -fg white -bg '#333333' -fn 'monofur for Powerline:regular:pixelsize=15'"
    -- xmonad $ withUrgencyHookC StdoutUrgencyHook urgencyConfig { suppressWhen = Focused, remindWhen = Dont } $ defaultConfig
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
        -- , logHook = (dynamicLogWithPP xmobarPP
                    -- { ppOutput = hPutStrLn xmproc
                    -- , ppTitle   = xmobarColor "#ffff00" "#000000" . shorten 40
                    -- , ppVisible = xmobarColor "#ffff00" "#000000"
                    -- , ppCurrent = xmobarColor "#ffff00" "#000000"
                    -- , ppLayout = (\_ -> "")
                    -- , ppSort    = getSortByXineramaRule
                    -- }) >> ewmhDesktopsLogHook >> setWMName "XMonad"
        , logHook = (dynamicLogWithPP dzenPP
                    { ppOutput          = hPutStrLn dzproc
                    , ppTitle           = dzenColor "#ffffff" "#333333" . shorten 40
                    , ppVisible         = dzenColor "#ffffff" "#333333"
                    , ppCurrent         = dzenColor "#ffffff" "#333333"
                    , ppHidden          = dzenColor "#bbbbbb" "#333333"
                    , ppLayout          = (\_ -> "")
                    , ppHiddenNoWindows = dzenColor "#555555" "#333333"
                    , ppSep             = "   "
                    , ppWsSep           = " / "
                    -- , ppSort            = getSortByXineramaRule
                    , ppExtras          = [aumixVolume,date "%a %b%_d (w %V) %H:%M:%S",battery]
                    }) >> ewmhDesktopsLogHook >> setWMName "XMonad"
        , modMask = mod4Mask
        --, terminal = "termite"
        , terminal = "urxvt"
        , workspaces = ["1","2","3","4","5","6","7","8","9"]
        }`additionalKeys`
            [ (( modM , xK_z ) , spawn "xscreensaver-command -lock")
            , (( modS , xK_z ) , spawn "xscreensaver-command -lock && sleep 2 && systemctl suspend")
            , (( modM , xK_a ) , spawn "pavucontrol" ) -- $ term  "alsamixer" "alsamixer" )
            , (( modS , xK_BackSpace ), io (exitWith ExitSuccess))
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
            , (( modN , toggleBacklightKey ) , spawn $ toggleBacklightCommand )
            , (( modS , xK_m ) , spawn $ term "social" socialCommand )
            , (( modM , xK_m ) , spawn $ term "cmus" cmusCommand )
            , (( modS , xK_p ) , spawn $ term "htop" "htop" )
            , (( modM , xK_i ) , spawn $ term "irssi" "irssi" )
            , (( modS , xK_t ) , spawn "compton-trans -c 90" )
            , (( modS , xK_q ) , spawn "xmonad --recompile || true && xmonad --restart" )
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
            , (( modM , xK_x) , sendMessage $ Toggle REFLECTX )
            , (( modM , xK_y) , sendMessage $ Toggle REFLECTY )
            , (( modM , xK_b) , launchBrowser )
            , (( modM , xK_g) , withFocused minimizeWindow )
            , (( modS , xK_g) , sendMessage RestoreNextMinimizedWin )
            , (( modM , xK_p) , spawn dmenuCommand )
        ]
        where
            term :: String -> String -> String
            term t c = "urxvt -title " ++ t ++ " -e " ++ c
            --term t c = "termite -t " ++ t ++ " -e " ++ c
            modM              = mod4Mask
            modN              = noModMask
            modS              = mod4Mask .|. shiftMask
            socialCommand     = "if tmux has -t social; then tmux detach -s social  || sleep 1 && tmux attach -t social && tmux select-window -t social -t 0; else tmux new -s social turses; sleep 1; tmux split -t social mutt; sleep 1; tmux new-window -t social irssi -c Freenode; fi"
            cmusCommand       = "~/.xmonad/cmusLaunch.sh"
            dmenuCommand      = "dmenu_run -nb rgb:30/30/30 -sb rgb:220/55/55 -nf white -sf white -p 'run ' -fn 'monofur for Powerline:regular:pixelsize=15'"
            -- purple dmenu
            -- dmenuCommand      = "dmenu_run -nb rgb:70/0/70 -sb yellow -nf white -sf rgb:70/0/70 -p 'run: ' -fn xft:monofur-10.5:regular"
            toggleBacklightKey     = (stringToKeysym "XF86Display")
            toggleBacklightCommand = "~/.xmonad/backlighttoggle.sh"
            raiseAudioKey     = (stringToKeysym "XF86AudioRaiseVolume")
            raiseAudioCommand = (spawn "amixer sset Master unmute && amixer sset Master 5%+")
            lowerAudioKey     = (stringToKeysym "XF86AudioLowerVolume")
            lowerAudioCommand = (spawn "amixer sset Master 5%-")
            muteAudioKey      = (stringToKeysym "XF86AudioMute")
            muteAudioCommand  = (spawn "amixer sset Master togglemute")
            brightnessUpKey   = (stringToKeysym "XF86MonBrightnessUp")
            brightnessDownKey = (stringToKeysym "XF86MonBrightnessDown")
            brightnessUpCommand   = (spawn "xbacklight -inc 5")
            brightnessDownCommand = (spawn "xbacklight -dec 5")
            pauseKey          = (stringToKeysym "XF86AudioPlay")
            pauseCommand      = (spawn "cmus-remote --pause")
            nextKey           = (stringToKeysym "XF86AudioNext")
            nextCommand       = (spawn "cmus-remote --next")
            previousKey       = (stringToKeysym "XF86AudioPrev")
            previousCommand   = (spawn "cmus-remote --prev")
            launchBrowser     = (spawn "firefox")
            myLayout =
                boringWindows $
                minimize $
                ( avoidStruts $ tallLayout ||| mirrorTall ||| noBorders Full )
                ||| noBorders Full
              where
                tallLayout = Tall {tallNMaster = 1, tallRatioIncrement = 3 / 100, tallRatio = 1 / 2}
                mirrorTall = Mirror tallLayout

takeTopFocus :: X ()
takeTopFocus = withWindowSet $ maybe (setFocusX =<< asks theRoot) takeFocusX . W.peek

xmobarStrip :: String -> String
xmobarStrip = strip [] where
    strip keep x
      | null x                 = keep
      | "<fc="  `isPrefixOf` x = strip keep (drop 1 . dropWhile (/= '>') $ x)
      | "</fc>" `isPrefixOf` x = strip keep (drop 5  x)
      | '<' == head x          = strip (keep ++ "<") (tail x)
      | otherwise              = let (good,x') = span (/= '<') x
                                 in strip (keep ++ good) x'

takeFocusX :: Window -> X()
takeFocusX w = withWindowSet $ \ _ -> do
                dpy <- asks display
                wmtakef <- atom_WM_TAKE_FOCUS
                wmprot <- atom_WM_PROTOCOLS
                protocols <- io $ getWMProtocols dpy w
                if (wmtakef `elem` protocols) then
                  do
                    io $ allocaXEvent $ \ev -> do
                      setEventType ev clientMessage
                      setClientMessageEvent ev w wmprot 32 wmtakef currentTime
                      sendEvent dpy w False noEventMask ev else
                  return ()
