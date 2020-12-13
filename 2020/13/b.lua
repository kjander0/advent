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

local startDividend = busList[1]
local found =  false
while not found do
    found = true
    for i = 2, #busList do
        local divisor = busList[i]
        local dividend = startDividend + i - 1
        if divisor ~= -1 then
            if dividend % divisor ~= 0 then
                found = false
                break
            end
        end
    end

    if not found then
        startDividend = startDividend + busList[1]
    end
end
print(startDividend)
