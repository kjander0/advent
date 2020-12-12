local inputFile = io.open('input', 'r')
local inputVals = {}
while true do
    local val = inputFile:read()
    if val == nil then
        break
    end
    table.insert(inputVals, val)
end
inputFile:close()

function parse_line(line)
    l, u, c, p =  string.match(line, '(%d+)-(%d+) (%a): ([%a%d]+)')
    return tonumber(l), tonumber(u), c, p
end

local validCount = 0
for i, line in ipairs(inputVals) do
    local lower, upper, char, password = parse_line(line)
    local count = 0
    for j = 1, #password do
        local c = password:sub(j, j)
        if c == char then
            count = count + 1
        end
    end
    if count >= lower and count <= upper then
        validCount = validCount + 1
    end
end
print(validCount)
