import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Actions.CopyWindow
import XMonad.Util.EZConfig
---import XMonad.Layout.Accordion
--this bit is for the fullscreen
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W
import XMonad.Hooks.EwmhDesktops
--- better accordian
import XMonad.Layout.DecorationMadness
import XMonad.Layout.SmallAccordion
---import XMonad.Layout.defaultTheme
import XMonad.Layout.Decoration
import XMonad.Layout.NoFrillsDecoration

myLayout = avoidStruts $ ( tiled ||| Mirror tiled ||| better_accordion )
	where
		tiled = Tall nmaster delta ratio
		nmaster = 1
		ratio = 1/2
		delta = 3/100
		better_accordion = noFrillsDeco shrinkText defaultTheme SmallAccordion

focusFollowsMouse = False

myManageHooks = composeAll
	[ isFullscreen --> (doF W.focusDown <+> doFullFloat) ]

main = do
	xmonad $ defaultConfig
		{manageHook = manageDocks <+> myManageHooks
		, layoutHook = myLayout
		, XMonad.focusFollowsMouse = False
		, modMask = mod4Mask
		} `additionalKeys`
		[   ((mod4Mask, xK_v ), windows copyToAll)
		, ((mod4Mask, xK_z), spawn "gnome-screensaver-command -l") ]
