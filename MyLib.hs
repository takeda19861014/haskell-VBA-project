{-# LANGUAGE ForeignFunctionInterface #-}
module MyLib where
import Foreign.C.Types

foreign export ccall doubleValue :: CInt -> CInt

doubleValue :: CInt -> CInt
doubleValue x = x * 2
