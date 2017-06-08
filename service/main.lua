local skynet = require "skynet"

local function main()
	local proto = skynet.uniqueservice("protoloader")
	skynet.call(proto, "lua", "load", {
		"proto.c2s",
		"proto.s2c"
	})

	local login = skynet.newservice("login")
	skynet.call(login, "lua", "start", {
		port = 8888,
		maxclient = 1000,
		nodelay = true
	})

	skynet.exit();
end

skynet.start(main)