-- Read lines of file
local inputFile = io.open('input2', 'r')
local inputLines = {}
while true do
    local line = inputFile:read()
    if line == nil then
        break
    end
    table.insert(inputLines, line)
end
inputFile:close()

local earliestDepart = tonumber(inputLines[1])
local busList = {}
for elem in string.gmatch(inputLines[2], "%w+") do
    if elem ~= 'x' then
        table.insert(busList, tonumber(elem))
    else
        table.insert(busList, -1)
    end
end

function reverse(list)
    newList = {}
    for i = #list, 1, -1 do
        table.insert(newList, list[i])
    end
    return newList
end

--local product = 1
--for _, bus in ipairs(busList) do
--    if bus > 0 then
--        product = product * bus
--    end
--end
--print(product)


function find(busIndex, targetDiff, jump)
    local bus = busList[busIndex]
    if bus ~= -1 then
        local t1 = busList[busIndex -1]
        local t2 = busList[busIndex]
        local first, second
        while true do
            if t2 - t1 == targetDiff then
                if first == nil then
                    first = t2
                else
                    second = t2
                    break
                end
            end
            t2 = t2 + busList[busIndex]
            while t1 < t2 do
                t1 = t1 + busList[busIndex -1]
            end
        end
        jump = jump * (second - first)
    end
end

print(find(2, 1, busList[2]))

--local startDividend = busList[1]
--local found =  false
--while not found do
--    found = true
--    local diff 
--    for i = 2, #busList do
--        local divisor = busList[i]
--        local dividend = startDividend + i - 1
--        if divisor ~= -1 then
--            if dividend % divisor ~= 0 then
--                found = false
--                break
--            end
--        end
--    end
--
--    if not found then
--        startDividend = startDividend + busList[1]
--    end
--end
--print(startDividend)
