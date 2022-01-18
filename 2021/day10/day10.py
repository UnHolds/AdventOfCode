import numpy as np
score = []
def calcPoints(x):
    if x == ")":
        score.append(3)
    if x == "]":
        score.append(57)
    if x == "}":
        score.append(1197)
    if x == ">":
        score.append(25137)


with open("./input.txt") as f:
    lines = f.readlines()

    score2 = []
    for line in lines:
        line = line.strip()
        stack = []
        valid = True
        for char in line:
            if char in "([{<":
                stack.append(char)
            else:
                if stack == []:
                    valid = False
                    calcPoints(char)
                    break
                stack_val = stack.pop()
                if stack_val == "(" and char != ")":
                    valid = False
                    calcPoints(char)
                    break
                if stack_val == "[" and char != "]":
                    valid = False
                    calcPoints(char)
                    break
                if stack_val == "{" and char != "}":
                    valid = False
                    calcPoints(char)
                    break
                if stack_val == "<" and char != ">":
                    valid = False
                    calcPoints(char)
                    break

        if valid:
            new_score = 0
            for elem in stack[::-1]:
                if elem == "(":
                    new_score = new_score * 5 + 1
                if elem == "[":
                     new_score = new_score * 5 + 2
                if elem == "{":
                     new_score = new_score * 5 + 3
                if elem == "<":
                     new_score = new_score * 5 + 4

            score2.append(new_score)

    print(sum(score))
    print(np.median(score2))
