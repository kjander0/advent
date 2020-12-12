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

local totalCount = 0
local charList = {}
for lineIndex, line in ipairs(inputLines) do
    for i = 1, #line do
        table.insert(charList, string.sub(line, i, i))    
    end
    if (line == '' or lineIndex == #inputLines) and #charList > 0 then
        local uniqs = uniq(charList)
        for _, item in ipairs(uniqs) do
            print(item)
        end
        totalCount = totalCount + #uniqs
        print('===')
        charList = {}

    end
end

print(totalCount)
