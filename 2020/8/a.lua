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

local accumulator = 0
local lineIndex = 1
local indexVisited = {}

while not indexVisited[lineIndex] do
    indexVisited[lineIndex] = true
    local line = inputLines[lineIndex]
    local instruction, numStr = string.match(line, "(%w+) ([+%-0-9]+)")
    local num = tonumber(numStr)

    if instruction == "nop" then
        lineIndex = lineIndex + 1
    elseif instruction == "acc" then
        accumulator = accumulator + num
        lineIndex = lineIndex + 1
    else
        lineIndex = lineIndex + num
    end
end
print(lineIndex)
print(accumulator)
