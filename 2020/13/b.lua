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


function findFirst(busIndex, jumpMulti)
    if busIndex ~= #busList then
        local nextBusIndex = busIndex + 1
        while busList[nextBusIndex] == -1 do
            nextBusIndex = nextBusIndex + 1
        end
        local targetDiff = nextBusIndex - busIndex

        local t1 = busList[busIndex]
        local t2 = busList[busIndex+1]
        local first, second
        while true do
            if t2 - t1 == targetDiff then
                if first == nil then
                    first = t2
                elseif second == nil then
                    second = t2
                    break
                end
            end
            t1 = t1 + busList[busIndex] * jumpMulti
            t2 = busList[busIndex+1] * (t1 // busList[busIndex+1] + 1)
        end
        return findFirst(busIndex + 1, (second - first) // busList[busIndex+1])
    else
        -- find first here!
        local time = 0
        while true do
            time = time + busList[busIndex]
            local lastTime = time + busList[busIndex]
            local lastIndex = busIndex
            local found = true
            for i = busIndex -1, 1, -1 do
                if busList[i] ~= -1 then
                    local targetDiff = lastIndex - i
                    local newTime = busList[i] * (lastTime // busList[i])
                    if targetDiff ~= lastTime - newTime then
                        found = false
                        break
                    end
                    lastIndex = i
                end
            end
            if found == true then 
                return time - busIndex
            end
        end
    end
    

end

print(findFirst(1, 1))

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
