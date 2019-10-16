module GameOfLife.Pattern.Methuselah where

import Data.Symbol (SProxy(..))
import GameOfLife.Pattern.Util (toPattern)
import GameOfLife.Type (Pattern)

acorn :: Pattern
acorn = toPattern
  ( SProxy :: SProxy """_*
                        ___*
                        **__***"""
  )

thunderbird :: Pattern
thunderbird = toPattern
  ( SProxy :: SProxy """***
                        _
                        _*
                        _*
                        _*"""
  )

bHeptomino :: Pattern
bHeptomino = toPattern
  ( SProxy :: SProxy """*_**
                        ***
                        _*"""
  )

piHeptomino :: Pattern
piHeptomino = toPattern
  ( SProxy :: SProxy """***
                        *_*
                        *_*"""
  )

queenBee :: Pattern
queenBee = toPattern
  ( SProxy :: SProxy """*
                        *_*
                        _*_*
                        _*__*
                        _*_*
                        *_*
                        *"""
  )
