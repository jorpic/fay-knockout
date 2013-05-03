

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
  , gridVM     :: SimpleGridViewModel
  }


-- TODO: we need deep seq
main :: Fay ()
main = do
  someItems <- observableList
    [ GridEntry (pack "foo") 23 45.2
    , GridEntry (pack "bar") 391 312.4
    ]
  print someItems
{-
  let pagedGridModel = PagedGridModel
        { items      = someItems
        , addItem    = error "not implemented"
        , sortByName = error "not implemented"
        , jumpToFP   = error "not implemented"
        , gridVM     = error "not implemented"
        }
  print pagedGridModel
-}

