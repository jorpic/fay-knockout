
{-# LANGUAGE RecordWildCards #-}

module SimpleGrid
  ( GridColumn (..)
  , SimpleGridConfig (..)
  , SimpleGrid
  , currentPageIndex
  , mkSimpleGrid
  ) where

import Prelude
import FFI
import Fay.Text

import Vector
import Knockout


data GridColumn a = GridColumn
  { headerText :: Text
  , rowText    :: a -> Fay Text
  }

data SimpleGridConfig a = SimpleGridConfig
  { gridData :: ObservableArray a
  , columns  :: Vector (GridColumn a)
  , pageSize :: Int
  }

data SimpleGrid a = SimpleGrid
  { gridConfig         :: SimpleGridConfig a
  , currentPageIndex   :: Observable Int
  , itemsOnCurrentPage :: Observable (Vector a)
  , maxPageIndex       :: Observable Int
  }

mkSimpleGrid :: SimpleGridConfig a -> SimpleGrid a
mkSimpleGrid cfg@(SimpleGridConfig{..})= sg
  where
   sg = SimpleGrid
    { gridConfig = cfg
    , currentPageIndex = ko_observable 0
    , itemsOnCurrentPage = ko_computed $ do
        cpi <- ko_get $ currentPageIndex sg
        let startIndex = pageSize * cpi
        ko_unwrapObservableArray gridData >>= sliceV startIndex (startIndex + pageSize)
    , maxPageIndex = ko_computed $ do
        len <- ko_unwrapObservableArray gridData >>= lengthV
        return len
        -- let res = 1 + div len pageSize
        -- return res
    }
