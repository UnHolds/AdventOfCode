{-# LANGUAGE OverloadedStrings #-}

import Data.Text (splitOn, pack, unpack)
import Data.List(sort)

task1 :: IO ()
task1 = do
    input <- readFile "input1.txt"
    let nums :: [[Integer]] = map (map (read . unpack) . splitOn "   " . pack) $ lines input
    print . sum $ zipWith (\a b -> abs $ a - b) (sort $ map head nums) (sort $ map last nums)


task2 :: IO ()
task2 = do
    input <- readFile "input1.txt"
    let nums :: [[Integer]] = map (map (read . unpack) . splitOn "   " . pack) $ lines input
    print $ sum [sum [y | y <-  map last nums, y == x] | x <- map head nums]