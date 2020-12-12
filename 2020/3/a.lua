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

-- Convert to 2d array
local data = {}
for _, line in ipairs(inputLines) do
    row = {}
    for i = 1, #line do
        table.insert(row, line:sub(i, i))
    end
    table.insert(data, row)
end

local rowIndex
local colIndex

local count

function move(right, down)
    if right then
        colIndex = colIndex % #data[1] + 1
    end

    if down then
        rowIndex = rowIndex + 1
    end
end

function moveAmount(rightCount, downCount)
    for i = 1, rightCount do
        move(true, false)
    end
    for i = 1, downCount do
        move(false, true)
    end
end

product = 1
slopes = {{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}}
for _, slope in ipairs(slopes) do
    rowIndex = 1 
    colIndex = 1
    count = 0
    while rowIndex < #data do
        moveAmount(slope[1], slope[2])

        if rowIndex <= #data and data[rowIndex][colIndex] == '#' then
            count = count + 1
        end
    end
    print(count)
    product = product * count
end

print(product)
