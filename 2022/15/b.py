infile = open('inputA', 'r')

rows = []
for i in range(1024):
    rows.append([])
    for j in range(1024):
        rows[i].append('.')

def getVal(x, y, rows):
    return rows[y][x]

def setVal(x, y, val, rows):
    rows[y][x] = val

def sign(num):
    if num > 0:
        return 1
    elif num < 0:
        return -1
    return 0

max_depth = 0
while True:
    line = infile.readline().rstrip()
    if line == '':
        break
    
    point_strings = [r.strip() for r in line.split('->')]
    rock_points = []
    for ps in point_strings:
        xstr, ystr = ps.split(',')
        rock_points.append((int(xstr), int(ystr)))
    
    for i in range(len(rock_points) - 1):
        dx = sign(rock_points[i+1][0] - rock_points[i][0])
        dy = sign(rock_points[i+1][1] - rock_points[i][1])
        point = rock_points[i]
        while True:
            rows[point[1]][point[0]] = '#'
            if point[1] > max_depth:
                max_depth = point[1]
            if point == rock_points[i+1]:
                break
            point = (point[0] + dx, point[1] + dy)

print(max_depth)
for i in range(len(rows[0])):
    rows[max_depth+2][i] = '#'

for i in range(10):
    line = ''
    for j in range(493, 505):
        line += rows[i][j]
    print(line)

count = 0
running = True
while running:
    grain = (500, 0)
    while True:
        down = getVal(grain[0], grain[1] + 1, rows)
        left = getVal(grain[0] - 1, grain[1] + 1, rows)
        right = getVal(grain[0] + 1, grain[1] + 1, rows)
        if down == '.':
            grain = (grain[0], grain[1]+1)
        elif left == '.':
            grain = (grain[0]-1, grain[1]+1)
        elif right == '.':
            grain = (grain[0]+1, grain[1]+1)
        else:
            setVal(grain[0], grain[1], 'o', rows)
            count += 1
            if grain == (500, 0):
                running = False
            break

    #for i in range(max_depth-100, max_depth):
    #    line = ''
    #    for j in range(450, 550):
    #        line += rows[i][j]
    #    print(line)


print(count)
