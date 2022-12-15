import functools

infile = open('inputB', 'r')

pairs = []
while True:
    line1 = infile.readline()
    if line1 == '': # EOF
        break
    line2 = infile.readline()
    empty = infile.readline()

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

packets = []
for p in pairs:
    packets.append(p[0])
    packets.append(p[1])

packets = sorted(packets, key=functools.cmp_to_key(comparePackets), reverse=True)

def find(packets, p):
    for i in range(len(packets)):
        if str(packets[i]) == p:
            return i
    return -1

index1 = 1 + find(packets, str([[2]]))
index2 = 1 + find(packets, str([[6]]))
print(index1, index2, index1 * index2)

