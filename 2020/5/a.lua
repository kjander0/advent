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

function parsePass(line)
    local rowUpper = 127
    local rowLower = 0
    local colUpper = 7
    local colLower = 0

    for i = 1, #line do
        local char = line:sub(i, i)
        if char == "F" then
            -- lower half
            rowUpper = rowUpper - (rowUpper - rowLower) // 2 - 1
        elseif char == "B" then
            rowLower = rowLower + (rowUpper - rowLower) // 2 + 1
        elseif char == "L" then
            -- lower half
            colUpper = colUpper - (colUpper - colLower) // 2 - 1
        else
            colLower = colLower + (colUpper - colLower) // 2 + 1
        end
        --print(rowLower, rowUpper, rowUpper - rowLower)
        --print(colLower, colUpper, colUpper - colLower)
    end
    return rowLower,  colLower
end

local idList = {}
local maxId = 0
for _, line in ipairs(inputLines) do
    local row, col = parsePass(line)
    local id = row * 8 + col
    table.insert(idList, id)
    if id > maxId then
        maxId = id
    end
end
print(string.format("max id: %d", maxId))

local prev
local prevPrev
for row = 1, 126 do
    for col = 1, 6 do
        local id = row * 8 + col
        local found = false
        for _, id2 in ipairs(idList) do
            if id == id2 then
                found = true
                break
            end
        end

        if found then
            if prevPrev and not prev then
                print(tonumber(id) - 1)
            end
        end

        --print(id)
        prevPrev = prev
        if found then
            prev = id
        else
            prev = nil
        end
    end
end
