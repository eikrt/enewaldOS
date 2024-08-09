local mqtt = require("mqtt")
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
