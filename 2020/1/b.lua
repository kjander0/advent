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

for i = 1, #inputVals do
    for j = i+1, #inputVals do
        for k = j+1, #inputVals do
            v1 = inputVals[i]
            v2 = inputVals[j]
            v3 = inputVals[k]
            if v1 + v2 + v3 == 2020 then
                print(v1 * v2 * v3)
            end   
        end
    end
end
