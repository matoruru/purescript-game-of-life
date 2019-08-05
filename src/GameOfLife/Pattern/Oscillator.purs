module GameOfLife.Pattern.Oscillator where

import Data.Tuple (Tuple (Tuple))

import GameOfLife.Type (Pattern)

-- period 2
blinker :: Pattern
blinker = [ Tuple 0 0, Tuple 0 1, Tuple 0 2 ]

trafficLight :: Pattern
trafficLight = [ Tuple 0 3, Tuple 0 4, Tuple 0 5, Tuple 4 0, Tuple 4 1, Tuple 4 2, Tuple 8 3, Tuple 8 4, Tuple 8 5, Tuple 4 6, Tuple 4 7, Tuple 4 8 ]


-- period 3
pulsar :: Pattern
pulsar = [ Tuple 5 6, Tuple 6 5, Tuple 5 8, Tuple 6 9, Tuple 8 5, Tuple 9 6, Tuple 8 9, Tuple 9 8, Tuple 1 4, Tuple 4 1, Tuple 1 10, Tuple 4 13, Tuple 10 1, Tuple 13 4, Tuple 13 10, Tuple 10 13, Tuple 4 6, Tuple 6 4, Tuple 4 8, Tuple 6 10, Tuple 8 4, Tuple 10 6, Tuple 8 10, Tuple 10 8, Tuple 0 4, Tuple 2 4, Tuple 0 10, Tuple 2 10, Tuple 12 4, Tuple 14 4, Tuple 12 10, Tuple 14 10, Tuple 4 0, Tuple 4 2, Tuple 4 12, Tuple 4 14, Tuple 10 0, Tuple 10 2, Tuple 10 12, Tuple 10 14, Tuple 2 5, Tuple 4 5, Tuple 5 2, Tuple 5 4, Tuple 2 9, Tuple 4 9, Tuple 5 10, Tuple 5 12, Tuple 9 2, Tuple 9 4, Tuple 10 5, Tuple 12 5, Tuple 9 10, Tuple 9 12, Tuple 10 9, Tuple 12 9 ]


-- period 8
nebula :: Pattern
nebula = [ Tuple 2 2, Tuple 3 2, Tuple 4 2, Tuple 5 2, Tuple 6 2, Tuple 7 2, Tuple 2 3, Tuple 3 3, Tuple 4 3, Tuple 5 3, Tuple 6 3, Tuple 7 3, Tuple 2 5, Tuple 2 6, Tuple 2 7, Tuple 2 8, Tuple 2 9, Tuple 2 10, Tuple 3 5, Tuple 3 6, Tuple 3 7, Tuple 3 8, Tuple 3 9, Tuple 3 10, Tuple 5 9, Tuple 6 9, Tuple 7 9, Tuple 8 9, Tuple 9 9, Tuple 10 9, Tuple 5 10, Tuple 6 10, Tuple 7 10, Tuple 8 10, Tuple 9 10, Tuple 10 10, Tuple 9 2, Tuple 9 3, Tuple 9 4, Tuple 9 5, Tuple 9 6, Tuple 9 7, Tuple 10 2, Tuple 10 3, Tuple 10 4, Tuple 10 5, Tuple 10 6, Tuple 10 7 ]
