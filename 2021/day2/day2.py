

with open("./input.txt") as f:
    lines = f.readlines()

    data = []
    for z in lines:
        y = z.split()
        data.append((y[0], int(y[1])))

    x = 0
    depth = 0
    aim = 0
    for inst in data:
        if inst[0] == "forward":
            x += inst[1]
            depth += inst[1] * aim
        elif inst[0] == "down":
            aim += inst[1]
        elif inst[0] == "up":
            aim -= inst[1]

    print(x*aim)
    print(x*depth)