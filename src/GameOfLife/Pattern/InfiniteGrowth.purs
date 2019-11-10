module GameOfLife.Pattern.InfiniteGrowth where

import Data.Symbol (SProxy(..))
import GameOfLife.Pattern.Util (toPattern)
import GameOfLife.Type (Pattern)

breeder :: Pattern
breeder = toPattern
  ( SProxy :: SProxy """______*
                        ____*_**
                        ____*_*
                        ____*
                        __*
                        *_*"""
  )

gliderGun :: Pattern
gliderGun = toPattern
  ( SProxy :: SProxy """________________________*
                        ______________________*_*
                        ____________**______**____________**
                        ___________*___*____**____________**
                        **________*_____*___**
                        **________*___*_**____*_*
                        __________*_____*_______*
                        ___________*___*
                        ____________**"""
  )
