module GameOfLife.Type where

import Data.Tuple (Tuple)

type FieldSize
  = { w :: Int
    , h :: Int
    }

type Pos = Tuple Int Int

type Pattern = Array Pos
