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

local diffs = {}

local prev = 0
for _, adapt in ipairs(adapters) do
    local diff = adapt - prev
    table.insert(diffs, diff)
    prev = adapt
end

local count1 = 0
local count3 = 0
for _, diff in ipairs(diffs) do
    if diff == 1 then
        count1 = count1 + 1
    elseif diff == 3 then
        count3 = count3 + 1
    end
end
print(count1, count3)

print(count1 * count3)
