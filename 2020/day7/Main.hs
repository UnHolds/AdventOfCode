module Main where
    
import Data.List
import Data.List.Split

main :: IO ()
main = do
    input <- readFile "input.txt"
    let bags = map getBags $ lines input
    print $ length $ filter (\x -> containsShinyGold (fst x) [] bags) bags
    let bagsWithNumber =  map getBagsWithNumber $ lines input
    print $ getCount "shiny gold bags" 1 bagsWithNumber - 1 --  -1 do not count the first bag itself



getCount :: String -> Int -> [(String, [(Int, String)])] -> Int
getCount bag count allBags 
    | null containedBagsNothing = count
    | otherwise = count + count * callBagCount containedBags
    where   
        containedBagsNothing = filter (\x -> bag `isInfixOf` fst x) allBags
        containedBags = snd . head $ containedBagsNothing
        callBagCount :: [(Int, String)] -> Int
        callBagCount [] = 0
        callBagCount ((num, bagname) : rest) = getCount bagname num allBags + callBagCount rest

containsShinyGold :: String -> [String]  -> [(String, [String])] -> Bool
containsShinyGold bag checkBags allBags
    | null containedBagsNothing = False
    | any ("shiny gold" `isInfixOf`) containedBags = True
    | any (bag `isInfixOf`) checkBags = False
    | otherwise = any (\x -> containsShinyGold x (bag : checkBags) allBags) containedBags
    where
        containedBagsNothing = filter (\x -> bag `isInfixOf` fst x) allBags
        containedBags = snd . head $ containedBagsNothing


getBagsWithNumber :: String -> (String, [(Int, String)])
getBagsWithNumber x 
    | "other bags" `isInfixOf` head resultBags = (startBag, [])
    | otherwise = (startBag, zip number resultBags)
    where 
        resultBags = map (drop 2) $ splitOn ", " $ takeWhile (/= '.') $ last $ splitOn "contain " x
        number = (map (read . takeWhile (/= ' ')) $ splitOn ", " $ takeWhile (/= '.') $ last $ splitOn "contain " x)  :: [Int]
        startBag = head $ splitOn " contain" x 

getBags :: String -> (String, [String])
getBags x = (startBag, resultBags)
    where 
        resultBags = map (drop 2) $ splitOn ", " $ takeWhile (/= '.') $ last $ splitOn "contain " x
        startBag = head $ splitOn " contain" x 