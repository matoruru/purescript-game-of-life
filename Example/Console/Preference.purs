module Example.Console.Preference where

import Data.Array (concat)
import GameOfLife.Pattern as P
import GameOfLife.Type (Pattern)

initialDelay :: Number
initialDelay = 1000.0

everyDelay :: Number
everyDelay = 50.0

pattern :: Pattern
pattern = concat
        [ P.gliderGun
        ]
