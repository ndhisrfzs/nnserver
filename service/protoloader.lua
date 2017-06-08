local skynet = require "skynet"
local sprotoparser = require "sprotoparser"
local sprotoloader = require "sprotoloader"

local CMD = {}
local data = {}

local function load(name)
	local filename = string.format("proto/%s.sproto", name)
	local f = assert(io.open(filename), "Can't open" .. name)
	local t = f:read "a"
	f:close()
	return sprotoparser.parse(t)
end

function CMD.load(list)
	for i, name in ipairs(list) do
		local p = load(name)
		data[name] = i
		sprotoloader.save(p, i)
	end
end

function CMD.index(name)
	return data[name]
end

skynet.start(function ()
	skynet.dispatch("lua", function(_, _, cmd, ...)
		local f = CMD[cmd]
		if f then
			skynet.ret(skynet.pack(f(...)))
		else
			skynet.response()(false)
		end
	end)
end)