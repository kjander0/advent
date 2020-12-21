-- Read lines of file
local inputFile = io.open('input4', 'r')
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

function check(msgList, ruleNum, depth)
    prefix = ''
    for i = 1, depth do
        prefix = prefix .. ' '
    end
    print(prefix .. ruleNum)
    for _, matchStr in ipairs(msgList) do
        print(prefix, matchStr)
    end
    local matchList = {}
    local rule = ruleMap[ruleNum]
    if rule.char then
        for _, msg in ipairs(msgList) do
            local match = string.sub(msg, 1, 1) == rule.char
            if match then
                local newStr = string.sub(msg, 2, #msg)
                table.insert(matchList,  newStr)
            end
        end
    else
        local rMatchList
        for _, subList in ipairs(rule.subLists) do
            rMatchList = {table.unpack(msgList)}
            for i, subRuleNum in ipairs(subList) do
                rMatchList = check(rMatchList, subRuleNum, depth + 1)
                if not rMatchList then
                    break
                end

            end
            if rMatchList then
                for _, matchStr in ipairs(rMatchList) do
                    table.insert(matchList, matchStr)
                end
                if ruleNum == 11 or ruleNum == 8 then
                    -- proceed as if we didn't actually match
                    ;
                else
                    break
                end
            end
        end
    end
    if #matchList == 0 then
        return nil
    end
    return matchList
end

local sum = 0
for i = index, #inputLines do
    local matchList = check({inputLines[i]}, 0, 1)
    local success = false
    if matchList then
        for _, match in ipairs(matchList) do
            if #match == 0 then
                success = true
                break
            end
        end
    end
    if success then
        print('SUCCESS')
        print(inputLines[i], true)
        sum = sum + 1
    else
        print(inputLines[i], false)
    end
end
print(sum)
