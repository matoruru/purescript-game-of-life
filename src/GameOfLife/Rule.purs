module GameOfLife.Rule ( nextGen ) where

import Prelude

import Data.Array (concat, filter, intersect, length, nubEq)
import Data.Tuple (Tuple(..))
import GameOfLife.Type (Pos, Width, Pattern)

nextGen :: Width -> Pattern -> Pattern
nextGen w lives = concat >>> nubEq $ [ keeps, births ]
  where
    keeps  = filter (score w lives >>> (==) 2) lives
    births = filter (score w lives >>> (==) 3) $ map (neighbors w) >>> concat $ lives

score :: Width -> Pattern -> Pos -> Int
score w lives = length <<< intersect lives <<< neighbors w

neighbors :: Width -> Pos -> Pattern
neighbors w (Tuple x y) = [ Tuple (x-1) (y-1), Tuple x (y-1), Tuple (x+1) (y-1)
                          , Tuple (x-1) (y  ),                Tuple (x+1) (y  )
                          , Tuple (x-1) (y+1), Tuple x (y+1), Tuple (x+1) (y+1)
                          ] # map (wrap w)

wrap :: Width -> Pos -> Pos
wrap w (Tuple x y) = Tuple (x `mod` w) (y `mod` w)
