infile = open('inputA', 'r')

line = infile.readline().strip()
print(line)
chars = list(line)

index = 4
while True:
    if len(set(line[index-4:index])) == 4:
        print(line[index-4:index])
        break
    index += 1
print(index)
