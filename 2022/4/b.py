infile = open('4/inputA', 'r')

def getRange(rangeStr):
    start, end = rangeStr.split('-')
    return [int(start), int(end)]

def overlaps(range0, range1):
    return range1[1] >= range0[0] and range1[0] <= range0[1]

count = 0
while True:
    line = infile.readline().strip()
    if line == '': # EOF
        break

    left, right = line.split(',')
    lrange = getRange(left)
    rrange = getRange(right)

    if overlaps(lrange, rrange):
        count += 1
print(count)
