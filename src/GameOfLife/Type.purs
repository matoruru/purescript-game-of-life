module GameOfLife.Type where

import Data.Tuple (Tuple)

data NextState = All | Keep | Birth

type FieldSize
  = { w :: Int
    , h :: Int
    }

type Diff
  = { dead  :: Pattern
    , alive :: Pattern
    }

type Diff'
  = { dead      :: Pattern
    , alive     :: Pattern
    , willDead  :: Pattern
    , willAlive :: Pattern
    }

type Pos = Tuple Int Int

type Pattern = Array Pos
