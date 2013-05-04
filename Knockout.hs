
{-# LANGUAGE EmptyDataDecls #-}

module Knockout
  ( KnockoutModel
  , ObservableArray
  , pushArr
  , observableList
  , applyBindings
  ) where


import           Prelude
import           FFI

import Fay.Text


class KnockoutModel m
data ObservableArray a

pushArr :: ObservableArray a -> Automatic a -> Fay ()
pushArr = ffi "%1.push(%2)"

data Vector a = Vector

emptyV :: Fay (Vector a)
emptyV = ffi "[]"

pushV :: Vector a -> Automatic a -> Fay (Vector a)
pushV = ffi "%1.push(%2)"

listToVector :: [a] -> Fay (Vector a)
listToVector xs = do
  v <- emptyV
  mapM_ (pushV v) xs
  return v


observableList :: [a] -> Fay (ObservableArray a)
observableList xs = listToVector xs >>= observableVector

observableVector :: (Vector a) -> Fay (ObservableArray a)
observableVector = ffi "ko.observableArray(%1)"


applyBindings :: KnockoutModel m => Automatic m -> Fay ()
applyBindings = ffi "ko.applyBindings(%1)"

