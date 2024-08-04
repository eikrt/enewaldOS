-- Require the package_manager module
local PackageManager = require("core")

-- Create a new instance of the package manager
local manager = PackageManager:new()

-- Example usage
manager:install("lua-logging", "1.3.0")
manager:install("lua-socket", "3.0-rc1")
manager:update("lua-logging", "1.4.0")
manager:remove("lua-socket")
manager:list()
