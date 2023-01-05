
def simulate(numKnots):
    with open('input.txt') as f:

        knots = list(map(list, [[0,0]]* numKnots))
        moves = [(0,0)]

        for line in f.readlines():

            for i in range(0, int(line.split(" ")[1])):

                if line[0] == 'R':
                    knots[0][0] += 1
                elif line[0] == 'L':
                    knots[0][0] -= 1
                elif line[0] == 'U':
                    knots[0][1] += 1
                elif line[0] == 'D':
                    knots[0][1] -= 1

                for j in range(1, numKnots):

                    dh = knots[j-1][0] - knots[j][0]
                    dv = knots[j-1][1] - knots[j][1]

                    if abs(dh) >= 2 or abs(dv) >= 2:

                        knots[j][0] += (-1 if dh < 0 else 1) if abs(dh) > 0 else 0
                        knots[j][1] += (-1 if dv < 0 else 1) if abs(dv) > 0 else 0

                        if j == numKnots - 1:
                            moves += [tuple(knots[j])]

        return len(set(moves))


print(simulate(2))
print(simulate(10))