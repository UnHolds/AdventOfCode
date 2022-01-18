module Day2 where

getWrongPasswords :: IO ()
getWrongPasswords = do
    lines <- readFile "input.txt"
    print . length . filter (== True) $ checkPWDString $ words lines

checkPWDString :: [String] -> [Bool]
checkPWDString (nums : inChar : pass : xs)
    | filteredLength < minV || filteredLength > maxV = False : checkPWDString xs
    | otherwise = True : checkPWDString xs
    where
        char = head inChar
        minV = read $ takeWhile (/= '-') nums
        maxV = read . tail $ dropWhile (/= '-') nums
        filteredLength = length $ filter (==char) pass
checkPWDString _ = []


getWrongPasswords2 :: IO ()
getWrongPasswords2 = do
    lines <- readFile "input.txt"
    print . length . filter (== True) $ checkPWDString2 $ words lines

checkPWDString2 :: [String] -> [Bool]
checkPWDString2 (nums : inChar : pass : xs)
    | pass!!pos1 == char && pass!!pos2 /= char = True : checkPWDString2 xs
    | pass!!pos1 /= char && pass!!pos2 == char = True : checkPWDString2 xs
    | otherwise = False : checkPWDString2 xs
    where
        char = head inChar
        pos1 = read (takeWhile (/= '-') nums) - 1  
        pos2 = (read . tail $ dropWhile (/= '-') nums) - 1
checkPWDString2 _ = []