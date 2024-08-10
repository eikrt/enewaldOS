-- load mqtt module
local mqtt = require("mqtt")
local sub = {}
local callback = {}
-- create mqtt client
function sub.new(args)
  sub.client = mqtt.client{
    uri = args.uri,
    username = args.username,
    id = args.id,
    clean = true,
  }
  sub.callback = args.callback
  sub.topic = args.topic
  print("created MQTT client ", tostring(sub.client) .. " listening for topic " .. args.topic)
  sub.client:on{
    connect = function(connack)
      if connack.rc ~= 0 then
        print("connection to broker failed:", connack:reason_string(), connack)
        return
      end
      print("connected:", connack) -- successful connection

      sub.client:subscribe{ topic=tostring(sub.topic), qos=1, callback=function(suback)
                              print("subscribed:", suback)
      end}
    end,
    message = function(msg)
      sub.client:acknowledge(msg)
      print("received:", msg)
      print("received message")
      sub.callback(msg["payload"])
      --print("disconnecting...")
      --sub.client:disconnect()
    end,

    error = function(err)
      print("MQTT client error:", err)
    end,
  }
  return sub
end


return sub
