

def part1():
    for x in range(firstLeave, firstLeave + 1000):
        
        for bus in busses:
            
            if x % bus == 0:
                print("Part1: ", (x - firstLeave) * bus)
                return

def part2():

    #chinese remainder theorem
    N = 1

    for bus in busses:
        N *= bus
    
    Ni = []
    for bus in busses:
        Ni.append(N // bus)

    Xi =[]
    for i in range(0, len(busses)):
        for x in range (0, 10000):
            if Ni[i] * x % busses[i] == 1:
                Xi.append(x)
                break

    biNiXi = []
    for i in range(0, len(busses)):
        biNiXi.append(remainder[i] * Ni[i] * Xi[i])

    answer = sum(biNiXi)%N

    print("Part2: ", answer)

with open("./input.txt") as f:
    lines = f.readlines()

    firstLeave = int(lines[0])
    busses = list(map(int, filter(lambda x : x != "x", lines[1].split(","))))

    remainder = []
    i = 0
    busses2 = lines[1].split(",")
    for x in range(0, len (busses2)):
        if busses2[x] != "x":
            #bi
            remainder.append(int(busses2[i]) - (i % int(busses2[i])))
        i += 1
    part1()
    part2()
    
   