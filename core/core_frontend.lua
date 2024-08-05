-- CORE_FRONTEND.lua
-- in prototype phase, the file is simply required
require("client_0")
require("compiler-resolver")
function compose_profile(pkgs)
  print("Composing profile...")
  local profile = {}
  for key,value in pairs(pkgs()) do
   profile[#profile+1] = resolve(key,value)
  end
  return profile
end

compose_profile(packages)
