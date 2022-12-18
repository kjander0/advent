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

min_cube = cubes[0]
max_cube = cubes[0]
for c in cubes:
    min_cube = (
        min(min_cube[0], c[0]-1),
        min(min_cube[1], c[1]-1),
        min(min_cube[2], c[2]-1),
    )
    max_cube = (
        max(max_cube[0], c[0]+1),
        max(max_cube[1], c[1]+1),
        max(max_cube[2], c[2]+1),
    )

    cube_map[c] = 1

to_visit = [min_cube]
count = 0
while len(to_visit) > 0:
    cube = to_visit.pop()
    for off in offsets:
        neigh = (cube[0] + off[0], cube[1] + off[1], cube[2] + off[2])
        if neigh[0] < min_cube[0] or neigh[0] > max_cube[0]:
            continue
        if neigh[1] < min_cube[1] or neigh[1] > max_cube[1]:
            continue
        if neigh[2] < min_cube[2] or neigh[2] > max_cube[2]:
            continue
        if neigh not in cube_map:
            cube_map[neigh] = 0
            to_visit.append(neigh)
        elif cube_map[neigh] == 1:
            count += 1
print(count)