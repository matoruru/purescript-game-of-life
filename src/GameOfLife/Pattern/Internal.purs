module GameOfLife.Pattern.Internal where

import Prelude ((+))

import Prim.Symbol (class Append, class Cons)

import Type.Equality (class TypeEquals)

import Data.Array ((:))
import Data.Tuple (Tuple(..))

import GameOfLife.Type (Pattern)

foreign import kind Nat
foreign import data Z :: Nat
foreign import data S :: Nat -> Nat

data NProxy (n :: Nat) = NProxy

class Nat (n :: Nat) where
  toInt :: NProxy n -> Int
instance natZero :: Nat Z where
  toInt _ = 0
instance natSucc :: Nat n => Nat (S n) where
  toInt _ = 1 + toInt (NProxy :: NProxy n)

foreign import kind Cell
foreign import data Dead  :: Cell
foreign import data Alive :: Nat -> Nat -> Cell

data CProxy (cl :: Cell) = CProxy

foreign import kind CellList
foreign import data CLNil    :: CellList
foreign import data CellList :: Cell -> CellList -> CellList

data CLProxy (cl :: CellList) = CLProxy

class SymbolToCellList (line :: Symbol) (cl :: CellList) | line -> cl
instance symbolToCellList
  :: ( Append line " " line'
     , Cons h t line'
     , SymbolToCellListImpl h t Z Z cl
     ) => SymbolToCellList line cl

class SymbolToCellListImpl (head :: Symbol) (tail :: Symbol) (n1 :: Nat) (n2 :: Nat) (cl :: CellList) | head tail n1 n2 -> cl
instance symbolToCellListImplNil :: SymbolToCellListImpl head "" n1 n2 CLNil
else instance symbolToCellListNewImplLine
  :: ( RemoveSpace tail removed
     , Cons h t removed
     , SymbolToCellListImpl h t Z (S n2) cl
     ) => SymbolToCellListImpl "\n" tail n1 n2 cl
else instance symbolToCellListImpl
  :: ( CharToCell head cell n1 n2
     , Cons h t tail
     , SymbolToCellListImpl h t (S n1) n2 cl
     , TypeEquals (CLProxy (CellList cell cl)) (CLProxy cl')
     ) => SymbolToCellListImpl head tail n1 n2 cl'

class CharToCell (i :: Symbol) (o :: Cell) (n1 :: Nat) (n2 :: Nat) | i n1 n2 -> o
instance      matchUnderScore :: CharToCell "_" Dead n1 n2
else instance matchAsterisk   :: CharToCell "*" (Alive n1 n2) n1 n2

class RemoveSpace (i :: Symbol) (o :: Symbol) | i -> o
instance removeSpace :: ( Cons h t i, RemoveSpaceImpl h t o ) => RemoveSpace i o

class RemoveSpaceImpl (head :: Symbol) (tail :: Symbol) (o :: Symbol) | head tail -> o
instance removeSpaceImpl :: ( Cons h t tail, RemoveSpaceImpl h t o ) => RemoveSpaceImpl " " tail o
else instance removeSpaceImplChar :: ( Cons h t o ) => RemoveSpaceImpl h t o

class CellListToPattern (cl :: CellList) where
  toPatternImpl :: CLProxy cl -> Pattern
instance toPatternNil :: CellListToPattern CLNil where
  toPatternImpl _ = []
else instance toPatternDead :: ( CellListToPattern t ) => CellListToPattern (CellList Dead t) where
  toPatternImpl _ = toPatternImpl ( CLProxy :: CLProxy t )
else instance toPatternAlive :: ( Nat n1, Nat n2, CellListToPattern t ) => CellListToPattern (CellList (Alive n1 n2) t) where
  toPatternImpl _ = Tuple (toInt (NProxy :: NProxy n1)) (toInt (NProxy :: NProxy n2)) : toPatternImpl (CLProxy :: CLProxy t)
