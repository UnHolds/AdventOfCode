import os


def getSize(files):
    size = 0
    for file in files:
        size += int(file.split(" ")[0])

    return size


with open("input2.txt") as f:
    dirs = []
    files = []
    filesInDir = {}
    dir = "."
    readFiles = False
    for line in f.readlines():

        if line.startswith("$ cd "):

            if readFiles:
                filesInDir[dir] = files
                readFiles = False
                files = []

            if line[5:-1] == "/":
                dir = "/"
            elif dir[-1] == "/":
                dir += line[5:-1]
            else:
                dir += "/" + line[5:-1]

            dir = os.path.normpath(dir)

        if line.startswith("$ ls"):
            dirs.append(dir)

            if readFiles:
                filesInDir[dir] = files
                readFiles = False
                files = []
            readFiles = True

        if line[0] != '$' and line[:4] != "dir ":
            files.append(line[:-1])

    if readFiles:
        filesInDir[dir] = files
        readFiles = False
        files = []
    readFiles = True


    dirToDelete = {}

    #part1
    total = 0
    for path in filesInDir:
        size = 0
        for p2 in [p for p in filesInDir if p.startswith(path) and len(p) > len(path)] + [path]:
            size += getSize(filesInDir[p2])

        dirToDelete[path] = size

        if size <= 100000:
            total += size


    #part2
    dirFreeSpace = {}
    for path in dirToDelete:
        dirFreeSpace[path] = 70000000 - dirToDelete["/"] + dirToDelete[path] - 30000000

    bestPath = ""
    bestSpace = 70000000
    for path in dirFreeSpace:
        if dirFreeSpace[path] > 0 and dirFreeSpace[path] < bestSpace:
            bestPath = path
            bestSpace = dirFreeSpace[path]


    print(total)
    print(dirToDelete[bestPath])