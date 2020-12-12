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

local dir = 0
local eastPos = 0
local northPos = 0
for _, line in ipairs(inputLines) do
    local l, d = parseLine(line)
    local done = false
    if l == 'L' then
        dir = (dir + d) % 360
        done = true
    elseif l == 'R' then
        dir = (dir - d) % 360
        done = true
    elseif l == 'F' then
        local index = dir / 90 + 1
        local letters = {'E', 'N', 'W', 'S'}
        l = letters[index]
    end
    
    if not done then
        if l == 'N' then
            northPos = northPos + d
        elseif l == 'S' then
            northPos = northPos - d
        elseif l == 'E' then
            eastPos = eastPos + d
        elseif l == 'W' then
            eastPos = eastPos - d
        end
    end
end
print(eastPos, northPos)
print(math.abs(eastPos) + math.abs(northPos))
