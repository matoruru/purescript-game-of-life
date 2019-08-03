module Example.Console.Main (main) where

import Prelude

import Data.Array (concat, elem, sort, (..))
import Data.Tuple (Tuple(..), snd, swap)
import Effect (Effect, foreachE)
import Effect.Timer (setTimeout)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)
import GameOfLife.Pattern as P
import GameOfLife.Rule (nextGen, wrap)
import GameOfLife.Type (Pattern, Pos, FieldSize)
import GameOfLife.Util (move)

foreign import consoleClear :: Effect Unit

foreign import cursorToImpl :: EffectFn2 Int Int Unit

cursorTo :: Int -> Int -> Effect Unit
cursorTo = runEffectFn2 cursorToImpl

foreign import logNoNewlineImpl :: EffectFn1 String Unit

logNoNewline :: String -> Effect Unit
logNoNewline = runEffectFn1 logNoNewlineImpl

foreign import getRows :: Effect Int

foreign import getColumns :: Effect Int

main :: Effect Unit
main = consoleClear *> loop field

loop :: Pattern -> Effect Unit
loop ps = do
  fs  <- fieldSize
  ps' <- pure $ map (wrap fs) ps
  _   <- setTimeout 100 $ cursorTo 0 0 *> showPattern fs ps' *> loop (nextGen fs ps')
  pure unit

fieldSize :: Effect FieldSize
fieldSize = { w: _, h: _ } <$> getColumns <*> getRows

field :: Pattern
field = concat
        [ move 10 30 P.glider
        , move 5  7  P.glider
        , move 50 78 P.nebula
        , move 70 88 P.pulsar
        , move 30 30 P.airclaftCarrier
        , move 27 20 P.beeHive
        ]

showPattern :: FieldSize -> Pattern -> Effect Unit
showPattern fs ps = foreachE (map (getCell ps <> newLine fs) <<< wholeBoard $ fs) logNoNewline

getCell :: Pattern -> Pos -> String
getCell ps p = case swap p `elem` ps of
                 true  -> "■"
                 false -> "□"

newLine :: FieldSize -> Pos -> String
newLine fs p = case snd p == fs.w - 1 of
                true  -> "\n"
                false -> ""

wholeBoard :: FieldSize -> Pattern
wholeBoard fs = sort $ Tuple <$> 0 .. (fs.h - 1) <*> 0 .. (fs.w - 1)
