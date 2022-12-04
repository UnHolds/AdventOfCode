

lookup = {
    'A' : 1, #rock
    'B' : 2, #paper
    'C' : 3, #sis
    'X' : 1, #rock / LOSE
    'Y' : 2, #paper / DRAW
    'Z' : 3  #sis / WIN
}

lookup2 = {
    'A X\n' : 0 + 3,
    'A Y\n' : 3 + 1,
    'A Z\n' : 6 + 2,

    'B X\n' : 0 + 1,
    'B Y\n' : 3 + 2,
    'B Z\n' : 6 + 3,

    'C X\n' : 0 + 2,
    'C Y\n' : 3 + 3,
    'C Z\n' : 6 + 1,
}

with open ("input.txt") as f:

    score = 0
    score2 = 0

    for line in f.readlines():
        guess = line[:-1].split(' ')

        if (guess[0] == 'A' and guess[1] == 'Y') or (guess[0] == 'B' and guess[1] == 'Z') or (guess[0] == 'C' and guess[1] == 'X'):
            score = score + 6
        elif lookup[guess[0]] == lookup[guess[1]]:
            score = score + 3

        score = score + lookup[guess[1]]

        score2 = score2 +  lookup2[line]

    print(score)
    print(score2)