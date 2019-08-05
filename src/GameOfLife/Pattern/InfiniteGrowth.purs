module GameOfLife.Pattern.InfiniteGrowth where

import Data.Tuple (Tuple (Tuple))

import GameOfLife.Type (Pattern)

breeder :: Pattern
breeder = [ Tuple 0 5, Tuple 2 4, Tuple 2 5, Tuple 4 1, Tuple 4 2, Tuple 4 3, Tuple 6 0, Tuple 6 1, Tuple 6 2, Tuple 7 1 ]

gliderGun :: Pattern
gliderGun = [ Tuple 0 4, Tuple 0 5, Tuple 1 4, Tuple 1 5, Tuple 10 4, Tuple 10 5, Tuple 10 6, Tuple 11 3, Tuple 11 7, Tuple 12 2, Tuple 12 8, Tuple 13 2, Tuple 13 8, Tuple 14 5, Tuple 15 3, Tuple 15 7, Tuple 16 4, Tuple 16 5, Tuple 16 6, Tuple 17 5, Tuple 20 2, Tuple 20 3, Tuple 20 4, Tuple 21 2, Tuple 21 3, Tuple 21 4, Tuple 22 1, Tuple 22 5, Tuple 24 0, Tuple 24 1, Tuple 24 5, Tuple 24 6, Tuple 34 2, Tuple 34 3, Tuple 35 2, Tuple 35 3 ]
