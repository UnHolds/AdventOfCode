


main :: IO ()
main = do
    lines <- readFile "input.txt"
    let input = map (read::String -> Int) (words lines)

    --part 1
    print $ length (filter (uncurry (<)) (zip input (tail input)))

    --part 2
    let list = map (\(x,y,z) -> x+y+z) (zip3 input (tail input) (tail (tail input)))
    print $ length (filter (uncurry (<)) (zip list (tail list)))

    
    
    
            