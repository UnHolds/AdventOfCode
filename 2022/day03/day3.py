def getVal(found):
    if ord ('A') <= ord(found) <= ord('Z'):
        return ord(found) - ord('A') + 27

    if ord ('a') <= ord(found) <= ord('z'):
        return ord(found) - ord('a') + 1

    return None


with open("input.txt") as f:

    score = 0
    lines = f.readlines()
    score1 = 0
    score2 = 0

    for i in range(0, len(lines)):

        line = lines[i]
        n = len(line)
        part1 = line[:n//2]
        part2 = line[n//2:]

        found = ''
        for letter in part1:
            if letter in part2:
                found = letter
                break

        score1 = score1 + getVal(found)

        if i % 3 == 0:
            found = ''
            for letter in lines[i]:
                if letter in lines[i+1] and letter in lines[i+2]:
                    found = letter
                    break

            score2 = score2 + getVal(found)

    print(score1)
    print(score2)



#other idea
with open("input.txt") as f:
    lines = f.readlines()

    print(sum(map(lambda y: ord(y) - 96 if y.islower() else ord(y) - 38, [[x for x in line[:len(line)//2] if x in line[len(line)//2:]][0] for line in lines])))
    print(sum(map(lambda y: ord(y) - 96 if y.islower() else ord(y) - 38, [[l for l in lines[i][:-1] if l in lines[i+1] and l in lines[i+2]][0] for i in range(0 , len(lines), 3)])))