infile = open('inputA', 'r')
grid = []
while True:
    line = infile.readline().strip()
    if line == '':
        break
    row = []
    for c in line:
        row.append(c)
    grid.append(row)

#def height(x, y, grid):
#    if y >= len(grid):
#        return -1
#    elif x >= len(grid[y]):
#        return -1
#    return grid[y][x]

def scan(originX, originY, dx, dy, grid):
    originHeight = grid[originY][originX]
    while True:
        originY += dy
        originX += dx
        if originY < 0 or originY >= len(grid):
            break
        if originX < 0 or originX >= len(grid[0]):
            break
        h = grid[originY][originX]
        if h >= originHeight:
            return False
    return True


count = 0
for y in range(len(grid)):
    for x in range(len(grid[y])):
        visible = False
        visible = visible or scan(x, y, 1, 0, grid)
        visible = visible or scan(x, y, -1, 0, grid)
        visible = visible or scan(x, y, 0, 1, grid)
        visible = visible or scan(x, y, 0, -1, grid)
        if visible:
            count += 1
print(count)
