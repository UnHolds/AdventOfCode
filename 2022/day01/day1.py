with open("input.txt") as f:

    numbers = []
    number = 0
    for line in f.readlines():
        if line != '\n':
            number = number + int(line)
        else:
            numbers.append(number)
            number = 0

    numbers.sort()

    print(numbers[-1])
    print(sum(numbers[-3:]))


with open("input.txt") as f:

    data = sorted(list(map(lambda y: sum(map(int, y)), [x.split('+')[:-1] for x in ''.join([l + '+' if l != '\n' else '*' for l in f.readlines()]).split('*')])), reverse=True)
    print(data[0])
    print(sum(data[:3]))