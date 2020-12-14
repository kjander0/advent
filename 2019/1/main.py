def fuel_fuel(fuel):
    extra_fuel = fuel/3 - 2
    if extra_fuel < 0:
        return 0
    return extra_fuel + fuel_fuel(extra_fuel)

with open('input', 'r') as inputFile:
    total_fuel = 0
    while True:
        line = inputFile.readline()
        if not line:
            break
        mass = int(line)
        fuel = mass/3 - 2
        total_fuel = total_fuel + fuel
        total_fuel = total_fuel + fuel_fuel(fuel)
    print(total_fuel)

        
