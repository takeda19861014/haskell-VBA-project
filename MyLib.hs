{-# LANGUAGE ForeignFunctionInterface #-}
module MyLib where

import Foreign
import Foreign.C.Types
import Foreign.C.String (CWString, peekCWStringLen, CString, withCString)
import qualified Data.Map.Strict as Map
import Data.Char (isSpace, ord, chr)
import Control.Exception (catch, SomeException)
import System.IO.Unsafe (unsafePerformIO)
import Data.List (find)
import Data.Maybe (listToMaybe)

-- デバッグ出力
foreign import ccall "OutputDebugStringA" outputDebugString :: CString -> IO ()

debugMsg :: String -> IO ()
debugMsg msg = withCString ("HASKELL: " ++ msg) outputDebugString

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

-- ヘブライ語文字種判定（より安全に）
isHebrewMain :: Int -> Bool
isHebrewMain x = x >= 1488 && x <= 1522

isDagesh :: Int -> Bool
isDagesh x = x == 1468

isBiblePoint :: Int -> Bool
isBiblePoint x = (x >= 1425 && x <= 1455) || x == 1469

isVowelEtc :: Int -> Bool
isVowelEtc x = (x >= 1456 && x <= 1459) || x == 1467 || x == 1479

-- パターン定義
data HebrewPattern = HebrewPattern
    { patternName :: String
    , patternLength :: Int
    , patternMatcher :: [Int] -> Bool
    }

-- パターン定義リスト
hebrewPatterns :: [HebrewPattern]
hebrewPatterns = [
    HebrewPattern "4char_pattern" 4 $ \xs -> case xs of
        (a:b:c:d:_) -> isHebrewMain a && isDagesh b && isBiblePoint c && isVowelEtc d
        _ -> False,
    
    HebrewPattern "3char_pattern" 3 $ \xs -> case xs of
        (a:b:c:_) -> isHebrewMain a && isDagesh b && isBiblePoint c
        _ -> False
    ]

-- 最長パターンマッチング（安全版）
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

-- 合成文字のUnicode値を計算（簡略化：最初の文字のUnicodeを使用）
getCompositeUnicode :: String -> Int
getCompositeUnicode compositeStr = case compositeStr of
    [] -> 0
    (c:_) -> ord c

-- 文字列解析（安全版）- 修正版：1行目に合成文字のUnicode値を格納
analyzeString :: String -> IO AnalysisResult
analyzeString str = do
    debugMsg $ "analyzeString: 入力=" ++ str
    let strNoSpaces = filter (not . isSpace) str
        unicodes = map ord strNoSpaces
    debugMsg $ "analyzeString: Unicode配列=" ++ show unicodes
    result <- processUnicodes unicodes
    debugMsg $ "analyzeString: 結果=" ++ show result
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
                    patternChars = take patLen xs
                    remaining = drop patLen xs
                    -- 合成文字を作成
                    compositeStr = createCompositeChar patternChars
                    compositeUnicode = getCompositeUnicode compositeStr
                    -- 6行構成：1行目=合成文字のUnicode値、2-6行目=各構成文字（不足分は0で埋める）
                    newColumn = 0 : patternChars ++ replicate (5 - length patternChars) 0
                debugMsg $ "パターン発見: " ++ patternName pattern ++ 
                          ", 構成文字=" ++ show patternChars ++ 
                          ", 合成文字=" ++ compositeStr ++ 
                          ", 合成Unicode=" ++ show compositeUnicode ++
                          ", 列=" ++ show newColumn
                go remaining (pos + patLen) (newColumn : acc)
            Nothing ->
                case safeIndex xs 0 of
                    Just firstChar -> do
                        let restChars = drop 1 xs
                            -- 単一文字の場合：1行目=その文字、2行目=その文字、3-6行目=0
                            singleCharColumn = 0 : [firstChar] ++ replicate 4 0
                        debugMsg $ "単一文字: " ++ show firstChar ++ ", 列=" ++ show singleCharColumn
                        go restChars (pos + 1) (singleCharColumn : acc)
                    Nothing -> 
                        -- 理論的には到達しないが、安全のため
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

-- 合成文字の取得（デバッグ用）
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

-- メイン関数（修正版）
real_len_advanced :: CWString -> CInt -> CInt -> CInt -> IO CInt
real_len_advanced cws len_c elem1 elem2 = do
    debugMsg "real_len_advanced: 開始"
    result <- (do
        if cws == nullPtr
            then do
                debugMsg "real_len_advanced: NULL pointer"
                return (-1)
            else do
                str <- peekCWStringLen (castPtr cws, fromIntegral len_c)
                let unicodes = map ord str
                debugMsg $ "real_len_advanced: 入力文字列長=" ++ show (length str) ++ ", Unicode値=" ++ show unicodes
                
                analysisResult <- analyzeString str
                let row = fromIntegral elem1
                    col = fromIntegral elem2
                
                debugMsg $ "real_len_advanced: row=" ++ show row ++ ", col=" ++ show col
                
                let value = getValueAt analysisResult row col
                
                -- デバッグ情報を追加
                if row == 1
                    then do
                        let compositeStr = getCompositeChar analysisResult col
                        debugMsg $ "real_len_advanced: 1行目, 合成文字=" ++ compositeStr ++ 
                                  ", 戻り値=" ++ show value
                    else do
                        debugMsg $ "real_len_advanced: " ++ show row ++ "行目, 戻り値=" ++ show value
                
                return (fromIntegral value)
                        
        ) `catch` (\e -> do
            debugMsg $ "real_len_advanced: 例外=" ++ show (e :: SomeException)
            return (-998)
        )
    
    debugMsg $ "real_len_advanced: 終了, 結果=" ++ show result
    return result

-- 既存関数（修正版）
real_len :: CWString -> CInt -> CInt -> CInt -> IO CInt
real_len cws len_c elem1 elem2 = do
    debugMsg "real_len: 開始"
    result <- (do
        if cws == nullPtr
            then do
                debugMsg "real_len: NULL pointer"
                return (-1)
            else do
                str <- peekCWStringLen (castPtr cws, fromIntegral len_c)
                debugMsg $ "real_len: 入力=" ++ str ++ ", 長さ=" ++ show (length str)
                
                let strNoSpaces = filter (not . isSpace) str
                    idx = fromIntegral elem2 - 1
                
                debugMsg $ "real_len: インデックス=" ++ show idx ++ ", 文字列長=" ++ show (length strNoSpaces)
                
                case strNoSpaces of
                    [] -> do
                        debugMsg "real_len: 空文字列"
                        return 0
                    _ -> case safeIndex strNoSpaces idx of
                        Nothing -> do
                            debugMsg "real_len: 範囲外"
                            return (-1)
                        Just ch -> do
                            let unicodeVal = ord ch
                            debugMsg $ "real_len: 文字=" ++ [ch] ++ ", Unicode=" ++ show unicodeVal
                            return (fromIntegral unicodeVal)
                        
        ) `catch` (\e -> do
            debugMsg $ "real_len: 例外=" ++ show (e :: SomeException)
            return (-998)
        )
    
    debugMsg $ "real_len: 終了, 結果=" ++ show result
    return result

-- エクスポート
foreign export ccall real_len :: CWString -> CInt -> CInt -> CInt -> IO CInt
foreign export ccall real_len_advanced :: CWString -> CInt -> CInt -> CInt -> IO CInt