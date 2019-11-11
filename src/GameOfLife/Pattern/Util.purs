module GameOfLife.Pattern.Util
  ( toPattern
  ) where

import Data.Symbol (SProxy)
import GameOfLife.Type (Pattern)
import GameOfLife.Pattern.Internal

toPattern :: forall sym cl. SymbolToCellList sym cl => CellListToPattern cl => SProxy sym -> Pattern
toPattern _ = toPatternImpl (CLProxy :: CLProxy cl)
