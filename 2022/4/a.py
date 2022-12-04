infile = open('4/inputA', 'r')

def getRange(rangeStr):
    start, end = rangeStr.split('-')
    return [int(start), int(end)]

def contains(range0, range1):
    return range1[0] >= range0[0] and range1[1] <= range0[1]

count = 0
while True:
    line = infile.readline().strip()
    if line == '': # EOF
        break

    left, right = line.split(',')
    lrange = getRange(left)
    rrange = getRange(right)

    if contains(lrange, rrange) or contains(rrange, lrange):
        count += 1
print(count)
