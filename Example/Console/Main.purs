module Example.Console.Main (main) where

import Prelude

import Data.Array (concat, elem, sort, (..), (:))
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
  _   <- setTimeout 10 $ cursorTo 0 0 *> showPattern fs ps' *> loop (nextGen fs ps')
  pure unit

fieldSize :: Effect FieldSize
fieldSize = do
  w <- getColumns
  h <- getRows
  pure { w: w - 2, h: h - 2 }

field :: Pattern
field = concat
        [ move 30 30 $ P.snake' 8
        , move 36 30   P.snake
        , move 85 35   P.nebula
        , move 25  4   P.glider
        ]

showPattern :: FieldSize -> Pattern -> Effect Unit
showPattern fs ps = foreachE lines logNoNewline
  where
    lines = "\n " : (map line <<< wholeBoard $ fs)
    line  = getCell ps <> newLine fs

getCell :: Pattern -> Pos -> String
getCell ps p = case swap p `elem` ps of
                 true  -> "■"
                 false -> "□"

newLine :: FieldSize -> Pos -> String
newLine fs p = case snd p == fs.w - 1 of
                true  -> "\n "
                false -> ""

wholeBoard :: FieldSize -> Pattern
wholeBoard fs = sort $ Tuple <$> 0 .. (fs.h - 1) <*> 0 .. (fs.w - 1)
