module Day3 where

import Data.List ( isInfixOf )

getInput :: IO ()
getInput = do
    input <- readFile "input.txt"
    let passportData = lines $ transformIntoSingleLinePassports input
    print $ length $ filter (== True) $ map isValidPassword passportData
    putStrLn (words (passportData!!1)!!1)


transformIntoSingleLinePassports :: String -> String
transformIntoSingleLinePassports [] = []
transformIntoSingleLinePassports ('\n' : '\n' : xs) = '\n' :  transformIntoSingleLinePassports xs
transformIntoSingleLinePassports ('\n' : xs) = ' ' : transformIntoSingleLinePassports xs
transformIntoSingleLinePassports (x : xs) = x : transformIntoSingleLinePassports xs


isValidPassword :: String -> Bool
isValidPassword input = all (`isInfixOf` input) ["byr:", "iyr:", "eyr:", "hgt:", "hcl:", "ecl:", "pid:"] && fieldCheck
    where
        fieldCheck = all ((== True) . checkFields) (words input)



checkHGT :: String -> Bool
checkHGT inData
    | "in" `isInfixOf` inData = hgt >= 59 &&  hgt <= 76
    | "cm" `isInfixOf` inData = hgt >= 150 &&  hgt <= 193
    | otherwise = False
    where
        hgt = read $ takeWhile (<= '9') inData

checkRange :: String -> Int -> Integer -> Integer -> Bool
checkRange input len min max = length input == len && val >= min &&val <= max
    where val = read input

checkFields :: String -> Bool
checkFields ('b' : 'y' : 'r' : ':' : dat) = checkRange dat 4 1920 2002 
checkFields ('i' : 'y' : 'r' : ':' : dat) = checkRange dat 4 2010 2020 
checkFields ('e' : 'y' : 'r' : ':' : dat) = checkRange dat 4 2020 2030 
checkFields ('h' : 'g' : 't' : ':' : dat) = checkHGT dat
checkFields ('h' : 'c' : 'l' : ':' : dat) = length dat == 7  && head dat == '#' && not (any (\x -> x > 'f' && x < '0') dat)
checkFields ('e' : 'c' : 'l' : ':' : dat) = dat `elem` ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
checkFields ('p' : 'i' : 'd' : ':' : dat) = length dat == 9  && not (any (\x -> x > '9' && x < '0') dat)
checkFields ('c' : 'i' : 'd' : ':' : _) = True