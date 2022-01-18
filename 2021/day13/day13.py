
import numpy as np


with open("./input.txt") as f:
    lines = f.readlines()

    foldInstr= []
    dots = []

    for x in lines:
        if x.startswith("fold along"):
            foldInstr.append(x.strip())
        elif len(x) > 1:
            dots.append(list(map(int, x.strip().split(","))))

    first = True
    for inst in foldInstr:
        inst = inst[11:]
        foldAt = int(inst[2:])
        
        if inst[0] == 'x':
            for i in range(len(dots)):
                if dots[i][0] > foldAt:
                    dots[i][0] = foldAt - (dots[i][0] - foldAt)
        else:
            for i in range(len(dots)):
                if dots[i][1] > foldAt:
                    dots[i][1] = foldAt - (dots[i][1] - foldAt)

        dots = [list(x) for x in set(tuple(x) for x in dots)]
        if first:
            first = False
            print("Sol part1:", len(dots))
    
    maxx = np.amax(dots, axis=0)

    for y in range(maxx[1]+1):
        for x in range(maxx[0]+1):
            if [x,y] in dots:
                print("#", end='')
            else:
                print(" ", end='')
        print()