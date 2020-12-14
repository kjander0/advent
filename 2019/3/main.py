def listLines(path):
	lineList = []
	prevLine = None
	for code in path:
            line = {'x': 0, 'y' : 0, 'dx': 0, 'dy': 0}
            if prevLine:
                line['x'] = prevLine['x'] + prevLine['dx']
                line['y'] = prevLine['y'] + prevLine['dy']
            prevLine = line
            direction = code[0]
            distance = int(code[1:])
            print(distance)
            
            if direction == 'L':
                line['dx'] = -distance
            elif direction == 'R':
                line['dx'] = distance
            elif direction == 'U':
                line['dy'] = distance
            elif direction == 'D':
                line['dy'] = -distance
            lineMinX = line['x']
            lineMinY = line['y']
            lineMaxX = lineMinX + line['dx']
            lineMaxY = lineMinX + line['dy']
            if lineMinX > lineMaxX:
                temp = lineMinX
                lineMinX = lineMaxX
                lineMaxX = temp
            if lineMinY > lineMaxY:
                temp = lineMinY
                lineMinY = lineMaxY
                lineMaxY = temp
            line['minX'] = lineMinX
            line['maxX'] = lineMaxX
            line['minY'] = lineMinY
            line['maxY'] = lineMaxY

            lineList.append(line)
	return lineList

def checkIntersection(horizontal, vertical):
    if vertical['minY'] <= horizontal['y'] <= vertical['maxY']:
        if horizontal['minX'] <= vertical['x'] <= horizontal['maxX']:
            return (vertical['x'], horizontal['y'])

def listCrossings(lines1, lines2):
    crossings = []
    for lineA in lines1:
        for lineB in lines2:
            intersection = None
            if abs(lineA['dx']) > 0 and abs(lineB['dy']) > 0:
                intersection = checkIntersection(lineA, lineB)
            elif abs(lineA['dy']) > 0 and abs(lineB['dx']) > 0:
                intersection = checkIntersection(lineB, lineA)
            if intersection:
                print(intersection)
                crossings.append(intersection)
    return crossings

with open("input", "r") as inputFile:
    path1 = inputFile.readline().split(',')
    path2 = inputFile.readline().split(',')
    lines1 = listLines(path1)
    lines2 = listLines(path2)
    crossings = listCrossings(lines1, lines2)
    
    minDist = None
    for intersect in crossings:
        dist = abs(intersect[0]) + abs(intersect[1])
        if (minDist is None or dist < minDist) and dist > 0:
            minDist = dist
    print(minDist)
