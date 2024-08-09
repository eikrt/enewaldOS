utils = {}

utils.file_exists = function(name)
  local f = io.open(name, "r")
  return f ~= nil and io.close(f)
end
utils.open_conf = function(path)
  local file = io.open(path, "r")
  if not file then
    print("Could not open file for reading")
  else
    local content = file:read("*all")
    print("Opened config file", content)
    file:close()
    return content
  end
end
utils.store_string_to_file = function(msg)
  local file = io.open("../core/clients/client_0.lua", "w")
  if not file then
    print("Could not open file for writing")
  else
    file:write(msg)
    file:close()
    print("Content successfully saved!")
  end
end

return utils
