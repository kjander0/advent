-- Read lines of file
local inputFile = io.open('input', 'r')
local inputLines = {}while true do
    local line = inputFile:read()
    if line == nil then
        break
    end
    table.insert(inputLines, line)
end
inputFile:close()

function uniq(arr)
    local uniqs = {}
    local hash = {}
    for _, val in ipairs(arr) do
        if not hash[val] then
            table.insert(uniqs, val)
            hash[val] = true
        end
    end
    return uniqs
end

function getCount(arr, val)
    local count = 0
    for _, elem in ipairs(arr) do
        if val == elem then
            count = count + 1
        end
    end
    return count
end

function conains(arr, val)
    for _, elem in ipairs(arr) do
        if val == elem then
            return true
        end
    end
    return false
end

local totalCount = 0
local charList = {}
local lineCount = 0
for lineIndex, line in ipairs(inputLines) do
    local empty = true
    for i = 1, #line do
        local char = string.sub(line, i, i)
        table.insert(charList, char)
        empty = false
    end
    if not empty then
        lineCount = lineCount + 1
    end

    if (line == '' or lineIndex == #inputLines) and #charList > 0 then
        local uniqs = uniq(charList)
        for _, item in ipairs(uniqs) do
            local count = getCount(charList, item)
            print(table.concat(charList, ''))
            print(item)
            print(count)
            if count == lineCount and not added then
                print(count)
                totalCount = totalCount + 1
            end
            print('===')
        end
        lineCount = 0
        charList = {}
    end
end

print(totalCount)
