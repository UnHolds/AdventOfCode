module Main where

main :: IO ()
main = do
    input <- readFile "input.txt"
    let weakNum = fst $ head $ dropWhile (not . null . snd) $ map isValid (parseNum $ lines input)
    print weakNum
    let numbers = map read $ lines input
    let sets = [z : takeWhile (/= z) (dropWhile (/= y) numbers) | y <- numbers, z <- numbers, not . null $ takeWhile (/= z) (dropWhile (/= y) numbers)]
    let weakSet = head [s |s <- sets, weakNum == sum s]
    print $ maximum weakSet + minimum weakSet


isValid :: (Int, [Int]) -> (Int, [Int])
isValid (num, pre) = (num, [x | x <- [num], y <- pre, z <- pre, x == y + z])

parseNum :: [String] -> [(Int, [Int])]
parseNum s 
    | length s > 26 = (read $ s!!25, map read $ take 25 s) : parseNum (tail s)
    | otherwise = [] :: [(Int, [Int])]