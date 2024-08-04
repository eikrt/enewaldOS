-- in prototype phase, the file is simply required
require("client_0")
require("compiler-resolver")
function compose_profile()
  print("Composing profile...")
  for key,value in pairs(packages()) do
    resolve(key,value)
  end
end


compose_profile()
