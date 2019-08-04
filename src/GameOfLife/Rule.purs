module GameOfLife.Rule
  ( nextGen
  , wrap
  ) where

import Prelude

import Data.Array (concat, filter, intersect, length, nubEq)
import Data.Tuple (Tuple(..))
import GameOfLife.Type (Pos, FieldSize, Pattern)

nextGen :: FieldSize -> Pattern -> Pattern
nextGen fs lives = concat >>> nubEq $ [ keeps, births ]
  where
    keeps  = filter (score fs lives >>> (==) 2) lives
    births = filter (score fs lives >>> (==) 3) $ map (neighbors fs) >>> concat $ lives

score :: FieldSize -> Pattern -> Pos -> Int
score fs lives = neighbors fs >>> intersect lives >>> length

neighbors :: FieldSize -> Pos -> Pattern
neighbors fs (Tuple x y) = [ Tuple (x-1) (y-1), Tuple x (y-1), Tuple (x+1) (y-1)
                           , Tuple (x-1) (y  ),                Tuple (x+1) (y  )
                           , Tuple (x-1) (y+1), Tuple x (y+1), Tuple (x+1) (y+1)
                           ] # map (wrap fs)

wrap :: FieldSize -> Pos -> Pos
wrap fs (Tuple x y) = Tuple (x `mod` fs.w) (y `mod` fs.h)
