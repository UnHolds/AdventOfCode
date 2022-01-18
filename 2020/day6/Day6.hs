module Day6 where

import Data.List

getInput :: IO ()
getInput = do
    input <- readFile "input.txt"
    print $ getEntriesSum $getEntries input
    let mult = moreLines $ getEntryMultipleLines input
    print $ sum $ map getCount mult


getCount :: [String] -> Int
getCount [] = 0
getCount input = length $ [x | x <- ['a' .. 'z'], all (x `elem`) input]

moreLines :: [String] -> [[String]]
moreLines = map (map nub . lines)

getEntryMultipleLines :: String -> [String]
getEntryMultipleLines [] = [[]]
getEntryMultipleLines input = nextEntry input : getEntryMultipleLines (restEntry input)
    where
        nextEntry :: String -> String
        nextEntry [] = []
        nextEntry ('\n' : '\n': xs) = []
        nextEntry (x : xs) = x : nextEntry xs
        restEntry :: String -> String
        restEntry [] = []
        restEntry ('\n' : '\n': xs) = xs
        restEntry (x : xs) = restEntry xs

getEntriesSum :: [String] -> Int
getEntriesSum input = sum (map length input)

getEntries :: String -> [String]
getEntries input = map nub (lines $ oneLine input)

oneLine :: String -> String
oneLine [] = []
oneLine ('\n' : '\n' : xs) = '\n' : oneLine xs
oneLine ('\n' : xs) = oneLine xs
oneLine (x : xs) = x : oneLine xs