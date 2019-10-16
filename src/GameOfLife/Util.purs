module GameOfLife.Util
  ( diff
  , diff'
  , move
  , move'
  , nextGen
  , nGen
  ) where

import Prelude

import Data.Array (difference)
import Data.Tuple (Tuple(..))
import GameOfLife.Rule (nextGen')
import GameOfLife.Type (Diff, Diff', NextState(..), FieldSize, Pattern, Pos)

move :: Int -> Int -> Pattern -> Pattern
move x y = map (_ + Tuple x y)

move' :: Pos -> Pattern -> Pattern
move' p = map (_ + p)

nextGen :: FieldSize -> Pattern -> Pattern
nextGen fs lives = nextGen' All fs lives

nGen :: FieldSize -> Int -> Pattern -> Pattern
nGen fs n ps
  | n <= 0    = ps
  | otherwise = nGen fs (n - 1) $ nextGen fs ps

diff :: Pattern -> Pattern -> Diff
diff curr next =
  { dead : difference curr next
  , alive: difference next curr
  }

diff' :: Pattern -> Pattern -> Pattern -> Diff'
diff' prev curr next =
  { dead      : difference prev curr
  , willDead  : difference curr next
  , alive     : difference curr prev
  , willAlive : difference next curr
  }
