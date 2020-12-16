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

function remove(list, elem)
    local index
    for i = 1, #list do
        if list[i] == elem then
            index = i
        end
    end
    table.remove(list, index)
end

local indicesToNames = {}
local remainingRules = {table.unpack(ruleList)}
local fieldList = {}
for i = 1,20 do
    table.insert(fieldList, {index=i, matchCount=0})
end
while #remainingRules > 0 do
    for _, field in ipairs(fieldList) do
        if not indicesToNames[field.index] then
            local validRules = {}
            for _, rule in ipairs(remainingRules) do
                local valid = true
                for _, ticket in ipairs(validTickets) do
                    local field = ticket[field.index]
                    if not checkValid(field, rule) then
                        valid = false
                        break
                    end
                end
                if valid then
                    table.insert(validRules, rule)
                end
            end
            field.matchCount = #validRules
            if #validRules == 1 then
                indicesToNames[field.index] = validRules[1].field
                remove(remainingRules, validRules[1])
            end
        end
    end
    table.sort(fieldList, function(first, second) return first.matchCount < second.matchCount end)
end

local product = 1
for index, name in ipairs(indicesToNames) do
    if string.match(name, "departure") then
        local val = myTicket[index]
        product = product * val
    end
end

print(product)
