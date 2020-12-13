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
    end
end

local earliestBus = busList[1]
local earliestTime
for _, bus in ipairs(busList) do
    local nextTime = bus * (earliestDepart // bus + 1)
    print(bus, nextTime)
    if earliestTime == nil or nextTime < earliestTime then
        earliestBus = bus
        earliestTime = nextTime
    end
end
print(earliestBus * (earliestTime - earliestDepart))
