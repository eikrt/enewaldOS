-- CORE_FRONTEND.lua
require("clients.client_0")
require("compiler-resolver")


function fetch_metadata(pkg, meta)
  print("Fetching metadata for package " .. pkg)
  os.execute("wget " .. "http://localhost:3333/" .. "packages/sources/hello-" .. meta["version"] .. "/metadata.lua " .. " -O" .. "current/metadata.lua")
  print("Done")
end
function compose_profile(pkgs)
  print("Composing profile...")
  local profile = {}
  for key,value in pairs(pkgs()) do
    print(key,value)
    fetch_metadata(key,value)
   profile[#profile+1] = resolve(key,value)
  end
  return profile
end

compose_profile(packages)
