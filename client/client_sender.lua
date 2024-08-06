local mqtt = require("mqtt")

-- create mqtt client
local client = mqtt.client{
	uri = "localhost:8000",
  username = "client_0",
  id = "b",
	clean = true,
}
function open_conf(path)
  local file = io.open(path, "r")

  if not file then
    print("Could not open file for reading")
  else
    local content = file:read("*all")
    print("Opened config file", content)
    file:close()
    return content
  end
  print("created MQTT client", client)
end
client:on{
	connect = function(connack)
		if connack.rc ~= 0 then
			print("connection to broker failed:", connack:reason_string(), connack)
			return
		end
		print("connected:", connack) -- successful connection
		-- publish test message
		print('publishing message to "profiles/profile_0" topic...')
		client:publish{
			topic = "profiles/profile_0",
			payload = open_conf("configuration/client_0.lua"),
			qos = 1
		}
	end,

	message = function(msg)
		client:acknowledge(msg)
		print("received:", msg)
		print("disconnecting...")
		client:disconnect()
	end,

	error = function(err)
		print("MQTT client error:", err)
	end,
}

function publish()
  print("running ioloop for it")
  mqtt.run_ioloop(client)
  print("done, ioloop is stopped")
end
