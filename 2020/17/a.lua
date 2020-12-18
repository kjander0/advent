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

local grid = {}

function add(grid, x, y, z, val)
    if grid[z] == nil then
        grid[z] = {}
    end

    if grid[z][y] == nil then
        grid[z][y] = {}
    end

    grid[z][y][x] = val
end

function get(grid, x, y, z)
    if grid[z] == nil then
        return '.'
    end

    if grid[z][y] == nil then
        return '.'
    end

    local val = grid[z][y][x]
    if val == nil then
        return '.'
    end

    return val
end

function getNeighs(grid, x, y, z)
    local neighs = {}
    for x2 = x-1, x+1 do
        for y2 = y-1, y+1 do
            for z2 = z-1, z+1 do
                if x2 ~= x or y2 ~= y or z2 ~= z then
                    table.insert(neighs, {x=x2, y=y2, z=z2, val=get(grid, x, y, z)})
                end
            end
        end
    end
    return neighs
end

function copy(grid)
    local newGrid = {}
    for x, gridPlane in pairs(grid) do
        newGrid[x] = {}
        for y, gridLine in pairs(gridPlane) do
            newGrid[x][y] = {}
            for z, val in pairs(gridLine) do
                newGrid[x][y][z] = val
            end
        end
    end
    return newGrid
end

function printGrid(grid)
    for z, gridPlane in pairs(grid) do
        for y, gridLine in pairs(gridPlane) do
            for x, val in pairs(gridLine) do
                io.write(val)
            end
            print()
        end
        print()
    end
end

function totalNumActive(grid)
    local total = 0
    for z, gridPlane in pairs(grid) do
        for y, gridLine in pairs(gridPlane) do
            for x, val in pairs(gridLine) do
                if val == '#' then
                    print('oh')
                    total = total + 1
                end
            end
        end
    end
    return total
end

for y, line in ipairs(inputLines) do
    for x = 1, #line do
        local val = string.sub(line, x, x)
        add(grid, x, y, 0, val)
    end
end
printGrid(grid)
print('copy')
printGrid(copy(grid))

for i = 1, 6 do
    local copyGrid = copy(grid)
    for x, plane in pairs(grid) do
        for y, line in pairs(plane) do
            for z, val in pairs(line) do
                -- TODO NEIGHBOURS NEED TO BE ADDED TO GRID IF THEY ARNT ALREADY
                local neighList = getNeighs(grid, x, y, z)
                local numActive = 0
                for _, neigh in ipairs(neighList) do
                    if neigh.val == '#' then
                        print('yeah!')
                        numActive = numActive + 1
                    end
                end
                print("num active", numActive)

                if val == '#' then
                    -- Ensure neighbours are added
                    for _, neigh in ipairs(neighList) do
                        if neigh.val == '.' then
                            add(copyGrid, neigh.x, neigh.y, neigh.z, neigh.val)
                        end
                    end

                    if numActive ~= 2 and numActive ~= 3 then
                        add(copyGrid, x, y, z, '.')
                    end
                else
                    if numActive == 3 then
                        add(copyGrid, x, y, z, '#')
                    end
                end
            end
        end
    end
    grid = copyGrid
    printGrid(grid)
end
print(totalNumActive(grid))

