module Pattern.StillLife where

import Data.Tuple (Tuple (Tuple))

import Type (Pos)

-- 4 cells
block :: Array Pos
block = [ Tuple 0 0, Tuple 1 0, Tuple 0 1, Tuple 1 1 ]

tub :: Array Pos
tub = [ Tuple 1 0, Tuple 0 1, Tuple 2 1, Tuple 1 2 ]


-- 5 cells
boat :: Array Pos
boat = [ Tuple 0 0, Tuple 1 0, Tuple 0 1, Tuple 2 1, Tuple 1 2 ]


-- 6 cells
beeHive :: Array Pos
beeHive = [ Tuple 1 0, Tuple 2 0, Tuple 0 1, Tuple 3 1, Tuple 1 2, Tuple 2 2 ]

ship :: Array Pos
ship = [ Tuple 1 0, Tuple 2 0, Tuple 0 1, Tuple 2 1, Tuple 0 2, Tuple 1 2 ]

airclaftCarrier :: Array Pos
airclaftCarrier = [ Tuple 0 0, Tuple 1 0, Tuple 0 1, Tuple 3 1, Tuple 2 2, Tuple 3 2 ]

barge :: Array Pos
barge = [ Tuple 1 0, Tuple 0 1, Tuple 2 1, Tuple 1 2, Tuple 3 2, Tuple 2 3 ]


-- 7 cells
loaf :: Array Pos
loaf = [ Tuple 1 0, Tuple 2 0, Tuple 0 1, Tuple 3 1, Tuple 1 2, Tuple 3 2, Tuple 2 3 ]
