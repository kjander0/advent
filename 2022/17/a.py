infile = open('17/inputA', 'r')
pattern = infile.readline().strip()
print(pattern, len(pattern))



shape_list = [
    [
        ['#', '#', '#', '#']
    ],
    [
        ['.', '#', '.'],
        ['#', '#', '#'],
        ['.', '#', '.'],
    ],
    [
        ['#', '#', '#'],
        ['.', '.', '#'],
        ['.', '.', '#'],
    ],
    [
        ['#'],
        ['#'],
        ['#'],
        ['#'],
    ],
    [
        ['#', '#'],
        ['#', '#'],
    ],
]

def collides(x, y, shape, rows):
    for sy, srow in enumerate(shape):
        for sx, val in enumerate(srow):
            if val == '.':
                continue
            px = sx + x
            py = sy + y
            if px < 0 or px >= len(rows[0]):
                return True
            if rows[py][px] == '#':
                return True

def settle(x, y, shape, rows):
    for sy, srow in enumerate(shape):
        for sx, val in enumerate(srow):
            if val == '.':
                continue
            px = sx + x
            py = sy + y
            rows[py][px] = '#'

rows = [['#'] * 7]
shape_index = 0
rock_level = 0
pattern_index = 0

for i in range(2022):
    shape = shape_list[shape_index]
    shape_index = (shape_index + 1) % len(shape_list)
   
    x = 2
    y = rock_level + 4
    while len(rows) < rock_level + 10:
        rows.append(['.'] * 7)
    do_jet = False
    while True:
        do_jet = not do_jet
        nx = x
        ny = y
        if do_jet:
            if pattern[pattern_index] == '>':
                nx += 1
            else:
                nx -= 1
            pattern_index = (pattern_index + 1) % len(pattern)
        else:
            ny -= 1

        if collides(nx, ny, shape, rows):
            if do_jet:
                continue
            else:
                settle(x, y, shape, rows)
                rock_level = max(rock_level, y + len(shape)-1)
                break
        x = nx
        y = ny
    # print('---')
    # for r in reversed(rows):
    #     print(''.join(r))

print(rock_level)
    


