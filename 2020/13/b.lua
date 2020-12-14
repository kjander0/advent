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

local earliestDepart = tonumber(inputLines[1])
local busList = {}
for elem in string.gmatch(inputLines[2], "%w+") do
    if elem ~= 'x' then
        table.insert(busList, tonumber(elem))
    else
        table.insert(busList, -1)
    end
end

function findFirst(busIndex, jumpMulti, startTime)
    if busIndex ~= #busList then
        local nextBusIndex = busIndex + 1
        while busList[nextBusIndex] == -1 do
            nextBusIndex = nextBusIndex + 1
        end
        local targetDiff = nextBusIndex - busIndex

        local t1 = startTime
        local first, second
        while true do
            t2 = busList[nextBusIndex] * (t1 // busList[nextBusIndex] + 1)
            while t2 - t1 < targetDiff do
                t2 = t2 + busList[nextBusIndex]
            end
            if t2 - t1 == targetDiff then
                if first == nil then
                    first = t2
                elseif second == nil then
                    second = t2
                    break
                end
            end
            t1 = t1 + busList[busIndex] * jumpMulti

        end
        return findFirst(nextBusIndex, (second - first) // busList[nextBusIndex], first)
    else
        -- find first here!
        local time = startTime
        while true do
            local lastTime = time
            local lastIndex = busIndex
            local found = true
            for i = busIndex -1, 1, -1 do
                if busList[i] ~= -1 then
                    local targetDiff = lastIndex - i
                    local newTime = busList[i] * (lastTime // busList[i])
                    if newTime == lastTime then
                        newTime = newTime - busList[i]
                    end
                    if targetDiff ~= lastTime - newTime then
                        found = false
                        break
                    end
                    lastIndex = i
                    lastTime = newTime
                end
            end
            if found == true then 
                return time - (busIndex -1)
            end
            time = time + busList[busIndex]
        end
    end
    

end

print("ans", findFirst(1, 1, 0))

--local jumpAmount = 1
--for _, bus in ipairs(busList) do
--    jumpAmount = jumpAmount * bus
--end
--print(jumpAmount)
--
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
