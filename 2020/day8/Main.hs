module Main where

import Data.List
import Debug.Trace

type AbsJmpAddr = Int
type Visited = [AbsJmpAddr]
type AccValue = Int

data AccRes = LOOP AccValue | FIN AccValue deriving (Show)

type RelJmpAddr = Int
type AccInc = Int
type Operation = String

data Command = CMD Operation AccInc RelJmpAddr deriving (Show)

main :: IO ()
main = do
    input <- readFile "input.txt"
    let cmdsStrings = lines input
    let cmds = map parseCommands cmdsStrings
    print $ execute (head cmds) cmds 0 0 []
    let mulCmds = map (parseCommands2 cmdsStrings 0) [0..627]
    print $ filter isFin $ map (\x -> execute (head x) x 0 0 []) mulCmds
    
isFin :: AccRes -> Bool
isFin (FIN _) = True
isFin _ = False

execute:: Command -> [Command] -> AccValue -> AbsJmpAddr -> Visited -> AccRes
execute (CMD _ accIns reljmp) allCmds accVal absAddr visAddr
    | absAddr `elem` visAddr = LOOP accVal
    | newAbsAddr >= length allCmds = FIN accVal
    | otherwise =  execute (allCmds!!newAbsAddr) allCmds newAccVal newAbsAddr newVisAddr
    where  
        newAbsAddr = absAddr + reljmp
        newAccVal = accVal + accIns
        newVisAddr = absAddr : visAddr


read2 :: String -> Int
read2 s
    | head s == '+' = read $ tail s
    | head s == '-' = read (tail s) * (- 1)

parseCommands :: String -> Command
parseCommands s
    | "nop" `isInfixOf` s = CMD "nop" 0 1 
    | "acc" `isInfixOf` s = CMD "acc" (read2 . tail $ dropWhile (/= ' ') s) 1
    | "jmp" `isInfixOf` s = CMD "jmp" 0 (read2 . tail $ dropWhile (/= ' ') s) 


parseCommands2 :: [String] -> Int -> Int -> [Command]
parseCommands2 [] _ _ = []
parseCommands2 (s:xs) count over = parseCommandsWithOverride s count over : parseCommands2 xs (count + 1) over

parseCommandsWithOverride :: String -> Int -> Int -> Command
parseCommandsWithOverride s count over
    | "nop" `isInfixOf` s && count /= over = CMD "nop" 0 1 
    | "jmp" `isInfixOf` s && count /= over = CMD "jmp" 0 (read2 . tail $ dropWhile (/= ' ') s) 
    | "jmp" `isInfixOf` s && count == over = CMD "nop" 0 1 
    | "nop" `isInfixOf` s && count == over = CMD "jmp" 0 (read2 . tail $ dropWhile (/= ' ') s) 
    | "acc" `isInfixOf` s = CMD "acc" (read2 . tail $ dropWhile (/= ' ') s) 1