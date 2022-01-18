

with open("./input.txt") as f:
    lines = f.readlines()

    lines = list(map(int, lines))
    
    depth1 = 0
    depth2 = 0
    win = []


    for x in range(1, len(lines)):
        if lines[x - 1] < lines[x]:
            depth1 += 1

    for x in range(0, len(lines)-2):
        y = lines[x] + lines[x+1] + lines[x+2]
        win.append(y)
    
    for x in range(1, len(win)):
        if win[x - 1] < win[x]:
            depth2 += 1
            

    print(depth1)
    print(depth2)