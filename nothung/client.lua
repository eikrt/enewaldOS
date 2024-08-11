package.path = package.path .. ";../utils/?.lua"
local pub = require("mqtt.publish")
local utils = require("utils")
local handler = require("mqtt.mqtt_handler")

URI = os.getenv("URI")
ID = os.getenv("ID")
math.randomseed(os.time())
local pub_config = pub.new({
	uri = URI,
	username = "client_" .. ID,
	id = ID,
	topic = "client/client_" .. ID,
	payload = utils.open_conf("configuration/client_" .. ID .. ".lua"),
	callback = {},
})
-- client.lua
local function handlePublish(switch)
	if switch then
		print("Rebuilding with switch enabled...")
	else
		pub_config.publish()
		print("Rebuilding without switch...")
	end
	-- Add rebuild logic here
end

-- Function to parse the command-line arguments
local function parseArgs()
	local args = { switch = false }
	for i = 1, #arg do
		if arg[i] == "publish" then
			args.command = "publish"
		elseif arg[i] == "deploy" then
			args.command = "deploy"
		elseif arg[i] == "--switch" then
			args.switch = true
		end
	end
	return args
end

-- Main function to execute the command based on parsed arguments
local function main()
	local args = parseArgs()
	if args.command == "publish" then
		handlePublish(args.switch)
	else
		print("Available commands: publish")
	end
end

-- Execute the main function

print("Executing main...")

handler.start(pub_config.client)
