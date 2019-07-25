module GameOfLife.Pattern.StillLife where

import Data.Tuple (Tuple (Tuple))

import GameOfLife.Type (Pattern)

-- 4 cells
block :: Pattern
block = [ Tuple 0 0, Tuple 1 0, Tuple 0 1, Tuple 1 1 ]

tub :: Pattern
tub = [ Tuple 1 0, Tuple 0 1, Tuple 2 1, Tuple 1 2 ]


-- 5 cells
boat :: Pattern
boat = [ Tuple 0 0, Tuple 1 0, Tuple 0 1, Tuple 2 1, Tuple 1 2 ]


-- 6 cells
beeHive :: Pattern
beeHive = [ Tuple 1 0, Tuple 2 0, Tuple 0 1, Tuple 3 1, Tuple 1 2, Tuple 2 2 ]

ship :: Pattern
ship = [ Tuple 1 0, Tuple 2 0, Tuple 0 1, Tuple 2 1, Tuple 0 2, Tuple 1 2 ]

airclaftCarrier :: Pattern
airclaftCarrier = [ Tuple 0 0, Tuple 1 0, Tuple 0 1, Tuple 3 1, Tuple 2 2, Tuple 3 2 ]

barge :: Pattern
barge = [ Tuple 1 0, Tuple 0 1, Tuple 2 1, Tuple 1 2, Tuple 3 2, Tuple 2 3 ]


-- 7 cells
loaf :: Pattern
loaf = [ Tuple 1 0, Tuple 2 0, Tuple 0 1, Tuple 3 1, Tuple 1 2, Tuple 3 2, Tuple 2 3 ]
