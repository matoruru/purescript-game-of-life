module GameOfLife.Util
  ( diff
  , diff'
  , flipH
  , flipV
  , move
  , move'
  , nextGen
  , nGen
  ) where

import Prelude

import Data.Array (difference)
import Data.Foldable (maximum, minimum)
import Data.Maybe (fromMaybe)
import Data.Tuple (Tuple(..), snd, swap)
import GameOfLife.Rule (nextGen')
import GameOfLife.Type (Diff, Diff', NextState(..), FieldSize, Pattern, Pos)

move :: Int -> Int -> Pattern -> Pattern
move x y = map (_ + Tuple x y)

move' :: Pos -> Pattern -> Pattern
move' p = map (_ + p)

flipH :: Pattern -> Pattern
flipH = map swap <<< flipV <<< map swap

flipV :: Pattern -> Pattern
flipV ps = map (\(Tuple x y) -> Tuple x $ maxDiff ps + negate y) ps
  where
    maxDiff = map snd >>> (maximum >>> fromMaybe 0 + minimum >>> fromMaybe 0)

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
  { dead     : difference prev curr
  , willDead : difference curr next
  , alive    : difference curr prev
  , willAlive: difference next curr
  }
