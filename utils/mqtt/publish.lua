local mqtt = require("mqtt")
local utils = require("utils")
local pub = {}
local handler = require("mqtt.mqtt_handler")


function pub.new(args)
  pub.client = mqtt.client{
    uri = args.uri,
    username = args.username,
    id = args.id,
    clean = true,
  }
  pub.topic = args.topic
  pub.callback = callback
  pub.client:on{
    connect = function(connack)
      if connack.rc ~= 0 then
        print("connection to broker failed:", connack:reason_string(), connack)
        return
      end
      print("connected:", connack) -- successful connection
      -- publish test message
      print('publishing message to ' .. args.topic .. ' topic...')
      pub.client:publish{
        topic = tostring(pub.topic),
        payload = args.payload,
        qos = 1
      }
    end,

    message = function(msg)
      pub.client:acknowledge(msg)
      -- print("received:", msg)
      pub.callback(msg["payload"])
      -- print("disconnecting...")
      pub.client:disconnect()
    end,

    error = function(err)
      print("MQTT client error:", err)
    end,
  }
  return pub
end

return pub
