lines = []
with open('7/inputA', 'r') as fp:
    while True:
        l = fp.readline()
        if l == '': # EOF
            break
        lines.append(l)

dir_stack = ['/']
dir_map = {}

line_index = 0
while line_index < len(lines):
    pieces = lines[line_index].split()

    if pieces[0] != '$':
        raise Exception('OOPS')

    if pieces[1] == 'cd':
        if pieces[2] == '/':
            dir_stack = ['/']
        elif pieces[2] == '..':
            dir_stack.pop()
        else:
            dir_stack.append(pieces[2])
    elif pieces[1] == 'ls':
        cur_dir = '/'.join(dir_stack)
        if cur_dir not in dir_map:
            dir_map[cur_dir] = {'size': 0, 'children': []}
            while True:
                line_index += 1
                if line_index >= len(lines):
                    break
                ls_pieces = lines[line_index].split()
                if ls_pieces[0] == '$':
                    line_index -= 1
                    break
                elif ls_pieces[0] == 'dir':
                    dir_name = ls_pieces[1]
                    if dir_name not in dir_map[cur_dir]['children']:
                        dir_map[cur_dir]['children'].append(dir_name)
                else:
                    size = int(ls_pieces[0])
                    file_name = ls_pieces[1]
                    dir_map[cur_dir]['size'] += size
    line_index += 1

def calc_size(dir, dir_map):
    size = dir_map[dir]['size']
    for c in dir_map[dir]['children']:
        cpath = '/'.join([dir, c])
        size += calc_size(cpath, dir_map)
    print(dir, size)
    return size

print(calc_size('/', dir_map))

total = 0
for dir in dir_map:
    size = calc_size(dir, dir_map)
    if size <= 100000:
        print('adding', dir, size)
        total += size

print(total)
