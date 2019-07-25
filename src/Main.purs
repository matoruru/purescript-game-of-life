module Main (main) where

import Prelude

import Effect (Effect)
import Effect.Timer (setTimeout)
import GameOfLife.Pattern (glider) as P
import GameOfLife.Rule (nextGen)
import GameOfLife.Type (Width, Pattern)
import GameOfLife.Util (consoleClear, showPattern)

main :: Effect Unit
main = do
  w <- pure 18
  t <- pure 200
  loop t w P.glider

loop :: Int -> Width -> Pattern -> Effect Unit
loop t w ps = do
  _ <- setTimeout t $ consoleClear *> showPattern w ps *> loop t w (nextGen t ps)
  pure unit
