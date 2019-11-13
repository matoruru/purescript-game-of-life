module Example.Console.Main3 where

import Prelude

import Data.HashMap (HashMap, empty, insert, lookup)
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Aff (Aff, Milliseconds(..), delay, launchAff_)
import Example.Console.Main2 (Color(..), color, replace)
import Example.Console.Preference as Config
import Example.Console.Util (Readline, consoleClear, fieldInit, fieldSize, logTo, readline)
import GameOfLife.Type (FieldSize, Pattern)
import GameOfLife.Util (diff', nextGen)

main :: Effect Unit
main = do
  fs <- fieldSize
  rl <- readline

  consoleClear
  gens' <- generate rl fs 4999 Config.pattern
  fieldInit rl fs $ color Black "□"
  launchAff_ $ loop rl fs (Milliseconds Config.initialDelay) [] [] (lookup 0 gens') gens' 1

loop :: Readline -> FieldSize -> Milliseconds -> Pattern -> Pattern -> Maybe Pattern -> HashMap Int Pattern -> Int -> Aff Unit
loop rl fs t prev curr Nothing     gens' n = mempty
loop rl fs t prev curr (Just next) gens' n = do
  replace rl $ diff' prev curr next
  delay t *> loop rl fs (Milliseconds Config.everyDelay) curr next (lookup n gens') gens' (n + 1)

generate :: Readline -> FieldSize -> Int -> Pattern -> Effect (HashMap Int Pattern)
generate rl fs n ps = impl 0 (n + 1) ps empty
  where
    impl lo hi ps' pss
      | hi - lo <= 0 = pure pss
      | otherwise    = do
                         logTo rl (Tuple 1 1) ("[" <> show lo <> "/" <> show hi <> "]")
                         g <- impl (lo + 1) hi (nextGen fs ps') pss
                         pure $ insert lo ps' g
