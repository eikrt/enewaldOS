-- Package Manager Template in Lua

-- Define a table to hold package information
local PackageManager = {}
PackageManager.__index = PackageManager

-- Constructor to create a new package manager instance
function PackageManager:new()
	local self = setmetatable({}, PackageManager)
	self.packages = {}
	return self
end

-- Function to install a package
function PackageManager:install(packageName, version)
	if not self.packages[packageName] then
		self.packages[packageName] = version
		print("Package " .. packageName .. " version " .. version .. " installed.")
	else
		print("Package " .. packageName .. " is already installed.")
	end
end

-- Function to update a package
function PackageManager:update(packageName, newVersion)
	if self.packages[packageName] then
		self.packages[packageName] = newVersion
		print("Package " .. packageName .. " updated to version " .. newVersion .. ".")
	else
		print("Package " .. packageName .. " is not installed.")
	end
end

-- Function to remove a package
function PackageManager:remove(packageName)
	if self.packages[packageName] then
		self.packages[packageName] = nil
		print("Package " .. packageName .. " removed.")
	else
		print("Package " .. packageName .. " is not installed.")
	end
end

-- Function to list all installed packages
function PackageManager:list()
	print("Installed packages:")
	for packageName, version in pairs(self.packages) do
		print(" - " .. packageName .. " (version " .. version .. ")")
	end
end

return PackageManager
