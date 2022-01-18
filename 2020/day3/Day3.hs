module Day3 where

getInput :: IO ()
getInput = do
    input <- readFile "input.txt"
    let treeLines = map cycle $ lines input
    let res = map (\x -> uncurry getTreeEncounter x treeLines) [(1,1), (3,1), (5,1), (7,1), (1,2)]
    print $ res !! 1
    print $ product res



isTree :: [String] -> (Int, Int) -> Bool
isTree treeLines (right, down) = treeLines !! down !! right == '#'

getTreeEncounter :: Int -> Int -> [String] -> Int
getTreeEncounter right down input = length . filter (==True) $ map (isTree input) steps
    where
        lineCount = length input
        downStep = [0,down ..]
        rightStep = [0,right ..]
        stepsInf = zip rightStep downStep
        steps = takeWhile (\x -> snd x < lineCount) stepsInf