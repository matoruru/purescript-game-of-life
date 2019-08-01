module Example.Console.Main (main) where

import Prelude

import Data.Array (concat, elem, sort, (..))
import Data.Tuple (Tuple(..), snd, swap)
import Effect (Effect, foreachE)
import Effect.Timer (setTimeout)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import GameOfLife.Pattern as P
import GameOfLife.Rule (nextGen)
import GameOfLife.Type (Pattern, Width, Pos)

foreign import consoleClear :: Effect Unit

foreign import logNoNewlineImpl :: EffectFn1 String Unit

logNoNewline :: String -> Effect Unit
logNoNewline = runEffectFn1 logNoNewlineImpl

foreign import getRows :: Effect Int

foreign import getColumns :: Effect Int

main :: Effect Unit
main = loop field

field :: Pattern
field = concat [ move 30  3 P.glider
               , move 30  8 P.glider
               , move 30 13 P.glider
               , move 30 19 P.glider
               , move 30 25 P.glider
               , move 30 30 P.glider
               , move 30 39 P.glider
               , move 30 48 P.glider
               , P.nebula
               , move  0 15 P.nebula
               , move  0 35 P.nebula
               , move 15 28 P.trafficLight
               ]

loop :: Pattern -> Effect Unit
loop ps = do
  w   <- width
  t   <- interval
  ps' <- pure $ map (wrap w) ps
  _   <- setTimeout t $ consoleClear *> showPattern w ps' *> loop (nextGen w ps')
  pure unit

width :: Effect Width
width = getColumns

interval :: Effect Int
interval = pure 100

wrap :: Width -> Pos -> Pos
wrap w (Tuple x y) = Tuple (x `mod` w) (y `mod` w)

field :: Pattern
field = concat [ P.glider ]

showPattern :: Width -> Pattern -> Effect Unit
showPattern w ps = do
  foreachE (map (getCell ps <> newLine w) <<< wholeBoard $ w) logNoNewline

getCell :: Pattern -> Pos -> String
getCell ps p = case swap p `elem` ps of
                 true  -> "■"
                 false -> "□"

newLine :: Width -> Pos -> String
newLine w p = case snd p == w - 1 of
                true  -> "\n"
                false -> ""

wholeBoard :: Width -> Pattern
wholeBoard w = do
  x <- 0 .. (w - 1)
  y <- 0 .. (w - 1)
  sort [ Tuple x y ]
