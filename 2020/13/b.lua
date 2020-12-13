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

function findFirst(busIndex, jumpMulti)
    if busIndex ~= #busList then
        local nextBusIndex = busIndex + 1
        while busList[nextBusIndex] == -1 do
            nextBusIndex = nextBusIndex + 1
        end
        local targetDiff = nextBusIndex - busIndex

        local t1 = busList[busIndex]
        local t2 = busList[nextBusIndex]
        local first, second
        print(t1, t2)
        while true do
            --print("t1 t2", t1, t2)
            if t2 - t1 == targetDiff then
                if first == nil then
                    first = t2
                elseif second == nil then
                    second = t2
                    break
                end
            end
            t1 = t1 + busList[busIndex] * jumpMulti
            t2 = busList[nextBusIndex] * (t1 // busList[nextBusIndex] + 1)
        end
        return findFirst(nextBusIndex, (second - first) // busList[nextBusIndex])
    else
        -- find first here!
        local time = 0
        while true do
            --print(time)
            --if time > 100 then
            --    print('ENDING EARLY')
            --    break
            --end
            time = time + busList[busIndex]
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
                    --print('t', newTime, lastTime)
                    if targetDiff ~= lastTime - newTime then
                        found = false
                        break
                    end
                    lastIndex = i
                    lastTime = newTime
                end
            end
            if found == true then 
                --print("time", time)
                return time - (busIndex -1)
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
