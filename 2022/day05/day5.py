
with open("input.txt") as f:

    lines = f.readlines()

    #parse
    stacklines = '*'.join(lines).split('*\n*')[0].split('\n*')[:-1]
    stacklines = [[sl[i:i+4].replace(' ', '').replace('[', '').replace(']','') for i in range(0, len(sl), 4)] for sl in stacklines]
    #flip so that it is a stack
    stacklines = list(map(lambda x: list(filter(lambda y: y != '', x)),[[stacklines[j][i] for j in range(0, len(stacklines))] for i in range(0, len(stacklines[0]))]))

    #copy list for part 2
    stacklines2 = list(map(lambda x: x.copy(), stacklines))

    # "parse" the move lines
    movelines = '*'.join(lines).split('*\n*')[1].split('\n*')


    for move in movelines:
        move = move.split(' ')

        fromidx = int(move[3]) -1
        toidx = int(move[5]) - 1
        count = int(move[1])

        #part1
        temp = stacklines[fromidx][0:count]
        temp.reverse()
        stacklines[fromidx] = stacklines[fromidx][count:]
        stacklines[toidx] = temp + stacklines[toidx]

        #part2
        temp2 = stacklines2[fromidx][0:count]
        stacklines2[fromidx] = stacklines2[fromidx][count:]
        stacklines2[toidx] = temp2 + stacklines2[toidx]



    print(''.join([x[0] for x in stacklines]))
    print(''.join([x[0] for x in stacklines2]))