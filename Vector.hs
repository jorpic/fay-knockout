
module Vector where

import Prelude
import FFI

data Vector a = Vector

emptyV :: Fay (Vector a)
emptyV = ffi "[]"

pushV :: Vector a -> Automatic a -> Fay (Vector a)
pushV = ffi "%1.push(%2)"

lengthV :: Vector a -> Fay Int
lengthV = ffi "%1.length"

sliceV :: Int -> Int -> Vector a -> Fay (Vector a)
sliceV = ffi "%3.slice(%1,%2)"


listToVector :: [a] -> Fay (Vector a)
listToVector xs = do
  v <- emptyV
  mapM_ (pushV v) xs
  return v
