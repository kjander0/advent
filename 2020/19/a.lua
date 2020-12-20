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
        return string.sub(msg, 1, 1) == rule.char, string.sub(msg, 2, #msg)
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
        end
        if matches then
            return true, rMsg
        else
            return false, nil
        end
    end
end

for i = index, #inputLines do
    print(inputLines[i], check(inputLines[i], 0))
end
