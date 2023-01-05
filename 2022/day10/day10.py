
def check(x,c):
    if (c + 20) % 40 == 0:
        return [x*c]
    return []

with open("input.txt") as f:

    s = []
    c = 0
    x = 1
    for l in f.readlines():
        c += 1
        s += check(x,c)
        if l.startswith("addx"):
            c += 1
            s += check(x,c)
            x += int(l.split(" ")[1])
    print(sum(s))


with open("input.txt") as f:
    lines = f.readlines()

    maxCycles = len(list(filter(lambda x: x.startswith("addx"), lines))) * 2 + len(list(filter(lambda x: x.startswith("noop"), lines)))

    screen = list(map(list, [" "*40]*(maxCycles//40)))

    c = 0
    x = 1
    crLine = 0
    for l in lines:
        c += 1

        if c % 40 - 1 == x or c % 40 - 1 == x - 1 or c % 40 - 1 == x + 1:
            screen[crLine][c % 40 - 1] = '█'
        if c % 40 == 0:
                crLine += 1

        if l.startswith("addx"):
            c += 1
            if c % 40 - 1 == x or c  % 40 - 1 == x - 1 or c  % 40 - 1 == x + 1:
                screen[crLine][c % 40 - 1] = '█'
            if c % 40 == 0:
                crLine += 1
            x += int(l.split(" ")[1])

    for l in screen:
        print(''.join(l)[:-1])