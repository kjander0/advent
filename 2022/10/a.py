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

sum = 0
index = 20
while index < len(x_vals):
    sum += index * x_vals[index]
    index += 40
print(sum)


