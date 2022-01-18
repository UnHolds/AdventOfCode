from itertools import permutations

valid_digits = ['abcefg', 'cf', 'acdeg', 'acdfg', 'bcdf', 'abdfg', 'abdefg', 'acf', 'abcdefg', 'abcdfg']

def getNumber(cur_perm, digits):
    num = 0
    for digit in digits:
        new_digit = ""
        for x in digit:
            index = ord(x) - 97
            new_digit += cur_perm[index]

        new_digit = ''.join(sorted(new_digit))

        new_num = valid_digits.index(new_digit)
        num *= 10
        num += new_num
    return num

def isValidNumber(cur_perm, digit):
    new_digit = ""

    for x in digit:
        index = ord(x) - 97
        new_digit += cur_perm[index]

    new_digit = ''.join(sorted(new_digit))

    if new_digit in valid_digits:
        return True
    else:
        return False

with open("./input.txt") as f:
    
    lines = f.readlines()
    count = 0
    for line in lines:
        
        for word in list(filter(len, line.strip().split("|")[1].split(" "))):
            if len(word) == 2 or len(word) == 3 or len(word) == 4 or len(word) == 7:
                count += 1
    print(count)


    perm = list(permutations(['a', 'b', 'c', 'd', 'e', 'f', 'g']))
    sum = 0
    for line in lines:
        words = list(filter(len, line.replace("|", '').strip().split(" ")))
        for cur_perm in perm:
            valid = True
            for word in words:
                if not isValidNumber(cur_perm, word):
                    valid = False
                    break
            if valid:
                num = getNumber(cur_perm, list(filter(len, line.strip().split("|")[1].split(" "))))
                sum += num
                break
    
    print(sum)
