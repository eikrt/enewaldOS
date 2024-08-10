local mqtt = require("mqtt")

local handler = {}

handler.start = function(...)
  mqtt.run_ioloop(...)
end


return handler
