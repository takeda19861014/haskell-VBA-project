{-# LANGUAGE ForeignFunctionInterface #-}
module MyLib where

import Foreign
import Foreign.C.Types
import Foreign.C.String (CWString, peekCWString, peekCWStringLen, CString, withCString, withCWString)
import qualified Data.Map.Strict as Map
import Data.Char (isSpace, ord, chr)
import Control.Exception (catch, SomeException)
import System.IO.Unsafe (unsafePerformIO)
import Data.List (find)
import Data.Maybe (listToMaybe, mapMaybe)
import Control.Monad (when)

-- エクスポート
foreign export ccall real_len :: CWString -> CInt -> CInt -> CInt -> IO CInt
foreign export ccall real_len_advanced :: CWString -> CInt -> CInt -> CInt -> IO CInt
foreign export ccall real_value_new_improved :: CWString -> CInt -> CInt -> CInt -> IO CInt

-- Mapの値をEither String Int型にする
myDict :: Map.Map Int (Either String Int)
myDict = Map.fromList [
 (32, Right 0),
 (33, Right 1),
 (38, Right 25),
 (40, Right 1),
 (41, Right 1),
 (42, Right 1),
 (43, Right 1),
 (44, Right 1),
 (45, Right 1),
 (46, Right 1),
 (48, Left "A"),
 (49, Left "A"),
 (50, Left "A"),
 (51, Left "A"),
 (52, Left "A"),
 (53, Left "A"),
 (54, Left "A"),
 (55, Left "A"),
 (56, Left "A"),
 (57, Left "A"),
 (58, Right 1),
 (59, Right 1),
 (61, Right 1),
 (62, Right 1),
 (63, Right 1),
 (65, Right 1),
 (66, Right 2),
 (67, Right 3),
 (68, Right 4),
 (69, Right 5),
 (70, Right 6),
 (71, Right 7),
 (72, Right 8),
 (73, Right 9),
 (74, Right 10),
 (75, Right 11),
 (76, Right 12),
 (77, Right 13),
 (78, Right 14),
 (79, Right 15),
 (80, Right 16),
 (81, Right 17),
 (82, Right 18),
 (83, Right 19),
 (84, Right 20),
 (85, Right 21),
 (86, Right 22),
 (87, Right 23),
 (88, Right 24),
 (89, Right 25),
 (90, Right 26),
 (91, Right 1),
 (93, Right 1),
 (96, Right 1),
 (97, Right 1),
 (98, Right 2),
 (99, Right 3),
 (100, Right 4),
 (101, Right 5),
 (102, Right 6),
 (103, Right 7),
 (104, Right 8),
 (105, Right 9),
 (106, Right 10),
 (107, Right 11),
 (108, Right 12),
 (109, Right 13),
 (110, Right 14),
 (111, Right 15),
 (112, Right 16),
 (113, Right 17),
 (114, Right 18),
 (115, Right 19),
 (116, Right 20),
 (117, Right 21),
 (118, Right 22),
 (119, Right 23),
 (120, Right 24),
 (121, Right 25),
 (122, Right 26),
 (167, Right 38),
 (192, Right 1),
 (193, Right 1),
 (194, Right 1),
 (196, Right 1),
 (198, Right 6),
 (200, Right 5),
 (201, Right 5),
 (202, Right 5),
 (203, Right 5),
 (204, Right 9),
 (205, Right 9),
 (206, Right 9),
 (207, Right 9),
 (210, Right 15),
 (211, Right 15),
 (212, Right 15),
 (214, Right 15),
 (217, Right 21),
 (218, Right 21),
 (219, Right 21),
 (220, Right 21),
 (223, Right 38),
 (224, Right 1),
 (225, Right 1),
 (226, Right 1),
 (228, Right 1),
 (230, Right 6),
 (232, Right 5),
 (233, Right 5),
 (234, Right 5),
 (235, Right 5),
 (236, Right 9),
 (237, Right 9),
 (238, Right 9),
 (239, Right 9),
 (242, Right 15),
 (243, Right 15),
 (244, Right 15),
 (246, Right 15),
 (249, Right 21),
 (250, Right 21),
 (251, Right 21),
 (252, Right 21),
 (338, Right 20),
 (339, Right 20),
 (383, Right 19),
 (390, Left "R"),
 (419, Right 17),
 (547, Right 22),
 (771, Right 0),
 (945, Right 1),
 (946, Right 2),
 (947, Right 3),
 (948, Right 4),
 (949, Right 5),
 (950, Right 6),
 (951, Right 7),
 (952, Right 8),
 (953, Right 9),
 (954, Right 10),
 (955, Right 11),
 (956, Right 12),
 (957, Right 13),
 (958, Right 14),
 (959, Right 15),
 (960, Right 16),
 (961, Right 17),
 (962, Right 18),
 (963, Right 18),
 (964, Right 19),
 (965, Right 20),
 (966, Right 21),
 (967, Right 22),
 (968, Right 23),
 (969, Right 24),
 (972, Right 15),
 (976, Right 2),
 (1425, Right 0),
 (1426, Right 0),
 (1427, Right 0),
 (1428, Right 0),
 (1429, Right 0),
 (1430, Right 0),
 (1431, Right 0),
 (1432, Right 0),
 (1433, Right 0),
 (1434, Right 0),
 (1435, Right 0),
 (1436, Right 0),
 (1437, Right 0),
 (1438, Right 0),
 (1439, Right 0),
 (1440, Right 0),
 (1441, Right 0),
 (1442, Right 0),
 (1443, Right 0),
 (1444, Right 0),
 (1445, Right 0),
 (1446, Right 0),
 (1447, Right 0),
 (1448, Right 0),
 (1449, Right 0),
 (1450, Right 0),
 (1451, Right 0),
 (1452, Right 0),
 (1453, Right 0),
 (1454, Right 0),
 (1455, Right 0),
 (1456, Right 0),
 (1457, Right 0),
 (1458, Right 0),
 (1459, Right 0),
 (1460, Right 0),
 (1461, Right 0),
 (1462, Right 0),
 (1463, Right 0),
 (1464, Right 0),
 (1465, Right 0),
 (1466, Right 0),
 (1467, Right 0),
 (1468, Right 0),
 (1469, Right 0),
 (1470, Right 0),
 (1471, Right 0),
 (1472, Right 0),
 (1473, Right 0),
 (1474, Right 0),
 (1475, Right 0),
 (1476, Right 0),
 (1477, Right 0),
 (1478, Right 0),
 (1479, Right 0),
 (1488, Right 1),
 (1489, Right 2),
 (1490, Right 3),
 (1491, Right 4),
 (1492, Right 5),
 (1493, Right 6),
 (1494, Right 7),
 (1495, Right 8),
 (1496, Right 9),
 (1497, Right 10),
 (1498, Right 11),
 (1499, Right 11),
 (1500, Right 12),
 (1501, Right 13),
 (1502, Right 13),
 (1503, Right 14),
 (1504, Right 14),
 (1505, Right 15),
 (1506, Right 16),
 (1507, Right 17),
 (1508, Right 17),
 (1509, Right 18),
 (1510, Right 18),
 (1511, Right 19),
 (1512, Right 20),
 (1513, Right 21),
 (1514, Right 22),
 (1519, Right 0),
 (1520, Right 12),
 (1521, Right 16),
 (1522, Right 20),
 (1523, Right 1),
 (1524, Right 1),
 (7936, Right 1),
 (8115, Right 1),
 (8213, Right 1),
 (8217, Right 1),
 (8222, Right 1),
 (8266, Right 25),
 (8544, Left "R"),
 (8548, Left "R"),
 (8553, Left "R"),
 (8556, Left "R"),
 (8557, Left "R"),
 (9644, Right 1),
 (9678, Right 33),
 (9679, Right 0),
 (12291, Right 1),
 (65293, Right 1)
  ]


-- 安全なリストアクセス
safeIndex :: [a] -> Int -> Maybe a
safeIndex xs i
    | i < 0 || i >= length xs = Nothing
    | otherwise = Just (xs !! i)

-- ★ 修正版解析結果データ型 - real_len_advancedと同じ構造
data ValueAnalysisResult = ValueAnalysisResult
    { valueColumns :: [[Int]]  -- 各列のデータ (6行固定)
    , valueTotalCols :: Int
    } deriving (Show)

-- ★ 文字の値を取得(分岐処理対応)
getCharValue :: Int -> Int
getCharValue char
    | isArabicDigit char = getArabicValue char  -- アラビア数字は単純な値
    | isRomanNumeral char = getRomanValue char  -- ローマ数字も単純な値
    | otherwise = case Map.lookup char myDict of
        Just (Right v) -> v
        _ -> 0

-- ★ 修正版:real_len_advancedと対応する値解析
analyzeStringForValues :: String -> IO ValueAnalysisResult
analyzeStringForValues str = do
    let strNoSpaces = filter (not . isSpace) str
        unicodes = map ord strNoSpaces
    result <- processUnicodesForValues unicodes
    return result

-- ★ 修正版:Unicode処理(real_len_advancedのロジックを値計算用に変更)
processUnicodesForValues :: [Int] -> IO ValueAnalysisResult
processUnicodesForValues unicodes = go unicodes 0 []
  where
    go [] _ acc = return $ ValueAnalysisResult (reverse acc) (length acc)
    go xs pos acc = do
        -- ★ 追加：3文字ローマ数字パターンを最初にチェック
        case checkRomanPattern (take 3 xs) of
            Just (totalValue, 3) -> do
                let patternChars = take 3 xs
                    remaining = drop 3 xs
                    -- 3文字パターンの個別値を計算
                    individualValues = calculateIndividualRomanValues patternChars 3 totalValue
                    -- 3つの列を作成
                    columns = map (\val -> 0 : [val] ++ replicate 4 0) individualValues
                go remaining (pos + 3) (reverse columns ++ acc)
            _ -> case findLongestPattern xs pos of
                Just pattern -> do
                    let patLen = patternLength pattern
                        split = splitPoint pattern
                        patternChars = take patLen xs
                        remaining = drop patLen xs
                        
                        -- 分割処理（real_len_advancedと同じ）
                        (firstColChars, nextColChars) = 
                            if split > 0 && split < patLen
                            then (take split patternChars, drop split patternChars)
                            else (patternChars, [])
                        
                        -- ★ 最初の列データ作成（値版）
                        firstColValues = processSpecialCharsAdvanced unicodes firstColChars pos
                        firstColumn = 0 : firstColValues ++ replicate (5 - length firstColValues) 0
                    
                    -- 次の列の文字がある場合の処理
                    if null nextColChars
                    then go remaining (pos + patLen) (firstColumn : acc)
                    else do
                        let nextColValues = processSpecialCharsAdvanced unicodes nextColChars (pos + split)
                            nextColumn = 0 : nextColValues ++ replicate (5 - length nextColValues) 0
                        go remaining (pos + patLen) (nextColumn : firstColumn : acc)
                        
                Nothing ->
                    case safeIndex xs 0 of
                        Just firstChar -> do
                            let restChars = drop 1 xs
                                -- 単一文字の場合も高度な値計算を適用
                                charValue = calculateAdvancedValue unicodes pos firstChar
                                singleCharColumn = 0 : [charValue] ++ replicate 4 0
                            go restChars (pos + 1) (singleCharColumn : acc)
                        Nothing -> 
                            return $ ValueAnalysisResult (reverse acc) (length acc)

-- ★ 特殊文字処理(アラビア数字・ローマ数字の分岐処理)- これは古い定義になるため,Advancedの方を使用
processSpecialChars :: [Int] -> [Int]
processSpecialChars chars = map processSingleChar chars

-- ★ 単一文字の値計算(分岐処理対応)- これは古い定義になるため,Advancedの方を使用
processSingleChar :: Int -> Int
processSingleChar char
    | isArabicDigit char = getArabicValue char
    | isRomanNumeral char = getRomanValue char
    | char == 390 = 0
    | otherwise = case Map.lookup char myDict of
        Just (Right v) -> v
        _ -> 0

-- ★ より高度な処理:文字列全体での位取り・パターン計算
processSpecialCharsAdvanced :: [Int] -> [Int] -> Int -> [Int]
processSpecialCharsAdvanced allUnicodes chars startPos = 
    -- ここでcharsリストの各文字に対して、全体unicodesとstartPosからのオフセットを考慮して値計算を行う
    -- 元のコードの `calculateAdvancedValue` は単一文字とポジションの計算をするため、mapで適用
    map (\(char, offset) -> calculateAdvancedValue allUnicodes (startPos + offset) char) 
        (zip chars [0..])

-- ★ 高度な値計算(位取り・ローマ数字パターン対応)
calculateAdvancedValue :: [Int] -> Int -> Int -> Int
calculateAdvancedValue allUnicodes pos char
    | pos < 0 || pos >= length allUnicodes = 0 -- 範囲外の場合は0
    | isArabicDigit char = calculateDigitValue allUnicodes pos
    | isRomanNumeralExtended char = 
        let remainingFromPos = drop pos allUnicodes
        in case checkRomanPattern remainingFromPos of
            Just (totalValue, consumed) ->
                -- パターン全体の値は取得できるが、個別の文字への分割が必要
                -- calculateIndividualRomanValues は消費文字数と合計値から個別の値リストを返す
                let individualValues = calculateIndividualRomanValues remainingFromPos consumed totalValue
                    -- この `char` がパターン内の何番目の文字かを特定する必要があるが、
                    -- calculateAdvancedValueは個々の文字に対して呼ばれるため、パターン内の最初の文字と仮定する
                    -- 複雑なパターンの場合、この関数はシンプルに最初の文字の値のみを返す
                    -- または、パターン全体の値を最初の文字に集約する
                in if not (null individualValues) && (pos - findSequenceStart allUnicodes pos) < length individualValues
                   then individualValues !! (pos - findSequenceStart allUnicodes pos)
                   else getCharValue char -- パターンにマッチしないか、パターン内の位置が不正なら単一文字の値
            Nothing -> getCharValue char
    | otherwise = getCharValue char -- 通常の文字はmyDictから取得

-- ヘブライ語文字種判定(より安全に・通番関数で再定義)

-- 1. x = 1460
isCode1460 :: Int -> Bool
isCode1460 x = x == 1460

-- 2. x = 1461
isCode1461 :: Int -> Bool
isCode1461 x = x == 1461

-- 3. x = 1462
isCode1462 :: Int -> Bool
isCode1462 x = x == 1462

-- 4. x = 1463
isCode1463 :: Int -> Bool
isCode1463 x = x == 1463

-- 5. x = 1464
isCode1464 :: Int -> Bool
isCode1464 x = x == 1464

-- 6. x = 1465
isCode1465 :: Int -> Bool
isCode1465 x = x == 1465

-- 7. x = 1466
isCode1466 :: Int -> Bool
isCode1466 x = x == 1466

-- 8. x = 1468（ダゲシュ）
isDagesh :: Int -> Bool
isDagesh x = x == 1468

-- 9. x = 1488（アレフ）
isAleph :: Int -> Bool
isAleph x = x == 1488

-- 10. x = 1493（ヴァヴ）
isVav :: Int -> Bool
isVav x = x == 1493

-- 11. x = 1497（ヨッド）
isYod :: Int -> Bool
isYod x = x == 1497

-- 12. x ≠ 1497
isNotYod :: Int -> Bool
isNotYod x = x /= 1497

-- 13. 1487 < x < 1523（ヘブライ語主文字範囲）
isHebrewMain :: Int -> Bool
isHebrewMain x = x > 1487 && x < 1523

-- 14. x = 1488 or x = 1492（アレフまたはベート）
isAlephOrBet :: Int -> Bool
isAlephOrBet x = x == 1488 || x == 1492

-- 15. x ≠ 1488 and x ≠ 1492
isNotAlephAndNotBet :: Int -> Bool
isNotAlephAndNotBet x = x /= 1488 && x /= 1492

-- 16. x ≠ 1488 and x ≠ 1497
isNotAlephAndNotYod :: Int -> Bool
isNotAlephAndNotYod x = x /= 1488 && x /= 1497

-- 17. x ≠ 1488 and x ≠ 1492 and x ≠ 1497
isNotAlephBetYod :: Int -> Bool
isNotAlephBetYod x = x /= 1488 && x /= 1492 && x /= 1497

-- 18. x = 1488 or x = 1492 or x = 1497
isAlephOrBetOrYod :: Int -> Bool
isAlephOrBetOrYod x = x == 1488 || x == 1492 || x == 1497

-- 19. x ≠ 1471 and x ≠ 1473 and x ≠ 1474 and x ≠ 1479
isNotSpecialMarks :: Int -> Bool
isNotSpecialMarks x = not (x `elem` [1471, 1473, 1474, 1479])

-- 20. (x < 1425 or x > 1469) and (x ≠ 1471 and x ≠ 1473 and x ≠ 1474 and x ≠ 1479)
isOutsideBibleAndNotSpecial :: Int -> Bool
isOutsideBibleAndNotSpecial x =
  (x < 1425 || x > 1469) && isNotSpecialMarks x

-- 21. (1425 ≤ x ≤ 1469) or (x = 1471 or x = 1473 or x = 1474 or x = 1479)
isBibleOrSpecialMarks :: Int -> Bool
isBibleOrSpecialMarks x =
  (x >= 1425 && x <= 1469) || (x `elem` [1471, 1473, 1474, 1479])

-- 22. (1455 < x < 1460) or x = 1467 or x = 1479（母音記号など）
isVowelEtc :: Int -> Bool
isVowelEtc x =
  (x > 1455 && x < 1460) || x == 1467 || x == 1479

-- 23. 1424 < x < 1456 or x = 1469（聖書記号など）
isBiblePoint :: Int -> Bool
isBiblePoint x =
  (x > 1424 && x < 1456) || x == 1469

-- 24. (x ≠ 1471 and x ≠ 1473 and x ≠ 1474 and x ≠ 1479) and (x ≠ 1493)
isNotSpecialMarksAndNotVav :: Int -> Bool
isNotSpecialMarksAndNotVav x =
  isNotSpecialMarks x && x /= 1493

-- 25. (x < 1425 or x > 1469) and (x ≠ 1471 and x ≠ 1473 and x ≠ 1474 and x ≠ 1479 and x ≠ 1497)
isOutsideBibleAndNotSpecialAndNotYod :: Int -> Bool
isOutsideBibleAndNotSpecialAndNotYod x =
  (x < 1425 || x > 1469) && not (x `elem` [1471, 1473, 1474, 1479, 1497])

--以下,ヘブライ語以外
-- 26
isCode547 :: Int -> Bool
isCode547 x = x == 547

-- 27
isCode771 :: Int -> Bool
isCode771 x = x == 771


-- パターン定義
data HebrewPattern = HebrewPattern
    { patternName :: String
    , patternLength :: Int
    , patternMatcher :: [Int] -> Bool
    , splitPoint :: Int  -- 何文字目まで最初の列に入れるか (0=全て)
    }

-- パターン定義リスト1
hebrewPatterns :: [HebrewPattern]
hebrewPatterns = [
   HebrewPattern "7char_test_pattern" 7 (\xs -> case xs of
    (a:b:c:d:e:f:g:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1463 d && isAleph e && isYod f && isOutsideBibleAndNotSpecialAndNotYod g
    _ -> False) 6,
   HebrewPattern "7char_test_pattern" 7 (\xs -> case xs of
    (a:b:c:d:e:f:g:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1464 d && isYod e && isVav f && isNotSpecialMarks g
    _ -> False) 6,
   HebrewPattern "7char_test_pattern" 7 (\xs -> case xs of
    (a:b:c:d:e:f:g:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1463 d && isAleph e && isYod f && isBibleOrSpecialMarks g
    _ -> False) 5,
   HebrewPattern "7char_test_pattern" 7 (\xs -> case xs of
    (a:b:c:d:e:f:g:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1464 d && isYod e && isVav f && isBibleOrSpecialMarks g
    _ -> False) 5,
   HebrewPattern "7char_test_pattern" 7 (\xs -> case xs of
    (a:b:c:d:e:f:g:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isVav d && isCode1466 e && isOutsideBibleAndNotSpecial f && isBibleOrSpecialMarks g
    _ -> False) 5,
   HebrewPattern "7char_test_pattern" 7 (\xs -> case xs of
    (a:b:c:d:e:f:g:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isVav d && isDagesh e && isOutsideBibleAndNotSpecial f && isBibleOrSpecialMarks g
    _ -> False) 5,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1460 d && isYod e && isOutsideBibleAndNotSpecialAndNotYod f
    _ -> False) 6,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1460 d && isYod e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1461 d && isAlephOrBetOrYod e && isOutsideBibleAndNotSpecialAndNotYod f
    _ -> False) 6,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1461 d && isAlephOrBetOrYod e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1462 d && isAlephOrBet e && isOutsideBibleAndNotSpecialAndNotYod f
    _ -> False) 6,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1462 d && isAlephOrBet e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1463 d && isYod e && isOutsideBibleAndNotSpecialAndNotYod f
    _ -> False) 6,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1463 d && isYod e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1464 d && isAlephOrBet e && isOutsideBibleAndNotSpecialAndNotYod f
    _ -> False) 6,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1464 d && isAlephOrBet e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1464 d && isYod e && isNotSpecialMarksAndNotVav f
    _ -> False) 6,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1464 d && isYod e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1465 d && isAlephOrBet e && isNotSpecialMarks f
    _ -> False) 6,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1465 d && isAlephOrBet e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isVav d && isCode1466 e && isOutsideBibleAndNotSpecial f
    _ -> False) 6,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isVav d && isDagesh e && isOutsideBibleAndNotSpecial f
    _ -> False) 6,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isCode1463 c && isAleph d && isYod e && isOutsideBibleAndNotSpecialAndNotYod f
    _ -> False) 6,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isCode1463 c && isAleph d && isYod e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isCode1464 c && isYod d && isVav e && isNotSpecialMarks f
    _ -> False) 6,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isCode1464 c && isYod d && isVav e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isVav c && isCode1466 d && isOutsideBibleAndNotSpecial e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isDagesh b && isVav c && isDagesh d && isOutsideBibleAndNotSpecial e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isBiblePoint b && isCode1463 c && isAleph d && isYod e && isOutsideBibleAndNotSpecialAndNotYod f
    _ -> False) 6,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isBiblePoint b && isCode1463 c && isAleph d && isYod e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isBiblePoint b && isCode1464 c && isYod d && isVav e && isNotSpecialMarks f
    _ -> False) 6,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isBiblePoint b && isCode1464 c && isYod d && isVav e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isBiblePoint b && isVav c && isCode1466 d && isOutsideBibleAndNotSpecial e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "6char_test_pattern" 6 (\xs -> case xs of
    (a:b:c:d:e:f:_) -> isHebrewMain a && isBiblePoint b && isVav c && isDagesh d && isOutsideBibleAndNotSpecial e && isBibleOrSpecialMarks f
    _ -> False) 4,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1460 d && isNotYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1461 d && isNotAlephBetYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1462 d && isNotAlephAndNotBet e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1463 d && isNotAlephAndNotYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1464 d && isNotAlephAndNotBet e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isCode1465 d && isNotAlephAndNotBet e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isVav d && isCode1466 e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isVav d && isDagesh e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1460 c && isYod d && isOutsideBibleAndNotSpecialAndNotYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1460 c && isYod d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1461 c && isAlephOrBetOrYod d && isOutsideBibleAndNotSpecialAndNotYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1461 c && isAlephOrBetOrYod d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1462 c && isAlephOrBet d && isOutsideBibleAndNotSpecialAndNotYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1462 c && isAlephOrBet d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1463 c && isYod d && isOutsideBibleAndNotSpecialAndNotYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1463 c && isYod d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1464 c && isAlephOrBet d && isOutsideBibleAndNotSpecialAndNotYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1464 c && isAlephOrBet d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1464 c && isYod d && isNotSpecialMarksAndNotVav e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1464 c && isYod d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1465 c && isAlephOrBet d && isNotSpecialMarks e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isCode1465 c && isAlephOrBet d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isVav c && isCode1466 d && isOutsideBibleAndNotSpecial e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isDagesh b && isVav c && isDagesh d && isOutsideBibleAndNotSpecial e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1460 c && isYod d && isOutsideBibleAndNotSpecialAndNotYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1460 c && isYod d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1461 c && isAlephOrBetOrYod d && isOutsideBibleAndNotSpecialAndNotYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1461 c && isAlephOrBetOrYod d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1462 c && isAlephOrBet d && isOutsideBibleAndNotSpecialAndNotYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1462 c && isAlephOrBet d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1463 c && isYod d && isOutsideBibleAndNotSpecialAndNotYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1463 c && isYod d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1464 c && isAlephOrBet d && isOutsideBibleAndNotSpecialAndNotYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1464 c && isAlephOrBet d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1464 c && isYod d && isNotSpecialMarksAndNotVav e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1464 c && isYod d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1465 c && isAlephOrBet d && isNotSpecialMarks e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isCode1465 c && isAlephOrBet d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isVav c && isCode1466 d && isOutsideBibleAndNotSpecial e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isBiblePoint b && isVav c && isDagesh d && isOutsideBibleAndNotSpecial e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isCode1463 b && isAleph c && isYod d && isOutsideBibleAndNotSpecialAndNotYod e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isCode1463 b && isAleph c && isYod d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isCode1464 b && isYod c && isVav d && isNotSpecialMarks e
    _ -> False) 5,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isCode1464 b && isYod c && isVav d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isVav b && isCode1466 c && isOutsideBibleAndNotSpecial d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "5char_test_pattern" 5 (\xs -> case xs of
    (a:b:c:d:e:_) -> isHebrewMain a && isVav b && isDagesh c && isOutsideBibleAndNotSpecial d && isBibleOrSpecialMarks e
    _ -> False) 3,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isVowelEtc d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isDagesh b && isCode1460 c && isNotYod d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isDagesh b && isCode1461 c && isNotAlephBetYod d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isDagesh b && isCode1462 c && isNotAlephAndNotBet d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isDagesh b && isCode1463 c && isNotAlephAndNotYod d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isDagesh b && isCode1464 c && isNotAlephAndNotBet d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isDagesh b && isCode1465 c && isNotAlephAndNotBet d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isDagesh b && isVav c && isCode1466 d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isDagesh b && isVav c && isDagesh d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isBiblePoint b && isCode1460 c && isNotYod d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isBiblePoint b && isCode1461 c && isNotAlephBetYod d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isBiblePoint b && isCode1462 c && isNotAlephAndNotBet d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isBiblePoint b && isCode1463 c && isNotAlephAndNotYod d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isBiblePoint b && isCode1464 c && isNotAlephAndNotBet d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isBiblePoint b && isCode1465 c && isNotAlephAndNotBet d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isBiblePoint b && isVav c && isCode1466 d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isBiblePoint b && isVav c && isDagesh d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1460 b && isYod c && isOutsideBibleAndNotSpecialAndNotYod d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1460 b && isYod c && isBibleOrSpecialMarks d
    _ -> False) 2,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1461 b && isAlephOrBetOrYod c && isOutsideBibleAndNotSpecialAndNotYod d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1461 b && isAlephOrBetOrYod c && isBibleOrSpecialMarks d
    _ -> False) 2,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1462 b && isAlephOrBet c && isOutsideBibleAndNotSpecialAndNotYod d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1462 b && isAlephOrBet c && isBibleOrSpecialMarks d
    _ -> False) 2,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1463 b && isYod c && isOutsideBibleAndNotSpecialAndNotYod d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1463 b && isYod c && isBibleOrSpecialMarks d
    _ -> False) 2,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1464 b && isAlephOrBet c && isOutsideBibleAndNotSpecialAndNotYod d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1464 b && isAlephOrBet c && isBibleOrSpecialMarks d
    _ -> False) 2,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1464 b && isYod c && isNotSpecialMarksAndNotVav d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1464 b && isYod c && isBibleOrSpecialMarks d
    _ -> False) 2,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1465 b && isAlephOrBet c && isNotSpecialMarks d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isCode1465 b && isAlephOrBet c && isBibleOrSpecialMarks d
    _ -> False) 2,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isVav b && isCode1466 c && isOutsideBibleAndNotSpecial d
    _ -> False) 4,
   HebrewPattern "4char_test_pattern" 4 (\xs -> case xs of
    (a:b:c:d:_) -> isHebrewMain a && isVav b && isDagesh c && isOutsideBibleAndNotSpecial d
    _ -> False) 4,
   HebrewPattern "3char_test_pattern" 3 (\xs -> case xs of
    (a:b:c:_) -> isHebrewMain a && isDagesh b && isVowelEtc c
    _ -> False) 3,
   HebrewPattern "3char_test_pattern" 3 (\xs -> case xs of
    (a:b:c:_) -> isHebrewMain a && isBiblePoint b && isVowelEtc c
    _ -> False) 3,
   HebrewPattern "3char_test_pattern" 3 (\xs -> case xs of
    (a:b:c:_) -> isHebrewMain a && isCode1460 b && isNotYod c
    _ -> False) 3,
   HebrewPattern "3char_test_pattern" 3 (\xs -> case xs of
    (a:b:c:_) -> isHebrewMain a && isCode1461 b && isNotAlephBetYod c
    _ -> False) 3,
   HebrewPattern "3char_test_pattern" 3 (\xs -> case xs of
    (a:b:c:_) -> isHebrewMain a && isCode1462 b && isNotAlephAndNotBet c
    _ -> False) 3,
   HebrewPattern "3char_test_pattern" 3 (\xs -> case xs of
    (a:b:c:_) -> isHebrewMain a && isCode1463 b && isNotAlephAndNotYod c
    _ -> False) 3,
   HebrewPattern "3char_test_pattern" 3 (\xs -> case xs of
    (a:b:c:_) -> isHebrewMain a && isCode1464 b && isNotAlephAndNotBet c
    _ -> False) 3,
   HebrewPattern "3char_test_pattern" 3 (\xs -> case xs of
    (a:b:c:_) -> isHebrewMain a && isCode1465 b && isNotAlephAndNotBet c
    _ -> False) 3,
   HebrewPattern "3char_test_pattern" 3 (\xs -> case xs of
    (a:b:c:_) -> isHebrewMain a && isVav b && isCode1466 c
    _ -> False) 3,
   HebrewPattern "3char_test_pattern" 3 (\xs -> case xs of
    (a:b:c:_) -> isHebrewMain a && isVav b && isDagesh c
    _ -> False) 3,
   HebrewPattern "2char_test_pattern" 2 (\xs -> case xs of
    (a:b:_) -> isHebrewMain a && isVowelEtc b
    _ -> False) 2,
    
    --ヘブライ語以外
    HebrewPattern "combining_char_547_771" 2 (\xs -> case xs of
    (a:b:_) -> a == 547 && b == 771
    _ -> False) 2
   ]

-- 最長パターンマッチング(安全版)
findLongestPattern :: [Int] -> Int -> Maybe HebrewPattern
findLongestPattern xs pos
    | pos < 0 || pos >= length xs = Nothing
    | otherwise = 
        let remaining = drop pos xs
            remainingLen = length remaining
        in find (\p -> remainingLen >= patternLength p && 
                      patternMatcher p remaining) hebrewPatterns

-- 解析結果データ型
data AnalysisResult = AnalysisResult
    { columns :: [[Int]]
    , totalCols :: Int
    } deriving (Show)

-- 合成文字を作成する関数
createCompositeChar :: [Int] -> String
createCompositeChar unicodes = map chr (filter (\x -> x > 0 && x < 1114112) unicodes)

-- 合成文字のUnicode値を計算（簡略化：最初の文字のUnicodeを使用）#NAME?
getCompositeUnicode :: String -> Int
getCompositeUnicode compositeStr = case compositeStr of
    [] -> 0
    (c:_) -> ord c

-- 文字列解析（安全版）- 修正版：1行目に合成文字のUnicode値を格納
analyzeString :: String -> IO AnalysisResult
analyzeString str = do
    let strNoSpaces = filter (not . isSpace) str
        unicodes = map ord strNoSpaces
    result <- processUnicodes unicodes
    return result

-- Unicode処理（安全版）- 修正版：1行目に合成文字、2行目以降に構成文字を格納
processUnicodes :: [Int] -> IO AnalysisResult
processUnicodes unicodes = go unicodes 0 []
  where
    go [] _ acc = return $ AnalysisResult (reverse acc) (length acc)
    go xs pos acc = do
        case findLongestPattern xs pos of
            Just pattern -> do
                let patLen = patternLength pattern
                    split = splitPoint pattern
                    patternChars = take patLen xs
                    remaining = drop patLen xs
                    
                    -- 分割処理
                    (firstColChars, nextColChars) = 
                        if split > 0 && split < patLen
                        then (take split patternChars, drop split patternChars)
                        else (patternChars, [])
                    
                    -- 最初の列データ作成
                    compositeStr = createCompositeChar firstColChars
                    compositeUnicode = getCompositeUnicode compositeStr
                    firstColumn = 0 : firstColChars ++ replicate (5 - length firstColChars) 0
                
                -- 次の列の文字がある場合の処理
                if null nextColChars
                then go remaining (pos + patLen) (firstColumn : acc)
                else do
                    let nextColumn = 0 : nextColChars ++ replicate (5 - length nextColChars) 0
                    go remaining (pos + patLen) (nextColumn : firstColumn : acc)
                    
            Nothing ->
                case safeIndex xs 0 of
                    Just firstChar -> do
                        let restChars = drop 1 xs
                            singleCharColumn = 0 : [firstChar] ++ replicate 4 0
                        go restChars (pos + 1) (singleCharColumn : acc)
                    Nothing -> 
                        return $ AnalysisResult (reverse acc) (length acc)

-- 値取得（1行目は常に0を返すよう修正）
getValueAt :: AnalysisResult -> Int -> Int -> Int
getValueAt result row col
    | col < 1 || col > totalCols result = 0
    | row < 1 = 0
    | row == 1 = 0  -- ★ 1行目は常に0を返す
    | otherwise =
        case safeIndex (columns result) (col - 1) of
            Nothing -> 0
            Just colData ->
                case safeIndex colData (row - 1) of
                    Nothing -> 0
                    Just value -> value

-- ★ 修正版:値取得 (real_len_advancedと同じインターフェース)
getValueAtPosition :: ValueAnalysisResult -> Int -> Int -> Int
getValueAtPosition result row col
    | col < 1 || col > valueTotalCols result = 0
    | row < 1 = 0
    | row == 1 = 0  -- 1行目は常に0（real_len_advancedと同じ）
    | otherwise =
        case safeIndex (valueColumns result) (col - 1) of
            Nothing -> 0
            Just colData ->
                case safeIndex colData (row - 1) of
                    Nothing -> 0
                    Just value -> value

-- 合成文字の取得(デバッグ用)
getCompositeChar :: AnalysisResult -> Int -> String
getCompositeChar result col
    | col < 1 || col > totalCols result = ""
    | otherwise =
        case safeIndex (columns result) (col - 1) of
            Nothing -> ""
            Just colData ->
                -- 2行目以降から構成文字を取得して合成文字を再構築
                let dataRows = drop 1 colData  -- 2行目以降
                    nonZeros = filter (/= 0) dataRows
                    validChars = filter (\x -> x > 0 && x < 1114112) nonZeros
                in map chr validChars

-- メイン関数(修正版)
real_len_advanced :: CWString -> CInt -> CInt -> CInt -> IO CInt
real_len_advanced cws len_c elem1 elem2 = do
    result <- (do
        if cws == nullPtr
            then return (-1)
            else do
                str <- peekCWStringLen (castPtr cws, fromIntegral len_c)
                let unicodes = map ord str
                analysisResult <- analyzeString str
                let row = fromIntegral elem1
                    col = fromIntegral elem2
                    value = getValueAt analysisResult row col
                return (fromIntegral value)
        ) `catch` (\(_ :: SomeException) -> return (-998))
    return result

-- 既存関数(修正版)
real_len :: CWString -> CInt -> CInt -> CInt -> IO CInt　　
real_len cws len_c elem1 elem2 = do
    result <- (do
        if cws == nullPtr
            then do
                return (-1)
            else do
                str <- peekCWStringLen (castPtr cws, fromIntegral len_c)
                
                let strNoSpaces = filter (not . isSpace) str
                    idx = fromIntegral elem2 - 1
                case strNoSpaces of
                    [] -> do
                        return 0
                    _ -> case safeIndex strNoSpaces idx of
                        Nothing -> do
                            return (-1)
                        Just ch -> do
                            let unicodeVal = ord ch
                            return (fromIntegral unicodeVal)
                        
        ) `catch` (\(_ :: SomeException) -> return (-998))
    return result

isArabicDigit :: Int -> Bool
isArabicDigit x = x >= 48 && x <= 57  -- Unicode range for '0' to '9'

-- Roman numeral checking function
isRomanNumeral :: Int -> Bool
isRomanNumeral x = x `elem` [8544, 8548, 8553, 8556, 8557]  
-- Corresponds to: Ⅰ(8544), Ⅴ(8548), Ⅹ(8553), Ⅼ(8556), Ⅽ(8557)

-- Get Arabic digit value
getArabicValue :: Int -> Int
getArabicValue x
    | x >= 48 && x <= 57 = x - 48  -- Convert Unicode to actual digit value
    | otherwise = 0

-- Get Roman numeral value
getRomanValue :: Int -> Int
getRomanValue x = case x of
    8544 -> 1   -- Ⅰ
    8548 -> 5   -- Ⅴ
    8553 -> 10  -- Ⅹ
    8556 -> 50  -- Ⅼ
    8557 -> 100 -- Ⅽ
    _ -> 0


-- ローマ数字も分岐処理の対象にする修正版

-- 数字の位取り処理を保持しつつ,real_lenとの配列対応を維持する解決策(ローマ数字対応)

-- 文字ごとの値変換(位取りを考慮,ローマ数字の分岐処理対応)
charToValueWithPosition :: [Int] -> Int -> Int
charToValueWithPosition allUnicodes pos
    | pos < 0 || pos >= length allUnicodes = 0
    | otherwise = 
        let currentChar = allUnicodes !! pos
        in if isArabicDigit currentChar
           then calculateDigitValue allUnicodes pos
           else if isRomanNumeral currentChar
           then calculateRomanValue allUnicodes pos
           else getSingleCharValueSimple currentChar

-- アラビア数字の位取り計算(前後の文字を考慮)
calculateDigitValue :: [Int] -> Int -> Int
calculateDigitValue unicodes pos = 
    let currentChar = unicodes !! pos
        digitValue = getArabicValue currentChar
        
        -- 連続する数字のシーケンスを特定
        digitSequence = getDigitSequence unicodes pos
        positionInSequence = pos - fst digitSequence
        sequenceLength = length (snd digitSequence)
        
        -- 位取り計算
        power = sequenceLength - positionInSequence - 1
    in digitValue * (10 ^ power)

-- ローマ数字の値計算(パターンマッチングによる分岐処理)
calculateRomanValue :: [Int] -> Int -> Int
calculateRomanValue unicodes pos
    | pos >= length unicodes = 0
    | otherwise = 
        let remaining = drop pos unicodes
        in case checkRomanPattern remaining of
            Just (value, _) -> value
            Nothing -> getSingleCharValueSimple (unicodes !! pos)

-- ローマ数字パターンの確認(文書3の表に基づく)
checkRomanPattern :: [Int] -> Maybe (Int, Int)  -- (値, 消費文字数)
-- 1. Ⅽ Ⅰ Ͷ → 1000の特殊表記（完全一致チェック）
checkRomanPattern (8557:8544:390:_) = Just (1000, 3)

-- 2. （≠Ⅽ）Ⅰ Ͷ → 500の特殊表記（第1文字チェック強化）
checkRomanPattern (x:8544:390:_) 
  | x /= 8557 && (isArabicDigit x || isInMyDict x || isRomanNumeral x) = Just (500, 3)

-- 3. Ⅰ Ⅼ → 49（減算表記）
checkRomanPattern (8544:8556:_) = Just (49, 2)

-- 4. Ⅰ Ⅹ → 9（減算表記）
checkRomanPattern (8544:8553:_) = Just (9, 2)

-- 5. Ⅰ Ⅴ → 4（減算表記）
checkRomanPattern (8544:8548:_) = Just (4, 2)

-- 6. Ⅹ Ⅼ → 40（減算表記）
checkRomanPattern (8553:8556:_) = Just (40, 2)

-- 7. Ⅹ Ⅽ → 90（減算表記）
checkRomanPattern (8553:8557:_) = Just (90, 2)

-- 8-12. 単一ローマ数字
checkRomanPattern (8544:_) = Just (1, 1)   -- Ⅰ
checkRomanPattern (8548:_) = Just (5, 1)   -- Ⅴ
checkRomanPattern (8553:_) = Just (10, 1)  -- Ⅹ
checkRomanPattern (8556:_) = Just (50, 1)  -- Ⅼ
checkRomanPattern (8557:_) = Just (100, 1) -- Ⅽ

-- 13. Ͷ → 0（特殊用途）
checkRomanPattern (390:_) = Just (0, 1)


checkRomanPattern _ = Nothing

isInMyDict :: Int -> Bool
isInMyDict x = case Map.lookup x myDict of
    Just (Right _) -> True
    _ -> False

-- ローマ数字パターンの各文字の個別寄与を計算(修正版)
calculateIndividualRomanValues :: [Int] -> Int -> Int -> [Int]
calculateIndividualRomanValues chars consumed totalValue = case (chars, consumed, totalValue) of
    -- 場合1: Ⅽ Ⅰ Ͷ → 1000 の特殊表記
    (8557:8544:390:_, 3, 1000) -> [0, 1000, 0]
    
    -- 場合2: （≠Ⅽ）Ⅰ Ͷ → 500 の特殊表記
    (first:8544:390:_, 3, 500) -> 
        let firstCharValue = if isArabicDigit first
                            then getArabicValue first  -- 0-9の数値をそのまま
                            else case Map.lookup first myDict of
                                Just (Right v) -> v
                                _ -> if isRomanNumeral first then getRomanValue first else 0
        in [firstCharValue, 500, 0]
    
    -- 2文字の減算記法
    (first:second:_, 2, _) -> 
        let secondValue = getRomanValue second
            firstValue = totalValue - secondValue
        in [firstValue, secondValue]
    
    -- その他の3文字パターン（安全処理）
    (first:second:third:_, 3, _) -> [0, 0, totalValue]
    
    -- 単一文字
    _ -> [totalValue]
    
-- 連続数字シーケンスの開始位置と文字列を取得
getDigitSequence :: [Int] -> Int -> (Int, [Int])
getDigitSequence unicodes pos = 
    let -- 後方検索：シーケンスの開始を見つける
        startPos = findSequenceStart unicodes pos
        -- 前方検索：シーケンスの終了を見つける  
        endPos = findSequenceEnd unicodes startPos
        sequence = take (endPos - startPos + 1) (drop startPos unicodes)
    in (startPos, sequence)

-- 数字シーケンスの開始位置を見つける
findSequenceStart :: [Int] -> Int -> Int
findSequenceStart unicodes pos
    | pos <= 0 = 0
    | pos >= length unicodes = pos
    | isArabicDigit (unicodes !! (pos - 1)) = findSequenceStart unicodes (pos - 1)
    | otherwise = pos

-- 数字シーケンスの終了位置を見つける
findSequenceEnd :: [Int] -> Int -> Int
findSequenceEnd unicodes pos
    | pos >= length unicodes - 1 = length unicodes - 1
    | isArabicDigit (unicodes !! (pos + 1)) = findSequenceEnd unicodes (pos + 1)
    | otherwise = pos

-- 単一文字の値(数字以外)
getSingleCharValueSimple :: Int -> Int
getSingleCharValueSimple char
    | isRomanNumeral char = getRomanValue char
    | otherwise = case Map.lookup char myDict of
        Just (Right v) -> v
        _ -> 0

-- ローマ数字判定の拡張(特殊文字390も含む)
isRomanNumeralExtended :: Int -> Bool
isRomanNumeralExtended x = isRomanNumeral x || x == 390

-- real_lenと対応する値解析(位取り処理付き,ローマ数字分岐対応)
analyzeStringWithPositions :: String -> IO ([Int], [(Int, String)])  -- (値リスト, デバッグ情報)
analyzeStringWithPositions str = do
    let strNoSpaces = filter (not . isSpace) str
        unicodes = map ord strNoSpaces
        (values, debugInfo) = processWithBranching unicodes
    return (values, debugInfo)

-- 分岐処理を含む値計算
processWithBranching :: [Int] -> ([Int], [(Int, String)])
processWithBranching unicodes = go unicodes 0 [] []
  where
    go [] _ values debugInfo = (reverse values, reverse debugInfo)
    go remaining pos values debugInfo
        | pos >= length unicodes = (reverse values, reverse debugInfo)
        | otherwise =
            let currentChar = unicodes !! pos
                currentRemaining = drop pos unicodes
            -- まず3文字パターンをチェック（場合1,2対応）
            in case checkRomanPattern (take 3 currentRemaining) of
                Just (value, 3) -> -- 3文字パターンの場合
                    let consumedChars = take 3 currentRemaining
                        individualValues = calculateIndividualRomanValues currentRemaining 3 value
                        debugMsg = "3-char pattern: " ++ show consumedChars ++ " -> " ++ show individualValues
                        newValues = reverse individualValues ++ values
                        nextPos = pos + 3
                    in go (drop 3 remaining) nextPos newValues ((pos, debugMsg) : debugInfo)
                Just (value, consumed) -> -- 2文字以下のパターン
                    let consumedChars = take consumed currentRemaining
                        individualValues = calculateIndividualRomanValues currentRemaining consumed value
                        debugMsg = "Roman pattern: " ++ show consumedChars ++ " -> " ++ show individualValues
                        newValues = reverse individualValues ++ values
                        nextPos = pos + consumed
                    in go (drop consumed remaining) nextPos newValues ((pos, debugMsg) : debugInfo)
                Nothing -> -- パターンなし、個別文字処理
                    if isArabicDigit currentChar
                    then -- アラビア数字処理
                        let digitValue = calculateDigitValue unicodes pos
                            nextPos = pos + 1
                            debugMsg = "Arabic digit: " ++ show currentChar ++ " -> " ++ show digitValue
                        in go remaining nextPos (digitValue : values) ((pos, debugMsg) : debugInfo)
                    else -- 通常文字処理
                        let charValue = getSingleCharValueSimple currentChar
                            nextPos = pos + 1
                            debugMsg = "Other char: " ++ show currentChar ++ " -> " ++ show charValue
                        in go remaining nextPos (charValue : values) ((pos, debugMsg) : debugInfo)

-- ★ 修正版:real_len_advancedと完全対応する値解析関数
real_value_new_improved :: CWString -> CInt -> CInt -> CInt -> IO CInt
real_value_new_improved cws len_c elem1 elem2 = do
    result <- (do
        if cws == nullPtr
            then return (-997)
            else do
                str <- peekCWStringLen (castPtr cws, fromIntegral len_c)
                valueResult <- analyzeStringForValues str
                let row = fromIntegral elem1
                    col = fromIntegral elem2
                
                -- ★ (0,0) → 全体の合計
                if row == 0 && col == 0
                then do
                    let allValues = concatMap (filter (/= 0)) (valueColumns valueResult)
                        totalSum = sum allValues
                    return (fromIntegral totalSum)
                -- ★ 通常のアクセス：real_len_advancedと同じ行列位置
                else do
                    let value = getValueAtPosition valueResult row col
                    return (fromIntegral value)
        ) `catch` (\(_ :: SomeException) -> return (-998))
    return result



