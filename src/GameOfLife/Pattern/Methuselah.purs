module GameOfLife.Pattern.Methuselah where

import Data.Array (concat)
import Data.Tuple (Tuple(Tuple))
import GameOfLife.Pattern.Oscillator (blinker)
import GameOfLife.Type (Pattern)
import GameOfLife.Util (move)

acorn :: Pattern
acorn = [ Tuple 0 2, Tuple 1 0, Tuple 1 2, Tuple 3 1, Tuple 4 2, Tuple 5 2, Tuple 6 2 ]

thunderbird :: Pattern
thunderbird = concat [ move 1 2 blinker, [ Tuple 0 0, Tuple 1 0, Tuple 2 0 ] ]

bHeptomino :: Pattern
bHeptomino = [ Tuple 0 0, Tuple 0 1, Tuple 1 1, Tuple 1 2, Tuple 2 0, Tuple 2 1, Tuple 3 0 ]

piHeptomino :: Pattern
piHeptomino = [ Tuple 0 0, Tuple 0 1, Tuple 0 2, Tuple 1 0, Tuple 2 0, Tuple 2 1, Tuple 2 2 ]

queenBee :: Pattern
queenBee = [ Tuple 0 0, Tuple 0 1, Tuple 0 5, Tuple 0 6, Tuple 1 2, Tuple 1 3, Tuple 1 4, Tuple 2 1, Tuple 2 5, Tuple 3 2, Tuple 3 4, Tuple 4 3 ]
