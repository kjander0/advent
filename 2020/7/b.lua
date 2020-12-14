local inputFile = io.open('input', 'r')
local inputLines = {}
while true do
    local val = inputFile:read()
    if val == nil then
        break
    end
    table.insert(inputLines, val)
end
inputFile:close()


function string:split(sep)
   local sep, fields = sep or ":", {}
   local pattern = string.format("([^%s]+)", sep)
   self:gsub(pattern, function(c) fields[#fields+1] = c end)
   return fields
end

function unique(arr)
    local hash = {}
    local uniques = {}
    for _, item in ipairs(arr) do
        if not hash[item] then
            hash[item] = true
            table.insert(uniques, item)
        end
    end
    return uniques
end


local rules = {}
local colors = {} 
for _, line in ipairs(inputLines) do
    local outer, remainder = string.match(line, "(.+) bags contain (.+)")
    table.insert(colors, outer)
    if remainder ~= "no other bags." then
        local innerStrList = remainder:split(',')
        local rule = {color = outer, children = {}}
        for _, innerStr in ipairs(innerStrList) do
            local numStr, inner = string.match(innerStr, "(%d+) (%w+ %w+)")
            table.insert(colors, inner)
            table.insert(rule.children, {color = inner, count = tonumber(numStr)})
        end
        table.insert(rules, rule)
    end
end

--for _, r in ipairs(rules) do
--    print(string.format("rule: %s", r.color))
--    for _, c in ipairs(r.children) do
--        print(string.format("\t%s", c))
--    end
--end

function traverse(color, rules)
    local count = 0
    for _, r in ipairs(rules) do
        if r.color == color then
            for _, child in ipairs(r.children) do
                if child.color == "shiny gold" then
                    print("INFINITE LOOP AGHHHH!")
                end
                count = count + child.count
                local childCount = traverse(child.color, rules)
                count = count + childCount * child.count
            end
        end
    end
    return count
end

local colors = unique(colors)
local count = traverse("shiny gold", rules)
print(string.format("count: %d", count))

