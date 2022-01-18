module Day5 where


emptySeats :: Integer -> Integer -> Bool
emptySeats _ _ = False


reserveSeat :: Integer -> Integer -> (Integer -> Integer -> Bool) -> (Integer -> Integer -> Bool)
reserveSeat pos1 pos2 oldSeats = newSeats
    where
        newSeats :: Integer -> Integer -> Bool
        newSeats x y
            | x == pos1 && y == pos2 = True
            | otherwise = oldSeats x y

updateSeats :: [String] -> (Integer -> Integer -> Bool) -> (Integer -> Integer -> Bool)
updateSeats [] seats = seats
updateSeats (x:xs) seat = updateSeats xs (reserveSeat (getBordingROW x) (getBordingCOLOM x) seat)


getInput :: IO ()
getInput = do
    input <- readFile "input.txt"
    let seatStrings = lines input
    let seats = updateSeats seatStrings emptySeats
    let validSeats = [x * 8 + y | x <- [0,1 .. 127], y <- [0,1 .. 7], seats x y]
    print $ maximum validSeats
    let mySeat = [x * 8 + y | x <- [0,1 .. 127], y <- [0,1 .. 7], x * 8 + y `notElem` validSeats, x * 8 + y - 1 `elem` validSeats, x * 8 + y + 1 `elem` validSeats]
    print mySeat

getBordingROW :: String -> Integer
getBordingROW input = getBordingROW2 input 0 127
    where 
        getBordingROW2 :: String -> Integer -> Integer -> Integer
        getBordingROW2 ('F' : xs) min max = getBordingROW2 xs min (max - (max - min) `div` 2 - 1)
        getBordingROW2 ('B' : xs) min max = getBordingROW2 xs (min + (max - min) `div` 2 + 1) max
        getBordingROW2 _ pos _ = pos

getBordingCOLOM :: String -> Integer
getBordingCOLOM input = getBordingCOLOM2 input 0 7
    where
        getBordingCOLOM2 :: String -> Integer -> Integer -> Integer
        getBordingCOLOM2 ('F' : xs) min max = getBordingCOLOM2 xs min max
        getBordingCOLOM2 ('B' : xs) min max = getBordingCOLOM2 xs min max
        getBordingCOLOM2 ('L' : xs) min max = getBordingCOLOM2 xs min (max - (max - min) `div` 2 - 1)
        getBordingCOLOM2 ('R' : xs) min max = getBordingCOLOM2 xs (min + (max - min) `div` 2 + 1) max
        getBordingCOLOM2 _ pos _ = pos