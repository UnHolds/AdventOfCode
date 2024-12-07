import Data.List (sortOn, group, sort)

data Direction = UP | DOWN | LEFT | RIGTH deriving (Show, Eq)
type Guard = (Int, Int, Direction)
type Move = (Int, Int, Direction)
type Obstacle = (Int, Int)

calcMoves :: Guard -> [Obstacle] -> [Move]
calcMoves (x,y,d) o
    | d == UP && null upObs = [(a,y, UP) | a <- [0..x]]
    | d == DOWN && null downObs = [(a,y, DOWN) | a <- [x..heighest]]
    | d == LEFT && null leftObs = [(x,b, LEFT) | b <- [0..y]]
    | d == RIGTH && null rigthObs = [(x,b, RIGTH) | b <- [y..heighest]]
    | d == UP = reverse [(a,y, UP) | a <- [(upx+1)..x]] ++ calcMoves (upx + 1, y, RIGTH) o
    | d == DOWN = [(a,y, DOWN) | a <- [x..(downx-1)]] ++ calcMoves (downx - 1, y, LEFT) o
    | d == LEFT = reverse [(x,b, LEFT) | b <- [(lefty+1)..y]] ++ calcMoves (x, lefty + 1, UP) o
    | d == RIGTH = [(x,b, RIGTH) | b <- [y..(righty-1)]] ++ calcMoves (x, righty - 1, DOWN) o
    where
        (upx, upy) = last upObs
        (downx, downy) = head downObs
        (leftx, lefty) = last leftObs
        (rigthx, righty) = head rigthObs
        upObs = sortOn fst $ filter (\(a,b) -> b == y && a < x) o
        downObs = sortOn fst $ filter (\(a,b) -> b == y && a > x) o
        leftObs = sortOn snd $ filter (\(a,b) -> a == x && b < y) o
        rigthObs = sortOn snd $ filter (\(a,b) -> a == x && b > y) o
        heighest = maximum $ map (uncurry max) o


isLoop :: Guard -> [Obstacle] -> Bool
isLoop g o = eval (calcMoves g o) []
    where
        eval :: [Move] -> [Move] -> Bool
        eval [] _ = False
        eval (x@(_,_,d):xs) ys
            | x `elem` ys = True
            | otherwise = eval xs (x:ys)

task1 :: IO ()
task1 = do
    input <- readFile "input.txt"
    let lns = lines input
    let l = length lns
    let obstacles = filter (\(x,y) -> lns!!x!!y == '#') [(x,y) | x <- [0..(l-1)], y <- [0..(l-1)]]
    let guard = head $ dropWhile (\(a,b,_) -> lns!!a!!b /= '^') [(x,y,UP) | x <- [0..(l-1)], y <- [0..(l-1)]]
    let locs = map head . group . sort $ map (\(a,b,_) -> (a,b)) $ calcMoves guard obstacles
    print $ length locs
    let posObsPos = filter (\(x,y) -> lns!!x!!y == '.') locs
    let loops =  filter (\x -> isLoop guard (x : obstacles)) posObsPos
    print $ length loops