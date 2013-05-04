
module Vector where

import Prelude
import FFI

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
