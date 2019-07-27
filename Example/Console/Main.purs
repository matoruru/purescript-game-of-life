module Example.Console.Main (main) where

import Prelude

import Data.Array (concat)
import Effect (Effect)
import Effect.Timer (setTimeout)
import GameOfLife.Pattern as P
import GameOfLife.Rule (nextGen, move, wrap)
import GameOfLife.Type (Width, Pattern)
import GameOfLife.Util (consoleClear, showPattern)

main :: Effect Unit
main = loop field

field :: Pattern
field = concat [ move 30  3 P.glider
               , move 30  8 P.glider
               , move 30 13 P.glider
               , move 30 19 P.glider
               , move 30 25 P.glider
               , move 30 30 P.glider
               , move 30 39 P.glider
               , move 30 48 P.glider
               , P.nebula
               , move  0 15 P.nebula
               , move  0 35 P.nebula
               , move 15 28 P.trafficLight
               ]

loop :: Pattern -> Effect Unit
loop ps = do
  w   <- width
  t   <- interval
  ps' <- pure $ map (wrap w) ps
  _   <- setTimeout t $ consoleClear *> showPattern w ps' *> loop (nextGen w ps')
  pure unit

width :: Effect Width
width = pure 50

interval :: Effect Int
interval = pure 20
