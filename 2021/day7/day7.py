


with open("./input.txt") as f:
    
    lines = f.readlines()
    crabs = list(map(int,lines[0].split(",")))
    
    minFuel_1 = float('inf')
    bestPos_1 = -1
    minFuel_2 = minFuel_1
    bestPos_2 = -1

    minCrab = min(crabs)
    maxCrab = max(crabs)

    fuellist = [0]
    for n in range(1, max(crabs) + 2):
        fuellist.append(fuellist[n-1] + n)

    carbRange = range(minCrab, maxCrab + 1)

    for pos in carbRange:
        fuel_1 = 0
        fuel_2 = 0
        for crab in crabs:
            if crab > pos:
                fuel_1 += crab - pos
                fuel_2 +=  fuellist[(crab - pos +1)]        
            else:
                fuel_1 -= crab - pos
                fuel_2 +=  fuellist[(pos - crab +1)]

        if fuel_1 < minFuel_1:
            minFuel_1 = fuel_1
            bestPos_1 = pos

        if fuel_2 < minFuel_2:
            minFuel_2 = fuel_2
            bestPos_2 = pos

    print(bestPos_1, minFuel_1)
    print(bestPos_2, minFuel_2)


