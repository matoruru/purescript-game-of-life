module Main where

import Prelude

import Data.Array (concat, filter, intersect, length, nubEq)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Timer (setTimeout)
import Pattern.Oscillator (blinker, trafficLight)
import Pattern.Spaceship
import Type (Pos, Width)
import Util (consoleClear, showPattern)

main :: Effect Unit
main = loop 18 glider

loop :: Width -> Array Pos -> Effect Unit
loop n ps = do
  _ <- setTimeout 200 $ consoleClear *> showPattern n ps *> loop n (nextGen n ps)
  pure unit

nextGen :: Width -> Array Pos -> Array Pos
nextGen n lives = concat >>> nubEq $ [ keeps, births ]
  where
    keeps  = filter (score n lives >>> (==) 2) lives
    births = filter (score n lives >>> (==) 3) $ map (neighbors n) >>> concat $ lives

neighbors :: Width -> Pos -> Array Pos
neighbors n (Tuple x y) = [ Tuple (x-1) (y-1), Tuple x (y-1), Tuple (x+1) (y-1)
                          , Tuple (x-1) (y  ),                Tuple (x+1) (y  )
                          , Tuple (x-1) (y+1), Tuple x (y+1), Tuple (x+1) (y+1)
                          ] # map (wrap n)

wrap :: Width -> Pos -> Pos
wrap n (Tuple x' y') = (Tuple (x' `mod` n) (y' `mod` n))

score :: Width -> Array Pos -> Pos -> Int
score n lives = length <<< intersect lives <<< neighbors n
