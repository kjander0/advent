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
            for oRowIndex = rowIndex-1, rowIndex+1 do
                for oColIndex = colIndex-1, colIndex+1 do
                    if oRowIndex ~= rowIndex or oColIndex ~= colIndex then
                        if oRowIndex >= 1 and oRowIndex <= #grid and oColIndex >= 1 and oColIndex <= #grid[1] then
                            local val = grid[oRowIndex][oColIndex]
                            if val == '#' then
                                numAdj = numAdj + 1
                            end
                        end
                    end

                end
            end
            --print(numAdj)
            if val == 'L' and numAdj == 0 then
                swapGrid[rowIndex][colIndex] = '#'
                numChanged = numChanged + 1
            elseif val == '#' and numAdj >= 4 then
                swapGrid[rowIndex][colIndex] = 'L'
                numChanged = numChanged + 1
            end
        end
    end
    grid = swapGrid
    print('===')
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
