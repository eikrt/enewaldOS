-- CONTROL_NODE.lua
package.path = package.path .. ';../utils/?.lua'
utils = require("utils")
client_config = require("clients.client_0")
compiler_resolver = require("compiler-resolver")
sub = require("subscribe")
pub = require("publish")
math.randomseed(os.time())
function callback(payload)
end
sub_config = sub.new({
    uri = "localhost:8000",
    username = "control",
    id = tostring(math.random(0,1000)),
    topic = "client/#",
    callback = callback
})
math.randomseed(os.time() + 1)
pub_profile = pub.new({
    uri = "localhost:8000",
    username = "control",
    id = tostring(math.random(0,1000)),
    topic = "profile/profile_0",
    callback = callback
})
control_node = {}
local REMOTE_URL = "http://localhost:3333/"

control_node.fetch_metadata = function(pkg, meta)
  print("Fetching metadata for package " .. pkg)
  os.execute("wget " .. REMOTE_URL .. "packages/sources/hello-" .. meta["version"] .. "/metadata.lua " .. " -O" .. "current/metadata.lua")
  print("Done")
end

control_node.compose_profile = function(pkgs)
  print("Composing profile...")
  local profile = {}
  for key,value in pairs(pkgs()) do
    compiler_resolver.fetch_metadata(key,value)
    profile[#profile+1] = compiler-resolver.resolve(key,value)
  end
  print("Done")
  return profile
end
function callback(path)
  utils.store_string_to_file(path)
  pub_profile({}, "profile/profile_0", math.random(0,10000))
end
co1 = coroutine.create(function ()
    sub_config.subscribe()
end)
coroutine.resume(co1)
pub_profile.publish()

return control_node
