module GameOfLife.Type where

import Data.Tuple (Tuple)

type Width = Int

type Pos = Tuple Int Int

type Pattern = Array Pos
