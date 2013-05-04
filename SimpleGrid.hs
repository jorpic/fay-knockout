

module SimpleGrid where

import Prelude
import FFI
import Fay.Text

import Vector
import Knockout


data GridColumn a = GridColumn
  { headerText :: Text
  , rowText    :: a -> Fay Text
  }

data SimpleGrid a = SimpleGrid
  { gridData :: ObservableArray a
  , columns  :: Vector (GridColumn a)
  , pageSize :: Int
  }

gridViewModel :: Automatic (SimpleGrid a) -> SimpleGrid a
gridViewModel = ffi "new ko.simpleGrid.viewModel(%1)"
