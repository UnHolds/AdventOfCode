module Main where


data Dir = UP | DOWN | LEFT | RIGHT | LEFTUP | RIGHTUP | LEFTDOWN | RIGHTDOWN deriving (Eq)

main :: IO ()
main = do
    input <- readFile "input.txt"
    let startSeats = lines input
    print $ length $ filter (=='#') $ concat $ simFull startSeats (length startSeats) (length $ head startSeats);
    print $ length $ filter (=='#') $ concat $ simFull2 startSeats (length startSeats) (length $ head startSeats);

    

simFull :: [[Char]] -> Int -> Int -> [[Char]]
simFull seats maxY maxX
    | seats == newSeats = newSeats
    | otherwise = simFull newSeats maxY maxX
    where
        newSeats = sim seats maxY maxX


simFull2 :: [[Char]] -> Int -> Int -> [[Char]]
simFull2 seats maxY maxX
    | seats == newSeats = newSeats
    | otherwise = simFull2 newSeats maxY maxX
    where
        newSeats = sim2 seats maxY maxX


sim :: [[Char]] -> Int -> Int -> [[Char]]
sim list maxY maxX = [[getSymbol list y x maxY maxX | x <- [0 .. (maxX - 1)]]|  y <- [0 .. (maxY - 1)]]


sim2 :: [[Char]] -> Int -> Int -> [[Char]]
sim2 list maxY maxX = [[getSymbol2 list y x maxY maxX | x <- [0 .. (maxX - 1)]]|  y <- [0 .. (maxY - 1)]]

getSymbol :: [[Char]] -> Int -> Int -> Int -> Int -> Char
getSymbol list y x maxY maxX
    | list!!y!!x == '#' && length neighbours >= 4 = 'L'
    | list!!y!!x == 'L' && null neighbours = '#'
    | otherwise = list!!y!!x
    where
        neighbours = filter (=='#') $ getListElement list (x - 1) (y - 1) maxY maxX ++ getListElement list x (y - 1) maxY maxX ++ getListElement list (x + 1) (y - 1) maxY maxX ++ getListElement list (x - 1) y maxY maxX ++ getListElement list (x + 1) y maxY maxX ++ getListElement list (x - 1) (y + 1) maxY maxX ++ getListElement list x (y + 1) maxY maxX ++ getListElement list (x + 1) (y + 1) maxY maxX


getSymbol2 :: [[Char]] -> Int -> Int -> Int -> Int -> Char
getSymbol2 list y x maxY maxX
    | list!!y!!x == '#' && length neighbours >= 5 = 'L'
    | list!!y!!x == 'L' && null neighbours = '#'
    | otherwise = list!!y!!x
    where
        neighbours = filter (=='#') $ findNext ++ findNext2
        findNext =  getListElement2 list x (y - 1) maxY maxX UP ++ getListElement2 list x (y + 1) maxY maxX DOWN ++ getListElement2 list (x + 1) y maxY maxX RIGHT ++ getListElement2 list (x - 1) y maxY maxX LEFT
        findNext2 = getListElement2 list (x - 1) (y - 1) maxY maxX LEFTUP ++ getListElement2 list (x + 1) (y - 1) maxY maxX RIGHTUP ++ getListElement2 list (x - 1) (y + 1) maxY maxX LEFTDOWN ++ getListElement2 list (x + 1) (y + 1) maxY maxX RIGHTDOWN


getListElement :: [[Char]] -> Int -> Int -> Int -> Int -> [Char]
getListElement list x y maxY maxX
    | x > maxX - 1 || x < 0 = []
    | y > maxY - 1 || y < 0 = []
    | otherwise = [list!!y!!x]


getListElement2 :: [[Char]] -> Int -> Int -> Int -> Int -> Dir -> [Char]
getListElement2 list x y maxY maxX dir
    | x > maxX - 1 || x < 0 = []
    | y > maxY - 1 || y < 0 = []
    | list!!y!!x /= '.' =  [list!!y!!x]
    | dir == UP = getListElement2 list x (y-1) maxY maxX dir
    | dir == DOWN = getListElement2 list x (y+1) maxY maxX dir
    | dir == LEFT = getListElement2 list (x-1) y maxY maxX dir
    | dir == RIGHT = getListElement2 list (x+1) y maxY maxX dir
    | dir == LEFTUP = getListElement2 list (x-1) (y-1) maxY maxX dir
    | dir == LEFTDOWN = getListElement2 list (x-1) (y+1) maxY maxX dir
    | dir == RIGHTUP = getListElement2 list (x+1) (y-1) maxY maxX dir
    | dir == RIGHTDOWN = getListElement2 list (x+1) (y+1) maxY maxX dir

