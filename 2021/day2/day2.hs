
toTuple :: String -> (String,Int)
toTuple x = (head y, read (y !! 1))
    where
        y = words x

part1 :: [(String,Int)] -> (Int,Int)
part1 (("forward", x):xs) = (fst (part1 xs), snd (part1 xs) + x)
part1 (("up", x):xs) = (fst (part1 xs) - x, snd (part1 xs))
part1 (("down", x):xs) = (fst (part1 xs) + x, snd (part1 xs))
part1 _ = (0,0)

part2 :: [(String,Int)] -> Int -> (Int,Int)
part2 (("forward", x):xs) aim = (depth + x * aim, forward + x)
    where (depth, forward) = part2 xs aim
part2 (("up", x):xs) aim = part2 xs (aim - x)
part2 (("down", x):xs) aim = part2 xs (aim + x)
part2 _ _ = (0,0)

main :: IO ()
main = do
    inData <- readFile "input.txt"
    let input = map toTuple (lines inData)
    print $ uncurry (*) $ part1 input
    print $ uncurry (*) $ part2 input 0

   

    
    
    
            