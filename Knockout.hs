
{-# LANGUAGE EmptyDataDecls #-}

module Knockout
  ( observableList
  , ObservableArray
  , applyBindings
  ) where


import           Prelude
import           FFI

import Fay.Text


class KnockoutModel m
data ObservableArray a

data Vector a = Vector

emptyV :: Fay (Vector a)
emptyV = ffi "[]"

pushV :: Vector a -> a -> Fay (Vector a)
pushV = ffi "%1.push(%2)"

listToVector :: [a] -> Fay (Vector a)
listToVector xs = do
  v <- emptyV
  mapM_ (pushV v) xs
  return v


observableList :: [a] -> Fay (ObservableArray a)
observableList xs = listToVector xs >>= observableVector

observableVector :: Automatic (Vector a) -> Fay (ObservableArray a)
observableVector = ffi "ko.observableArray(%1)"


applyBindings :: KnockoutModel m => m -> Fay ()
applyBindings m = ffi "ko.applyBindings(%1)"

