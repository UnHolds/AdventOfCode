{-# LANGUAGE OverloadedStrings #-}

import Data.Text (splitOn, pack, unpack)

task1 :: IO ()
task1 = do
    input <- readFile "input.txt"
    let numbers :: [[Integer]] = map (map (read . unpack) . splitOn " " . pack) (lines input)
    print . length $ filter (\l -> all (\(x,y) -> x < y && y - x <= 3) (zip l (tail l)) || all (\(x,y) -> y < x && x - y <= 3) (zip l (tail l))) numbers


expand :: [Integer] -> [Integer] -> [[Integer]]
expand [] _ = []
expand (x:xs) ys = (ys ++ xs) : expand xs (ys ++ [x])

checkReport :: [Integer] -> Bool
checkReport l = all (\(x,y) -> x < y && y - x <= 3) (zip l (tail l)) || all (\(x,y) -> y < x && x - y <= 3) (zip l (tail l))

task2 :: IO ()
task2 = do
    input <- readFile "input.txt"
    let numbers :: [[Integer]] = map (map (read . unpack) . splitOn " " . pack) (lines input)
    print . length $ filter (any checkReport . (`expand` [])) numbers