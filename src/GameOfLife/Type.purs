module GameOfLife.Type where

import Data.Tuple (Tuple)

type FieldSize
  = { w :: Int
    , h :: Int
    }

type Diff
  = { dead  :: Pattern
    , alive :: Pattern
    }

type Pos = Tuple Int Int

type Pattern = Array Pos
