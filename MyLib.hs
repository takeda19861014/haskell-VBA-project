{-# LANGUAGE ForeignFunctionInterface #-}
module MyDict where

import Foreign.C.Types
import qualified Data.Map.Strict as Map

-- Map�̒l��Either String Int�^�ɂ���
myDict :: Map.Map Int (Either String Int)
myDict = Map.fromList [
    (32, Right 0),
    (33, Right 1),
    (38, Right 25),
    (65293, Right 1)
  ]

-- C���ꂩ��Ăяo����悤�ɃG�N�X�|�[�g
foreign export ccall getDictValue :: CInt -> IO CInt

getDictValue :: CInt -> IO CInt
getDictValue key =
  case Map.lookup (fromIntegral key) myDict of
    Nothing        -> return (-1)  -- �L�[�����݂��Ȃ�
    Just (Left _)  -> return (-2)  -- ���ʂ�Left�l�i���͖��g�p�j
    Just (Right v) -> return (fromIntegral v)  -- �ʏ�̒l

