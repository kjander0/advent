
cubes = []
infile = open('18/inputA', 'r')
while True:
    line = infile.readline()
    if line == '':
        break
    line.strip()
    x, y, z = line.split(',')
    cubes.append((int(x), int(y), int(z)))

offsets = [
    (-1, 0, 0),
    (1, 0, 0),
    (0, -1, 0),
    (0, 1, 0),
    (0, 0, -1),
    (0, 0, 1),
]

cube_map = {}
neigh_count = 0
for c in cubes:
    cube_map[c] = True
    for off in offsets:
        neigh = (c[0] + off[0], c[1] + off[1], c[2] + off[2])
        if neigh in cube_map:
            neigh_count += 1
print(len(cubes) * 6 - neigh_count * 2)

