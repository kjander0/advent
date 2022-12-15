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

def scan(originX, originY, dx, dy, grid):
    scenic_score = 0
    originHeight = grid[originY][originX]
    while True:
        originY += dy
        originX += dx
        if originY < 0 or originY >= len(grid):
            break
        if originX < 0 or originX >= len(grid[0]):
            break
        scenic_score += 1
        h = grid[originY][originX]
        if h >= originHeight:
            break
    return scenic_score


max_score = 0
for y in range(len(grid)):
    for x in range(len(grid[y])):
        scenic_score = scan(x, y, 1, 0, grid) * scan(x, y, -1, 0, grid) * scan(x, y, 0, 1, grid) * scan(x, y, 0, -1, grid)
        max_score = max(max_score, scenic_score)
print(max_score)
