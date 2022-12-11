infile = open('11/inputA', 'r')

def read_line():
    while True:
        line = infile.readline()
        if line == '': # EOF
            return None
        if not line.isspace():
            return line

def parse_monkey():
    l = read_line()
    if l is None:
        return None
    items = [int(num) for num in read_line().split(':')[1].split(',')]
    operator, const = read_line().split()[-2:]
    test = int(read_line().split()[-1])
    doTrue = int(read_line().split()[-1])
    doFalse = int(read_line().split()[-1])

    return {
        'items': items,
        'operator': operator,
        'const': const,
        'test': test,
        'doTrue': doTrue,
        'doFalse': doFalse,
        'inspects': 0,
    }


monkeys = []
while True:
    m = parse_monkey()
    if m is None:
        break
    monkeys.append(m)

worryMax = 1
for m in monkeys:
    worryMax *= m['test']
print(worryMax)

for i in range(10000):
    for m in monkeys:
        for item in m['items']:
            m['inspects'] += 1
            worry = item

            constval = worry
            if m['const'] != 'old':
                constval = int(m['const'])

            if m['operator'] == '*':
                worry *= constval
            elif m['operator'] == '+':
                worry += constval
            worry %= worryMax
            if worry % m['test'] == 0:
                monkeys[m['doTrue']]['items'].append(worry)
            else:
                monkeys[m['doFalse']]['items'].append(worry)
        m['items'] = []

top_monks = sorted(monkeys, key=lambda m: m['inspects'])[-2:]
print(top_monks[0]['inspects'] * top_monks[1]['inspects'])