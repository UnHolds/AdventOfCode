
with open("./input.txt") as f:
    lines = f.readlines()

    octoMap = []
    for line in lines:
        row = []
        for x in line.strip():
            row.append(int(x))
        octoMap.append(row)

    flashCounter = 0
    day = 1
    while True:
        for x in range(len(octoMap)):
            for y in range(len(octoMap[0])):
                octoMap[x][y] += 1
        flashed = True
        flashedList = []
        while flashed:
            flashed = False
            for x in range(len(octoMap)):
                for y in range(len(octoMap[0])):
                    if octoMap[x][y] > 9:
                        octoMap[x][y] = 0
                        flashedList.append([x,y])
                        flashed = True
                        flashCounter += 1

                        if x > 0:
                            octoMap[x-1][y] += 1
                            if y > 0:
                                octoMap[x-1][y-1] += 1
                            if y < len(octoMap[x-1]) -1:
                                octoMap[x-1][y+1] += 1

                        if x < len(octoMap) - 1:
                            octoMap[x+1][y] += 1
                            if y > 0:
                                octoMap[x+1][y-1] += 1
                            if y < len(octoMap[x+1]) -1:
                                octoMap[x+1][y+1] += 1

                        if y > 0:
                            octoMap[x][y-1] += 1
                        if y < len(octoMap[x]) - 1:
                            octoMap[x][y+1] += 1

        for z in flashedList:
            octoMap[z[0]][z[1]] = 0

        if day == 99:
            print(flashCounter)
            

        if 0 == sum(sum(octoMap, [])):
            print("step: ",day)
            break
        
        day += 1
    