package.path = package.path .. ";../utils/?.lua"
local utils = require("utils")
local handler = require("mqtt.mqtt_handler")
local sub = require("mqtt.subscribe")
local sender = require("ssh.send")
local compiler_resolver = require("compiler-resolver")
local STORE_LOCATION = os.getenv("STORE_LOCATION")
local ID = os.getenv("ID")
local URI = os.getenv("URI")
local IS_REMOTE = os.getenv("IS_REMOTE")
local pub_dump = sender.new()
local server = {}
local callback = function(payload)
  utils.store_string_to_file("current/config.lua", payload)
	local config = require("current.config")
	for p, m in pairs(config.packages()) do
		compiler_resolver.resolve(p, m, config)
	end
  compiler_resolver.create_profile(config)
  local profile_location = STORE_LOCATION .. "/" .. "profile_" .. config.metadata().id
  local profile = require("current.profile")
  if IS_REMOTE == "true" then
    pub_dump.send_remote(profile_location, profile.targets["target_" .. config.metadata().id].host, profile.targets["target_" .. config.metadata().id].username, config.metadata().estore_location)
    else if IS_REMOTE == "false" then
        pub_dump.send_local(profile_location, config.metadata().estore_location)
    end
    end
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
