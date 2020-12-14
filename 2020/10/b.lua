local inputFile = io.open('input', 'r')
local adapters = {}
while true do
    local val = inputFile:read()
    if val == nil then
        break
    end
    table.insert(adapters, tonumber(val))
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

table.sort(adapters)
local myAdapter = adapters[#adapters] + 3
table.insert(adapters, myAdapter)

-- map adapters to combinations it supports
local adapterMap = {}

function numArrangements(adapters, prevIndex)
    local prevJolts
    if prevIndex == 0 then
        prevJolts = 0
    else
        prevJolts = adapters[prevIndex]
    end

    if prevIndex == #adapters then
        return 1
    end

    local count = 0
    for i = prevIndex + 1, #adapters do
        local jolts = adapters[i]
        if jolts <= prevJolts + 3 then
            local num
            if adapterMap[i] ~= nil then
                num = adapterMap[i]
            else
                num = numArrangements(adapters, i)
                adapterMap[i] = num
            end
            if num == 0 then
                return 0
            else
                count = count + num
            end
        end
    end
    return count
end

print(numArrangements(adapters, 0))
