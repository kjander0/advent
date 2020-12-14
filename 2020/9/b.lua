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

local startIndex = 0
local endIndex = 0
local sum = 0
while sum ~= 756008079 do
    startIndex = startIndex + 1
    for i = startIndex, #inputLines do
        sum = sum + tonumber(inputLines[i])
        if sum == 756008079 then
            endIndex = i
            break
        elseif sum > 756008079 then
            sum = 0
            break
        end
    end
end


local max = tonumber(inputLines[startIndex])
local min = tonumber(inputLines[startIndex])
for i = startIndex, endIndex do
    local num = tonumber(inputLines[i])
    if num > max then
        max = num
    end

    if num < min then
        min = num
    end
end
print(min + max)
