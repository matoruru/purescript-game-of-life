module GameOfLife.Pattern.Oscillator where

import Data.Symbol (SProxy(..))
import GameOfLife.Pattern.Util (toPattern)
import GameOfLife.Type (Pattern)

-- period 2
blinker :: Pattern
blinker = toPattern
  ( SProxy :: SProxy """*
                        *
                        *"""
  )

trafficLight :: Pattern
trafficLight = toPattern
  ( SProxy :: SProxy """____*
                        ____*
                        ____*
                        *_______*
                        *_______*
                        *_______*
                        ____*
                        ____*
                        ____*"""
  )

-- period 3
pulsar :: Pattern
pulsar = toPattern
  ( SProxy :: SProxy """____*_____*
                        ____*_____*
                        ____**___**
                        _
                        ***__**_**__***
                        __*_*_*_*_*_*
                        ____**___**
                        _
                        ____**___**
                        __*_*_*_*_*_*
                        ***__**_**__***
                        _
                        ____**___**
                        ____*_____*
                        ____*_____*"""
  )

-- period 8
nebula :: Pattern
nebula =  toPattern
  ( SProxy :: SProxy """******_**
                        ******_**
                        _______**
                        **_____**
                        **_____**
                        **_____**
                        **
                        **_******
                        **_******"""
  )
