{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, TypeSynonymInstances #-}

module XMonad.Layout.SmallAccordion(
	SmallAccordion(SmallAccordion)) where

import XMonad
import qualified XMonad.StackSet as W

import Data.Ratio

data SmallAccordion a = SmallAccordion deriving ( Read, Show )

from_win_list rec [] focus = []
from_win_list (Rectangle sx sy sw sh) (w_head:w_rest) focus = 
	[(w_head, (Rectangle sx sy sw win_h))] ++ from_win_list (Rectangle sx (sy + fromIntegral(win_h)) sw (sh - win_h)) w_rest focus
		where
			win_h = if w_head == focus then sh - (fromIntegral(length w_rest) * 20)::Dimension else (20)::Dimension
			---win_h = 20 :: Dimension

instance LayoutClass SmallAccordion Window where

		
	pureLayout self area ws = from_win_list area (W.integrate ws) (W.focus ws)
