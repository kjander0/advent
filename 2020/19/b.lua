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

local ruleMap = {}
local index = 1
while inputLines[index] ~= '' do
    local rule = {}
    local line = inputLines[index]
    local ruleNumStr, ruleStr = string.match(line, "(%d+): (.+)")
    local ruleNum = tonumber(ruleNumStr)
    
    local firstChar = string.sub(ruleStr, 1, 1)
    if firstChar == '"' then
        local ruleChar = string.sub(ruleStr, 2, 2)
        rule.char = ruleChar
    else
        rule.subLists = {}
        local subList = {}
        for token in string.gmatch(ruleStr, "%S+") do
            if token == '|' then
                table.insert(rule.subLists, subList)
                subList = {}
            else
                table.insert(subList, tonumber(token))
            end
        end
        table.insert(rule.subLists, subList)
    end
    ruleMap[ruleNum] = rule
    index = index + 1
end

index = index + 1

function check(msg, ruleNum)
    local rule = ruleMap[ruleNum]
    if rule.char then
        local match = string.sub(msg, 1, 1) == rule.char
        print(ruleNum, msg, match)
        return match, string.sub(msg, 2, #msg)
    else
        local matches
        local rMsg
        for _, subList in ipairs(rule.subLists) do
            matches = true
            rMsg = msg
            for i, subRuleNum in ipairs(subList) do
                match, rMsg = check(rMsg, subRuleNum)
                if not match then
                    matches = false
                    break
                end
            end
            if matches then
                Record match to array
                if ruleNum == 11 or ruleNum == 8 then
                    proceed as if match didnt fail (no break)
                else
                    break
                end
            end
        end
        if matches then
            print(ruleNum, msg, true)
            return true, rMsg

        else
            print(ruleNum, msg, false)
            return false, nil
        end
    end
end

local sum = 0
for i = index, #inputLines do
    local match, rMsg = check(inputLines[i], 0)
    if match and rMsg == '' then
        print(inputLines[i], true)
        sum = sum + 1
    else
        print(inputLines[i], false)
    end
end
print(sum)
