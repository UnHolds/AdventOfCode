import numpy as np

def checkBoard():
    new_winner = []
    for i in range(len(boards)):
        if i not in winners:
            for x in range(5):
                bingo = True
                for y in range(5):
                    if boards[i][x][y][1] == 0:
                        bingo = False
                if bingo == True:
                    new_winner.append(i)

            for x in range(5):
                bingo = True
                for y in range(5):
                    if boards[i][y][x][1] == 0:
                        bingo = False
                if bingo == True:
                    new_winner.append(i)
    return list(set(new_winner))

with open("./input.txt") as f:
    lines = f.readlines()
    drawNumbers = lines[0] + lines[1]
    draw = map(int,drawNumbers.split(","))


    boards = np.zeros((((len(lines) - 1) // 6),5,5,2))

    #create boards
    for i in range((len(lines) - 1) // 6):
        for x in range(5):
            data = list(filter(lambda l : l != '', lines[i*6 + x + 2].split(" ")))
            for y in range(5):
                boards[i][x][y][0] = int(data[y])
                boards[i][x][y][1] = 0
                

    won = False
    winners = []      
    for num in draw:
        for i in range(len(boards)):
            for x in range(5):
                for y in range(5):
                    if boards[i][x][y][0] == num:
                        boards[i][x][y][1] = 1
        new_win = checkBoard()
        if len(new_win) > 0:
            winners = winners + new_win
            if not won or len(winners) == ((len(lines) - 1) // 6):
                print("bingo", new_win)
                won = True
                
                for win in new_win:
                    sum1 = 0
                    for x in range(5):
                        for y in range(5):
                            if boards[win][x][y][1] == 0:
                                sum1 += boards[win][x][y][0]
                    if len(winners) == 1:
                        print("first wining board: ", winners[-1])
                    if len(winners) == ((len(lines) - 1) // 6):
                        print("last wining board: ", winners[-1])
                    print(sum1 * num)

