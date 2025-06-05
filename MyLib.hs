{-# LANGUAGE ForeignFunctionInterface #-}
module MyDict where

import Foreign.C.Types
import qualified Data.Map.Strict as Map

myDict :: Map.Map Int Int
myDict = Map.fromList [
    (32, 0),
    (33, 1),
    (38, 25),
    (65293, 1)
  ]

foreign export ccall getDictValue :: CInt -> IO CInt
getDictValue :: CInt -> IO CInt
getDictValue key = return $ maybe (-1) fromIntegral (Map.lookup (fromIntegral key) myDict)
