module GameOfLife.Util
  ( diff
  , move
  , move'
  , nGen
  ) where

import Prelude

import Data.Array (difference)
import Data.Tuple (Tuple(..))
import GameOfLife.Rule (nextGen)
import GameOfLife.Type (FieldSize, Pattern, Pos, Diff)

move :: Int -> Int -> Pattern -> Pattern
move x y = map (_ + Tuple x y)

move' :: Pos -> Pattern -> Pattern
move' p = map (_ + p)

nGen :: FieldSize -> Int -> Pattern -> Pattern
nGen fs n ps
  | n <= 0    = ps
  | otherwise = nGen fs (n - 1) $ nextGen fs ps

diff :: Pattern -> Pattern -> Diff
diff curr next = { dead : difference curr next
                 , alive: difference next curr
                 }
