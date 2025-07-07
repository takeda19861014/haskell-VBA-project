{-# LANGUAGE ForeignFunctionInterface #-}
module MyLib where

import Foreign
import Foreign.C.Types
import Foreign.C.String (CWString, peekCWStringLen)
import qualified Data.Map.Strict as Map
import Data.Char (isSpace, ord, chr)
import Control.Exception (catch, SomeException)

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

-- ヘブライ語文字種判定(より安全に・通番関数で再定義)

-- ヘブライ語の子音判定
isHebrewConsonant :: Int -> Bool
isHebrewConsonant x = x `elem` hebrewConsonants
  where
    hebrewConsonants =
      [1488,1489,1490,1491,1492,1493,1494,1495,1496,1497,
       1498,1499,1500,1501,1502,1503,1504,1505,1506,1507,
       1508,1509,1510,1511,1512,1514]

-- ヘブライ語の母音記号（ニクード）判定
isHebrewVowelMark :: Int -> Bool
isHebrewVowelMark x = x `elem` hebrewVowelMarks
  where
    hebrewVowelMarks =
      [1456,1457,1458,1459,1460,1461,1462,1463,1464,1465,1466,1467]

-- シン（ש, 1513）判定
isShinLetter :: Int -> Bool
isShinLetter x = x == 1513

-- シン・ドット（שׁ: 1473, שׂ: 1474）判定
isShinDotMark :: Int -> Bool
isShinDotMark x = x == 1473 || x == 1474

-- ヨッド, セゴル, ダゲシュ判定
isYodSegolOrDagesh :: Int -> Bool
isYodSegolOrDagesh x = x `elem` [1497, 1466, 1468]

-- 主要な母音記号+ヴァヴ判定
isMainVowelOrVav :: Int -> Bool
isMainVowelOrVav x = x `elem` [1460, 1461, 1462, 1463, 1464, 1465, 1493]

-- セゴル, ダゲシュ, アレフ, ベート, ヨッド判定
isSegolDageshAlefBetYod :: Int -> Bool
isSegolDageshAlefBetYod x = x `elem` [1466, 1468, 1488, 1492, 1497]

-- パタフ, カマツ, ヴァヴ判定
isPatahQamatsOrVav :: Int -> Bool
isPatahQamatsOrVav x = x `elem` [1463, 1464, 1493]

-- セゴル, ダゲシュ, アレフ, ヨッド判定
isSegolDageshAlefYod :: Int -> Bool
isSegolDageshAlefYod x = x `elem` [1466, 1468, 1488, 1497]

-- ヴァヴ, ヨッド判定
isVavOrYod :: Int -> Bool
isVavOrYod x = x `elem` [1493, 1497]

isHiriqTzereOrVav :: Int -> Bool
isHiriqTzereOrVav x = x `elem` [1460, 1461, 1493]

isMainLetterVavYodAlef :: Int -> Bool
isMainLetterVavYodAlef x =
    (1425 <= x && x <= 1455) ||
    (1456 <= x && x <= 1467) ||
    x == 1468 ||
    x == 1469 ||
    x == 1493

isHiriqOrTzere :: Int -> Bool
isHiriqOrTzere x = x == 1460 || x == 1461

isYod :: Int -> Bool
isYod x = x == 1497

isAlefOrYod :: Int -> Bool
isAlefOrYod x = x == 1488 || x == 1497

isDagesh :: Int -> Bool
isDagesh x = x == 1468

isCantillation :: Int -> Bool
isCantillation x = (1425 <= x && x <= 1455) || (x == 1469)

--ヘブライ語以外
is547 :: Int -> Bool
is547 x = x == 547

is771 :: Int -> Bool
is771 x = x == 771

-- Hebrew用のパターン定義
data HebrewPattern = HebrewPattern
    { tpName :: String
    , tpLength :: Int
    , tpCheckers :: [Int -> Bool]  -- 各位置での判定関数
    , tpSplitPoint :: Int
    }

allHebrewPatterns :: [HebrewPattern]
allHebrewPatterns = [
     HebrewPattern "c_k_l_f_h_pattern" 8 [isShinLetter, isShinDotMark, isDagesh, isCantillation, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod, isMainLetterVavYodAlef] 6,

     HebrewPattern "c_k_l_f_pattern" 7 [isShinLetter, isShinDotMark, isDagesh, isCantillation, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod] 7,
     HebrewPattern "a_k_l_f_h_pattern" 7 [isHebrewConsonant, isDagesh, isCantillation, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod, isMainLetterVavYodAlef] 5,
     HebrewPattern "c_k_l_g_h_pattern" 7 [isShinLetter, isShinDotMark, isDagesh, isCantillation, isHiriqOrTzere, isYod, isMainLetterVavYodAlef] 5,
     HebrewPattern "c_k_l_i_j_h_pattern" 7 [isShinLetter, isShinDotMark, isDagesh, isCantillation, isMainVowelOrVav, isAlefOrYod, isMainLetterVavYodAlef] 5,
     HebrewPattern "c_l_f_h_pattern" 7 [isShinLetter, isShinDotMark, isCantillation, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod, isMainLetterVavYodAlef] 5,
     HebrewPattern "c_k_f_h_pattern" 7 [isShinLetter, isShinDotMark, isDagesh, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod, isMainLetterVavYodAlef] 5,

     HebrewPattern "c_k_l_e_pattern" 6 [isShinLetter, isShinDotMark, isDagesh, isCantillation, isMainVowelOrVav, isSegolDageshAlefBetYod] 6,
     HebrewPattern "a_k_l_f_pattern" 6 [isHebrewConsonant, isDagesh, isCantillation, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod] 6,
     HebrewPattern "c_l_f_pattern" 6 [isShinLetter, isShinDotMark, isCantillation, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod] 6,
     HebrewPattern "c_k_f_pattern" 6 [isShinLetter, isShinDotMark, isDagesh, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod] 6,
     HebrewPattern "c_k_l_d_pattern" 6 [isShinLetter, isShinDotMark, isDagesh, isCantillation, isHiriqTzereOrVav, isYodSegolOrDagesh] 6,
     HebrewPattern "c_f_h_pattern" 6 [isShinLetter, isShinDotMark, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod, isMainLetterVavYodAlef] 4,
     HebrewPattern "a_k_l_g_h_pattern" 6 [isHebrewConsonant, isDagesh, isCantillation, isHiriqOrTzere, isYod, isMainLetterVavYodAlef] 4,
     HebrewPattern "a_k_l_i_j_h_pattern" 6 [isHebrewConsonant, isDagesh, isCantillation, isMainVowelOrVav, isAlefOrYod, isMainLetterVavYodAlef] 4,
     HebrewPattern "a_l_f_h_pattern" 6 [isHebrewConsonant, isCantillation, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod, isMainLetterVavYodAlef] 4,
     HebrewPattern "a_k_f_h_pattern" 6 [isHebrewConsonant, isDagesh, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod, isMainLetterVavYodAlef] 4,
     HebrewPattern "c_k_g_h_pattern" 6 [isShinLetter, isShinDotMark, isDagesh, isHiriqOrTzere, isYod, isMainLetterVavYodAlef] 4,
     HebrewPattern "c_k_i_j_h_pattern" 6 [isShinLetter, isShinDotMark, isDagesh, isMainVowelOrVav, isAlefOrYod, isMainLetterVavYodAlef] 4,
     HebrewPattern "c_l_g_h_pattern" 6 [isShinLetter, isShinDotMark, isCantillation, isHiriqOrTzere, isYod, isMainLetterVavYodAlef] 4,
     HebrewPattern "c_l_i_j_h_pattern" 6 [isShinLetter, isShinDotMark, isCantillation, isMainVowelOrVav, isAlefOrYod, isMainLetterVavYodAlef] 4,

     HebrewPattern "a_k_l_e_pattern" 5 [isHebrewConsonant, isDagesh, isCantillation, isMainVowelOrVav, isSegolDageshAlefBetYod] 5,
     HebrewPattern "a_k_f_pattern" 5 [isHebrewConsonant, isDagesh, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod] 5,
     HebrewPattern "a_l_f_pattern" 5 [isHebrewConsonant, isCantillation, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod] 5,
     HebrewPattern "c_f_pattern" 5 [isShinLetter, isShinDotMark, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod] 5,
     HebrewPattern "c_k_e_pattern" 5 [isShinLetter, isShinDotMark, isDagesh, isMainVowelOrVav, isSegolDageshAlefBetYod] 5,
     HebrewPattern "c_l_e_pattern" 5 [isShinLetter, isShinDotMark, isCantillation, isMainVowelOrVav, isSegolDageshAlefBetYod] 5,
     HebrewPattern "a_k_l_d_pattern" 5 [isHebrewConsonant, isDagesh, isCantillation, isHiriqTzereOrVav, isYodSegolOrDagesh] 5,
     HebrewPattern "c_k_l_b_pattern" 5 [isShinLetter, isShinDotMark, isDagesh, isCantillation, isHebrewVowelMark] 5,
     HebrewPattern "c_k_d_pattern" 5 [isShinLetter, isShinDotMark, isDagesh, isHiriqTzereOrVav, isYodSegolOrDagesh] 5,
     HebrewPattern "c_l_d_pattern" 5 [isShinLetter, isShinDotMark, isCantillation, isHiriqTzereOrVav, isYodSegolOrDagesh] 5,
     HebrewPattern "a_k_g_h_pattern" 5 [isHebrewConsonant, isDagesh, isHiriqOrTzere, isYod, isMainLetterVavYodAlef] 3,
     HebrewPattern "a_k_i_j_h_pattern" 5 [isHebrewConsonant, isDagesh, isMainVowelOrVav, isAlefOrYod, isMainLetterVavYodAlef] 3,
     HebrewPattern "a_l_g_h_pattern" 5 [isHebrewConsonant, isCantillation, isHiriqOrTzere, isYod, isMainLetterVavYodAlef] 3,
     HebrewPattern "a_l_i_j_h_pattern" 5 [isHebrewConsonant, isCantillation, isMainVowelOrVav, isAlefOrYod, isMainLetterVavYodAlef] 3,
     HebrewPattern "a_f_h_pattern" 5 [isHebrewConsonant, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod, isMainLetterVavYodAlef] 3,
     HebrewPattern "c_g_h_pattern" 5 [isShinLetter, isShinDotMark, isHiriqOrTzere, isYod, isMainLetterVavYodAlef] 3,
     HebrewPattern "c_i_j_h_pattern" 5 [isShinLetter, isShinDotMark, isMainVowelOrVav, isAlefOrYod, isMainLetterVavYodAlef] 3,

     HebrewPattern "a_k_l_b_pattern" 4 [isHebrewConsonant, isDagesh, isCantillation, isHebrewVowelMark] 4,
     HebrewPattern "a_k_e_pattern" 4 [isHebrewConsonant, isDagesh, isMainVowelOrVav, isSegolDageshAlefBetYod] 4,
     HebrewPattern "a_l_e_pattern" 4 [isHebrewConsonant, isCantillation, isMainVowelOrVav, isSegolDageshAlefBetYod] 4,
     HebrewPattern "a_f_pattern" 4 [isHebrewConsonant, isPatahQamatsOrVav, isSegolDageshAlefYod, isVavOrYod] 4,
     HebrewPattern "c_e_pattern" 4 [isShinLetter, isShinDotMark, isMainVowelOrVav, isSegolDageshAlefBetYod] 4,
     HebrewPattern "c_k_b_pattern" 4 [isShinLetter, isShinDotMark, isDagesh, isHebrewVowelMark] 4,
     HebrewPattern "c_l_b_pattern" 4 [isShinLetter, isShinDotMark, isCantillation, isHebrewVowelMark] 4,
     HebrewPattern "c_k_l_pattern" 4 [isShinLetter, isShinDotMark, isDagesh, isCantillation] 4,
     HebrewPattern "a_k_d_pattern" 4 [isHebrewConsonant, isDagesh, isHiriqTzereOrVav, isYodSegolOrDagesh] 4,
     HebrewPattern "a_l_d_pattern" 4 [isHebrewConsonant, isCantillation, isHiriqTzereOrVav, isYodSegolOrDagesh] 4,
     HebrewPattern "c_d_pattern" 4 [isShinLetter, isShinDotMark, isHiriqTzereOrVav, isYodSegolOrDagesh] 4,
     HebrewPattern "a_g_h_pattern" 4 [isHebrewConsonant, isHiriqOrTzere, isYod, isMainLetterVavYodAlef] 2,
     HebrewPattern "a_i_j_h_pattern" 4 [isHebrewConsonant, isMainVowelOrVav, isAlefOrYod, isMainLetterVavYodAlef] 2,

     HebrewPattern "a_k_b_pattern" 3 [isHebrewConsonant, isDagesh, isHebrewVowelMark] 3,
     HebrewPattern "a_d_pattern" 3 [isHebrewConsonant, isHiriqTzereOrVav, isYodSegolOrDagesh] 3,
     HebrewPattern "a_e_pattern" 3 [isHebrewConsonant, isMainVowelOrVav, isSegolDageshAlefBetYod] 3,
     HebrewPattern "a_l_b_pattern" 3 [isHebrewConsonant, isCantillation, isHebrewVowelMark] 3,
     HebrewPattern "c_b_pattern" 3 [isShinLetter, isShinDotMark, isHebrewVowelMark] 3,
     HebrewPattern "c_k_pattern" 3 [isShinLetter, isShinDotMark, isDagesh] 3,
     HebrewPattern "c_l_pattern" 3 [isShinLetter, isShinDotMark, isCantillation] 3,

     HebrewPattern "a_b_pattern" 2 [isHebrewConsonant, isHebrewVowelMark] 2,
     HebrewPattern "c_pattern" 2 [isShinLetter, isShinDotMark] 2,
     HebrewPattern "k_l_pattern" 2 [isDagesh, isCantillation] 2,
     -- ヘブライ語以外
     HebrewPattern "nonHebrewpattern" 2 [is547, is771] 2
     ]
     
     

---- スライディングウィンドウによる最長パターンマッチ
findLongestPatternSliding :: [HebrewPattern] -> [Int] -> Maybe (HebrewPattern, Int, [Int])
findLongestPatternSliding patterns xs = 
    let -- パターンを長さの降順でソート（最長優先）
        sortedPatterns = sortBy (flip compare `on` tpLength) patterns
        
        -- 各位置での最良のマッチを見つける
        findBestMatch pos remainingChars
            | null remainingChars = Nothing
            | otherwise = 
                let validPatterns = filter (\p -> tpLength p <= length remainingChars) sortedPatterns
                in tryPatterns validPatterns pos remainingChars
        
        tryPatterns [] _ _ = Nothing
        tryPatterns (p:ps) pos chars =
            let len = tpLength p
                checkers = tpCheckers p
                segment = take len chars
            in if length segment == len && and (zipWith ($) checkers segment)
               then Just (p, pos, segment)
               else tryPatterns ps pos chars
        
        -- 全ての位置を試す
        tryAllPositions pos
            | pos >= length xs = Nothing
            | otherwise =
                case findBestMatch pos (drop pos xs) of
                    Just result -> Just result
                    Nothing -> tryAllPositions (pos + 1)
    
    in tryAllPositions 0

-- スライディングウィンドウ方式で解析
processUnicodesWithPatternMatching :: [Int] -> IO AnalysisResult
processUnicodesWithPatternMatching unicodes = 
    let processChunk :: [Int] -> Int -> [[Int]] -> IO AnalysisResult
        processChunk [] _ acc = return $ AnalysisResult (reverse acc) (length acc)
        processChunk chars@(c:rest) startPos acc = do
            case findLongestPatternSliding allHebrewPatterns chars of
                Just (pat, relPos, seg) -> do
                    let absPos = startPos + relPos
                    -- パターンマッチ前の文字を個別処理
                    let beforeChars = take relPos chars
                        beforeColumns = map (\c -> 0 : [c] ++ replicate 4 0) beforeChars
                    
                    -- パターンを処理
                    let split = tpSplitPoint pat
                        (firstCol, nextCol) = 
                            if split > 0 && split < tpLength pat
                            then (take split seg, drop split seg)
                            else (seg, [])
                        firstColumn = 0 : firstCol ++ replicate (5 - length firstCol) 0
                    
                    let newAcc = reverse beforeColumns ++ acc
                    if null nextCol
                        then do
                            let remainingChars = drop (relPos + tpLength pat) chars
                            processChunk remainingChars (absPos + tpLength pat) (firstColumn : newAcc)
                        else do
                            let nextColumn = 0 : nextCol ++ replicate (5 - length nextCol) 0
                                remainingChars = drop (relPos + tpLength pat) chars
                            processChunk remainingChars (absPos + tpLength pat) (nextColumn : firstColumn : newAcc)
                
                Nothing -> do
                    -- パターンが見つからない場合、最初の文字のみ処理
                    let singleCharColumn = 0 : [c] ++ replicate 4 0
                    processChunk rest (startPos + 1) (singleCharColumn : acc)
    
    in processChunk unicodes 0 []


processUnicodesInBatches :: [Int] -> Int -> IO AnalysisResult
processUnicodesInBatches unicodes batchSize = do
    let batches = chunksOf batchSize unicodes
    results <- mapM processUnicodesWithPatternMatching batches
    let combinedColumns = concatMap columns results
        totalColumns = length combinedColumns
    return $ AnalysisResult combinedColumns totalColumns
  where
    chunksOf :: Int -> [a] -> [[a]]
    chunksOf _ [] = []
    chunksOf n xs = take n xs : chunksOf n (drop n xs)

-- 解析結果データ型
data AnalysisResult = AnalysisResult
    { columns :: [[Int]]
    , totalCols :: Int
    } deriving (Show)

-- 合成文字を作成する関数
createCompositeChar :: [Int] -> String
createCompositeChar unicodes = map chr (filter (\x -> x > 0 && x < 1114112) unicodes)

-- 合成文字のUnicode値を計算(簡略化:最初の文字のUnicodeを使用)
getCompositeUnicode :: String -> Int
getCompositeUnicode compositeStr = case compositeStr of
    [] -> 0
    (c:_) -> ord c

-- 値取得（1行目は常に0を返すよう修正）
getValueAtImproved :: AnalysisResult -> Int -> Int -> Int
getValueAtImproved result row col
    | col < 1 || col > totalCols result = 0
    | row < 1 = 0
    | row == 1 = 0  -- 1行目は常に0
    | otherwise =
        case safeIndex (columns result) (col - 1) of
            Nothing -> 0
            Just colData ->
                case safeIndex colData (row - 1) of
                    Nothing -> 0
                    Just value -> value

-- ★ 値取得 (real_len_advancedと同じインターフェース)
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

real_len_advanced :: CWString -> CInt -> CInt -> CInt -> IO CInt
real_len_advanced cws len_c elem1 elem2 = do
    result <- (do
        if cws == nullPtr
            then return (-1)
            else do
                str <- peekCWStringLen (castPtr cws, fromIntegral len_c)
                let unicodes = map ord (filter (not . isSpace) str)
                
                -- バッチサイズを動的に調整
                let batchSize = max 1000 (length unicodes `div` 10)
                analysisResult <- if length unicodes > 5000
                    then processUnicodesInBatches unicodes batchSize
                    else processUnicodesWithPatternMatching unicodes
                
                let row = fromIntegral elem1
                    col = fromIntegral elem2
                
                if row == 0 && col == 0
                then do
                    let totalColumns = totalCols analysisResult
                        validColumns = length $ filter (\colIdx -> 
                            let colValue = getValueAtImproved analysisResult 2 colIdx
                            in colValue /= 0 && colValue /= -999 && colValue /= -998 && colValue /= -1) [1..totalColumns]
                    return (fromIntegral validColumns)
                else do
                    let value = getValueAtImproved analysisResult row col
                    return (fromIntegral value)
        ) `catch` (\(_ :: SomeException) -> return (-998))
    return result

-- Helper functions
sortBy :: (a -> a -> Ordering) -> [a] -> [a]
sortBy cmp = foldr (insertBy cmp) []

insertBy :: (a -> a -> Ordering) -> a -> [a] -> [a]
insertBy _   x [] = [x]
insertBy cmp x ys@(y:ys') = case cmp x y of
    GT -> y : insertBy cmp x ys'
    _  -> x : ys

on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
on f g x y = f (g x) (g y)

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
    | isArabicDigit char = getArabicValue char  
    | isRomanNumeral char = getRomanValue char  
    | otherwise = case Map.lookup char myDict of
        Just (Right v) -> v
        _ -> 0

-- ★ :real_len_advancedと対応する値解析
analyzeStringForValues :: String -> IO ValueAnalysisResult
analyzeStringForValues str = do
    let strNoSpaces = filter (not . isSpace) str
        unicodes = map ord strNoSpaces
    result <- processUnicodesForValues unicodes
    return result

-- ★ :Unicode処理(real_len_advancedのロジックを値計算用に変更)
processUnicodesForValues :: [Int] -> IO ValueAnalysisResult
processUnicodesForValues unicodes = go unicodes []
  where
    go [] acc = return $ ValueAnalysisResult (reverse acc) (length acc)
    go xs acc = do
        -- まず3文字のローマ数字パターンをチェック
        case checkRomanPattern (take 3 xs) of
            Just (totalValue, 3) -> do
                let patternChars = take 3 xs
                    remaining = drop 3 xs
                    individualValues = calculateIndividualRomanValues patternChars 3 totalValue
                    columns = map (\val -> 0 : [val] ++ replicate 4 0) individualValues
                go remaining (reverse columns ++ acc)
            _ -> 
                -- 次に2文字のローマ数字パターンをチェック
                case checkRomanPattern (take 2 xs) of
                    Just (totalValue, 2) -> do
                        let patternChars = take 2 xs
                            remaining = drop 2 xs
                            individualValues = calculateIndividualRomanValues patternChars 2 totalValue
                            columns = map (\val -> 0 : [val] ++ replicate 4 0) individualValues
                        go remaining (reverse columns ++ acc)
                    _ -> 
                        -- ヘブライ語パターンをチェック
                        case findLongestPatternSliding allHebrewPatterns xs of
                            Just (pat, pos, seg) -> do
                                -- パターンマッチ前の文字を個別処理（修正）
                                let beforeChars = take pos xs
                                    beforeColumns = map (\c -> 
                                        let charPos = length unicodes - length xs + (c `elemIndex'` beforeChars)
                                            charValue = calculateSimpleCharValue unicodes charPos c
                                        in 0 : [charValue] ++ replicate 4 0) beforeChars
                                
                                let patLen = tpLength pat
                                    split = tpSplitPoint pat
                                    (firstColChars, nextColChars) = 
                                        if split > 0 && split < patLen
                                        then (take split seg, drop split seg)
                                        else (seg, [])
                                    -- パターン内文字は専用関数を使用
                                    firstColValues = map (\c -> 
                                        let charPos = length unicodes - length xs + pos + (c `elemIndex'` firstColChars)
                                        in calculateValueForPatternChar unicodes charPos c) firstColChars
                                    firstColumn = 0 : firstColValues ++ replicate (5 - length firstColValues) 0
                                
                                let newAcc = reverse beforeColumns ++ acc
                                if null nextColChars
                                then go (drop (pos + patLen) xs) (firstColumn : newAcc)
                                else do
                                    let nextColValues = map (\c -> 
                                            let charPos = length unicodes - length xs + pos + split + (c `elemIndex'` nextColChars)
                                            in calculateValueForPatternChar unicodes charPos c) nextColChars
                                        nextColumn = 0 : nextColValues ++ replicate (5 - length nextColValues) 0
                                    go (drop (pos + patLen) xs) (nextColumn : firstColumn : newAcc)
                            Nothing ->
                                -- 個別文字処理（修正）
                                case xs of
                                    (firstChar:restChars) -> do
                                        let charPos = length unicodes - length xs
                                            charValue = calculateSimpleCharValue unicodes charPos firstChar
                                            singleCharColumn = 0 : [charValue] ++ replicate 4 0
                                        go restChars (singleCharColumn : acc)

-- ヘルパー関数:リスト内での要素のインデックスを取得
elemIndex' :: Eq a => a -> [a] -> Int
elemIndex' x xs = case elemIndex x xs of
    Just i -> i
    Nothing -> 0
  where
    elemIndex _ [] = Nothing
    elemIndex y (z:zs)
        | y == z = Just 0
        | otherwise = fmap (+1) (elemIndex y zs)

-- ★ より高度な処理:文字列全体での位取り・パターン計算
processSpecialCharsAdvanced :: [Int] -> [Int] -> Int -> [Int]
processSpecialCharsAdvanced allUnicodes chars startPos =     
    map (\(char, offset) -> calculateValueForPatternChar allUnicodes (startPos + offset) char) 
        (zip chars [0..])


-- ★ 高度な値計算(位取り・ローマ数字パターン対応)
calculateValueForPatternChar :: [Int] -> Int -> Int -> Int
calculateValueForPatternChar allUnicodes pos char
    | pos < 0 || pos >= length allUnicodes = 0
    | isArabicDigit char = calculateDigitValue allUnicodes pos
    | otherwise = getCharValue char  -- 辞書参照のみ、ローマ数字の特殊処理は行わない

calculateSimpleCharValue :: [Int] -> Int -> Int -> Int
calculateSimpleCharValue allUnicodes pos char
    | pos < 0 || pos >= length allUnicodes = 0
    | isArabicDigit char = calculateDigitValue allUnicodes pos
    | otherwise = getCharValue char  -- 辞書参照のみ

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
        startPos = fst digitSequence
        sequence = snd digitSequence
        positionInSequence = pos - startPos
        sequenceLength = length sequence
        
        -- 位取り計算 - 右から左へ
        power = sequenceLength - positionInSequence - 1
    in if power >= 0 && positionInSequence >= 0 && positionInSequence < sequenceLength
       then digitValue * (10 ^ power)
       else digitValue

-- ローマ数字の値計算(パターンマッチングによる分岐処理)
calculateRomanValue :: [Int] -> Int -> Int
calculateRomanValue unicodes pos
    | pos >= length unicodes = 0
    | otherwise = 
        let remaining = drop pos unicodes
        in case checkRomanPattern remaining of
            Just (value, _) -> value
            Nothing -> getSingleCharValueSimple (unicodes !! pos)

-- ローマ数字パターンの確認
checkRomanPattern :: [Int] -> Maybe (Int, Int)  -- (値, 消費文字数)
-- 1. Ⅽ Ⅰ Ɔ → 1000の特殊表記（完全一致チェック）
checkRomanPattern (8557:8544:390:_) = Just (1000, 3)

-- 2. （≠Ⅽ）Ⅰ Ɔ → 500の特殊表記（第1文字チェック強化）
checkRomanPattern (x:8544:390:_) 
  | x /= 8557 && (isArabicDigit x || isInMyDict x || isRomanNumeral x) = Just (500, 3)

-- 3. Ⅰ Ɔ → 500の特殊表記（2文字パターンとして追加）
checkRomanPattern (8544:390:_) = Just (500, 2)

-- 4. Ⅰ Ⅼ → 49（減算表記）
checkRomanPattern (8544:8556:_) = Just (49, 2)

-- 5. Ⅰ Ⅹ → 9（減算表記）
checkRomanPattern (8544:8553:_) = Just (9, 2)

-- 6. Ⅰ Ⅴ → 4（減算表記）
checkRomanPattern (8544:8548:_) = Just (4, 2)

-- 7. Ⅹ Ⅼ → 40（減算表記）
checkRomanPattern (8553:8556:_) = Just (40, 2)

-- 8. Ⅹ Ⅽ → 90（減算表記）
checkRomanPattern (8553:8557:_) = Just (90, 2)

-- 9-13. 単一ローマ数字
checkRomanPattern (8544:_) = Just (1, 1)   -- Ⅰ
checkRomanPattern (8548:_) = Just (5, 1)   -- Ⅴ
checkRomanPattern (8553:_) = Just (10, 1)  -- Ⅹ
checkRomanPattern (8556:_) = Just (50, 1)  -- Ⅼ
checkRomanPattern (8557:_) = Just (100, 1) -- Ⅽ

-- 14. Ɔ  → 0（特殊用途）
checkRomanPattern (390:_) = Just (0, 1)

checkRomanPattern _ = Nothing

isInMyDict :: Int -> Bool
isInMyDict x = case Map.lookup x myDict of
    Just (Right _) -> True
    _ -> False

-- ローマ数字パターンの各文字の個別寄与を計算(修正版)
calculateIndividualRomanValues :: [Int] -> Int -> Int -> [Int]
calculateIndividualRomanValues chars consumed totalValue = case (chars, consumed, totalValue) of
    -- 場合1: Ⅽ Ⅰ Ɔ  → 1000 の特殊表記
    (8557:8544:390:_, 3, 1000) -> [0, 1000, 0]
    
    -- 場合2: （≠Ⅽ）Ⅰ Ɔ  → 500 の特殊表記
    (first:8544:390:_, 3, 500) -> 
        let firstCharValue = if isArabicDigit first
                            then getArabicValue first
                            else case Map.lookup first myDict of
                                Just (Right v) -> v
                                _ -> if isRomanNumeral first then getRomanValue first else 0
        in [firstCharValue, 500, 0]
    
    -- 場合3: Ⅰ Ɔ → 500 の特殊表記（2文字パターン）
    (8544:390:_, 2, 500) -> [500, 0]
    
    -- 2文字の減算記法 - 修正版
    (first:second:_, 2, _) -> 
        let firstValue = getRomanValue first
            secondValue = getRomanValue second
        in case (first, second) of
            (8544, 8556) -> [-1, 50]   -- Ⅰ Ⅼ → 49 = -1 + 50
            (8544, 8553) -> [-1, 10]   -- Ⅰ Ⅹ → 9 = -1 + 10  
            (8544, 8548) -> [-1, 5]    -- Ⅰ Ⅴ → 4 = -1 + 5
            (8553, 8556) -> [-10, 50]  -- Ⅹ Ⅼ → 40 = -10 + 50
            (8553, 8557) -> [-10, 100] -- Ⅹ Ⅽ → 90 = -10 + 100
            _ -> [firstValue, secondValue]
    
    -- その他の3文字パターン
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

-- ダゲッシュ判定関数
isDageshStrong :: Int -> Bool
isDageshStrong x = x == 1468  -- Unicode for dagesh (U+05BC)

-- BeGaDKeFaT文字判定
isBeGaDKeFaT :: Int -> Bool
isBeGaDKeFaT x = x `elem` [1489, 1490, 1491, 1499, 1508, 1514]  -- ב ג ד כ פ ת

-- 空白位置を保持したUnicode変換
convertToUnicodesWithSpaceInfo :: String -> [(Int, Bool)]  -- (Unicode, isAfterSpace)
convertToUnicodesWithSpaceInfo str = 
    let processChar :: [Char] -> Bool -> [(Int, Bool)]
        processChar [] _ = []
        processChar (c:cs) wasSpace
            | isSpace c = processChar cs True  -- 空白をスキップするが、次の文字にフラグを設定
            | otherwise = (ord c, wasSpace) : processChar cs False
    in processChar str True  -- 文字列の最初は語境界として扱う

-- 空白情報を考慮した語境界判定
isWordBoundaryWithSpaceInfo :: [(Int, Bool)] -> Int -> Bool
isWordBoundaryWithSpaceInfo unicodeInfo pos
    | pos <= 0 = True  -- 文字列の最初
    | pos >= length unicodeInfo = True  -- 文字列の最後
    | otherwise = snd (unicodeInfo !! pos)  -- 空白後フラグをチェック

-- 修正版：空白情報を考慮した強ダゲッシュ判定
isStrongDageshWithSpaceInfo :: [(Int, Bool)] -> Int -> Bool
isStrongDageshWithSpaceInfo unicodeInfo pos
    | pos < 0 || pos >= length unicodeInfo = False
    | not (isDageshStrong (fst (unicodeInfo !! pos))) = False
    | otherwise = 
        let -- 前の文字をチェック
            prevChar = if pos > 0 then Just (fst (unicodeInfo !! (pos - 1))) else Nothing
            -- 次の文字をチェック（ダゲッシュの直後）
            nextChar = if pos < length unicodeInfo - 1 then Just (fst (unicodeInfo !! (pos + 1))) else Nothing
            -- 現在位置が語境界かチェック
            atWordBoundary = isWordBoundaryWithSpaceInfo unicodeInfo pos
        in case prevChar of
            -- BeGaDKeFaT文字の直後にダゲッシュがある場合
            Just prev | isBeGaDKeFaT prev -> 
                -- 語頭のBeGaDKeFaT + ダゲッシュかどうかをチェック
                if isWordBoundaryWithSpaceInfo unicodeInfo (pos - 1)
                then True  -- 語頭の強ダゲッシュ
                else True  -- 語中の強ダゲッシュ（子音重複）
            -- その他のヘブライ語子音の直後にダゲッシュがある場合は強ダゲッシュ
            Just prev | isHebrewConsonant prev -> True
            -- ダゲッシュが語頭にある場合
            _ -> case nextChar of
                Just next | isBeGaDKeFaT next && atWordBoundary -> True  -- 語頭のBeGaDKeFaT + ダゲッシュ
                _ -> False

-- 修正版：空白情報を考慮した強ダゲッシュ値計算
calculateStrongDageshValueWithSpaceInfo :: [(Int, Bool)] -> Int -> Int
calculateStrongDageshValueWithSpaceInfo unicodeInfo pos
    | not (isStrongDageshWithSpaceInfo unicodeInfo pos) = 0
    | pos <= 0 = 0
    | otherwise = 
        let prevPos = pos - 1
            prevChar = fst (unicodeInfo !! prevPos)
            isAtWordStart = isWordBoundaryWithSpaceInfo unicodeInfo prevPos
        in if isHebrewConsonant prevChar
           then getCharValue prevChar  -- 語頭・語中問わず前の子音と同じ値
           else 0

-- 修正版の値計算関数（空白情報考慮の強ダゲッシュ対応）
calculateValueForPatternCharWithSpaceInfo :: [(Int, Bool)] -> [Int] -> Int -> Int -> Int
calculateValueForPatternCharWithSpaceInfo unicodeInfo allUnicodes pos char
    | pos < 0 || pos >= length allUnicodes = 0
    | isStrongDageshWithSpaceInfo unicodeInfo pos = calculateStrongDageshValueWithSpaceInfo unicodeInfo pos
    | isArabicDigit char = calculateDigitValue allUnicodes pos
    | otherwise = getCharValue char

calculateSimpleCharValueWithSpaceInfo :: [(Int, Bool)] -> [Int] -> Int -> Int -> Int
calculateSimpleCharValueWithSpaceInfo unicodeInfo allUnicodes pos char
    | pos < 0 || pos >= length allUnicodes = 0
    | isStrongDageshWithSpaceInfo unicodeInfo pos = calculateStrongDageshValueWithSpaceInfo unicodeInfo pos
    | isArabicDigit char = calculateDigitValue allUnicodes pos
    | otherwise = getCharValue char

-- 修正版のUnicode処理関数（空白情報考慮の強ダゲッシュ対応）
processUnicodesForValuesWithSpaceInfo :: [(Int, Bool)] -> IO ValueAnalysisResult
processUnicodesForValuesWithSpaceInfo unicodeInfo = 
    let unicodes = map fst unicodeInfo  -- Unicode値のリストを抽出
    in go unicodes []
  where
    go [] acc = return $ ValueAnalysisResult (reverse acc) (length acc)
    go xs acc = do
        -- まず3文字のローマ数字パターンをチェック
        case checkRomanPattern (take 3 xs) of
            Just (totalValue, 3) -> do
                let patternChars = take 3 xs
                    remaining = drop 3 xs
                    individualValues = calculateIndividualRomanValues patternChars 3 totalValue
                    columns = map (\val -> 0 : [val] ++ replicate 4 0) individualValues
                go remaining (reverse columns ++ acc)
            _ -> 
                -- 次に2文字のローマ数字パターンをチェック
                case checkRomanPattern (take 2 xs) of
                    Just (totalValue, 2) -> do
                        let patternChars = take 2 xs
                            remaining = drop 2 xs
                            individualValues = calculateIndividualRomanValues patternChars 2 totalValue
                            columns = map (\val -> 0 : [val] ++ replicate 4 0) individualValues
                        go remaining (reverse columns ++ acc)
                    _ -> 
                        -- ヘブライ語パターンをチェック
                        case findLongestPatternSliding allHebrewPatterns xs of
                            Just (pat, pos, seg) -> do
                                -- パターンマッチ前の文字を個別処理（空白情報考慮）
                                let beforeChars = take pos xs
                                    allUnicodes = map fst unicodeInfo
                                    beforeColumns = map (\c -> 
                                        let charPos = length allUnicodes - length xs + (c `elemIndex'` beforeChars)
                                            charValue = calculateSimpleCharValueWithSpaceInfo unicodeInfo allUnicodes charPos c
                                        in 0 : [charValue] ++ replicate 4 0) beforeChars
                                
                                let patLen = tpLength pat
                                    split = tpSplitPoint pat
                                    (firstColChars, nextColChars) = 
                                        if split > 0 && split < patLen
                                        then (take split seg, drop split seg)
                                        else (seg, [])
                                    -- パターン内文字は専用関数を使用（空白情報考慮）
                                    firstColValues = map (\c -> 
                                        let charPos = length allUnicodes - length xs + pos + (c `elemIndex'` firstColChars)
                                        in calculateValueForPatternCharWithSpaceInfo unicodeInfo allUnicodes charPos c) firstColChars
                                    firstColumn = 0 : firstColValues ++ replicate (5 - length firstColValues) 0
                                
                                let newAcc = reverse beforeColumns ++ acc
                                if null nextColChars
                                then go (drop (pos + patLen) xs) (firstColumn : newAcc)
                                else do
                                    let nextColValues = map (\c -> 
                                            let charPos = length allUnicodes - length xs + pos + split + (c `elemIndex'` nextColChars)
                                            in calculateValueForPatternCharWithSpaceInfo unicodeInfo allUnicodes charPos c) nextColChars
                                        nextColumn = 0 : nextColValues ++ replicate (5 - length nextColValues) 0
                                    go (drop (pos + patLen) xs) (nextColumn : firstColumn : newAcc)
                            Nothing ->
                                -- 個別文字処理（空白情報考慮）
                                case xs of
                                    (firstChar:restChars) -> do
                                        let allUnicodes = map fst unicodeInfo
                                            charPos = length allUnicodes - length xs
                                            charValue = calculateSimpleCharValueWithSpaceInfo unicodeInfo allUnicodes charPos firstChar
                                            singleCharColumn = 0 : [charValue] ++ replicate 4 0
                                        go restChars (singleCharColumn : acc)

-- 修正版の文字列解析関数（空白情報考慮の強ダゲッシュ対応）
analyzeStringForValuesWithSpaceInfo :: String -> IO ValueAnalysisResult
analyzeStringForValuesWithSpaceInfo str = do
    let unicodeInfo = convertToUnicodesWithSpaceInfo str
    result <- processUnicodesForValuesWithSpaceInfo unicodeInfo
    return result

-- ★ 最終修正版:空白情報を考慮した強ダゲッシュ対応のreal_value_new_improved
real_value_new_improved :: CWString -> CInt -> CInt -> CInt -> IO CInt
real_value_new_improved cws len_c elem1 elem2 = do
    result <- (do
        if cws == nullPtr
            then return (-997)
            else do
                str <- peekCWStringLen (castPtr cws, fromIntegral len_c)
                valueResult <- analyzeStringForValuesWithSpaceInfo str  -- 空白情報考慮版を使用
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

