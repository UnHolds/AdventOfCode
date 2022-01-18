module AdventOfCodeDay1 where

find2020 :: IO ()
find2020 = do
    lines <- readFile "input.txt"
    let numbers = map read (words lines)
    print $ head [x*y | x <- numbers, y <- numbers, x + y == 2020]
    

find2020_2 :: IO ()
find2020_2 = do
    lines <- readFile "input.txt"
    let numbers = map read (words lines)
    print $ head [x*y*z | x <- numbers, y <- numbers, z <- numbers, x + y + z == 2020]
    