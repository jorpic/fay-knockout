
{-# LANGUAGE DeriveDataTypeable #-}

module Main (main) where

import Prelude
import FFI
import Fay.Text

import Vector
import Knockout
import SimpleGrid



data Entry = Entry
  { name  :: Text
  , sales :: Int
  , price :: Double
  }

data TheViewModel = TheViewModel
  { gridVM     :: SimpleGrid Entry
  , addItem    :: Fay ()
  , sortByName :: Fay ()
  , jumpToFP   :: Fay ()
  }

instance KnockoutModel TheViewModel



main :: Fay ()
main = do
  someItems <- observableList
    [ Entry (pack "foo") 23 45.2
    , Entry (pack "bar") 391 312.4
    ]

  cols <- listToVector
            [ GridColumn (pack "Item Name")   (return . txt . name)
            , GridColumn (pack "Sales Count") (return . txt . sales)
            , GridColumn (pack "Price")       (return . txt . price)
            ]
  applyBindings $ TheViewModel
    { gridVM     = gridViewModel $ SimpleGrid
        { gridData = someItems
        , columns  = cols
        , pageSize = 4
        }
    , addItem    = pushArr someItems $ Entry (pack "new") 0 100
    , sortByName = print (pack "not implemented")
    , jumpToFP   = print (pack "not implemented")
    }


txt :: Automatic a -> Text
txt = ffi "'' + %1"
