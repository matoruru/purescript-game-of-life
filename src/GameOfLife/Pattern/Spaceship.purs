module GameOfLife.Pattern.Spaceship where

import Data.Tuple (Tuple (Tuple))

import GameOfLife.Type (Pattern)

glider :: Pattern
glider = [ Tuple 1 0, Tuple 2 1, Tuple 0 2, Tuple 1 2, Tuple 2 2 ]
