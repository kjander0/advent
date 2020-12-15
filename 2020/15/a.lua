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

local inputNums = {}
for numStr in string.gmatch(inputLines[1], "%d+") do
    table.insert(inputNums, tonumber(numStr))
end

local numList = {}
local numObjs = {}

for i = 1, 30000000 do
    local newNum
    if i <= #inputNums then
        newNum = inputNums[i]
    else
        local prevNum = numList[i-1]
        local prevNumObj = numObjs[prevNum]
        if prevNumObj.count == 1 then
            -- first time
            newNum = 0
        else
            -- seen before
            newNum = (i-1) - prevNumObj.index
        end
        prevNumObj.index = i - 1
        prevNumObj.count = prevNumObj.count + 1
    end

    local newNumObj = numObjs[newNum]
    if not newNumObj then
        newNumObj = {index = i, count = 1}
        numObjs[newNum] = newNumObj
    else
        newNumObj.count = newNumObj.count + 1
    end
    numList[i] = newNum
end
print(numList[#numList])
