


with open("./input.txt") as f:
    lines = f.readlines()
    
    mask = ""
    index = 0
    value = 0

    storage = {}

    number = "000000000000000000000000000000000000"

    for line in lines:
        
        if "mask = " in line:
            mask = line[7:-1]
        else:
            index = int(line[4:].split("]")[0])
            value = format(int(line.split("=")[1]), "b")

            value = list(number[:(len(number) - len(value))] + value)

            for i, bit in enumerate(mask):
                if bit != "X":
                    value[i] = bit
        
            storage[index] = int("".join(value), 2)

    res = 0
    for elem in storage:
        res += storage[elem]

    print(res)

#part 2 --------
#TODO
    for line in lines:
        
        if "mask = " in line:
            mask = line[7:-1]
        else:
            index = int(line[4:].split("]")[0])
            value = format(int(line.split("=")[1]), "b")