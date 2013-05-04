
{-# LANGUAGE DeriveDataTypeable #-}

module Main (main) where

import           Prelude
import           FFI
import           Fay.Text
import           Knockout

data GridEntry = GridEntry
  { name  :: Text
  , sales :: Int
  , price :: Double
  }

data SimpleGridViewModel = SimpleGridViewModel

data PagedGridModel = PagedGridModel
  { items      :: ObservableArray GridEntry
  , addItem    :: Fay ()
  , sortByName :: Fay ()
  , jumpToFP   :: Fay ()
  }

instance KnockoutModel PagedGridModel


main :: Fay ()
main = do
  someItems <- observableList
    [ GridEntry (pack "foo") 23 45.2
    , GridEntry (pack "bar") 391 312.4
    ]

  let pgm = PagedGridModel
        { items      = someItems
        , addItem
          = pushArr (items pgm) $ GridEntry (pack "new") 0 0
        , sortByName = print (pack "not implemented")
        , jumpToFP   = print (pack "not implemented")
        }
  applyBindings pgm
