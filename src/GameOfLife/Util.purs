module GameOfLife.Util
  ( move
  , move'
  , nGen
  ) where

import Prelude

import Data.Tuple (Tuple(..))
import GameOfLife.Rule (nextGen)
import GameOfLife.Type (Pattern, Pos, Width)

move :: Int -> Int -> Pattern -> Pattern
move x y = map (_ + Tuple x y)

move' :: Pos -> Pattern -> Pattern
move' p = map (_ + p)

nGen :: Width -> Int -> Pattern -> Pattern
nGen w n ps
  | n <= 0    = ps
  | otherwise = nGen w (n - 1) $ nextGen w ps
