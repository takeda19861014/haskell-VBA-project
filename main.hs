module Main where

import MyLib  -- removeSpaces, realLenBaseがMyLib.hsにある場合

main :: IO ()
main = do
  let testStr = "abcdefghijelmnopqrstu aiu  djg 55"
  print $ removeSpaces testStr           -- "א◌֓ב"
  print $ realLenBase testStr            -- [1488, 1458, 1489] など
