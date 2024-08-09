package.path = package.path .. ';../utils/?.lua'
sub = require("subscribe")
pub_dump = require("subscribe")
utils = require("utils")
compiler_resolver = require("compiler-resolver")
server = {}
math.randomseed(os.time())
callback = function(path)
  --sub_config.subscribe(utils.store_string_to_file(path), "profiles/#")
  --pub_dump.publish({}, "dump/dump")
  config = require("clients.client_0")
  profile = {}
  for p,m in pairs(config.packages()) do
    profile[#profile+1] = compiler_resolver.resolve(p,m)
  end
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
