

def floodfill(map, num, x,y):
    map[x][y] = num

    if x < len(map) - 1:
        if map[x+1][y] == -1:
            floodfill(map, num,x+1,y)

    if y < len(map[x]) - 1:
        if map[x][y+1] == -1:
            floodfill(map, num,x,y+1)

    if x > 0:
        if map[x-1][y] == -1:
            floodfill(map, num,x-1,y)

    if y > 0:
        if map[x][y-1] == -1:
            floodfill(map, num,x,y-1)




with open("./input.txt") as f:
    lines = f.readlines()

    map = []

    for line in lines:
        row = []
        for num in line.strip():
            row.append(int(num))
        map.append(row)

    summe = 0
    for x in range(len(map)):
        for y in range(len(map[0])):
        
            center = map[x][y]

            up = 10
            if x < len(map) - 1:
                up = map[x+1][y]

            left = 10
            if y < len(map[x]) - 1:
                left = map[x][y+1]


            down = 10
            if x > 0:
                down = map[x-1][y]

            right = 10
            if y > 0:
                right = map[x][y-1]

            if center < up and center < down and center < left and center < right:
                summe += center + 1
    print(summe)



    map2 = []
    for line in lines:
        row = []
        for num in line.strip():
            if int(num) < 9:
                row.append(-1)
            else:
                row.append(-2)
        map2.append(row)

    floodnum = 0   
    for x in range(len(map)):
        for y in range(len(map[0])):
            if map2[x][y] == -1:
                floodfill(map2,floodnum, x,y)
                floodnum+= 1

    map3 = sum(map2, [])
    basinSizes = []
    for c in range(max(map3) + 1):
        basinSizes.append(map3.count(c))

    res = 1
    basinSizes.sort(reverse=True)
    for x in range(3):
        res *= basinSizes[x]

    print(res)