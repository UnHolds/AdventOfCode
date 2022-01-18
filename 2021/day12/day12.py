

def traverse(node, nodes, visited):

    if node == "end":
        return 1

    num = 0
    if node.islower():
        visited.append(node)
    for next_node in nodes[node]:

        if next_node not in visited:
            num += traverse(next_node, nodes, list(visited))

    return num

pathList = []

def traverse2(node, nodes, visited, twice, path):

    if node == "end":
        pathList.append(path)
        return
    if node.islower():
        if twice == False:
            twice = True
            visited2 = list(visited)
            visited2.append(node)
            for next_node in nodes[node]:
                if next_node not in visited2: 
                    traverse2(next_node, nodes, list(visited2), False, path + "," + next_node)
        else:
            visited.append(node)
    for next_node in nodes[node]:
        if next_node not in visited: 
            traverse2(next_node, nodes, list(visited), twice, path + "," + next_node)


with open("./input.txt") as f:
    lines = f.readlines()

    nodes = {}

    paths = []
    for line in lines:
        line = line.strip()
        paths.append(line)
        temp = line.split("-")
        paths.append(temp[1] + "-" + temp[0])

    for path in paths:
        start = path.split("-")[0]
        end = path.split("-")[1]
        if start not in nodes:
            nodes[start] = []  
        nodes[start].append(end)


    for x in nodes:
        nodes[x] = sorted(nodes[x])
    
    visited = ["start"]
    num = 0
    for next_node in nodes["start"]:    
        num += traverse(next_node, nodes, list(visited))
    print(num)

    num = 0
    visited = ["start"]
    for next_node in nodes["start"]: 
        traverse2(next_node, nodes, list(visited), False, "start," + next_node)
    print(len(set(pathList)))
