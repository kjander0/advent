infile = open('inputA', 'r')

def win_score(opp, me):
    if 'X' in me:
        if 'B' in opp:
            return 0
        elif 'C' in opp:
            return 6
        else:
            return 3
    elif 'Y' in me:
        if 'A' in opp:
            return 6
        elif 'C' in opp:
            return 0
        else:
            return 3
    else:
        if 'A' in opp:
            return 0
        elif 'B' in opp:
            return 6
        else:
            return 3

def item_score(item):
    if 'X' in item:
        return 1
    elif 'Y' in item:
        return 2
    else:
        return 3

def convert(opp, me):
    if 'X' in me: # lose
        if 'A' in opp:
            return 'Z'
        elif 'B' in opp:
            return 'X'
        else:
            return 'Y'

    elif 'Y' in me: # draw
        if 'A' in opp:
            return 'X'
        elif 'B' in opp:
            return 'Y'
        else:
            return 'Z'
    
    else: # win
        if 'A' in opp:
            return 'Y'
        elif 'B' in opp:
            return 'Z'
        else:
            return 'X'


total = 0
while True:
    line = infile.readline()
    if line == '': # EOF
        break

    
    opp, me = line.split()
    me = convert(opp, me)
    total += win_score(opp, me) + item_score(me)
print(total)

