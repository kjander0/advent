infile = open('inputA', 'r')

pairs = []
while True:
    line1 = infile.readline()
    line2 = infile.readline()
    empty = infile.readline()
    if empty == '': # EOF
        break

    pairs.append((eval(line1), eval(line2)))

def comparePackets(left, right):
    #import pdb;pdb.set_trace()
    if type(left) is int and type(right) is int:
        if left < right:
            return 1
        elif left > right:
            return -1
        return 0

    if type(left) is list and type(right) is list:
        index = 0
        while True:
            if index >= len(left) or index >= len(right):
                if len(left) < len(right):
                    return 1
                elif len(left) > len(right):
                    return -1
                else:
                    return 0
            res = comparePackets(left[index], right[index])
            if res != 0:
                return res
            index += 1
    if type(left) is int and type(right) is list:
        return comparePackets([left], right)
    elif type(right) is int and type(left) is list:
        return comparePackets(left, [right])
    print('OOPS')
    return 0

count = 0
for i, p in enumerate(pairs):
    if comparePackets(p[0], p[1]) == 1:
        count += i + 1
print(count)



