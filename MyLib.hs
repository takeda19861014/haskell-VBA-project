{-# LANGUAGE ForeignFunctionInterface #-}
module MyDict where

import Foreign.C.Types
import qualified Data.Map.Strict as Map

-- Mapの値をEither String Int型にする
myDict :: Map.Map Int (Either String Int)
myDict = Map.fromList [
    (32, Right 0),
    (33, Right 1),
    (38, Right 25),
    (65293, Right 1)
  ]

-- C言語から呼び出せるようにエクスポート
foreign export ccall getDictValue :: CInt -> IO CInt

getDictValue :: CInt -> IO CInt
getDictValue key =
  case Map.lookup (fromIntegral key) myDict of
    Nothing        -> return (-1)  -- キーが存在しない
    Just (Left _)  -> return (-2)  -- 特別なLeft値（今は未使用）
    Just (Right v) -> return (fromIntegral v)  -- 通常の値

