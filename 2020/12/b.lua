-- Read lines of file
local inputFile = io.open('input', 'r')
local inputLines = {}
while true do
    local line = inputFile:read()
    if line == nil then
        break
    end
    table.insert(inputLines, line)
end
inputFile:close()

function parseLine(line)
    return string.match(line, "(%w)(%d+)")
end

function rotate(wpe, wpn, d)
    d = d % 360
    local numRotations = d / 90

    for i = 1, numRotations do
        local tmp = wpn
        wpn = wpe
        wpe = -tmp
    end
    return wpe, wpn
end

local dir = 0
local wpEast = 10
local wpNorth = 1
local shipEast = 0
local shipNorth = 0
for _, line in ipairs(inputLines) do
    local l, d = parseLine(line)
    local done = false
    if l == 'L' then
        wpEast, wpNorth = rotate(wpEast, wpNorth, d)
    elseif l == 'R' then
        wpEast, wpNorth = rotate(wpEast, wpNorth, -d)
    elseif l == 'F' then
        shipEast = shipEast + wpEast * d
        shipNorth = shipNorth + wpNorth * d
    elseif l == 'N' then
        wpNorth = wpNorth + d
    elseif l == 'S' then
        wpNorth = wpNorth - d
    elseif l == 'E' then
        wpEast = wpEast + d
    elseif l == 'W' then
        wpEast = wpEast - d
    end
end
print(math.abs(shipEast) + math.abs(shipNorth))
