import Data.List


findXMAS :: String -> Int
findXMAS ('X':'M':'A':'S':xs) = 1 + findXMAS ('M':'A':'S':xs)
findXMAS ('S':'A':'M':'X':xs) = 1 + findXMAS ('A':'M':'X':xs)
findXMAS (_:xs) = findXMAS xs
findXMAS [] = 0

task1 :: IO ()
task1 = do
    input <- readFile "input.txt"
    let m1 = lines input
    let m2 = transpose m1
    let l = length $ head m1
    let z = groupBy (\(a,b) (c,d) -> a + b == c + d) $ sortBy (\(i, j) (k, l) -> compare (i+j) (k+l)) [(x,y) | x <- [0..(l-1)], y <- [0..(l-1)]]
    let m3 = map (map (\(a,b) -> m1!!a!!b)) z
    let m4 = map (map (\(a,b) -> reverse m1!!a!!b)) z
    let res = sum (map findXMAS m1) + sum (map findXMAS m2) + sum (map findXMAS m3) + sum (map findXMAS m4)
    print res


isXCross :: [String] -> (Int, Int) -> Bool
isXCross m (x,y)
    | m!!(x+1)!!(y+1) == 'M' && m!!(x-1)!!(y-1) == 'S' && m!!(x-1)!!(y+1) == 'M' && m!!(x+1)!!(y-1) == 'S' = True
    | m!!(x+1)!!(y+1) == 'M' && m!!(x-1)!!(y-1) == 'S' && m!!(x-1)!!(y+1) == 'S' && m!!(x+1)!!(y-1) == 'M' = True
    | m!!(x+1)!!(y+1) == 'S' && m!!(x-1)!!(y-1) == 'M' && m!!(x-1)!!(y+1) == 'M' && m!!(x+1)!!(y-1) == 'S' = True
    | m!!(x+1)!!(y+1) == 'S' && m!!(x-1)!!(y-1) == 'M' && m!!(x-1)!!(y+1) == 'S' && m!!(x+1)!!(y-1) == 'M' = True
    | otherwise = False

task2 :: IO ()
task2 = do
    input <- readFile "input.txt"
    let m1 = lines input
    let aPos = filter (\(x,y) -> m1!!x!!y == 'A') [(x,y) | x <-[1..(length m1 - 2)], y <-[1..(length m1 - 2)]]
    let r = length $ filter (isXCross m1) aPos
    print r