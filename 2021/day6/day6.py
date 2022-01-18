


with open("./input.txt") as f:
    lines = f.readlines()
    fishies = list(map(int,lines[0].split(",")))
    fishies2 = list(fishies)

    for x in range(80):
        newFishies = 0
        for i in range(len(fishies)):

            if fishies[i] == 0:
                newFishies += 1
                fishies[i] = 6
            else:
                fishies[i] -= 1
        
        for i in range(newFishies):
            fishies.append(8)
    print(len(fishies))


    superFishies = []
    for x in range(9):
        numFish = len(list(filter(lambda y: y == x, fishies2)))
        superFishies.append(numFish)

    for x in range(256):
        temp = 0
        for y in range(9):
            if y == 0:
                temp = superFishies[0]
            else:
                superFishies[y - 1] = superFishies[y]
        superFishies[8] = temp
        superFishies[6] += temp

    res = 0
    for fish in superFishies:
        res += fish

    print(res)