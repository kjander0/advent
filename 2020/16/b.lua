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

local ruleList = {}
local index = 1
while inputLines[index] ~= '' do
    field, l1, u1, l2, u2 = string.match(inputLines[index], '([%w%s]+): (%d+)-(%d+) or (%d+)-(%d+)')
    table.insert(ruleList, {field=field, ranges={{lower=tonumber(l1), upper=tonumber(u1)}, {lower=tonumber(l2), upper=tonumber(u2)}}})
    index= index + 1
end

function parseTicket(str)
    local values = {}
    for numStr in string.gmatch(str, '%d+') do
        table.insert(values, tonumber(numStr))
    end
    return values
end

index = index + 2
local myTicket = parseTicket(inputLines[index])

function checkValid(field, rule)
    for _, range in ipairs(rule.ranges) do
        if field >= range.lower and field <= range.upper then
            return true
        end
    end
    return false
end


local validTickets = {}
index= index + 3
local sum = 0
for i = index, #inputLines do
    local ticket = parseTicket(inputLines[i])
    local ticketValid = true
    for _, field in ipairs(ticket) do
        local valid = false
        for _, rule in ipairs(ruleList) do
            valid = checkValid(field, rule)
            if valid then
                break
            end
        end
        if not valid then
            sum = sum + field
            ticketValid = false
        end
    end
    if ticketValid then
        table.insert(validTickets, ticket)
    end
end

--local possibleRules = {}
--for i = 1, #ruleList do
--    table.insert(possibleRules, {table.unpack(ruleList)})
--end

local running = true
while running do
    running = false
    for fieldIndex = 1, #ruleList do
        local remainingRules = {}
        for _, rule in ipairs(ruleList) do
            if not rule.fieldIndex then
                local valid = true
                for _, ticket in ipairs(validTickets) do
                    local field = ticket[fieldIndex]
                    valid = checkValid(field, rule)
                    if not valid then
                        break
                    end
                end
                if valid then
                    table.insert(remainingRules, rule)
                end
            end
        end
        if #remainingRules == 1 then
            print(#remainingRules)
            remainingRules[1]['fieldIndex'] = fieldIndex
        else
            running = true
        end
    end
end
