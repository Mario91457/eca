local Ruleset = {0, 0, 0, 0, 0, 0, 0, 0}
local generation = 0

local function Evaluate(a, b, c)
	local binary = tostring(a .. b .. c)
	local convert = tonumber(binary, 2)
	return Ruleset[8 - convert]
end

local function NewRuleSet(number)
    local newSet = {}
    local remainder = ""

    while number > 0 do
          remainder = tostring(number % 2)..remainder
          number = math.floor(number/2)
    end

    for i = 1, 8 - #remainder do
        table.insert(newSet, 0)
    end
    for i = 1, #remainder do
        local number = tonumber(string.sub(remainder, i, i))
        table.insert(newSet, number)
    end
    return newSet
end

local function NextGen(currentGen)
	local newGen = {}

	for i = 1, #currentGen do
		local a = currentGen[i-1] or 0
		local b = currentGen[i]
		local c =  currentGen[i+1] or 0
		
		table.insert(newGen, Evaluate(a,b,c))
	end
	
	return newGen
end

local function PrintPattern(t)
    local string = "["
    for i = 1, #t - 1 do
        local convert = (t[i] == 1) and "." or " "
        
        string = string .. convert .. " "
    end
    string = string .. ((t[#t] == 1) and ".]" or " ]")
    print(string)
end

local function Main(size, Rule)
    print(string.rep("-", size*2+1))
    print("Rule : "..Rule)
	local currentGen = {}
	
	for i = 1, size do
		currentGen[i] = 0
	end
	currentGen[math.ceil(size/2)] = 1
	PrintPattern(currentGen)
    	Ruleset = NewRuleSet(Rule)

	for i = 0, size do
		local newGen = NextGen(currentGen)
		generation = generation + 1
		currentGen  = newGen
		PrintPattern(currentGen)
	end
end

local function AllPatterns(size)
    for i = 1, 255 do
        Main(size, i)
    end
end

Main(40, 137)
