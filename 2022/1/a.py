infile = open('inputA', 'r')

sumList = [0]
while True:
    line = infile.readline()
    if line == '':
        break
    if line.isspace():
        sumList.append(0)
    else:
        sumList[-1] += int(line)
 
sumList.sort()
print(sumList[-1])
print(sum(sumList[-3:]))
