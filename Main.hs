
{-# LANGUAGE DeriveDataTypeable #-}

module Main (main) where

import Prelude
import FFI
import Fay.Text

import Vector
import Knockout
import SimpleGrid



data Item = Item
  { name  :: Text
  , sales :: Int
  , price :: Double
  }

data TheViewModel = TheViewModel
  { gridVM     :: SimpleGrid Item
  , addItem    :: Fay ()
  , sortByName :: Fay ()
  , jumpToFP   :: Fay ()
  }

instance KnockoutModel TheViewModel



main :: Fay ()
main = do
  someItems <- ko_observableList
    [ Item (pack "foo") 23 45.2
    , Item (pack "bar") 391 312.4
    ]

  cols <- listToVector
    [ GridColumn (pack "Item Name")   (return . txt . name)
    , GridColumn (pack "Sales Count") (return . txt . sales)
    , GridColumn (pack "Price")       (return . append (pack "$") . txt . price)
    ]

  let grid = mkSimpleGrid $ SimpleGridConfig
        { gridData = someItems
        , columns  = cols
        , pageSize = 4
        }

  let vm = TheViewModel
        { gridVM     = grid
        , addItem    = ko_pushObservableArray someItems $ Item (pack "new") 0 100
        , sortByName = print (pack "not implemented")
        , jumpToFP   = currentPageIndex grid `ko_set` 0
        }
  ko_applyBindings vm


-- Text
txt :: Automatic a -> Text
txt = ffi "'' + %1"

append :: Text -> Text -> Text
append = ffi "%1 + %2"
