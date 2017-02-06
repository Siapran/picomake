local traversal = {}
local marked = {}
local sources = {}

do
	local output = io.popen('find src -name "*.lua"')
	for filename in output:lines() do
		local name = string.gsub(filename, "(.*/)(.*)%.lua", "%2")
		local file = io.open(filename)
		local module = { path = filename, edges = {}, source = {} }
		for line in file:lines() do
			local match, number = string.gsub(line, 'require%("(.*)"%)', "%1")
			if number == 1 then
				table.insert(module.edges, match)
				-- print(name .. " -> " .. match)
			else
				table.insert(module.source, line)
			end
		end
		sources[name] = module
		marked[name] = true
	end
end

function visit( node )
	assert(marked[node] ~= "temp", "Not a DAG")
	if marked[node] then
		marked[node] = "temp"
		for _,edge in ipairs(sources[node].edges) do
			visit(edge)
		end
		marked[node] = nil
		table.insert(traversal, node)
	end
end

while next(marked) do
	local node = next(marked)
	visit(node)
end

local file = io.open("code.lua", "w")

for _,name in ipairs(traversal) do
	local module = sources[name]
	file:write(table.concat(module.source, "\n"))
	file:write("\n")
end

file:close()