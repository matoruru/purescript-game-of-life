module GameOfLife.Pattern.StillLife where

import Data.Symbol (SProxy(..))
import GameOfLife.Pattern.Util (toPattern)
import GameOfLife.Type (Pattern)

block :: Pattern
block = toPattern
  ( SProxy :: SProxy """**
                        **"""
  )

tub :: Pattern
tub = toPattern
  ( SProxy :: SProxy """_*
                        *_*
                        _*"""
  )

boat :: Pattern
boat = toPattern
  ( SProxy :: SProxy """**
                        *_*
                        _*"""
  )

beeHive :: Pattern
beeHive = toPattern
  ( SProxy :: SProxy """_**
                        *__*
                        _**"""
  )

ship :: Pattern
ship = toPattern
  ( SProxy :: SProxy """_**
                        *_*
                        **"""
  )

airclaftCarrier :: Pattern
airclaftCarrier = toPattern
  ( SProxy :: SProxy """**
                        *__*
                        __**"""
  )

barge :: Pattern
barge = toPattern
  ( SProxy :: SProxy """_*
                        *_*
                        _*_*
                        __*"""
  )

loaf :: Pattern
loaf = toPattern
  ( SProxy :: SProxy """_**
                        *__*
                        _*_*
                        __*"""
  )

pond :: Pattern
pond = toPattern
  ( SProxy :: SProxy """_**
                        *__*
                        *__*
                        _**"""
  )
