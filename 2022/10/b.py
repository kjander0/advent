infile = open('10/inputA', 'r')

x_vals = [1]
x = 1
while True:
    line = infile.readline().strip()
    if line == '': # EOF
        break

    pieces = line.split()

    if pieces[0] == 'noop':
        x_vals.append(x)
    elif pieces[0] == 'addx':
        x_vals.append(x)
        x_vals.append(x)
        x += int(pieces[1])


for y in range(6):
    row = ''
    for x in range(40):
        index =  1 + y * 40 + x
        x_pos = x_vals[index]
        if abs(x - x_pos) < 2:
            row += '#'
        else:
            row += ' '
    print(row)
