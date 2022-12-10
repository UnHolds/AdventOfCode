
def gTl(l, r):
    n = []
    for x in l:
        n += [x]
        if x >= r:
            break
    return n


with open("input.txt") as f:

    t = list(map(lambda x: list(map(int,[*x[:-1]])) ,f.readlines()))

    vis = len(t) * 2 + len(t[0]) * 2 - 4
    score = []
    for x in range(1, len(t) - 1):
        for y in range(1, len(t[0]) - 1):

            if all(map(lambda z: z < t[x][y], t[x][:y])) or all(map(lambda z: z < t[x][y], t[x][y+1:]))  or all(map(lambda z: z < t[x][y], [a[y] for a in t[:x]]))  or all(map(lambda z: z < t[x][y], [a[y] for a in t[x+1:]])):
                vis += 1

            score += [len(gTl(t[x][:y][::-1], t[x][y])) * len(gTl(t[x][y+1:], t[x][y])) * len(gTl([a[y] for a in t[:x]][::-1], t[x][y])) * len(gTl([a[y] for a in t[x+1:]], t[x][y]))]

    print(vis)
    print(max(score))