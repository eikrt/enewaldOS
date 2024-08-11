local utils = {}
function utils.hash(str)
	local command = "echo -n " .. str .. " | sha256sum"
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()
	result = result:match("^%s*(.-)%s*$")
	result = result:match("^(.-)%s*-*$")
	print("SHA-256 hash:", result)
	return result
end
function utils.split(str)
	local words = {}
	for word in string.gmatch(str, "([^,]+)") do
		words[#words + 1] = str
	end
	return words
end
utils.serialize_profile_to_string = function(profile)
	local np = {}
	for k, v in pairs(profile) do
		np[k] = tostring(v)
	end
	return np
end
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
		print("Opened config file")
		file:close()
		return content
	end
end
utils.store_string_to_file = function(path, msg)
	local file = io.open(path, "w")
	if not file then
		print("Could not open file for writing")
	else
		file:write(msg)
		file:close()
		print("Content successfully saved!")
	end
end
utils.open_bin = function(path)
	local file = io.open(path, "r") -- Open in binary mode
	if not file then
		print("Failed to open file")
		return
	end
	local data = file:read("*all") -- Read the entire file
	file:close()
	print("data", data)
	return data
end
return utils
