infile = open('9/inputA', 'r')

knots = []
for i in range(10):
    knots.append((0,0))

def add(a, b):
    return (a[0] + b[0], a[1] + b[1])

def sub(a, b):
    return (a[0] - b[0], a[1] - b[1])

def update(head, tail):
    diff = sub(head, tail)

    if abs(diff[0]) < 2 and abs(diff[1]) < 2:
        return tail
    
    moveX = diff[0]
    if abs(moveX) == 2:
        moveX /= 2

    moveY = diff[1]
    if abs(moveY) == 2:
        moveY /= 2
    
    move = (moveX, moveY)

    return add(tail, move)

visited = [(0, 0)]

while True:
    line = infile.readline().strip()
    if line == '': # EOF
        break

    dir, num = line.split()
    num = int(num)

    for i in range(num):
        delta = None
        if dir == 'L':
            delta = (-1, 0)
        elif dir == 'R':
            delta = (1, 0)
        elif dir == 'U':
            delta = (0, 1)
        elif dir == 'D':
            delta = (0, -1)
        
        knots[0] = add(knots[0], delta)

        for i in range(1, 10):
            knots[i] = update(knots[i-1], knots[i])

        if knots[-1] not in visited:
            visited.append(knots[-1])
print(len(visited))


