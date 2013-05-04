
{-# LANGUAGE EmptyDataDecls #-}

module Knockout
  ( KnockoutModel
  , ObservableArray
  , pushArr
  , observableList
  , applyBindings
  ) where


import Prelude
import FFI
import Vector


class KnockoutModel m
data ObservableArray a

pushArr :: ObservableArray a -> Automatic a -> Fay ()
pushArr = ffi "%1.push(%2)"

observableList :: [a] -> Fay (ObservableArray a)
observableList xs = listToVector xs >>= observableVector

observableVector :: (Vector a) -> Fay (ObservableArray a)
observableVector = ffi "ko.observableArray(%1)"

applyBindings :: KnockoutModel m => Automatic m -> Fay ()
applyBindings = ffi "ko.applyBindings(%1)"

