import numpy as np

with open("input.txt") as f:
    coord = f.readlines()

    lines = []

    for cor in coord:
        lines.append(list(map(int,cor.replace(" -> ", ",").split(","))))


    lines = np.array(lines)

    maxi = np.amax(lines) + 1

    grid = np.zeros((maxi,maxi))


    for line in lines:

        if line[0] == line[2]:
            for x in range(min(line[1], line[3]), max(line[1], line[3]) + 1):
                grid[x][line[0]] += 1

        elif line[1] == line[3]:
             for x in range(min(line[0], line[2]), max(line[0], line[2]) + 1):
                grid[line[1]][x] += 1


        else:
            range1 = []
            if line[0] < line[2]:
                range1 = list(range(line[0], line[2] + 1))
            else:
                range1 = list(range(line[0], line[2] - 1, -1))

            range2 = []
            if line[1] < line[3]:
                range2 = list(range(line[1], line[3] + 1))
            else:
                range2 = list(range(line[1], line[3] - 1, -1))


            for x in range(0, len(range1)):
                    grid[range2[x]][range1[x]] += 1

    danger = 0
    for x in grid:
        for y in x:
            if y > 1:
                danger += 1



    print(danger)