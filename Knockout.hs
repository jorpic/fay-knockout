
{-# LANGUAGE EmptyDataDecls #-}

module Knockout
  ( Observable
  , ko_observable
  , ko_computed
  , ko_get
  , ko_set

  , ObservableArray
  , ko_observableList
  , ko_pushObservableArray
  , ko_unwrapObservableArray

  , KnockoutModel
  , ko_applyBindings
  ) where


import Prelude
import FFI

import Vector


data Observable a

ko_observable :: a -> Observable a
ko_observable = ffi "ko.observable(%1)"

ko_computed :: Fay a -> Observable a
ko_computed = ffi "ko.computed(%1)"

ko_get :: Observable a -> Fay a
ko_get = ffi "%1()"

ko_set :: Observable a -> Automatic a -> Fay ()
ko_set = ffi "%1(%2)"


data ObservableArray a

ko_observableList :: [a] -> Fay (ObservableArray a)
ko_observableList xs = listToVector xs >>= observableVector

observableVector :: Vector a -> Fay (ObservableArray a)
observableVector = ffi "ko.observableArray(%1)"

ko_pushObservableArray :: ObservableArray a -> Automatic a -> Fay ()
ko_pushObservableArray = ffi "%1.push(%2)"

ko_unwrapObservableArray :: ObservableArray a -> Fay (Vector a)
ko_unwrapObservableArray = ffi "ko.utils.unwrapObservable(%1)"


class KnockoutModel m

ko_applyBindings :: KnockoutModel m => Automatic m -> Fay ()
ko_applyBindings = ffi "ko.applyBindings(%1)"

