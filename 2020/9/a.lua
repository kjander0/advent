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

for index = 26, #inputLines do
    local num = tonumber(inputLines[index])
    local found = false
    for prevIndex1 = index-25, index - 1  do
        for prevIndex2 = prevIndex1 + 1, index - 1 do
            local prevNum1 = tonumber(inputLines[prevIndex1])
            local prevNum2 = tonumber(inputLines[prevIndex2])
            if prevNum1 + prevNum2 == num then
                found = true
            end 
        end
    end
    if not found then
        print(index, num)
    end
end
