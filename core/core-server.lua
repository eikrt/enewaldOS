-- load mqtt module
local mqtt = require("mqtt")
function store_string_to_file(msg)
  local file = io.open("clients/client_0.lua", "w")
  if not file then
    print("Could not open file for writing")
  else
    file:write(msg)
    file:close()
    print("Content successfully saved!")
  end
end
-- create mqtt client
local client = mqtt.client{
	uri = "localhost:8000",
	username = "server_0",
  id = "a",
	clean = true,
}
print("created MQTT client", client)
client:on{
	connect = function(connack)
		if connack.rc ~= 0 then
			print("connection to broker failed:", connack:reason_string(), connack)
			return
		end
		print("connected:", connack) -- successful connection

		client:subscribe{ topic="profiles/#", qos=1, callback=function(suback)
                        print("subscribed:", suback)
		end}
	end,
	message = function(msg)
		client:acknowledge(msg)
		print("received:", msg)
    store_string_to_file(msg["payload"])
		print("disconnecting...")
		client:disconnect()
	end,

	error = function(err)
		print("MQTT client error:", err)
	end,
}


while true do
  print("running ioloop for it")
  mqtt.run_ioloop(client)
  print("done, ioloop is stopped")
end
