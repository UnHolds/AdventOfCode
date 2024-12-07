{-# LANGUAGE OverloadedStrings #-}

import Data.Text(splitOn, pack, unpack)
import Data.List (permutations)


check :: [Int] -> [Int] -> (Int -> [Int]) -> Bool
check [] _ _ = True
check (x:xs) ys f
    | all (\ z -> z `notElem` xs || z `elem` ys) (f x) = check xs (x:ys) f
    | otherwise = False

middle :: [a] -> a
middle [x] = x
middle xs = middle . tail . init $ xs

fix :: [Int] -> (Int -> [Int]) -> [Int]
fix [] _ = []
fix (x:xs) f
    | any (`elem` xs) (f x) = fix (xs ++ [x]) f
    | otherwise = x : fix xs f


task1 :: IO ()
task1 = do
    input <- readFile "input.txt"
    let getRules :: Int -> [Int] = \x -> map head $ filter (\(a:b:_) -> b == x) (map (map (read . unpack) . splitOn "|" . pack) $ takeWhile (/="") $ lines input) ++ [[-1]]
    let prod :: [[Int]] = map (map (read . unpack) . splitOn "," . pack) $ tail $ dropWhile (/="") $ lines input
    let res1 = sum $ map middle $ filter (\x -> check x [] getRules) prod
    let invalid = filter (\x -> not $ check x [] getRules) prod
    let res2 = sum $ map (middle . (`fix` getRules)) invalid
    print res1
    print res2