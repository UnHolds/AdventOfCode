with open("./input.txt") as f:
    lines = f.readlines()

    gamma = 0
    epislon = 0

    s = ""
    for i in range(0, len(lines[0]) -1):
        s = ""
        for line in lines:
            s += line[i]
        
        zeros = len(list(filter(lambda x: x == "0", s)))
        ones = len(list(filter(lambda x: x == "1", s)))
        
        if zeros > ones:
            gamma = gamma << 1
            epislon = epislon << 1 | 1
        else:
            gamma = gamma << 1 | 1
            epislon = epislon << 1
    
    print("Part1:", gamma * epislon)



    linesOxy = list(lines)
    linesCo2 = list(lines)

    Oxy = ""
    Co2 = ""
    for i in range(0, len(lines[0]) -1):

        nO = list(filter(lambda x: x[i] == "0", linesOxy))
        nC = list(filter(lambda x: x[i] == "0", linesCo2))
        
        c1 = ""
        c2 = ""

        if len(nO) > len(linesOxy) - len(nO):
            c2 = "0"
        else:
            c2 = "1"
        if len(nC) > len(linesCo2) - len(nC):
            c1 = "1"
        else:
            c1 = "0"

        for j in range(0, len(lines)):
     
            if lines[j][i] == c1:
                linesCo2 = list(filter(lambda x: x != lines[j], linesCo2))
            
            if lines[j][i] == c2:
                linesOxy = list(filter(lambda x: x != lines[j], linesOxy))
            
            if len(linesCo2) == 1:
                Co2 = linesCo2[0]
            if len(linesOxy) == 1:
                Oxy = linesOxy[0]

    print("Part2:", int(Oxy,2)*int(Co2,2))