infile = open('inputA', 'r')

def value(c):
    v = ord(c)
    if v >= ord('a') and v <= ord('z'):
        return v - ord('a') + 1
    else:
        return v - ord('A') + 27

def common(e1, e2):
    ret = ''
    for c in e1:
        if c in e2:
            if c not in ret:
                ret += c
    return ret

total = 0
while True:
    e1 = infile.readline().strip()
    if e1 == '': # EOF
        break
    e2 = infile.readline().strip()
    e3 = infile.readline().strip()

    cmn = common(e3, common(e1, e2))
    print(cmn)
    total += value(cmn)

print(total)

