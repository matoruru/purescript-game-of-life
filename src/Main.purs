module Main where

import Prelude

import Data.Symbol (SProxy(..), reflectSymbol)
import Effect.Console (log)

main :: _
main = log $ reflectSymbol
  (SProxy :: SProxy """|_*_|
                       |_*_|
                       |**_|.""")
