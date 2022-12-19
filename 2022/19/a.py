blueprints = []

infile = open('19/testInput', 'r')
while True:
    line = infile.readline()
    if line == '':
        break
    line.strip()
    pieces = line.split()
    
    bp = {
        'id': int(pieces[1][:-1]),
        'ore': (int(pieces[6]), 0, 0, 0),
        'clay': (int(pieces[12]), 0, 0, 0),
        'osb': (int(pieces[18]), int(pieces[21]), 0, 0),
        'geod': (int(pieces[27]), 0, int(pieces[30]), 0),
    }
    blueprints.append(bp)

def greater(a, b):
    for i in range(len(a)):
        if a[i] <= b[i]:
            return False
    return True

def greater_eq(a, b):
    for i in range(len(a)):
        if a[i] < b[i]:
            return False
    return True

def add(a, b):
    return (a[0] + b[0], a[1] + b[1], a[2] + b[2], a[3] + b[3])

def sub(a, b):
    return (a[0] - b[0], a[1] - b[1], a[2] - b[2], a[3] - b[3])

bp = blueprints[0]

targets = {'ore': 0, 'clay': 0, 'osb': 0, 'geod': 0}
for k in ['ore', 'clay', 'osb', 'geod']:
    targets['ore'] = max(targets['ore'], bp[k][0])
    targets['clay'] = max(targets['clay'], bp[k][1])
    targets['osb'] = max(targets['osb'], bp[k][2])
    targets['geod'] = max(targets['geod'], bp[k][3])

# print(targets)
# cache = {}
# def max_orbs(mins, robots, resources):
#     global cache
#     key = (mins, robots, resources)
#     print(key)
#     if key in cache:
#         return cache[key]

#     if mins == 0:
#         return resources[3]

#     mins -= 1
#     resources = add(resources, robots)
#     max_val = -1
#     count = 0
#     if greater_eq(resources, bp['ore']) and robots[0] < targets['ore'] and resources[0] < targets['ore']:
#         max_val = max(max_val, max_orbs(mins, add(robots, (1, 0, 0, 0)), sub(resources, bp['ore'])))
#         count += 1
#     if greater_eq(resources, bp['clay']) and robots[1] < targets['clay'] and resources[1] < targets['clay']:
#         max_val = max(max_val, max_orbs(mins, add(robots, (0, 1, 0, 0)), sub(resources, bp['clay'])))
#         count += 1
#     if greater_eq(resources, bp['osb']) and robots[2] < targets['osb'] and resources[2] < targets['osb']:
#         max_val = max(max_val, max_orbs(mins, add(robots, (0, 0, 1, 0)), sub(resources, bp['osb'])))
#         count += 1
#     if greater_eq(resources, bp['geod']):
#         max_val = max(max_val, max_orbs(mins, add(robots, (0, 0, 0, 1)), sub(resources, bp['geod'])))
#         count += 1
#     if count < 4:
#         max_val = max(max_val, max_orbs(mins, robots, resources))

#     cache[key] = max_val
#     max_k = 0
#     for k in cache:
#         max_k = max(k[0], max_k)

#     return max_val



# print(max_orbs(24, (1, 0, 0, 0), (0, 0, 0, 0)))

best_states = {}
bp = blueprints[0]
#          min     robots       resources
to_visit = [(0, (1, 0, 0, 0), (0, 0, 0, 0))]
for min in range(24):
    print(min, len(to_visit))
    new_states = []
    for state in to_visit:
        min = state[0]
        robots = state[1]
        resources = state[2]

        if min not in best_states:
            best_states[min] = state

        current_best = best_states[min]
        if greater(current_best[1], state[1]) and greater(current_best[2], state[2]):
            continue
        elif greater_eq(state[1], current_best[1]) and greater_eq(state[2], current_best[2]):
            best_states[min] = state

        min += 1
        resources = add(resources, robots)

        if greater_eq(resources, bp['ore']) and robots[0] < targets['ore'] and resources[0] < targets['ore']:
            new_states.append( (min, add(robots, (1, 0, 0, 0)), sub(resources, bp['ore'])) )
        if greater_eq(resources, bp['clay']) and robots[1] < targets['clay'] and resources[1] < targets['clay']:
            new_states.append( (min, add(robots, (0, 1, 0, 0)), sub(resources, bp['clay'])) )
        if greater_eq(resources, bp['osb']) and robots[2] < targets['osb'] and resources[2] < targets['osb']:
            new_states.append( (min, add(robots, (0, 0, 1, 0)), sub(resources, bp['osb'])) )
        if greater_eq(resources, bp['geod']):
            new_states.append( (min, add(robots, (0, 0, 0, 1)), sub(resources, bp['geod'])) )
        new_states.append( (min, robots, resources) )
    to_visit = new_states
print(best_states[23])