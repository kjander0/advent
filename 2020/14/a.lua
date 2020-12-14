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

function printBits(num)
    local bits = {}
    for i = 1, 36 do
        table.insert(bits, num & 1)
        num = num >> 1
    end
    local reverse = {}
    for i = #bits, 1, -1 do
        table.insert(reverse, bits[i])
    end
    print(table.concat(reverse, ''))
end

mem = {}
local posMask, negMask
for _, line in ipairs(inputLines) do
    local newMask = string.match(line, "mask = (%w+)")
    if newMask then
        posMask = 0
        negMask = 0
        for i = 1, #newMask do
            local bit = string.sub(newMask, i, i)
            if bit ~= 'X' then
                bit = tonumber(bit)
                posMask = posMask | bit
                negMask = negMask | (~bit & 1)
            end
            if i < #newMask then
                posMask = posMask << 1 
                negMask = negMask << 1 
            end
        end
        printBits(posMask)
        printBits(negMask)
    else
        local addr, val = string.match(line, "mem%[(%d+)%] = (%d+)")
        addr = tonumber(addr)
        val = tonumber(val)
        print('before:', val)
        printBits(val)
        mem[addr] = (val | posMask) & (~negMask)
        print('after:', mem[addr])
        printBits(mem[addr])
    end
end
local sum = 0
for k, val in pairs(mem) do
    sum = sum + val
end
print('answer', sum)


