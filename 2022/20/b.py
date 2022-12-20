items = []

infile = open('20/inputA', 'r')
while True:
    line = infile.readline()
    if line == '':
        break
    line.strip()
    items.append((len(items), 811589153 * int(line)))


orig_items = items.copy()

for mix in range(10):
    print(mix)
    for orig in orig_items:
        for index in range(len(items)):
            if orig[0] == items[index][0]:
                break

        new_index = index + orig[1]
        if new_index <= 0:
            new_index = new_index % (len(items)-1)
        else:
            new_index = new_index % (len(items)-1)

        if index < new_index:
            for i in range(index, new_index):
                items[i] = items[i+1]
        elif index > new_index:
            for i in range(index, new_index, -1):
                items[i] = items[i-1]
        items[new_index] = orig
        #print(orig[1], [it[1] for it in items])

for index in range(len(items)):
    if items[index][1] == 0:
        break
a = items[(index + 1000) % len(items)][1]
b = items[(index + 2000) % len(items)][1]
c = items[(index + 3000) % len(items)][1]
print(a + b + c)

            