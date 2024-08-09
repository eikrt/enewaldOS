package.path = package.path .. ';../utils/?.lua'
sub = require("subscribe")
pub_dump = require("subscribe")
utils = require("utils")
server = {}
math.randomseed(os.time())
callback = function(path)
  sub_config.subscribe(utils.store_string_to_file(path), "profiles/#")
  pub_dump.publish({}, "dump/dump")
end
sub_config = sub.new({
    uri = "localhost:8000",
    username = "client",
    id = tostring(math.random(0,1000)),
    topic = "client/#",
    callback = callback 
})
sub_config.subscribe()
return server
