infile = open('12/inputA', 'r')

rows = []
while True:
    line = infile.readline()
    if line == '': # EOF
        break
    rows.append(list(line.rstrip()))

start_row = start_col = None
for r in range(len(rows)):
    for c in range(len(rows)):
        if rows[r][c] == 'S':
            start_row = r
            start_col = c
            break

def height_at(r, c, rows):
    l = rows[r][c]
    if l == 'S':
        l = 'a'
    if l == 'E':
        l = 'z'
    return ord(l) - ord('a')

def expand(r, c, current_cost, rows):
    current_height = height_at(r,c, rows)
    result_neighs = []
    neighs = [(r-1, c), (r+1, c), (r, c-1), (r, c+1)]
    for n in neighs:
        if n[0] < 0 or n[0] >= len(rows):
            continue
        if n[1] < 0 or n[1] >= len(rows[0]):
            continue
        if height_at(n[0], n[1], rows) > current_height + 1:
            continue
        
        result_neighs.append({
            'pos': n,
            'cost': current_cost + 1,
        })

    return result_neighs


visited = [(start_row, start_col)]
working = expand(start_row, start_col, 0, rows)
while True:
    working = sorted(working, key=lambda x: x['cost'], reverse=True)
    best = working.pop()
    r,c = best['pos']
    if rows[r][c] == 'E':
        print(best['cost'])
        break
    neighs = expand(r, c, best['cost'], rows)
    for n in neighs:
        if n['pos'] in visited:
            continue
        working.append(n)
        visited.append(n['pos'])