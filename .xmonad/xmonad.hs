{-# LANGUAGE DeriveDataTypeable, FlexibleContexts, FlexibleInstances, MultiParamTypeClasses, TypeSynonymInstances #-}

import qualified Data.Map             as M
import qualified XMonad.Layout.Groups as G
import qualified XMonad.StackSet      as W
import Data.List ( partition )
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Column
import XMonad.Layout.Groups.Helpers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane

moveGroup :: G.ModifySpec
moveGroup _ Nothing   = Nothing
moveGroup l0 (Just s) = if null (W.up s) && null (W.down s)
                            then G.moveToNewGroupUp l0 (Just s)
                            else G.moveToGroupUp True  l0 (Just s)

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
    [ ((modm .|. mod1Mask , xK_l     ), spawn "xscreensaver-command --lock")
    , ((modm .|. shiftMask, xK_t     ), spawn $ XMonad.terminal conf)
    , ((modm              , xK_p     ), spawn "XMODIFIERS=\"\" interrobang")
    , ((modm .|. shiftMask, xK_c     ), kill)
    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space ), withFocused (sendMessage . maximizeRestore))
 
    , ((modm .|. shiftMask, xK_Return), sendMessage $ G.Modify moveGroup)
    , ((modm              , xK_Return), sendMessage $ G.Modify G.focusGroupUp)
 
    , ((modm .|. mod1Mask , xK_j     ), swapDown)
    , ((modm .|. mod1Mask , xK_k     ), swapUp)
    , ((modm .|. shiftMask, xK_j     ), focusDown)
    , ((modm .|. shiftMask, xK_k     ), focusUp)

    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myLayoutHook = avoidStruts $ maximize $ G.group (simpleTabbed ||| (Column 1)) (TwoPane 0.03 0.5)

main = xmonad =<< xmobar defaultConfig
        { modMask  = controlMask
        , terminal = "xfce4-terminal"
        , keys     = myKeys
        , layoutHook = myLayoutHook
        , handleEventHook = mconcat
            [ docksEventHook
            , handleEventHook defaultConfig ]
        }

-----------------------------------------------------------------------------
-- |
-- Module      :  XMonad.Layout.Maximize
-- Copyright   :  (c) 2007 James Webb
-- License     :  BSD3-style (see LICENSE)
--
-- Maintainer  :  xmonad#jwebb,sygneca,com
-- Stability   :  unstable
-- Portability :  unportable
--
-- Temporarily yanks the focused window out of the layout to mostly fill
-- the screen.
--
-- Edited by dec41 to actually fill the screen
-----------------------------------------------------------------------------

data Maximize a = Maximize (Maybe Window) deriving ( Read, Show )
maximize :: LayoutClass l Window => l Window -> ModifiedLayout Maximize l Window
maximize = ModifiedLayout $ Maximize Nothing

data MaximizeRestore = MaximizeRestore Window deriving ( Typeable, Eq )
instance Message MaximizeRestore
maximizeRestore :: Window -> MaximizeRestore
maximizeRestore = MaximizeRestore

instance LayoutModifier Maximize Window where
    modifierDescription (Maximize _) = "Maximize"
    pureModifier (Maximize (Just target)) rect (Just (W.Stack focused _ _)) wrs =
            if focused == target
                then (maxed ++ rest, Nothing)
                else (rest ++ maxed, lay)
        where
            (toMax, rest) = partition (\(w, _) -> w == target) wrs
            maxed = map (\(w, _) -> (w, maxRect)) toMax
            maxRect = Rectangle (rect_x rect) (rect_y rect)
                (rect_width rect) (rect_height rect)
--            maxRect = Rectangle (rect_x rect + 25) (rect_y rect + 25)
--                (rect_width rect - 50) (rect_height rect - 50)
            lay | null maxed = Just (Maximize Nothing)
                | otherwise  = Nothing
    pureModifier _ _ _ wrs = (wrs, Nothing)

    pureMess (Maximize mw) m = case fromMessage m of
        Just (MaximizeRestore w) -> case mw of
            Just w' -> if (w == w')
                        then Just $ Maximize Nothing   -- restore window
                        else Just $ Maximize $ Just w  -- maximize different window
            Nothing -> Just $ Maximize $ Just w        -- maximize window
        _ -> Nothing
