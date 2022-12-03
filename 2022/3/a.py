infile = open('inputA', 'r')

def value(c):
    v = ord(c)
    if v >= ord('a') and v <= ord('z'):
        return v - ord('a') + 1
    else:
        return v - ord('A') + 27

total = 0
while True:
    line = infile.readline().strip()
    if line == '': # EOF
        break
    left, right = line[:len(line)//2], line[len(line)//2:]
    print(left, right)
    for c in left:
        if c in right:
            print(c)
            total += value(c)
            break
print(total)

