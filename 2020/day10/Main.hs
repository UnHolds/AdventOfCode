module Main where

import Data.List

main :: IO ()
main = do
    input <- readFile "input.txt"
    let nums = 0 : sort (map read $ lines input)
    let newNums = nums ++ [maximum nums + 3]
    print $ getDiff1 nums * getDiff3 nums
    print $ getComb2 newNums

getDiff1 :: [Int] -> Int
getDiff1 (x:y:xs)
    | y - x == 1 = 1 + getDiff1 (y:xs)
    | otherwise = getDiff1 (y:xs)
getDiff1 (_:_) = 0

getDiff3 :: [Int] -> Int
getDiff3 (x:y:xs)
    | y - x == 3 = 1 + getDiff3 (y:xs)
    | otherwise = getDiff3 (y:xs)
getDiff3 (_:_) = 1




getStepSizeList :: [Int] -> [Int]
getStepSizeList list = zipWith (-) (tail list) list


removeEveryGroupOtherThan1 :: [[Int]] -> [[Int]] --only 1 runs 
removeEveryGroupOtherThan1 [] = []
removeEveryGroupOtherThan1 (x:xs)
    | head x == 1 = x : removeEveryGroupOtherThan1 xs
    | otherwise = removeEveryGroupOtherThan1 xs

getTribleFib :: [Integer]
getTribleFib = 1 : 1 : 2 : zipWith3 (\x y z -> x + y + z) getTribleFib (drop 1 getTribleFib) (drop 2 getTribleFib)  -- 2 previous  + 1 previous + last (tribe fib) 


{-

runs list after group [[1,1,1], [2,2], [3,3], [1,1]]
only the 1 runs can be interchanged 

because ex: 

[4,6,8] = [2,2] (2 run)
[4, 8] = spacing of 4 -> not okay 
so only the 1 runs are important 

combs of 1 where only one 1 between 1s can be removed

[1,1,1] -> [1,1] valid
[1,1,1,1] -> [1,1,1] valid
[1,1,1,1] -> [1,1] valid

lets check this a bit 

[1] = 1 comb
[1,1] = 2 comb
[1,1,1] = 4 combs [b,c] [a,b] [a,c] [b]
[1,1,1,1] = 7 combs [a,b,c] [a,b,d] [a,c,d] [b,c,d] [a,c] [b,d] [b,c]

so we have a seqence

length -> 1 2 3 4 ...
comb   -> 1 2 4 7 ...

this looks like somthing is adding up (ps I just came accross this because I searched for the fibbonacci sequence in haskell)

1 + 1 = 2
1 + 1 + 2 = 4
1 + 1 + 4 = 7 

we need a fib sequence 

[1,1,2,4,7,13]

newValue = 1 previous + 2 previous + 3 previous

I am not sure how this sequence is called 
-}

getComb2 :: [Int] -> Integer
getComb2 list = product $ map (\x -> getTribleFib !! length x) $ removeEveryGroupOtherThan1 $ group $ getStepSizeList list
