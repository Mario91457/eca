--Roblox Studios

local ruleset = {0, 1, 1, 1, 1, 0, 1, 0}
local generation = 0
local Folder = script.Parent.Parent
local startPos = Folder.Part.Position

local function rule(a, b, c)
	local binary = tostring(a .. b .. c)
	local convert = tonumber(binary, 2)
	return ruleset[8 - convert]
end

local function nextGen(currentGen)
	local newGen = {}

	for i = 1, #currentGen do
		local a = currentGen[i-1] or 0
		local b = currentGen[i]
		local c =  currentGen[i+1] or 0
		
		table.insert(newGen, rule(a,b,c))
	end
	
	return newGen
end


local function generatePattern(t)
	for i,v in ipairs(t) do
		if v == 1 then
			local newPart = Instance.new("Part", Folder)
			newPart.Anchored = true
			newPart.Size = Vector3.new(1,1,1)
			newPart.Position = Vector3.new(startPos.X + 1 + i , startPos.Y - generation, startPos.Z)
		end	
	end
end

local function main(size)
	local currentGen = {}
	
	for i = 1, size do
		currentGen[i] = 0
	end
	currentGen[math.ceil(size/2)] = 1
	generatePattern(currentGen)
	for i = 0, size do
		local newGen = nextGen(currentGen)
		generation += 1
		currentGen  = newGen
		generatePattern(currentGen)
	end
end

main(100)
