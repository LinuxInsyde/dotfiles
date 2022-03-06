-- XMonad Configuration
import XMonad

-- Utils
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce

-- qualified Imports
import qualified Data.Map as M
import qualified XMonad.StackSet as W

-- Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.LayoutModifier

-- Layouts
import XMonad.Layout.Grid
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.TwoPane (TwoPane)
import XMonad.Layout.Spiral

import Colors.DoomTokyo
----------------------------------------------------

myWorkspaces = ["dev","www","mus","gfx","vid","vms","VII","IIX","IX"]

main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB(statusBarProp "xmobar -x 0" (pure myXmobarPP)) defToggleStrutsKey
     . withEasySB(statusBarProp "xmobar -x 1" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig


myConfig = def
  { layoutHook = smartBorders $ mySpacing 6 $ myLayout
  , borderWidth = 2
  , focusedBorderColor = color06
  , manageHook = myManageHook
  , startupHook = myStartupHook
  , workspaces = myWorkspaces
  }


-- Layouts
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

myLayout = tiled ||| spiral (6/7)
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 3/5
    delta = 3/100

-- Startup Hook
myStartupHook = do
  spawnOnce("conky")
  spawnOnce("displays")

-- ManageHook
myManageHook :: ManageHook
myManageHook = composeAll
  [ className   =? "conky"              --> doFloat
  , className   =? "VirtualBox Manager" --> doFloat
  , isDialog                            --> doFloat
  ]

-- XMobar Config
windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myXmobarPP :: PP
myXmobarPP = def
  { ppCurrent = xmobarColor color06 "" . wrap
    ("<box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">") "</box>"
  , ppVisible = xmobarColor color06 ""
  , ppHidden = xmobarColor color05 "" . wrap
    ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">") "</box>"
  , ppHiddenNoWindows = xmobarColor color05 "" 
  , ppTitle = xmobarColor color16 "" . shorten 60
  , ppSep =  "<fc=" ++ color09 ++ "> <fn=1>|</fn> </fc>"
  , ppUrgent = xmobarColor color02 "" . wrap "!" "!"
  , ppExtras  = [windowCount]
  , ppOrder  = \(ws:l:t:ex) -> [ws]++ex++[t]
 }
  where
    formatFocused     = wrap (xmobarColor color16 ""    "[") (xmobarColor color16 ""   "]") . xmobarColor color06 "" . ppWindow
    formatUnfocused   = wrap (xmobarColor colorFore ""  "[") (xmobarColor colorFore ""  "]") . xmobarColor color15 ""  . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30
