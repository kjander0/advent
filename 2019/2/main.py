def doStep(codes, index):
    action = codes[index]
    if action == 99:
        return None
    num1 = codes[codes[index + 1]]
    num2 = codes[codes[index + 2]]
    resultIndex = codes[index + 3]
    if action == 1:
        codes[resultIndex] = num1 + num2
    elif action == 2:
        codes[resultIndex] = num1 * num2
    return index + 4

for noun in range(100):
    for verb in range(100):
        with open('input', 'r') as inputFile:
            line = inputFile.readline()
            codes = [int(numstr) for numstr in line.split(',')]

            codes[1] = noun
            codes[2] = verb

            index = 0
            while True:
                index = doStep(codes, index)
                if index is None:
                    if codes[0] == 19690720:
                        print(100*noun + verb)
                        exit()
                    break
