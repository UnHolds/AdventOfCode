import math

shipPos = [0,0]
markerPos = [10,1]


def rotate(degree, left):

    if left:
        degree *= -1

    s = round(math.sin(math.radians(degree)), 10)
    c = round(math.cos(math.radians(degree)), 10)
    y_norm = markerPos[0] - shipPos[0]
    x_norm = markerPos[1] - shipPos[1]

    x_new = x_norm * c - y_norm * s
    y_new = x_norm * s + y_norm * c

    markerPos[0] = y_new + shipPos[0]
    markerPos[1] = x_new + shipPos[1]


with open("input.txt", "r") as f:
    for inst in f.readlines():
        if inst[0] == 'E':
            markerPos[0] += int(inst[1:])
        elif inst[0] == 'N':
            markerPos[1] += int(inst[1:])
        elif inst[0] == 'S':
            markerPos[1] -= int(inst[1:])
        elif inst[0] == 'W':
            markerPos[0] -= int(inst[1:])
        elif inst[0] == 'R':
            rotate(int(inst[1:]), False)
        elif inst[0] == 'L':
            rotate(int(inst[1:]), True)
        elif inst[0] == 'F':
            
            xDist = markerPos[0] - shipPos[0]
            yDist = markerPos[1] - shipPos[1]
            shipPos[0] += xDist * int(inst[1:])
            shipPos[1] += yDist * int(inst[1:])
            markerPos[0] += xDist * int(inst[1:])
            markerPos[1] += yDist * int(inst[1:])

print(abs(shipPos[0]) + abs(shipPos[1]))