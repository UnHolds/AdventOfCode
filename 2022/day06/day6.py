
def findDestinctPos(line, num):
    l = list(line[:num-1])
    count = num - 1

    for char in line[num - 1:]:
        l.append(char)
        count += 1

        if len(set(l)) == num:
            break

        l = l[1:]
    return count

with open("input.txt") as f:

    line = f.readline()

    print(findDestinctPos(line, 4))
    print(findDestinctPos(line, 14))