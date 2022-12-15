infile = open('15/inputA', 'r')

def parse_int(string):
    new_string = ''
    for c in string:
        if c.isnumeric() or c == '-':
            new_string += c
    return int(new_string)

sensors = []
while True:
    line = infile.readline()
    if line == '':
        break

    parts = line.split()
    sx = parse_int(parts[2])
    sy = parse_int(parts[3])
    bx = parse_int(parts[8])
    by = parse_int(parts[9])
    dist = abs(bx - sx) + abs(by - sy)
    sensors.append({
        'x': sx,
        'y': sy,
        'dist': dist,
    })



for target_row in range(4000001):
    int_list = []
    for sensor in sensors:
        sx = sensor['x']
        sy = sensor['y']
        dist = sensor['dist']
        remain = dist - abs(target_row - sy)
        if remain <= 0:
            continue

        left = sx - remain
        right = sx + remain
        left = max(0, left)
        right = min(4000000, right)
        if left > right:
            continue
        int_list.append((left, right))

    def merge(intA, intB):
        if intA[1] >= intB[0] and intA[0] <= intB[1]:
            return (min(intA[0], intB[0]), max(intA[1], intB[1]))
        return None

    sorted_ints = sorted(int_list, key=lambda x:x[0])
    result_ints = [sorted_ints[0]]
    for i in range(1, len(sorted_ints)):
        merged = merge(result_ints[-1], sorted_ints[i])
        if merged is not None:
            result_ints[-1] = merged
        else:
            result_ints.append(sorted_ints[i])


    count = 0
    for interval in result_ints:
        count += 1 + interval[1] - interval[0]
    if count != 4000001:
        print(target_row, result_ints)
        break

print(3435885 * 4000000 + 2639657)