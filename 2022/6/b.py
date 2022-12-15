infile = open('inputA', 'r')

line = infile.readline().strip()
print(line)
chars = list(line)

index = 14
while True:
    if len(set(line[index-14:index])) == 14:
        print(line[index-14:index])
        break
    index += 1
print(index)
