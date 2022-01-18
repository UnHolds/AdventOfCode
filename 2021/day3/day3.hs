import Data.Bits
import Data.Bifunctor
import Numeric


part1 :: [String] -> (Int,Int)
part1 x
    | null (head x) = (0,0)
    | zeros > ones = second ((1 `shiftL` len) +) $ part1 new_x
    | ones > zeros = first ((1 `shiftL` len) +) $ part1 new_x
    where
        zeros = length $ filter (\y -> head y == '0') x
        ones = length $ filter (\y -> head y == '1') x
        len = (-) (length $ head x) 1
        new_x = map tail x


part2 :: [String] -> (Int -> Int -> Bool)  -> Int
part2 [x] op = foldr (\c s -> s * 2 + c) 0 . reverse . map (\y -> if y == '0' then 0 else 1) $ x
part2 x op
    | null (head x) = 0
    | op zeros ones = part2 (map tail $ filter (\y -> head y == '0') x) op
    | otherwise = (1 `shiftL` len) + part2 (map tail $ filter (\y -> head y == '1') x) op
    where
        zeros = length $ filter (\y -> head y == '0') x
        ones = length $ filter (\y -> head y == '1') x
        len = (-) (length $ head x) 1


main :: IO ()
main = do
    inData <- readFile "input.txt"
    let input = lines inData
    print $ uncurry (*) $ part1 input
    print $ part2 input (>) * part2 input (<=)
