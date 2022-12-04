

with open("input.txt") as f:

    count = 0
    count2 = 0

    for l in f.readlines():
        data = list(map(int, '-'.join(l[:-1].split(',')).split('-')))

        range1 = list(range(data[0], data[1] + 1))
        range2 = list(range(data[2], data[3] + 1))

        if all(x in range1 for x in range2) or all(x in range2 for x in range1):
            count += 1
            count2 += 1
        elif len([x for x in range1 if x in range2]) > 0 or len([x for x in range2 if x in range1]) > 0:
            count2 += 1

    print(count)
    print(count2)