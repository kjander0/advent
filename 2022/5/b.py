infile = open('5/inputA', 'r')

def read_row(line):
    items = []
    index = 1
    while index < len(line):
        item = line[index]
        if item == ' ':
            item = None
        items.append(item)
        index += 4
    return items

def read_stacks():
    stacks = []
    while True:
        line = infile.readline()
        if line[1] == '1': # finished reading stacks
            break
        row = read_row(line)
        if len(stacks) == 0:
            for i in range(len(row)):
                stacks.append([])

        for i in range(len(row)):
            if row[i] is not None:
                stacks[i].insert(0, row[i])
    return stacks

stacks = read_stacks()

infile.readline() # read blank line

while True:
    line = infile.readline().strip()
    if line == '': # EOF
        break

    pieces = line.split()
    num, frm, to = int(pieces[1]), int(pieces[3]), int(pieces[5])

    substack = []
    for i in range(num):
        substack.append(stacks[frm-1].pop())
    for i in range(num):
        stacks[to-1].append(substack.pop())

result = ''
for stack in stacks:
    result += stack[-1]

print(result)