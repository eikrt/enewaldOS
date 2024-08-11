package.path = package.path .. ";../utils/?.lua"
local handler = require("mqtt.mqtt_handler")
local sub = require("mqtt.subscribe")
local sender = require("ssh.send")
local compiler_resolver = require("compiler-resolver")
local STORE_LOCATION = os.getenv("STORE_LOCATION")
local ID = os.getenv("ID")
local URI = os.getenv("URI")
local pub_dump = sender.new()
local server = {}
local callback = function()
	local config = require("clients.client_0")
	local profile = {}
	for p, m in pairs(config.packages()) do
		profile[#profile + 1] = compiler_resolver.resolve(p, m)
	end
	pub_dump.send(STORE_LOCATION, "localhost", "eino", "/home/eino/repo/enewald/enewaldOS/nothung/")
end
local sub_config = sub.new({
	uri = URI,
	username = "server_" .. ID,
	id = ID,
	topic = "client/#",
	callback = callback,
})
handler.start(sub_config.client)
return server
