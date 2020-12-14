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

function test(swapIndex)
    local accumulator = 0
    local lineIndex = 1
    local indexVisited = {}
    while not indexVisited[lineIndex] do
        indexVisited[lineIndex] = true
        local line = inputLines[lineIndex]
        local instruction, numStr = string.match(line, "(%w+) ([+%-0-9]+)")
        if lineIndex == swapIndex then
            if instruction == "nop" then
                instruction = "jmp"
            elseif instruction == "jmp" then
                instruction = "nop"
            end
        end
        local num = tonumber(numStr)

        if instruction == "nop" then
            lineIndex = lineIndex + 1
        elseif instruction == "acc" then
            accumulator = accumulator + num
            lineIndex = lineIndex + 1
        else
            lineIndex = lineIndex + num
        end
        
        if lineIndex == #inputLines + 1 then
            return accumulator
        end
    end
end

for i, line in ipairs(inputLines) do
    if line:sub(1, 1) ~= 'a' then
        local res = test(i)
        if res then
            print(i, res)
        end
    end
end
