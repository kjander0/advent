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

function printBits(msg, num)
    local bits = {}
    for i = 1, 36 do
        table.insert(bits, num & 1)
        num = num >> 1
    end
    local reverse = {}
    for i = #bits, 1, -1 do
        table.insert(reverse, bits[i])
    end
    print(msg, table.concat(reverse, ''))
end

function wildCardAddresses(addr, wildCardIndices)
    local addrList = {}
    print("pow", math.pow(2, #wildCardIndices))
    for val = 0, math.pow(2, #wildCardIndices) -1 do
        local newAddr = addr
        for i = #wildCardIndices, 1, -1 do
            local offset = wildCardIndices[i]
            local overwriteMask = 1 << offset
            printBits('overmask', overwriteMask)
            local overwriteVal = val & 1
            if overwriteVal == 1 then
                newAddr = addr & overwriteMask
            else
                newAddr = addr & (~overwriteMask)
            end
            val = val >> 1
        end
        table.insert(addrList, newAddr)
    end
    return addrList
end

mem = {}
local posMask, negMask
local wildCardIndices
for _, line in ipairs(inputLines) do
    local newMask = string.match(line, "mask = (%w+)")
    if newMask then
        posMask = 0
        negMask = 0
        wildCardIndices = {}
        for i = 1, #newMask do
            local bit = string.sub(newMask, i, i)
            if bit ~= 'X' then
                bit = tonumber(bit)
                posMask = posMask | bit
                negMask = negMask | (~bit & 1)
            else
                table.insert(wildCardIndices, i)
            end
            if i < #newMask then
                posMask = posMask << 1 
                negMask = negMask << 1 
            end
        end
        printBits('pos', posMask)
        printBits('neg', negMask)
    else
        local addr, val = string.match(line, "mem%[(%d+)%] = (%d+)")
        addr = tonumber(addr)
        val = tonumber(val)
        addr = (addr | posMask) & (~negMask)
        print('=wilds=')
        for wildAddr in pairs(wildCardAddresses(addr, wildCardIndices)) do
            printBits('wild', wildAddr)
        end
        print(#wildCardIndices)
    end
end
local sum = 0
for k, val in pairs(mem) do
    sum = sum + val
end
print('answer', sum)


