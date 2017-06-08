local skynet = require "skynet"
local socket = require "socket"
local account_mgr = require "account_mgr"

local M = {}

function M:start(conf)
	self.gate = skynet.newservice("gate")
	skynet.call(self.gate, "lua", "open", conf)
end

return M