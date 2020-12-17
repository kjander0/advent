-- Read lines of file
local inputFile = io.open('input2', 'r')
local inputLines = {}
while true do
    local line = inputFile:read()
    if line == nil then
        break
    end
    table.insert(inputLines, line)
end
inputFile:close()

local grid = {}  

function add(grid, x, y, z, val)
    local key = table.concat({x, y, z}, '.')
    grid[key] = val
end

function get(grid, x, y, z)
end

for x, line in ipairs(inputLines) do
    for y = 1, #line do
        local val = string.sub(line, y, y)
        add(grid, x, y, 0, val)
    end
end

for i = 1, 3 do
end

