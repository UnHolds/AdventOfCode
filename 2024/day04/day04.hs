{-# LANGUAGE OverloadedStrings #-}

import Data.Text(splitOn, pack, unpack)
import Debug.Trace
import Data.List (permutations)


check :: [Int] -> [Int] -> (Int -> [Int]) -> Bool
check [] _ _ = True
check (x:xs) ys f
    | all (\ z -> z `notElem` xs || z `elem` ys) (f x) = check xs (x:ys) f
    | otherwise = False

middle :: [a] -> a
middle [x] = x
middle xs = middle . tail . init $ xs

task1 :: IO ()
task1 = do
    input <- readFile "input.txt"
    let getRules :: Int -> [Int] = \x -> map head $ filter (\(a:b:_) -> b == x) (map (map (read . unpack) . splitOn "|" . pack) $ takeWhile (/="") $ lines input) ++ [[-1]]
    let prod :: [[Int]] = map (map (read . unpack) . splitOn "," . pack) $ tail $ dropWhile (/="") $ lines input
    let res1 = sum $ map middle $ filter (\x -> check x [] getRules) prod
    let invalid = filter (\x -> not $ check x [] getRules) prod
    let x = sum $ map (middle . head . filter (\x -> check x [] getRules) . permutations) invalid
    print x