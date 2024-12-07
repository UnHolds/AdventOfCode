import re
import math
from itertools import chain

with open("input.txt") as f:
    txt = f.read()
    print(sum([math.prod(map(int, x[4:-1].split(","))) for x in re.findall(r"mul\(\d{1,3},\d{1,3}\)", txt)])) #part 1
    cmds = filter(None,chain.from_iterable(re.findall(r"(mul\(\d{1,3},\d{1,3}\))|(don't\(\))|(do\(\))", txt)))
    do = True
    s = 0
    for cmd in cmds:
        if cmd == "don't()":
            do = False
        elif cmd == "do()":
            do = True
        elif do:
            s += math.prod(map(int, cmd[4:-1].split(",")))
    print(s)
