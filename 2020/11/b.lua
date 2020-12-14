local inputFile = io.open('input', 'r')
local inputLines = {}
while true do
    local val = inputFile:read()
    if val == nil then
        break
    end
    table.insert(inputLines, val)
end
inputFile:close()

function string:split(sep)
   local sep, fields = sep or ":", {}
   local pattern = string.format("([^%s]+)", sep)
   self:gsub(pattern, function(c) fields[#fields+1] = c end)
   return fields
end

function unique(arr)
    local hash = {}
    local uniques = {}
    for _, item in ipairs(arr) do
        if not hash[item] then
            hash[item] = true
            table.insert(uniques, item)
        end
    end
    return uniques
end

local grid = {}
for _, line in ipairs(inputLines) do
    local row = {}
    for i = 1, #line do
        table.insert(row, string.sub(line, i, i))
    end
    table.insert(grid, row)
end

function checkDir(grid, startRowIndex, startColIndex, rowDelta, colDelta)
    local rowIndex = startRowIndex + rowDelta
    local colIndex = startColIndex + colDelta
    while rowIndex >= 1 and rowIndex <= #grid and colIndex >= 1 and colIndex <= #grid[1] do
        local val = grid[rowIndex][colIndex]
        if val == '#' then
            return 1
        elseif val == 'L' then
            return 0
        end
        rowIndex = rowIndex + rowDelta
        colIndex = colIndex + colDelta
    end
    return 0
end

local numChanged = 1
while numChanged > 0 do
    local swapGrid = {}
    numChanged = 0
    for rowIndex, row in ipairs(grid) do
        table.insert(swapGrid, {})
        print(table.concat(row, ''))
        for colIndex, val in ipairs(row) do
            table.insert(swapGrid[rowIndex], val)
            local numAdj = 0
            numAdj = numAdj + checkDir(grid, rowIndex, colIndex, 1, 0)
            numAdj = numAdj + checkDir(grid, rowIndex, colIndex, -1, 0)
            numAdj = numAdj + checkDir(grid, rowIndex, colIndex, 0, 1)
            numAdj = numAdj + checkDir(grid, rowIndex, colIndex, 0, -1)
            numAdj = numAdj + checkDir(grid, rowIndex, colIndex, 1, 1)
            numAdj = numAdj + checkDir(grid, rowIndex, colIndex, 1, -1)
            numAdj = numAdj + checkDir(grid, rowIndex, colIndex, -1, -1)
            numAdj = numAdj + checkDir(grid, rowIndex, colIndex, -1, 1)
            if val == 'L' then
                print('L', numAdj)
            end

            if val == 'L' and numAdj == 0 then
                swapGrid[rowIndex][colIndex] = '#'
                numChanged = numChanged + 1
            elseif val == '#' and numAdj >= 5 then
                swapGrid[rowIndex][colIndex] = 'L'
                numChanged = numChanged + 1
            end
        end
    end
    grid = swapGrid
    print('===')
    print('BREAKING EARLY')
    --break
end

local count = 0
for rowIndex, row in ipairs(grid) do
    print(table.concat(row, ''))
    for colIndex, val in ipairs(row) do
        if val == '#' then
            count = count + 1
        end
    end
end

print(count)
