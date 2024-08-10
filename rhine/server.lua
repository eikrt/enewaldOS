package.path = package.path .. ";../utils/?.lua"
local utils = require("utils")
local handler = require("mqtt.mqtt_handler")
local sub = require("mqtt.subscribe")
local pub = require("mqtt.publish")
local sender = require("ssh.send")
local compiler_resolver = require("compiler-resolver")
local ESTORE_LOCATION = "/home/eino/repo/enewald/enewaldOS/rhine/estore/"
local function dump_callback(payload)
	print("dump_callback")
end
local pub_dump = sender.new()
local server = {}
math.randomseed(os.time() + 1)
local callback = function(path)
	local config = require("clients.client_0")
	local profile = {}
	for p, m in pairs(config.packages()) do
		profile[#profile + 1] = compiler_resolver.resolve(p, m)
	end
	pub_dump.send(ESTORE_LOCATION, "localhost", "eino", "/home/eino/repo/enewald/enewaldOS/nothung/")
end
local sub_config = sub.new({
	uri = "localhost:8000",
	username = "server",
	id = tostring(math.random(0, 1000)),
	topic = "client/#",
	callback = callback,
})
handler.start(sub_config.client)
return server
