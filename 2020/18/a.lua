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

function evaluate(expression)
    local index = #expression
    local c = string.sub(expression, index, index)
    local leftStart, leftEnd, rightStart, rightEnd
    local leftVal, rightVal
    if c == ')' then
        rightEnd = index - 1
        -- read to opening bracket
        local closeRemaining = 1
        while closeRemaining > 0 do
            index = index - 1
            c = string.sub(expression, index, index)
            if c == ')' then
                closeRemaining = closeRemaining + 1
            elseif c == '(' then
                closeRemaining = closeRemaining - 1
            end
        end
        rightStart = index + 1
        rightVal = evaluate(string.sub(expression, rightStart, rightEnd))
    else
        rightEnd = index
        -- read to start of digits
        while tonumber(c) do
            index = index - 1
            c = string.sub(expression, index, index)
        end
        index = index + 1
        rightStart = index
        rightVal = tonumber(string.sub(expression, rightStart, rightEnd))
    end

    if index == 1 then
        print('a', expression, rightVal)
        return rightVal
    else
        local operator = string.sub(expression, index-2, index-2)
        index = index - 4
        leftEnd = index
        while operator == '+' do
            c = string.sub(expression, index, index)
            if c == ')' then
                leftEnd = index - 1
                -- read to opening bracket
                local closeRemaining = 1
                while closeRemaining > 0 do
                    index = index - 1
                    c = string.sub(expression, index, index)
                    if c == ')' then
                        closeRemaining = closeRemaining + 1
                    elseif c == '(' then
                        closeRemaining = closeRemaining - 1
                    end
                end
                leftStart = index + 1
                leftVal = evaluate(string.sub(expression, leftStart, leftEnd))
            else
                while tonumber(c) do
                    index = index - 1
                    c = string.sub(expression, index, index)
                end
                index = index + 1
                leftStart = index
                leftVal = tonumber(string.sub(expression, leftStart, leftEnd))
            end
            rightVal = rightVal + leftVal
            index = index - 4
            leftEnd = index
            operator = string.sub(expression, index+2, index+2)
        end
        if index < 1 then
            print('b', expression, rightVal)
            return rightVal
        end

        local leftStart = 1
        leftVal = evaluate(string.sub(expression, leftStart, leftEnd))

        if operator == '*' then
            print('c', expression, leftVal * rightVal)
            return leftVal * rightVal
        elseif operator == '+' then
            print('d', leftVal, rightVal)
            print('d', expression, leftVal * rightVal)
            return leftVal + rightVal
        else
            print('WE HAVE A PROBLEM, non operator', operator)
        end
    end
end

local sum = 0
for _, line in ipairs(inputLines) do
    sum = sum + evaluate(line)
end
print(sum)
