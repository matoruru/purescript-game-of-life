module GameOfLife.Pattern.Spaceship where

import Data.Symbol (SProxy(..))
import GameOfLife.Pattern.Util (toPattern)
import GameOfLife.Type (Pattern)

glider :: Pattern
glider = toPattern
  ( SProxy :: SProxy """_*
                        __*
                        ***"""
  )
