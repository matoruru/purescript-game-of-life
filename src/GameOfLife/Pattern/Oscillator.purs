module GameOfLife.Pattern.Oscillator where

import Data.Tuple (Tuple (Tuple))

import GameOfLife.Type (Pattern)

-- period 2
blinker :: Pattern
blinker = [ Tuple 0 0, Tuple 0 1, Tuple 0 2 ]

trafficLight :: Pattern
trafficLight = [ Tuple 0 3, Tuple 0 4, Tuple 0 5, Tuple 5 0, Tuple 5 1, Tuple 5 2, Tuple 8 3, Tuple 8 4, Tuple 8 5, Tuple 5 6, Tuple 5 7, Tuple 5 8 ]
