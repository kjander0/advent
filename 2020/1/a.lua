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

for i, v1 in ipairs(inputVals) do
    for j, v2 in ipairs(inputVals) do
        if i ~= j then
            if v1 + v2 == 2020 then
                print(v1 * v2)
            end
        end
    end
end
